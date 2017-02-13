import numpy as np
import random
from PIL import Image, ImageDraw
import sys

SCREEN_WIDTH  = 800
SCREEN_HEIGHT = 600


im = Image.new("RGB", (SCREEN_WIDTH, SCREEN_HEIGHT), "black")
draw = ImageDraw.Draw(im)

GRID_WIDTH = 500
GRID_HEIGHT = 400

########################################
#### FRAME OF REFERENCE: XY IN GRID ####

# layer 1: division grid
l1_lines = []
for i in range(4):
    x_pos = i * 50    
    x = 50 + x_pos
    l1_lines.append( (x, 0, x, GRID_HEIGHT) )
    
for i in range(4):
    x_pos = i * 50   
    x = 300 + x_pos
    l1_lines.append( (x, 0, x, GRID_HEIGHT) )

for i in range(3):
    y_pos = i * 50    
    y = 50 + y_pos
    l1_lines.append( (0, y, GRID_WIDTH, y) )
    
  
for i in range(3):
    y_pos = i * 50   
    y = GRID_WIDTH / 2 + y_pos
    l1_lines.append( (0, y, GRID_WIDTH, y) )
        
# layer 2: division frame
l2_lines = [ (0,0,GRID_WIDTH,0), (0,0,0,GRID_HEIGHT), (0,GRID_HEIGHT,GRID_WIDTH,GRID_HEIGHT), (GRID_WIDTH,0,GRID_WIDTH,GRID_HEIGHT), (GRID_WIDTH / 2,0,GRID_WIDTH / 2,GRID_HEIGHT), (0,GRID_HEIGHT / 2,GRID_WIDTH,GRID_HEIGHT / 2)]
    

def rgb4b(r,g,b):
    return (r * 16, g * 16, b * 16)
    
     
# DRAW LINES FUNCTION
def draw_grid(color12, llist, grid_xos, grid_yos):
    for l in llist:
    
        #CHANGE TO ABS XY
        x1 = l[0] + grid_xos
        y1 = l[1] + grid_yos
        
        x2 = l[2] + grid_xos
        y2 = l[3] + grid_yos
        
        # CHANGE TO ABS COL ROW 
        r1 = SCREEN_HEIGHT - y1
        c1 = x1
        
        r2 = SCREEN_HEIGHT - y2
        c2 = x2
            
        draw.line( (c1, r1, c2, r2) , fill=rgb4b(*color12))


# DRAW CHANNEL FUNCTION
def draw_channel(ch, rgb, grid_x_offset, grid_y_offset):
    def rgb_atten(rgb, atten):
        nr = int(rgb[0] * atten)
        ng = int(rgb[1] * atten)
        nb = int(rgb[2] * atten)
        return (nr, ng, nb)

    for i in range(len(ch)-1):

        # signal x,y (ALREADY SCALED AND ARBITRARLY OFFSETED)
        sx, sy = ch[i]
        
        
        next_sx, next_sy = ch[i+1]
        # change to grid frame coordinates:
        # same x
        # but  y is referenced to grid center
        gx = sx
        gy = sy + GRID_HEIGHT / 2
        
        next_gy = next_sy + GRID_HEIGHT / 2
        
        # change to absolute screen xy
        x = gx + grid_x_offset
        y = gy + grid_y_offset

        next_y = next_gy + grid_y_offset 
        # finally change to abs ROW,COL
        
        r = SCREEN_HEIGHT - y
        nextr = SCREEN_HEIGHT - next_y
        
        c = x
        
        ## generate plot verical line
        LINE_THICKNESS = 2
        
        if r < nextr:
            ln_coords = (c,r,c,nextr+LINE_THICKNESS)
        else:
            ln_coords = (c,nextr,c,r+LINE_THICKNESS)
        
        draw.line(ln_coords , fill=rgb)



# DEFINE GRID LOWER LEFT CORNER OFFSET
if len(sys.argv) != 3:
    print "usage: %s x_grid_offset  y_grid_offset"
    exit()

grid_x_offset = int(sys.argv[1])
grid_y_offset = int(sys.argv[2])

print
print "grid_x_offset =", grid_x_offset
print "grid_y_offset =", grid_y_offset
print

draw_grid((2,2,2), l1_lines, grid_x_offset, grid_y_offset)
draw_grid((4,4,4), l2_lines, grid_x_offset, grid_y_offset)




########## VERILOG CODE GENERATOR


def verilog_lines(color12, llist, grid_xos, grid_yos):
    for l in llist:
        #CHANGE TO ABS XY
        x1 = l[0] + grid_xos
        y1 = l[1] + grid_yos
        
        x2 = l[2] + grid_xos
        y2 = l[3] + grid_yos
        
        
        # CHANGE TO ABS COL, ROW
        r1 = SCREEN_HEIGHT - y1
        c1 = x1
        
        r2 = SCREEN_HEIGHT - y2
        c2 = x2
        
        ########### SORTING
        if r2 < r1:
            r1, r2 = r2, r1
        if c2 < c1:
            c1, c2 = c2, c1
        
        #horizontal lines
        if r1 == r2:    
            # (x <= c1 && x <= c2 && y == r1)
            print "(col >= %i && col <= %i && row == %i) |" % (c1, c2, r1)

        #vertical lines
        if c1 == c2:    
            # (y <= r1 && y <= r2 && x == c1)
            print "(row >= %i && row <= %i && col == %i) |" % (r1, r2, c1)



print "// GRID LINES"
verilog_lines((4,4,4), l1_lines, grid_x_offset, grid_y_offset) # 1/4 intensity
print 
print

print "// FRAME LINES"
verilog_lines((8,8,8), l2_lines, grid_x_offset, grid_y_offset) # 1/2 intensity

print
print


# generate signal traces
# CHANNEL 1
x = np.linspace(0, 499, num=GRID_WIDTH)

noise = 0#np.random.normal(0, 20, GRID_WIDTH) * (x>360) 
y = 125.0 * np.sin(4 * np.pi * x/ GRID_WIDTH) + noise
ch_1 = zip(list(x.astype(int)), list(y.astype(int)))
#####   
  
draw_channel(ch_1, (255,255,0), grid_x_offset, grid_y_offset)

    
im.show()

print 
print 
print "SIGNAL TRANSFORM:    col  =  sigx - %i" % grid_x_offset
print "                     row  =  %i - sigy" % (SCREEN_HEIGHT - GRID_HEIGHT / 2 - grid_y_offset)
print
print
#im.save('asd.png')




    

//
//  CHAR LOGIC
//
module gpu_char_logic(char_addr,
                      row,
                      col,
                      row_offset,
                      col_offset,
                      on_char
                      );
                                    
input [5:0] char_addr;
input [9:0] row;
input [9:0] col;

input [9:0] row_offset;
input [9:0] col_offset;

wire row_no_offset;
wire col_no_offset;

assign row_no_offset = row;
assign col_no_offset = col;

output on_char;

assign on_char =
(char_addr == 0) &
(   //CHAR: "0"
    (row == 0 && col== 2) ||
    (row == 0 && col== 3) ||
    (row == 0 && col== 4) ||
    (row == 1 && col== 1) ||
    (row == 1 && col== 5) ||
    (row == 2 && col== 1) ||
    (row == 2 && col== 4) ||
    (row == 2 && col== 5) ||
    (row == 3 && col== 1) ||
    (row == 3 && col== 3) ||
    (row == 3 && col== 5) ||
    (row == 4 && col== 1) ||
    (row == 4 && col== 2) ||
    (row == 4 && col== 5) ||
    (row == 5 && col== 1) ||
    (row == 5 && col== 5) ||
    (row == 6 && col== 2) ||
    (row == 6 && col== 3) ||
    (row == 6 && col== 4)
)
||
(char_addr == 1) &
(   //CHAR: "1"
    (row == 0 && col == 3) ||
    (row == 1 && col == 2) ||
    (row == 1 && col == 3) ||
    (row == 2 && col == 3) ||
    (row == 3 && col == 3) ||
    (row == 4 && col == 3) ||
    (row == 5 && col == 3) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 2) &
(   //CHAR: "2"
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 2) ||
    (row == 5 && col == 1) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4) ||
    (row == 6 && col == 5)
)
||
(char_addr == 3) &
(   //CHAR: "3"
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 4) &
(   //CHAR: "4"
    (row == 0 && col == 4) ||
    (row == 1 && col == 3) ||
    (row == 1 && col == 4) ||
    (row == 2 && col == 2) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 2) ||
    (row == 4 && col == 3) ||
    (row == 4 && col == 4) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 4) ||
    (row == 6 && col == 4)
)
||
(char_addr == 5) &
(   //CHAR: "5"
    (row == 0 && col == 1) ||
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 1) ||
    (row == 2 && col == 1) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 6) &
(   //CHAR: "6"
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 2) ||
    (row == 2 && col == 1) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 7) &
(   //CHAR: "7"
    (row == 0 && col == 1) ||
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 3) ||
    (row == 4 && col == 2) ||
    (row == 5 && col == 2) ||
    (row == 6 && col == 2)
)
||
(char_addr == 8) &
(   //CHAR: "8"
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 9) &
(   //CHAR: "9"
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 4) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3)
)
||
(char_addr == 10) &
(   //CHAR: "A"
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 2) ||
    (row == 4 && col == 3) ||
    (row == 4 && col == 4) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 5)
)
||
(char_addr == 11) &
(   //CHAR: "B"
    (row == 0 && col == 1) ||
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 12) &
(   //CHAR: "C"
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 3 && col == 1) ||
    (row == 4 && col == 1) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 13) &
(   //CHAR: "D"
    (row == 0 && col == 1) ||
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 14) &
(   //CHAR: "E"
    (row == 0 && col == 1) ||
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 1) ||
    (row == 2 && col == 1) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 1) ||
    (row == 5 && col == 1) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4) ||
    (row == 6 && col == 5)
)
||
(char_addr == 15) &
(   //CHAR: "F"
    (row == 0 && col == 1) ||
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 1) ||
    (row == 2 && col == 1) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 1) ||
    (row == 5 && col == 1) ||
    (row == 6 && col == 1)
)
||
(char_addr == 16) &
(   //CHAR: "G"
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4) ||
    (row == 6 && col == 5)
)
||
(char_addr == 17) &
(   //CHAR: "H"
    (row == 0 && col == 1) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 5)
)
||
(char_addr == 18) &
(   //CHAR: "I"
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 3) ||
    (row == 2 && col == 3) ||
    (row == 3 && col == 3) ||
    (row == 4 && col == 3) ||
    (row == 5 && col == 3) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 19) &
(   //CHAR: "J"
    (row == 0 && col == 5) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 20) &
(   //CHAR: "K"
    (row == 0 && col == 1) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 4) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 3) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 2) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 3) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 4) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 5)
)
||
(char_addr == 21) &
(   //CHAR: "L"
    (row == 0 && col == 1) ||
    (row == 1 && col == 1) ||
    (row == 2 && col == 1) ||
    (row == 3 && col == 1) ||
    (row == 4 && col == 1) ||
    (row == 5 && col == 1) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4) ||
    (row == 6 && col == 5)
)
||
(char_addr == 22) &
(   //CHAR: "M"
    (row == 0 && col == 1) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 2) ||
    (row == 1 && col == 4) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 5)
)
||
(char_addr == 23) &
(   //CHAR: "N"
    (row == 0 && col == 1) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 2) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 4) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 5)
)
||
(char_addr == 24) &
(   //CHAR: "O"
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 25) &
(   //CHAR: "P"
    (row == 0 && col == 1) ||
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 1) ||
    (row == 5 && col == 1) ||
    (row == 6 && col == 1)
)
||
(char_addr == 26) &
(   //CHAR: "Q"
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 3) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 4) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 5)
)
||
(char_addr == 27) &
(   //CHAR: "R"
    (row == 0 && col == 1) ||
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 4) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 5)
)
||
(char_addr == 28) &
(   //CHAR: "S"
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 29) &
(   //CHAR: "T"
    (row == 0 && col == 1) ||
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 3) ||
    (row == 2 && col == 3) ||
    (row == 3 && col == 3) ||
    (row == 4 && col == 3) ||
    (row == 5 && col == 3) ||
    (row == 6 && col == 3)
)
||
(char_addr == 30) &
(   //CHAR: "U"
    (row == 0 && col == 1) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 31) &
(   //CHAR: "V"
    (row == 0 && col == 1) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 2) ||
    (row == 5 && col == 4) ||
    (row == 6 && col == 3)
)
||
(char_addr == 32) &
(   //CHAR: "W"
    (row == 0 && col == 1) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 3) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 3) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 4)
)
||
(char_addr == 33) &
(   //CHAR: "X"
    (row == 0 && col == 1) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 2) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 3) ||
    (row == 4 && col == 2) ||
    (row == 4 && col == 4) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 5)
)
||
(char_addr == 34) &
(   //CHAR: "Y"
    (row == 0 && col == 1) ||
    (row == 0 && col == 5) ||
    (row == 1 && col == 1) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 3) ||
    (row == 5 && col == 3) ||
    (row == 6 && col == 3)
)
||
(char_addr == 35) &
(   //CHAR: "Z"
    (row == 0 && col == 1) ||
    (row == 0 && col == 2) ||
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 4) ||
    (row == 2 && col == 3) ||
    (row == 3 && col == 2) ||
    (row == 4 && col == 1) ||
    (row == 5 && col == 1) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 36) &
(   //CHAR: "a"
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 2) ||
    (row == 4 && col == 3) ||
    (row == 4 && col == 4) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4) ||
    (row == 6 && col == 5)
)
||
(char_addr == 37) &
(   //CHAR: "b"
    (row == 0 && col == 1) ||
    (row == 1 && col == 1) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 38) &
(   //CHAR: "c"
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 39) &
(   //CHAR: "d"
    (row == 0 && col == 5) ||
    (row == 1 && col == 5) ||
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4) ||
    (row == 6 && col == 5)
)
||
(char_addr == 40) &
(   //CHAR: "e"
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 2) ||
    (row == 4 && col == 3) ||
    (row == 4 && col == 4) ||
    (row == 5 && col == 1) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 41) &
(   //CHAR: "f"
    (row == 0 && col == 3) ||
    (row == 0 && col == 4) ||
    (row == 1 && col == 2) ||
    (row == 2 && col == 2) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 2) ||
    (row == 5 && col == 2) ||
    (row == 6 && col == 2)
)
||
(char_addr == 42) &
(   //CHAR: "g"
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 2) ||
    (row == 5 && col == 3) ||
    (row == 5 && col == 4) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 5) ||
    (row == 7 && col == 2) ||
    (row == 7 && col == 3) ||
    (row == 7 && col == 4)
)
||
(char_addr == 43) &
(   //CHAR: "h"
    (row == 0 && col == 1) ||
    (row == 1 && col == 1) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 4) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 4) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 4)
)
||
(char_addr == 44) &
(   //CHAR: "i"
    (row == 0 && col == 3) ||
    (row == 2 && col == 3) ||
    (row == 3 && col == 3) ||
    (row == 4 && col == 3) ||
    (row == 5 && col == 3) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 45) &
(   //CHAR: "j"
    (row == 0 && col == 4) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 4) ||
    (row == 5 && col == 4) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 4) ||
    (row == 7 && col == 2) ||
    (row == 7 && col == 3)
)
||
(char_addr == 46) &
(   //CHAR: "k"
    (row == 0 && col == 1) ||
    (row == 1 && col == 1) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 3) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 2) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 3) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 4)
)
||
(char_addr == 47) &
(   //CHAR: "l"
    (row == 0 && col == 3) ||
    (row == 1 && col == 3) ||
    (row == 2 && col == 3) ||
    (row == 3 && col == 3) ||
    (row == 4 && col == 3) ||
    (row == 5 && col == 3) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 48) &
(   //CHAR: "m"
    (row == 2 && col == 1) ||
    (row == 2 && col == 2) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 3) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 3) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 5)
)
||
(char_addr == 49) &
(   //CHAR: "n"
    (row == 2 && col == 1) ||
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 4) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 4) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 4)
)
||
(char_addr == 50) &
(   //CHAR: "o"
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 51) &
(   //CHAR: "p"
    (row == 2 && col == 1) ||
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4) ||
    (row == 7 && col == 1)
)
||
(char_addr == 52) &
(   //CHAR: "q"
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4) ||
    (row == 6 && col == 5) ||
    (row == 7 && col == 5)
)
||
(char_addr == 53) &
(   //CHAR: "r"
    (row == 2 && col == 1) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 2) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 2) ||
    (row == 5 && col == 2) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3)
)
||
(char_addr == 54) &
(   //CHAR: "s"
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 1) ||
    (row == 4 && col == 2) ||
    (row == 4 && col == 3) ||
    (row == 4 && col == 4) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 55) &
(   //CHAR: "t"
    (row == 1 && col == 2) ||
    (row == 2 && col == 1) ||
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 2) ||
    (row == 4 && col == 2) ||
    (row == 5 && col == 2) ||
    (row == 5 && col == 4) ||
    (row == 6 && col == 3)
)
||
(char_addr == 56) &
(   //CHAR: "u"
    (row == 2 && col == 1) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 4) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 3) ||
    (row == 5 && col == 4) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 4)
)
||
(char_addr == 57) &
(   //CHAR: "v"
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 2) ||
    (row == 5 && col == 4) ||
    (row == 6 && col == 3)
)
||
(char_addr == 58) &
(   //CHAR: "w"
    (row == 2 && col == 1) ||
    (row == 2 && col == 5) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 5) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 3) ||
    (row == 4 && col == 5) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 2) ||
    (row == 5 && col == 3) ||
    (row == 5 && col == 4) ||
    (row == 5 && col == 5) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 4)
)
||
(char_addr == 59) &
(   //CHAR: "x"
    (row == 2 && col == 1) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 2) ||
    (row == 4 && col == 3) ||
    (row == 5 && col == 1) ||
    (row == 5 && col == 4) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 4)
)
||
(char_addr == 60) &
(   //CHAR: "y"
    (row == 2 && col == 1) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 1) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 1) ||
    (row == 4 && col == 4) ||
    (row == 5 && col == 2) ||
    (row == 5 && col == 3) ||
    (row == 5 && col == 4) ||
    (row == 6 && col == 3) ||
    (row == 7 && col == 1) ||
    (row == 7 && col == 2)
)
||
(char_addr == 61) &
(   //CHAR: "z"
    (row == 2 && col == 1) ||
    (row == 2 && col == 2) ||
    (row == 2 && col == 3) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 4) ||
    (row == 4 && col == 2) ||
    (row == 4 && col == 3) ||
    (row == 5 && col == 1) ||
    (row == 6 && col == 1) ||
    (row == 6 && col == 2) ||
    (row == 6 && col == 3) ||
    (row == 6 && col == 4)
)
||
(char_addr == 62) &
(   //CHAR: "/"
    (row == 1 && col == 5) ||
    (row == 2 && col == 4) ||
    (row == 3 && col == 3) ||
    (row == 4 && col == 2) ||
    (row == 5 && col == 1)
)
||
(char_addr == 63) & 0//CHAR: " "
;
endmodule
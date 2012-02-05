call ..\[ x86_aam.gif
call ..\t 00 "AAM (with non standard operand)"
call ..\t 02 "setting AL"
call ..\t 03 "executing AAM 3"
call ..\t 04 "AH, AL = AL / OP, AL % OP = 13h, 1
call ..\tse 05 "<end>"
call ..\tse 06 "<end>"
call ..\] x86_aam-.gif
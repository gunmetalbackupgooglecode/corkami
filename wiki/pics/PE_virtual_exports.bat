call ..\[ PE_virtual_exports.gif

call ..\t 00 "external and virtual exports"
call ..\t 02 "giving EAX a correct value for 00 00
call ..\t 03 "getting export at RVA -1"
call ..\t 04 "adjusting
call ..\t 05 "jumping
call ..\t 08 "jumping to virtual export
call ..\t 09 "(in virtual space)...
call ..\t 10 ...
call ..\t 11 ...
call ..\t 12 "...about to reach the first section
call ..\t 13 "(back in physical space)
call ..\t 14 "execution goes on normally
call ..\tse 15 "<end>
copy _ex15.gif _ex16.gif

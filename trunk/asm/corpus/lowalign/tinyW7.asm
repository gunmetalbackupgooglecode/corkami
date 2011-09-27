; a 268-byte PE (as small as possible), W7 Compatible

; technically, it's like the 97 bytes XP tiny PE, except that we need to fill with zeroes up to 268...
; so we can fit code, imports and data

;Ange Albertini, BSD Licence, 2010-2011

%include '..\..\consts.inc'

IMAGEBASE equ 400000h

org IMAGEBASE

DOS_HEADER:
.e_magic       dw 'MZ'

align 4, db 0

istruc IMAGE_NT_HEADERS
    at IMAGE_NT_HEADERS.Signature, db 'PE',0,0
iend
istruc IMAGE_FILE_HEADER
    at IMAGE_FILE_HEADER.Machine,               dw IMAGE_FILE_MACHINE_I386
    at IMAGE_FILE_HEADER.Characteristics,       dw IMAGE_FILE_EXECUTABLE_IMAGE | IMAGE_FILE_32BIT_MACHINE
iend

istruc IMAGE_OPTIONAL_HEADER32
    at IMAGE_OPTIONAL_HEADER32.Magic,                     dw IMAGE_NT_OPTIONAL_HDR32_MAGIC
    at IMAGE_OPTIONAL_HEADER32.AddressOfEntryPoint,       dd EntryPoint - IMAGEBASE
    at IMAGE_OPTIONAL_HEADER32.ImageBase,                 dd IMAGEBASE
    at IMAGE_OPTIONAL_HEADER32.SectionAlignment,          dd 4      ; also sets e_lfanew
    at IMAGE_OPTIONAL_HEADER32.FileAlignment,             dd 4
    at IMAGE_OPTIONAL_HEADER32.MajorSubsystemVersion,     dw 4
    at IMAGE_OPTIONAL_HEADER32.SizeOfImage,               dd 40h    ; can't be smaller
    at IMAGE_OPTIONAL_HEADER32.Subsystem,                 db IMAGE_SUBSYSTEM_WINDOWS_CUI
    at IMAGE_OPTIONAL_HEADER32.NumberOfRvaAndSizes,       dd 2
iend

; data directories
dd 0, 0
dd Import_Descriptor - IMAGEBASE

bits 32
EntryPoint:
    push helloworld
    call [__imp__printf]
    add esp, 1 * 4
    retn

helloworld db " * tiny 268 bytes PE (W7)", 0ah, 0

Import_Descriptor:
;msvcrt.dll_DESCRIPTOR
    dd msvcrt.dll_hintnames - IMAGEBASE
    dd 0, 0
    dd msvcrt.dll - IMAGEBASE
    dd msvcrt.dll_iat - IMAGEBASE
;terminator
    dd 0, 0, 0, 0, 0

hnprintf:
    dw 0
    db 'printf', 0

msvcrt.dll_iat:
__imp__printf:
    dd hnprintf - IMAGEBASE
    dd 0

msvcrt.dll_hintnames:
    dd hnprintf - IMAGEBASE
    dd 0

msvcrt.dll  db 'msvcrt.dll'

;filling up to 268 bytes for W7, irritating... :(
times 15 db 0
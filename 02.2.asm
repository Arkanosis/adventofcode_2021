          global    _start

          section   .text
_start:
          mov       rsi, 0                  ; O_RDONLY
          mov       rdi, filename
          mov       rax, 2                  ; open
          syscall

          mov       r8, rax                 ; file descriptor
          mov       r9, 0                   ; position
          mov       r10, 0                  ; depth
          mov       r15, 0                  ; aim

fill:
          mov       rdx, 4096
          mov       rsi, buffer
          mov       rdi, r8                 ; file descriptor
          mov       rax, 0                  ; read
          syscall

          cmp       rax, 0
          jz        eof

          mov       r13, rax                ; available characters
          mov       r14, 0                  ; character offset

dive:
          cmp       r14, r13
          je        fill
          movzx     r11, byte [buffer + r14]; command
          inc       r14
          mov       r12, 0                  ; value

atoi:
          cmp       r14, r13
          je        fill
          movzx     rbx, byte [buffer + r14]; digit
          inc       r14

          cmp       rbx, 10                 ; new line
          je        move

          cmp       rbx, '0'
          jb        atoi

          cmp       rbx, '9'
          jg        atoi

          sub       rbx, '0'
          mov       rax, r12
          mov       rcx, 10                 ; base
          mul       rcx
          mov       r12, rax
          add       r12, rbx

          jmp       atoi

move:
          cmp       r11, 'f'
          je        forward

          cmp       r11, 'd'
          je        down

          cmp       r11, 'u'
          je        up

forward:
          add       r9, r12
          mov       rax, r12
          mul       r15
          add       r10, rax
          jmp       dive

down:
          add       r15, r12
          jmp       dive

up:
          sub       r15, r12
          jmp       dive

eof:
          mov       rdi, r8                 ; file descriptor
          mov       rax, 3                  ; close
          syscall

          mov       rax, r9
          mul       r10
          mov       r13, rax                ; result

          mov       byte [buffer + 21], 10  ; new line
          mov       r14, 20                 ; digit offset
          mov       r10, 10                 ; base

itoa:
          mov       rdx, 0
          mov       rax, r13
          div       r10
          mov       r13, rax
          mov       r8, rdx

          mov       r15, '0'                ; digit
          add       r15, r8

          mov       byte [buffer + r14], r15b
          dec       r14

          cmp       r13, 0
          jnz       itoa

          mov       rsi, buffer             ; string
          add       rsi, r14
          inc       rsi

          mov       rdx, buffer             ; string length
          add       rdx, 22
          sub       rdx, rsi

          mov       rdi, 1                  ; STDOUT_FILENO
          mov       rax, 1                  ; write
          syscall

          mov       rdi, 0                  ; EXIT_SUCCESS
          mov       rax, 60                 ; exit
          syscall

          section   .data
filename: db        "02.input", 0

          section   .bss
buffer:   resb      4096


; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

;iniciar pantalla
mov ah, 00h
mov al, 03h
int 10h

;Adolfo Josue Monterroso Elias 0901-18-50
;Jaime Noel Lopez Daniel 0901-18-735

menu:
    mov ah, 09h
    mov al, 00h
    mov dx, offset menuT;
    int 21h
    
    ;muestra el menu principal
    call salto
    mov dx, offset m1
    int 21h
    call salto
    mov dx, offset m2
    int 21h
    call salto
    mov dx, offset m3
    int 21h
    call salto
    mov dx, offset m4
    int 21h
    call salto
    mov dx, offset m5
    int 21h
    call salto
    
    ;pedir el dato
    mov ah, 01h; con 01 muestra el dato
    ;mov ah, 07h; con 07 no mostrara el dato
    int 21h
    
    ;validar si esta en el rango
    ;1 = 31h
    ;5 = 35h
    ; si al es mayor a 35h (a 5), salta
    cmp al, 35h
    ja error
    ; si es menor a 31h (a 1), salta
    cmp al, 31h
    jb error
    
    cmp al,31h;compara si es 1
    jz OP1;salta a OP1 si al=31h
    
    cmp al,32h;compara si es 2
    jz OP2;salta a OP2 si al=32h
    
    cmp al,33h;compara si es 3
    jz OP3; salta a OP3 si al=33h
    
    cmp al,34h; compara si es 4
    jz OP4; salta a OP4 si al=34h
    
    cmp al,35h; compara si es 5
    jz OP5; salta a OP5 si al=35h
    
    ;si en dado caso para todo esto y no salta
    jmp error
    
error:
    ;en caso de haber error, debe mostrar de nuevo
    ;todo
    ;y limpiar pantalla
    call salto
    ;muestro si errror
    mov ah, 09h
    mov dx, offset erro
    int 21h
    call pausa
    call limpiar
    ;deregreso
    jmp menu     
    
OP1:
    call salto
    ;operaciones basicas
    mov ah, 09h
    mov dx, offset sm1
    int 21h
    call pausa
    call limpiar
    jmp menu
    
    
OP2:
    call salto
    ;el juego
    mov ah, 09h
    mov dx, offset sm2
    int 21h
    call pausa
    call limpiar
    jmp menu
    
OP3:
    call salto
    ;manipulacion de cadenas
    mov ah, 09h
    mov dx, offset sm3
    int 21h
    call pausa
    call limpiar
    jmp menu

OP4:
    call salto
    ;ops recurrentes
    mov ah, 09h
    mov dx, offset sm4
    int 21h
    call pausa
    call limpiar
    jmp menu

OP5:
    call salto
    ;mensaje salida
    mov ah, 09h
    mov dx, offset sm5
    int 21h
    call pausa
    call limpiar
    ret;regresar para salir
    ;si esto no funciona, hacer un jmp a una opcion hasta el final del programa
        
;otras etiquetas de submenus

ret
;variables
menuT db "Seleccione una opcion$"
saltoRetorno db 10d,13d,"$"
m1 db "1) Operaciones Basicas$"
m2 db "2) Juego$"
m3 db "3) Manipulacion de cadenas$"
m4 db "4) Operaciones de Recurrencia$"
m5 db "5) Salida$"
sm1 db "Operaciones Basicas$"
sm2 db "Juego$"
sm3 db "Manipulacion de cadenas$"
sm4 db "Operaciones de Recurrencia$"
sm5 db "Adios$"
erro db "Error, seleccione de nuevo$"
preT db "Presione una tecla para continuar$"

;Procedimientos

salto PROC
    mov ah, 09h
    mov dx, offset saltoRetorno
    int 21h;muestra el salto de linea con retorno
    ret;regresa a donde se quedo
salto ENDP

pausa PROC
    call salto
    ;muestra presione tecla
    mov ah, 09h
    mov dx, offset preT
    int 21h
    ;salta
    call salto
    ;pide el dato
    ;mov ah, 01h
    ;mov 07 para que nos mostremos el dato
    mov ah, 07h
    int 21h
    ;salta
    call salto
    ret;y regresa a donde estaba
pausa ENDP

limpiar PROC
    ;fila 0 a 24 25 * 80?
    ;col 0 a 79
    ;cursor a posicion inicial
    mov ah, 02h
    mov al, 00h
    mov dh, 00h
    mov dl, 00h
    mov bh, 00h
    mov bl, 00h
    int 10h
    
    ;limpiar pantalla
    mov ah, 06h
    mov al, 00h
    mov bh, 07h ;fondo negro, letra blanca
    mov bl, 00h
    mov ch, 00h ;fila inicial 0
    mov cl, 00h ; col inicial 0
    mov dh, 24d ;fila fin 
    mov dl, 79d ;col fin 
    int 10h
    
    ;cursor a posicion inicial
    mov ah, 02h
    mov al, 00h
    mov dh, 00h
    mov dl, 00h
    mov bh, 00h
    int 10h
    
    ret
limpiar ENDP
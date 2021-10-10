
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
    mov ah, 09h
    mov dx, offset smob
    int 21h
    mov ah, 01h; con 01 muestra el dato
    ;mov ah, 07h; con 07 no mostrara el dato
    int 21h
    ; si al es mayor a 33h (a 3), salta
    cmp al, 33h
    ja error
    ; si es menor a 31h (a 1), salta
    cmp al, 31h
    jb error
    
    cmp al,31h;compara si es 1
    jz SOP1;salta a SOP1 si al=31h
    
    cmp al,32h;compara si es 2
    jz SOP2;salta a SOP2 si al=32h
    
    cmp al,33h;compara si es 3
    jz SOP3; salta a SOP3 si al=33h
    
    
    
OP2:
    call salto
    ;el juego
    mov ah, 09h
    mov dx, offset sm2
    int 21h
    call pausa
    call limpiar
    jmp juego
    
OP3:
    call salto
    ;manipulacion de cadenas
    mov ah, 09h
    mov dx, offset sm3
    int 21h
    call pausa
    call limpiar
    jmp manip

OP4:
    call salto
    ;ops recurrentes
    mov ah, 09h
    mov dx, offset sm4
    int 21h
    call pausa
    call limpiar
    jmp recur

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

SOP1:
;Subopcion para resta
call salto
call limpiar       
;Bienvenida e ingreso numero 1
mov ah, 09h
mov dx, offset smre
int 21h
mov ah, 01h; con 01 muestra el dato
;mov ah, 07h; con 07 no mostrara el dato
int 21h
mov d1r,al
call salto
;Termina ingreso numero 1
mov ah, 09h
mov dx, offset smre2
int 21h
mov ah, 01h; con 01 muestra el dato
;mov ah, 07h; con 07 no mostrara el dato
int 21h
mov d2r,al
mov bl,d2r
call salto
;Termina ingreso numero 2
;Calculo de la resta:
sub d1r,bl
mov ah, 09h
mov dx, offset smre3
int 21h
;Termina resultado de resta
call pausa
call salto
call limpiar       

jmp menu

SOP2:
;Subopcion para cuadrado
call salto
call limpiar       
mov ah, 09h
mov dx, offset smcd
int 21h         
;Recibimos el dato ingresado por el usuario
mov ah, 01h; con 01 muestra el dato
;mov ah, 07h; con 07 no mostrara el dato
int 21h
;Almacenamos en dcu el dato ingresado por el usuario
mov dcu,al                                          
;Eliminamos las decenas del dato ingresado 
and dcu,00001111b                          
;Limpiamos registros y copiamos dato para realizar cuadrado a traves de mul
mov al,0h
mov ah,0h
mov al,dcu
mov bh,dcu
;Se efectua el cuadrado
mul bh
;Almacenamos en dcu1 el resultado del 
mov dcu1,ax
call salto
call pausa    
call salto
call limpiar       
jmp menu

SOP3:
;Subopcion para base 3
call salto
call limpiar       
mov ah, 09h
mov dx, offset smb3
int 21h
call pausa
call salto
call limpiar       
jmp menu     

juego:
;Opcion para realizar juego
call salto
call limpiar       
mov ah, 09h
mov dx, offset smjg
int 21h
call pausa
call salto
call limpiar       
jmp menu     

manip:
;Opcion para realizar manipulacion de cadena
mov ah, 09h
mov dx, offset smsc
int 21h
call pausa
call salto
call limpiar       
jmp menu     

recur:
;Opcion para realizar opcion de recurrencia
mov ah, 09h
mov dx, offset smor
int 21h               
;Ingresa datos el usuario
;Ingresa numero inicial
mov ah, 09h
mov dx, offset sini
int 21h            
;Recibimos el dato ingresado por el usuario
mov ah, 01h; con 01 muestra el dato
;mov ah, 07h; con 07 no mostrara el dato
int 21h
;Almacenamos en dcu el dato ingresado por el usuario
mov nini,al                                          
;Ingresa numero a sumar
mov ah, 09h
mov dx, offset ssum
int 21h               
;Recibimos el dato ingresado por el usuario
mov ah, 01h; con 01 muestra el dato
;mov ah, 07h; con 07 no mostrara el dato
int 21h                           
;Almacenamos en dcu el dato ingresado por el usuario
mov nsum,al                                          
;Ingresa cantidad de terminos a visualizar
mov ah, 09h
mov dx, offset ster
int 21h                  
;Recibimos el dato ingresado por el usuario
mov ah, 01h; con 01 muestra el dato
;mov ah, 07h; con 07 no mostrara el dato
int 21h   
call salto
;Almacenamos en dcu el dato ingresado por el usuario
mov nter,al       
;Finaliza ingreso de datos                                   
call pausa
call salto
call limpiar       
jmp menu     


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
smob db "Ingrese la operacion que desea",10,13,"1.Resta",10,13,"2.Cuadrado",10,13,"3.Conversion a base3",10,13,"$"
smjg db "Bienvenido al juego de adivinar una letra, numero o simbolo",10,13,"$"
smsc db "Bienvenido a manipulacion de cadena",10,13,"$"
smor db "Bienvenido a opciones de recurrencia, Serie Aritmetica",10,13,"$"
sini db 10,13,"Ingrese el numero inicial: ",10,13,"$"
ssum db 10,13,"Ingrese el numero a sumar al numero inicial: ",10,13,"$"
ster db 10,13,"Ingrese la cantidad de terminos a visualizar: ",10,13,"$" 
smre db "Bienvenido a resta, ingrese el primer numero: ",10,13,"$"
smre2 db "Ingrese el segundo numero: ",10,13,"$"
smre3 db "El resultado de el primer numero menos el segundo es: ",10,13,"$"
smcd db "Bienvenido a cuadrado, ingrese 1 numero: ",10,13,"$"
smb3 db "Bienvenido a conversor a base 3, ingrese el numero: ",10,13,"$"
d1r db ? ;Variable para almacenar dato 1 y resultado de la resta
d2r db ? ;VAriable para almacenar dato 2 y numero que resta a dato 1
dcu db ? ;Variable para almacenar dato para el cuadrado
dcu1 dw ?;Variable para almacenar el resultado del dato al cuadrado                                                                 
nini db ? ;Variable para pedir numero inicial serie aritmetica
nsum db ? ;Variable para pedir numero a sumar serie aritmetica
nter db ? ;Variable para pedir cantidad de terminos serie aritmetica

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
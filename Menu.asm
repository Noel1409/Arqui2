
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
;imprimir resultado resta (de momento solo esta para un digito)
mov dl, d1r; traemos el valor resultado
OR dl, 00110000b;convertimos a ascii antes de imprimir
mov dh, 00h
mov ah, 02h;modo para imprimir un solo caracter
mov al, 00h
int 21h

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
;imprimir cadena indicatoria:
mov ah, 09h
mov al, 00h
mov dx, offset resCuadrado
int 21h

;imprimir resultado
;PENDIENTE: Ajustar el resultado para que se puedan
;tener los ascii de las decenas y las unidades
;por aparte
;y luego mostrarlas
mov ax, dcu1   ; como al hacer salto se modificn
;los registros de ax, copiamos de regreso el valor
;original que se calculo
;luego hacemos el
aam;ajuste ascci para la multiplicaicon
;en ah van las decenas
;en al van las unidades
OR ah, 30h;agregamos el 3 para convertir a ascii
OR al, 30h;agregamos el 3 para convertir a ascii
;en este momento ya tenemos el resultado en ascii del cuadrado en el registro ax
;lo que haremos sera imprimir caracter por caracter, para eso:
mov dl, ah; copiamos el valor de las decenas en dl
mov dh, al; como al se modificara al interrumpir pantalla, 
;copiaremos el valor de las unidades a dh, el cual no se modificara

mov ah, 02h; en este modo llamara a la interrupcion para imprimir solo un caracter
int 21h;imprimimos la decena
;ahora usaremos la copia del valor de al que tenemos en dh para imprimir las unidades
mov dl, dh; copiamos el valor de dh en dl (dl contiene el caracter a mostrar en pantalla)
mov ah, 02h;valga redundancia igual volvemos a indicar que ah va en modo 02h 
mov al, 00h
int 21h; imprimimos las unidades

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
int 21h;muestra el mensaje
call salto;
;calcular # al azar
;mostrar una cadena
;pedir el ingreso de una letra que sea la faltante
;saltar segun el # de palabra mostrada

;Primero mostramos los mensajes
mov dx, offset msjJuego1;
int 21h
;ahora generamos un # al azar para escoger entre los nombres 
call salto;
mov ax, 0000h
int 1ah;interrupcion para obtener num del reloj
;el resultado se guarda en DX
;tomaremos solo en # mas bajo de DX y lo usaremos para ver las posibilidades
;entre 0 a F
AND dx, 000Fh;deja solo lo + bajo
mov bx, dx ; copiamos el # en bx
;y lo mostramos para ver si vamos bien
;pero para eso lo ponemos en ASCII
mov ax, 0000h
mov ah, 02h
OR dl,30h;para ascii / puede mostrar simbolos raros por los HEX
int 21h
;ahora debo ver que muestro
mov ah, 09h;preparo para mostrar segun el azar
;evaluo el valor en bl para ver que pkmn llamo
cmp bl, 0h
je pkmn0

cmp bl, 1h
je pkmn1

cmp bl, 2h
je pkmn2

cmp bl, 3h
je pkmn3

cmp bl, 4h
je pkmn4

cmp bl, 5h
je pkmn5

cmp bl, 6h
je pkmn6

cmp bl, 7h
je pkmn7

cmp bl, 8h
je pkmn8

cmp bl, 9h
je pkmn9

cmp bl, 0ah
je pkmnA

cmp bl, 0bh
je pkmnB     

cmp bl, 0ch
je pkmnC

cmp bl, 0dh
je pkmnD

cmp bl, 0eh
je pkmnE

;el ultimo caso no lo evaluamos xq ya sabemos que si no salto antes
;saltara ahora
jmp pkmnF

pkmn0:
    mov dx, offset poke0
    int 21h
    mov bl, 'g';le indicamos la letra faltante para esta opcion
    call salto
    jmp finJuego
                
pkmn1:
    mov dx, offset poke1
    int 21h
    mov bl, 'i'
    call salto
    jmp finJuego
                
pkmn2:
    mov dx, offset poke2
    int 21h
    mov bl, 'a'
    call salto
    jmp finJuego
    
pkmn3:
    mov dx, offset poke3
    int 21h
    mov bl, 't'
    call salto
    jmp finJuego

pkmn4:
    mov dx, offset poke4
    int 21h
    mov bl, 'u'
    call salto
    jmp finJuego

pkmn5:
    mov dx, offset poke5
    int 21h
    mov bl, 'a'
    call salto
    jmp finJuego

pkmn6:
    mov dx, offset poke6
    int 21h
    mov bl, 'e'
    call salto
    jmp finJuego

pkmn7:
    mov dx, offset poke7
    int 21h
    mov bl, 'e'
    call salto
    jmp finJuego

pkmn8:
    mov dx, offset poke8
    int 21h
    mov bl, 'a'
    call salto
    jmp finJuego

pkmn9:
    mov dx, offset poke9
    int 21h
    mov bl, 'o'
    call salto
    jmp finJuego

pkmnA:
    mov dx, offset pokeA
    int 21h
    mov bl, 'l'
    call salto
    jmp finJuego

pkmnB:
    mov dx, offset pokeB
    int 21h
    mov bl, 'g'
    call salto
    jmp finJuego

pkmnC:
    mov dx, offset pokeC
    int 21h
    mov bl, 'e'
    call salto
    jmp finJuego

pkmnD:
    mov dx, offset pokeD
    int 21h
    mov bl, 'c'
    call salto
    jmp finJuego

pkmnE:
    mov dx, offset pokeE
    int 21h
    mov bl, 'b'
    call salto
    jmp finJuego

pkmnF:
    mov dx, offset pokeF
    int 21h
    mov bl, 'g'
    call salto
    jmp finJuego

finJuego:;usado para pedir caracter 
    mov ah, 01h;pide dato
    int 21h
    
    ;el dato queda en al
    mov cl, al
    call salto
    mov ah,09h
    mov al,00h
    ;ahora validamos si acerto o si no...
    cmp cl,bl;validamos el dato que puso con el que habiamos dicho que era en las opciones
    je acerto; si son iguales acerto
    jmp noAcerto; si no son iguales no acerto

acerto:
    ;mostrar cadena de acerto
    mov dx, offset YESJ
    int 21h
    jmp SalirJuego ; y salir del juego    

noAcerto:
    mov dx, offset NOJ
    int 21h
    jmp SalirJuego;    

SalirJuego:    
    call pausa
    call salto
    call limpiar       
    jmp menu

manip:
;Opcion para realizar manipulacion de cadena
    mov ah, 09h
    mov dx, offset smsc
    int 21h
    ;este es el mensaje inicial
    mov di, 2000h; empezare desde aqui para no topar con el codigo
    mov [di], '%';con este indicare el inicio de la cadena
    jmp pideCar;pasamos a pedir caracter

pideCar:    
    inc di;incremento la pos de memo donde guardo el resultado
    mov ah, 01h
    mov al, 00h
    int 21h;pido caracter
    ;ahora que esta en al, comparo si no es %, y si no lo es, continuo
    cmp al, 25h
    je manip2; si lo es, ahora debo mostrar la cadena invetida
    ; si no, sigo
    mov [di],al
    jmp pideCar

manip2:
    call salto
    call salto
    ;mensaje para decir esta es la cadena invertida:
    mov ah, 09h
    mov al, 00h
    mov dx, offset cadInv
    int 21h;
    
    dec di;como di aumento para el % final, pero este no se guardo
    ;no es necesario acceder a esa posicion
    ;configura ah para imprimir
    mov ah, 02h
    mov al, 00h
    jmp imprInv;imprime la cadena invertida
    
imprInv:
    mov dl, [di]
    cmp dl, 25h;compara si no es el % del inicio
    je finManip; si lo es, salta al final
    ;si no, sigue imprimiendo
    int 21h;imprime el caracter
    dec di;decrementa di
    jmp imprInv;ahora con la siguiente

finManip:;finaliza la manipulacion de cadenas
    call salto
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
;Almacenamos en dcu el dato ingresado por el usuario
mov nter,al
call salto
       
;Finaliza ingreso de datos                                   
;ahora a sumar y mostrar
;tratarlo como decenas
;nini # inicial
;nsum # a sumar
;nter cantidad
mov cl, 00h;debera llegar a ser igual al nter
mov bl, nini; el registro que llevara la cuenta del #actual
mov bh, 00h
mov dh, nsum; el registro que llevara el # a sumar
;pasamos los datos de ascii a #
mov dl, nter
AND dl, 00001111b
mov nter, dl;ahora el contador ya tendra el # como tal

AND bl, 00001111b;dejamos el num inicial como numero

AND dh, 00001111b
mov nsum, dh;ahora el # a sumar ya esta en numero

call salto
;ahora toca a empezar la suma
jmp rec1

rec1:
    inc cl;incremento el contador
    add bl, nsum;el num actual + el num a sumar
    mov ax, bx ; copiamos los valores de bx en ax para el ajuste
    aam;ajuste a la suma
    ;ahora en AH tendremos decenas y en AL unidades
    ;ajustamos a Ascii
    OR ah, 30h
    OR al, 30h
    ;aaa;ajuste a la suma
    ;lo hago aca para ver que pasa
    mov [1],ah;pondremos en la pos 1 de memo el valor de las decenas
    mov [2],al;el valor de las unidades en la pos 2 de memo
    ;ahora imprimimos el resultado
    mov ah, 02h
    mov al, 00h
    mov dl, [1];decenas primero
    int 21h
    mov dl, [2];unidades siguiente
    int 21h
    mov dl, 20h;espacio
    int 21h
    ;ahora que ya imprimimos todo, comparemos si cl es igual al contador
    cmp cl, nter
    je finRec;fin de recurrencia
    ;si no es el fin, seguimos recurriendo
    jmp rec1
    
finRec:
    call salto   
    call pausa
    call salto
    call limpiar       
    jmp menu     
;ret;? daba error de overflow?
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
smjg db "Bienvenido al juego de adivinar el simbolo faltante:",10,13,"$"
smsc db "Bienvenido a manipulacion de cadena",10,13,"Ingrese cadena a invertir, indique su final con el caracter %:",10,13, "$"
smor db "Bienvenido a opciones de recurrencia, Serie Aritmetica",10,13,"$"
sini db 10,13,"Ingrese el numero inicial: ",10,13,"$"
ssum db 10,13,"Ingrese el numero a sumar al numero inicial: ",10,13,"$"
ster db 10,13,"Ingrese la cantidad de terminos a visualizar: ",10,13,"$" 
smre db "Bienvenido a resta, ingrese el primer numero: ",10,13,"$"
smre2 db "Ingrese el segundo numero: ",10,13,"$"
smre3 db "El resultado de el primer numero menos el segundo es: ",10,13,"$"
smcd db "Bienvenido a cuadrado, ingrese 1 numero: ",10,13,"$"
smb3 db "Bienvenido a conversor a base 3, ingrese el numero: ",10,13,"$"
resCuadrado db "El resultado del cuadrado es: $"
cadInv db "La cadena invertida es: ",10,13,"$"
msjJuego1 db "Debe indicar la letra que falta en el nombre del pokemon:",10,13,"Solo tiene un intento, ingrese la letra en minusculas",10,13,"$"
poke1 db "P?kachu",10,13,"$"
poke2 db "Ch?riz?rd",10,13,"$"
poke3 db "Squir?le",10,13,"$"
poke4 db "B?lbasa?r",10,13,"$"
poke5 db "Di?lg?",10,13,"$"
poke6 db "M?w",10,13,"$"
poke7 db "??v??",10,13,"$"
poke8 db "M?gik?rp",10,13,"$"
poke9 db "Sn?rlax",10,13,"$"
pokeA db "Abso?",10,13,"$"
pokeB db "Dra?onite",10,13,"$"
pokeC db "Gard?voir",10,13,"$"
pokeD db "Lu?ario",10,13,"$"
pokeE db "Um?reon",10,13,"$"
pokeF db "Gen?ar",10,13,"$"
poke0 db "Ji??lypuff",10,13,"$"
YESJ db "Acierto! Felicidades!",10,13,"$"
NOJ db "Fallo! Mala suerte!",10,13,"$"
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

;pokemon PROC
    ;elegira una cadena de pkmn y la muestra
;    mov ah, 09h
;    mov dx, offset poke0
;    int 21h
;    call salto
    
;    ret
;pokemon ENDP
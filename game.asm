.model small
.stack 100H
.data
title1 DB "Brick Breaker ", '$'
pause1 db "    --- Game Paused ---", '$'
pause2 db "--- Press P To Continue ---", '$'
pause_clear1 db "                       ", '$'
pause_clear2 db "                           ", '$'
;;;;;;;;;;;FileH
file db "HighScores.txt", '$'
h dw 0
buff dw 100 dup ('$')
score_str db "  ", '$'
cor_x dw 0
cor_y dw 0
;;;;;;;;;;;;
instructions_1 db "  --- Instructions ---  ", '$'
instructions_2 db "   1) Use Left & Right Arrow Keys to Move Paddle   ", '$'
instructions_3 db "   2) After Every Level Ball Speed Will Increase   ", '$'
instructions_4 db "   3) The Level Number Tells You How Many Times The Ball Must Hit   ", '$'
instructions_5 db "      To Remove Bricks   ", '$'
instructions_6 db "   4) You Have 3 Lives & 4 Minutes To Finish The Game   ", '$'
instructions_7 db "   5) You Loose a Life Everytime The Ball Goes Below the Paddle   ", '$'
instructions_8 db "   6) Eliminate Bricks On All 3 Levels To Win a Special Prize   ", '$'
instructions_exit db "   Press Any Key To Continue...   ", '$'
show_level_1 db "-----------------------LEVEL 1----------------------------",'$'
show_level_2 db "-----------------------LEVEL 2----------------------------",'$'
show_level_3 db "-----------------------LEVEL 3----------------------------",'$'
;;;;;;;;;;;
menu_1 db "  --- MAIN MENU ---  ", '$'
menu_2_0  db "* * * * * * * * * * * *", '$'
menu_2_1 db "**    New Game       **", '$'
menu_2_2 db "* * * * * * * * * * * *", '$'

menu_3 db   "**   Instructions    **", '$'
menu_4 db   "**   Leaderboard     **", '$'
menu_5 db   "**       Exit        **", '$'
arrow db "-->", '$'
arrow_clear db "    ", '$'
arrow_row db 7
arrow_col db 23
number_arrow db 0
;;;;;;;;;;;
len_var1 equ $ - title1
io3 db '$'
count_var1 db 0
MSG  DB ' Enter Name --> ','$'
len_MSG equ $ - MSG
STR1 DB  "            ", '$'
num1 db 0
ball_x dw 300
ball_y dw 370
ball_x_2 dw ?
ball_y_2 dw ?
ball_color db 0FH
ball_restart_pos_x dw 300
ball_restart_pos_y dw 360
speed_ball_x dw 2
speed_ball_y dw 12
height_min dw 40
height_max dw 417;screen x final h
width_max dw 599;screen y final w
width_max2 dw 599;screen y final w
width_least2 dw 42
score db 'Score: ', '$'
score_dh db ?
score_dl db ?
score_var dw 0
countt db 0
highest_score dw 160
highest_score2 dw 320
start11 db 0
var1 db 0
var2 db 0
var3 db 0
var4 db 0
var5 db 0
var6 db 0
var7 db 0
var8 db 0
var9 db 0
var10 db 0
var11 db 0
var12 db 0
var13 db 0
var14 db 0
var15 db 0
var16 db 0
;;;;;;;;;;;;;;;;;
var2_1 db 1
var2_2 db 1
var2_3 db 1
var2_4 db 1
var2_5 db 1
var2_6 db 1
var2_7 db 1
var2_8 db 1
var2_9 db 1
var2_10 db 1
var2_11 db 1
var2_12 db 1
var2_13 db 1
var2_14 db 1
var2_15 db 1
var2_16 db 1
;;;;;;;;;;;;;;;;;BLOCK
count db ?
blockx dw ?
blocky dw ?
block_bx1 dw ?
block_bx2 dw ?
block_color db ?
dummy dw ?
blockxx dw 50, 80, 120, 80, 190, 80, 260, 80, 330, 80, 400, 80, 470, 80, 540, 80,
            50, 150, 120, 150, 190, 150, 260, 150, 330, 150, 400, 150,470, 150,540, 150
block_temp_x1 dw 50
block_temp_x2 dw 50
block_temp_y1 dw 80
block_temp_y2 dw 150
block_arr db 17 dup(1)
;;;;;;;;;;;;;;;;;
lives_str db "LIVES: ",'$'
heart_var dw 3
heart_var2 dw 0
secs db ?
sec1 db 0
sec2 db ?
min db 0
text db ' $'
seconds  db 99
;;;;;;;;;;;;;;;;;
bar_x dw 250
bar_y dw 375
bar_x_2 dw ?
bar_y_2 dw ?
bar_restart_x dw 250
bar_restart_y dw 375
bar_height dw 10
bar_width dw 100
speed_paddle dw 8
ball_size dw 08
sys_time db 0
;;;;;;;;;;;;;;;;;;;;;;;
lose_x1 db 12
lose_y1 db 15
lose_x2 db 13
lose_y2 db 15
lose_x3 db 14
lose_y3 db 15
lose_x4 db 15
lose_y4 db 15
lose_x5 db 16
lose_y5 db 15
lose_x6 db 17
lose_y6 db 15
lose1 db "***********************************", '$'
lose2 db "**                               **", '$'
lose3 db "**        TIME'S UP.....         **", '$'
lose4 db "**        YOU LOOSE.....         **", '$'
lose5 db "**                               **", '$'
lose6 db "***********************************", '$'
lose3_1 db "**      LIVES FINISHED.....      **", '$'
win3 db  "**        WoWWiEEEEE....         **", '$'
win4 db  "**        YOU WON !!....         **", '$'
;;;;;;;;;;;;;;;;;;;;;;

.code
mov ax, @DATA
mov ds,ax

DRAW_ROW  MACRO X  
    LOCAL L1
    MOV AH,0CH
    MOV AL,6        
    MOV CX,40
    MOV DX,X
    L1:
        INT 10H
        INC CX
        CMP CX,600
        JL L1

    
ENDM   

DRAW_COLUMN MACRO   Y
    LOCAL L2
    MOV AH,0CH
    MOV AL,6
    MOV CX,Y
    MOV DX,40
    L2:
        INT 10H
        INC DX
        CMP DX,428
        JL L2
ENDM

block2 macro blockx,blocky,block_color
LOCAL Line2
LOCAL Line1
mov dx, blocky
mov bx, 30

Line2:
mov count,bl
mov bx, 50
mov cx, blockx

Line1:

mov ah, 0Ch
mov al, block_color
int 10h
dec bx
inc cx
cmp bx, 0
jne Line1
mov bl,count
dec bx
inc dx
cmp bx, 0
jne Line2
endm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Main Proc

mov ah, 0
mov al, 02h
int 10h

mov dl, 10
mov ah, 0002h
int 21h

mov dl, 10
mov ah, 0002h
int 21h

mov cx, 6
.while ( cx > 0)
mov dl, 10
mov ah, 0002h
int 21h
dec cx
.endw

mov cx, 30
.while ( cx > 0)
mov dl, 00
mov ah, 0002h
int 21h
dec cx
.endw


; mov ah, 09h
; mov bl, 02h
; mov cx, 01h
; int 10h


mov dx, offset title1
MOV AH,09H
INT 21H

mov ah, 1
int 21h


mov ah, 0
mov al, 02h
int 10h

hehehehe:
;call Instructions
call Menu
call Menu_Keys


cmp number_arrow, 0
je name_ask
cmp number_arrow, 1
je instructing
cmp number_arrow, 2
je leaderbord
cmp number_arrow, 3
je foff2
jmp name_ask
leaderbord:
    mov ah,3dh 
    mov al,2
    mov dx,offset file ; File Open 
    int 21h 
    mov h, ax 

    ;;;;; Read File
    mov ah,3fh
    mov cx,65 
    mov dx,offset buff
    mov bx, h 
    int 21h 
    ;;;;;;;Close File
    mov ah, 3eh 
    mov bx, h
    int 21h
    jmp hehehehe
instructing:
    mov ah, 0
    mov al, 02h
    int 10h
    call Instructions
    mov ah, 0
    mov al, 02h
    int 10h
    jmp hehehehe



name_ask:
mov ah, 0
mov al, 02h
int 10h
mov dl, 10
mov ah, 0002h
int 21h

mov dl, 10
mov ah, 0002h
int 21h

mov dl, 10
mov ah, 0002h
int 21h

mov dl, 10
mov ah, 0002h
int 21h

mov dl, 10
mov ah, 0002h
int 21h

mov dl, 10
mov ah, 0002h
int 21h

mov cx, 29
.while ( cx > 0)
mov dl, 00
mov ah, 0002h
int 21h
dec cx
.endw

mov dx, offset MSG
MOV AH,09H
INT 21H

mov si, offset STR1
MOV AH,01H
call Welcome



mov ax, 0
;Video Game Mode
mov ah, 00h
mov al, 12h
int 10h
; BACKGROUND COLOR
MOV AH, 0Bh
MOV AL, 0
MOV CX, 0
MOV DX, 8080
MOV BH, 00h
;mov bl, 02h
INT 10h


call spawn_block
call Make_Paddle
call SET_DISPLAY_MODE
call Draw_Ball

mov ah, 2h
mov bx, 0
MOV DH, 28 ;Row Number
MOV DL, 12 ;Column Number
INT 10H
mov dx, offset show_level_1
MOV AH, 9
INT 21H

; mov ah, 09h
; mov bl, 02h
; mov cx, 01h
; int 10h

MOV AH,02H
MOV BX,0
MOV DH, 1 ;Row Number
MOV DL, 30 ;Column Number
INT 10H

mov DX, offset STR1
MOV AH,09H
INT 21H

MOV AH,02H
MOV BX,0
mov dh, 1
mov dl, 55
INT 10H

mov dx, offset score
mov ah, 09H
int 21h

mov score_dh, dh
mov score_dl, dl

MOV AH,02H
MOV BX,0


jmp Time_Checker

Blockus:
mov ax, 0
;Video Game Mode
mov ah, 00h
mov al, 12h
int 10h
; BACKGROUND COLOR
MOV AH, 0Bh
MOV AL, 0
MOV CX, 0
MOV DX, 8080
MOV BH, 00h
;mov bl, 02h
INT 10h


add height_min, 5
mov highest_score, 0

sub bar_width, 25
add speed_ball_y, 28
add speed_ball_x, 1
;screen x final h
add width_max2, 25;screenfinal

call spawn_block
call SET_DISPLAY_MODE
call Make_Paddle

mov ah, 2h
mov bx, 0
MOV DH, 28 ;Row Number
MOV DL, 12 ;Column Number
INT 10H
mov dx, offset show_level_2
    MOV AH, 9
INT 21H

mov bx, 0
mov bx, ball_restart_pos_x
mov ball_x, bx
mov bx, 0
mov bx, ball_restart_pos_y
mov ball_y, bx
mov bx, 0
mov bx, bar_restart_x
mov bar_x, bx
mov bx, 0
mov bx, bar_restart_y
mov bar_y, bx

mov cx, 17
mov bx, 0
mov ax, 0
mov al, 3
.while( cx > 0)
    mov block_arr[bx],  al
    inc bx
    dec cx
.endw
; mov ah, 09h
; mov bl, 02h
; mov cx, 01h
; int 10h

MOV AH,02H
MOV BX,0
MOV DH, 1 ;Row Number
MOV DL, 30 ;Column Number
INT 10H

mov DX, offset STR1
MOV AH,09H
INT 21H

MOV AH,02H
MOV BX,0
mov dh, 1
mov dl, 55
INT 10H

mov dx, offset score
mov ah, 09H
int 21h

mov score_dh, dh
mov score_dl, dl

jmp restarting_for_lvl_2

blockus2:
mov ax, 0
;Video Game Mode
mov ah, 00h
mov al, 12h
int 10h
; BACKGROUND COLOR
MOV AH, 0Bh
MOV AL, 0
MOV CX, 0
MOV DX, 8080
MOV BH, 00h
;mov bl, 02h
INT 10h

add height_min, 5
mov highest_score2, 0
add speed_ball_y, 28
add speed_ball_x, 1
inc var1
inc var2
inc var3
inc var4
inc var5
inc var6
inc var7
inc var8
inc var9
inc var10
inc var11
inc var12
inc var13
inc var14
inc var15
inc var16

call spawn_block
call SET_DISPLAY_MODE
call Make_Paddle
mov ah, 2h
mov bx, 0
MOV DH, 28 ;Row Number
MOV DL, 12 ;Column Number
INT 10H
mov dx, offset show_level_3
MOV AH, 9
INT 21H

mov bx, 0
mov bx, ball_restart_pos_x
mov ball_x, bx
mov bx, 0
mov bx, ball_restart_pos_y
mov ball_y, bx
mov bx, 0
mov bx, bar_restart_x
mov bar_x, bx
mov bx, 0
mov bx, bar_restart_y
mov bar_y, bx

mov cx, 17
mov bx, 0
mov ax, 0
mov al, 3
.while( cx > 0)
    mov block_arr[bx],  al
    inc bx
    dec cx
.endw
; mov ah, 09h
; mov bl, 02h
; mov cx, 01h
; int 10h

MOV AH,02H
MOV BX,0
MOV DH, 1 ;Row Number
MOV DL, 30 ;Column Number
INT 10H

mov DX, offset STR1
MOV AH,09H
INT 21H

MOV AH,02H
MOV BX,0
mov dh, 1
mov dl, 55
INT 10H

mov dx, offset score
mov ah, 09H
int 21h

mov score_dh, dh
mov score_dl, dl

jmp restarting_for_lvl_2


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Time_Checker:
    mov ax, 0
    mov sec2, al
    mov sec1, al

    mov cx, 10
    mov dx, 10
whiler:  
    cmp start11, 1 
    je restarting_for_lvl_2
    MOV AH,1
    INT 21H 
    inc start11
  restarting_for_lvl_2:
  call SET_DISPLAY_MODE
  call Draw_Ball_Black
  call Make_Paddle_Black

  MOV AH,02H
  MOV BX,0
  MOV DH, 1 ;Row Number
  ;inc dh
  MOV DL, 62 ;Column Number
  ;add dl, 60
  INT 10H
  call Score_P
    ;call Paddle_Movement_Black

    ; mov ah,02h
    ; mov bx,0
    ; mov dh,0
    ; mov dl,10
    ; int 10h
  call lives
  mov ax, 0
  mov ax, score_var
  cmp ax, highest_score
  je blockus

  mov ax, 0
  mov ax, score_var
  cmp ax, highest_score2
  je blockus2

 mov ax, 0
  mov ax, score_var
  cmp ax, 470
  je foff
  call Time_Of_Ball

  
  call Draw_Ball

  call Make_Paddle

  call Paddle_Movement
  mov  ah, 2ch
  int  21h 

  cmp  dh, seconds
  je   no_change


  mov  seconds, dh
  mov sec2, dh
  mov ax, 0
  mov al, sec2
  mov bl, 10
  div bl
  mov secs, ah
  MOV AH,02H
  MOV BX,0
  MOV DH, 1 ;Row Number
  MOV DL, 70 ;Column Number
  INT 10H
  mov dl, min
  add dl, 48
  mov ah, 02h
  int 21h

  mov dl, ':'
  mov ah, 02h
  int 21h

  mov dl, sec1
  add dl, 48
  mov ah, 02h
  int 21h
  cmp secs, 9
  
  jne mm
  inc sec1
  cmp sec1, 6
  je exit
  mm:
  ; mov dl, sec1
  ; add dl, 48
  ; mov ah, 02h
  ; int 21h

  mov dl, secs
  add dl, 48
  mov  ah, 2
  int  21h

  


    

    ; ;inc ball_x
    ; cmp ball_x, 518
    ; je exit
    ; ; ;dec ball_y
    ; cmp ball_y, 480
    ; je exit
    
no_change:  
    jmp  whiler



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
exit:
    mov dl, secs
    add dl, 48
    mov  ah, 2
    int  21h

    inc min
    cmp min, 5

    jne Time_Checker

    call ENDGAME
    call File_H
    mov ah,4ch
    int 21h
foff:
    call WINGAME
foff2:
    call File_H
    mov ah,4ch
    int 21h

Main Endp

Welcome Proc

INT 21H
MOV [SI],AL
INC SI
CMP AL,13;;;;;;;;;;;cariage return = 0dh
je lolz
;  JNE READ
call Welcome
lolz:
ret
Welcome Endp

Time_Of_Ball Proc
    ; mov ah, 0Ch
    ; mov al, 0h
    ; mov bh, 0
    ; int 10H
    mov bx, 0
    mov bx, ball_x
    add bx, speed_ball_x
    mov ball_x, bx
    mov ball_x_2, bx
;     ;;;;;;;;;;;;;;;;;;  Screen Clear
;     ;mov ax, 0
;     ;Video Game Mode
;     mov ah, 00h
;     mov al, 12h
;     int 10h
;     ; BACKGROUND COLOR
    ; mov ah, 0Bh
    ; mov bx, 0
    ; ;mov bl, 02h
    ; INT 10h
; ;;;;;;;;;;;;;;;;;;;;;;;;;

    ;;;;;; COLLISION ;;;;;;;;;; 
    ;if ball_x is less than 0 or if ball_x > boundary, y has collided
    mov si, 0
    mov si, height_min
    cmp ball_x, si
    jl collisionx

    mov ax, width_max
    cmp ball_x, ax
    jg collisionx
    ;;;;;;;;;;;;;;;;;
    mov bx, ball_y
    sub bx, speed_ball_y
    mov ball_y, bx
    mov ball_y_2, bx
    
    mov si, 0
    mov si, height_min
    cmp ball_y, si
    jl collisiony

    mov ax, height_max
    cmp ball_y, ax
    jg collisiony
    
    ;;;;COLLISION W Paddle Using AABB
    ;maxx1 > minx2 && minx1 < maxx2 && maxy1 > miny1 && miny1 < maxy2
    ;ball_x+ball_size > bar_x && ball_x < bar_x+bar_width && ball_y+ball_size > bar_y && ball_y < bar_y+bar_height 
    ;cmp al, 0
    je c_coll_w_block
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, bar_x
    jng c_coll_w_r_paddle

    mov bx, 0
    mov bx, bar_width
    add bx, bar_x
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl c_coll_w_r_paddle

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, bar_y
    cmp bx, ax
    jng c_coll_w_r_paddle

    mov bx, 0
    mov ax, 0
    mov bx, bar_y
    mov ax, bar_height
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl c_coll_w_r_paddle

    neg speed_ball_y
    ret

    c_coll_w_r_paddle:
    ; ;;;;COLLISION W Paddle Using AABB
    ; ;maxx1 > minx2 && minx1 < maxx2 && maxy1 > miny1 && miny1 < maxy2   ; width = 50, height  = 30
    ; ;ball_x+ball_size > block_x && ball_x < block_x+block_width && ball_y+ball_size > block_y && ball_y < block_y+block_height 
    ;400, 80
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;1st
    cmp block_arr[1], 0
    je coll1
    cmp var1, 3
    je coll1
    cmp var1, 7
    je coll1

    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 50
    jng coll1

    mov bx, 0
    mov bx, 50
    add bx, 50
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll1

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 80
    cmp bx, ax
    jng coll1

    mov bx, 0
    mov ax, 0
    mov bx, 80
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll1

    mov bx, 0
    mov bl, var1
    inc var1

.if( bl == 0)
    
    add score_var, 10
    mov block_arr[1], al
    mov al, 0
    mov block_arr[1], al
    neg speed_ball_y
    block2 50,80,0

.elseif ( bl == 1)

    neg speed_ball_y
    block2 50,80, 0EH
    
.elseif( bl == 2)
    add score_var, 10
    neg speed_ball_y
    block2 50,80, 0

.elseif( bl == 4)
    neg speed_ball_y
    block2 50,80, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 50,80, 0FH

.elseif( bl == 6)
    add score_var, 10
    neg speed_ball_y
    block2 50,80,0
.endif 
    call sound
    ret
    coll1:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;2nd
    cmp block_arr[2], 0
    je coll2

    cmp var2,3
    je coll2

    cmp var2, 7
    je coll2
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 120
    jng coll2

    mov bx, 0
    mov bx, 50
    add bx, 120
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll2

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 80
    cmp bx, ax
    jng coll2

    mov bx, 0
    mov ax, 0
    mov bx, 80
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll2
    
    mov bx, 0
    mov bl, var2
    inc var2

.if( bl == 0)
    add score_var, 14
    mov ax, 0
    mov block_arr[2], al
    neg speed_ball_y
    block2 120,80,0

.elseif ( bl == 1)
    neg speed_ball_y
    block2 120,80, 0EH
    
.elseif( bl == 2)
    add score_var, 13
    neg speed_ball_y
    block2 120,80,0

.elseif( bl == 4)
    neg speed_ball_y
    block2 120,80, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 120,80, 0FH

.elseif( bl == 6)
    add score_var, 14
    neg speed_ball_y
    block2 120,80,0
.endif 
    call sound
    ret
    coll2:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;3rd
    cmp block_arr[3], 0
    je coll3
    cmp var3,3
    je coll3
    cmp var3, 7
    je coll3
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 190
    jng coll3

    mov bx, 0
    mov bx, 50
    add bx, 190
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll3

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 80
    cmp bx, ax
    jng coll3

    mov bx, 0
    mov ax, 0
    mov bx, 80
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll3
    
    mov bx, 0
    mov bl, var3
    inc var3

.if( bl == 0)
    add score_var, 8
    mov block_arr[3], al
    mov al, 0
    mov block_arr[3], al
    neg speed_ball_y
    block2 190,80,0

.elseif ( bl == 1)
    neg speed_ball_y
    block2 190,80, 0EH
    
.elseif( bl == 2)
    add score_var, 4
    neg speed_ball_y
    block2 190,80,0

.elseif( bl == 4)
    neg speed_ball_y
    block2 190,80, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 190,80, 0FH

.elseif( bl == 6)
    add score_var, 8
    neg speed_ball_y
    block2 190,80,0
.endif
    call sound
    ret
    coll3:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;4th
    cmp block_arr[4], 0
    je coll4
    cmp var4,3
    je coll4
    cmp var4, 7
    je coll4
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 260
    jng coll4

    mov bx, 0
    mov bx, 50
    add bx, 260
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll4

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 80
    cmp bx, ax
    jng coll4

    mov bx, 0
    mov ax, 0
    mov bx, 80
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll4

    mov bx, 0
    mov bl, var4
    inc var4

.if( bl == 0)
    add score_var, 10
    mov block_arr[4], al
    mov al, 0
    mov block_arr[4], al
    neg speed_ball_y
    block2 260,80,0

.elseif ( bl == 1)
    neg speed_ball_y
    block2 260,80, 0EH
    
    ; jmp exit_lvl1
.elseif( bl == 2)
    add score_var, 10
    neg speed_ball_y
    block2 260,80,0

.elseif( bl == 4)
    neg speed_ball_y
    block2 260,80, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 260,80, 0FH

.elseif( bl == 6)
    add score_var, 10
    neg speed_ball_y
    block2 260,80,0
.endif
    call sound
    ret
    coll4:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;5th
    cmp block_arr[5], 0
    je coll5
    cmp var5, 3
    je coll5
    ; cmp var5, 7
    ; je coll5
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 330
    jng coll5

    mov bx, 0
    mov bx, 50
    add bx, 330
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll5

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 80
    cmp bx, ax
    jng coll5

    mov bx, 0
    mov ax, 0
    mov bx, 80
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll5

    mov bx, 0
    mov bl, var5
    inc var5

.if( bl == 0)
    add score_var, 7
    mov block_arr[5], al
    mov al, 0
    mov block_arr[5], al
    neg speed_ball_y
    block2 330,80,0

.elseif ( bl == 1)
    neg speed_ball_y
    block2 330,80, 0EH

.elseif( bl == 2)
    add score_var, 6
    neg speed_ball_y
    block2 330,80,0

; .elseif( bl == 4)
;     neg speed_ball_y
;     block2 330,80, 0CH

; .elseif ( bl == 5)
;     neg speed_ball_y
;     block2 330,80, 0FH

; .elseif( bl == 6)
;     add score_var, 10
;     neg speed_ball_y
;     block2 330,80,0
.else
    neg speed_ball_y
    block2 330,80, 0AH
.endif
    call sound
    ret
    coll5:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;6th
    cmp block_arr[6], 0
    je coll6
    cmp var6,3
    je coll6
    cmp var6, 7
    je coll6
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 400
    jng coll6

    mov bx, 0
    mov bx, 50
    add bx, 400
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll6

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 80
    cmp bx, ax
    jng coll6

    mov bx, 0
    mov ax, 0
    mov bx, 80
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll6
    
    mov bx, 0
    mov bl, var6
    inc var6

.if( bl == 0)
    add score_var, 10
    mov block_arr[6], al
    mov al, 0
    mov block_arr[6], al
    neg speed_ball_y
    block2 400,80,0
    
.elseif ( bl == 1)
    neg speed_ball_y
    block2 400,80, 0EH

.elseif( bl == 2)
    add score_var, 10
    neg speed_ball_y
    block2 400,80,0

.elseif( bl == 4)
    neg speed_ball_y
    block2 400,80, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 400,80, 0FH

.elseif( bl == 6)
    add score_var, 7
    neg speed_ball_y
    block2 400,80,0

.endif
    call sound
    ret
    coll6:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;7th
    cmp block_arr[7], 0
    je coll7
    cmp var7,3
    je coll7
    cmp var7, 7
    je coll7
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 470
    jng coll7

    mov bx, 0
    mov bx, 50
    add bx, 470
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll7

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 80
    cmp bx, ax
    jng coll7

    mov bx, 0
    mov ax, 0
    mov bx, 80
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll7
    
    mov bx, 0
    mov bl, var7
    inc var7

.if( bl == 0)
   add score_var, 16
    mov block_arr[7], al
    mov al, 0
    mov block_arr[7], al
    neg speed_ball_y
    block2 470,80,0
    
.elseif ( bl == 1)

    neg speed_ball_y
    block2 470,80, 0EH
    
    ; jmp exit_lvl1
.elseif( bl == 2)
    add score_var, 12

    neg speed_ball_y
    block2 470,80,0

.elseif( bl == 4)
    neg speed_ball_y
    block2 470,80, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 470,80, 0FH

.elseif( bl == 6)
    add score_var, 16
    neg speed_ball_y
    block2 470,80,0

.endif
    call sound
    ret
    coll7:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 8th
    cmp block_arr[8], 0
    je coll8
    cmp var8, 3
    je coll8
    cmp var8, 7 
    je coll8
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 540
    jng coll8

    mov bx, 0
    mov bx, 50
    add bx, 540
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll8

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 80
    cmp bx, ax
    jng coll8

    mov bx, 0
    mov ax, 0
    mov bx, 80
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll8
    
    mov bx, 0
    mov bl, var8
    inc var8

.if( bl == 0)
    add score_var, 10
    mov block_arr[8], al
    mov al, 0
    mov block_arr[8], al
    neg speed_ball_y
    block2 540,80,0
    
.elseif ( bl == 1)

    neg speed_ball_y
    block2 540,80, 0EH
    
    ; jmp exit_lvl1
.elseif( bl == 2)
    add score_var, 10

    neg speed_ball_y
    block2 540,80,0

.elseif( bl == 4)
    neg speed_ball_y
    block2 540,80, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 540,80, 0FH

.elseif( bl == 6)
    add score_var, 10
    neg speed_ball_y
    block2 540,80,0

.endif
    call sound
    ret
    coll8:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;9th

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;1st
    cmp block_arr[9], 0
    je coll9
    cmp var9, 3
    je coll9
    cmp var9, 7
    je coll9
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 50
    jng coll9

    mov bx, 0
    mov bx, 50
    add bx, 50
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll9

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 150
    cmp bx, ax
    jng coll9

    mov bx, 0
    mov ax, 0
    mov bx, 150
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll9
    
   
    mov bx, 0
    mov bl, var9
    inc var9

.if( bl == 0)
    add score_var, 10
    mov block_arr[9], al
    mov al, 0
    mov block_arr[9], al
    neg speed_ball_y
    block2 50,150,0

    
.elseif ( bl == 1)

    neg speed_ball_y
    block2 50,150, 0EH
    
    ; jmp exit_lvl1
.elseif( bl == 2)
    add score_var, 10

    neg speed_ball_y
    block2 50,150,0
    

.elseif( bl == 4)
    neg speed_ball_y
    block2 50,150, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 50,150, 0FH

.elseif( bl == 6)
    add score_var, 10
    neg speed_ball_y
    block2 50,150,0
.endif
    call sound
    ret
    coll9:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;2nd
    cmp block_arr[10], 0
    je coll10
    cmp var10, 3
    je coll10
    cmp var10, 7
    je coll10
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 120
    jng coll10

    mov bx, 0
    mov bx, 50
    add bx, 120
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll10

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 150
    cmp bx, ax
    jng coll10

    mov bx, 0
    mov ax, 0
    mov bx, 150
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll10
    


    mov bx, 0
    mov bl, var10
    inc var10
    inc var2_10

.if( bl == 0)
    add score_var, 13
    mov block_arr[10], al
    mov al, 0
    mov block_arr[10], al
    neg speed_ball_y
    block2 120,150,0

    
.elseif ( bl == 1)

    neg speed_ball_y
    block2 120,150, 0EH
    
    ; jmp exit_lvl1
.elseif( bl == 2)
    add score_var, 14

    neg speed_ball_y
    block2 120,150,0
 

.elseif( bl == 4)
    neg speed_ball_y
    block2 120,150, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 120,150, 0FH

.elseif( bl == 6)
    add score_var, 13
    neg speed_ball_y
    block2 120,150,0
.endif
    call sound
    ret
    coll10:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;3rd
    cmp block_arr[11], 0
    je coll11
    cmp var11,3
    je coll11
    cmp var11, 7
    je coll11
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 190
    jng coll11

    mov bx, 0
    mov bx, 50
    add bx, 190
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll11

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 150
    cmp bx, ax
    jng coll11

    mov bx, 0
    mov ax, 0
    mov bx, 150
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll11
    
 
     mov bx, 0
    mov bl, var11
    inc var11
    inc var2_11

.if( bl == 0)


    add score_var, 4
    mov block_arr[11], al
    mov al, 0
    mov block_arr[11], al
    neg speed_ball_y
    block2 190,150,0


    
.elseif ( bl == 1)

    neg speed_ball_y
    block2 190,150, 0EH
    
    ; jmp exit_lvl1
.elseif( bl == 2)
    add score_var, 8

    neg speed_ball_y
    block2 190,150,0


.elseif( bl == 4)
    neg speed_ball_y
    block2 190,150, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 190,150, 0FH

.elseif( bl == 6)
    add score_var, 4
    neg speed_ball_y
    block2 190,150,0
.endif
    call sound
    ret
    coll11:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;4th
    cmp block_arr[12], 0
    je coll12
    cmp var12, 3
    je coll12
    cmp var12, 7
    je coll12
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 260
    jng coll12

    mov bx, 0
    mov bx, 50
    add bx, 260
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll12

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 150
    cmp bx, ax
    jng coll12

    mov bx, 0
    mov ax, 0
    mov bx, 150
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll12
    
    
 
     mov bx, 0
    mov bl, var12
    inc var12
    inc var2_12

.if( bl == 0)
    add score_var, 10
    mov block_arr[12], al
    mov al, 0
    mov block_arr[12], al
    neg speed_ball_y
    block2 260,150,0


    
.elseif ( bl == 1)

    neg speed_ball_y
    block2 260,150, 0EH
    
    ; jmp exit_lvl1
.elseif( bl == 2)
    add score_var, 10

    neg speed_ball_y
    block2 260,150,0

.elseif( bl == 4)
    neg speed_ball_y
    block2 260,150, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 260,150, 0FH

.elseif( bl == 6)
    add score_var, 10
    neg speed_ball_y
    block2 260,150,0
.endif
    call sound
    ret
    coll12:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;5th
    cmp block_arr[13], 0
    je coll13
    cmp var13,3
    je coll13
    cmp var13, 7
    je coll13
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 330
    jng coll13

    mov bx, 0
    mov bx, 50
    add bx, 330
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll13

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 150
    cmp bx, ax
    jng coll13

    mov bx, 0
    mov ax, 0
    mov bx, 150
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll13
    

    
 
    mov bx, 0
    mov bl, var13
    inc var13

.if( bl == 0)
    add score_var, 6
    mov block_arr[13], al
    mov al, 0
    mov block_arr[13], al
    ;call sound
    neg speed_ball_y
    block2 330,150,0
   
.elseif ( bl == 1)

    neg speed_ball_y
    block2 330,150, 0EH
  
.elseif( bl == 2)
    add score_var, 7
    neg speed_ball_y
    block2 330,150,0

    ; mov al, 0
    ; mov al, var2_13 ;3
    ; mov var13, al ; 3

    ; mov ax, 0
    ; mov al, var2_13

.elseif( bl == 4)
    neg speed_ball_y
    block2 330,150, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 330,150, 0FH

.elseif( bl == 6)
    add score_var, 6
    neg speed_ball_y
    block2 330,150,0
.endif

    call sound
    ret
    coll13:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;6th
    cmp block_arr[14], 0
    je coll14
    cmp var14,3
    je coll14
    cmp var14, 7
    je coll14
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 400
    jng coll14

    mov bx, 0
    mov bx, 50
    add bx, 400
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll14

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 150
    cmp bx, ax
    jng coll14

    mov bx, 0
    mov ax, 0
    mov bx, 150
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll14
    

    mov bx, 0
    mov bl, var14
    inc var14

.if( bl == 0)
    add score_var, 10
    mov al, 0
    mov block_arr[14], al
    neg speed_ball_y
    block2 400,150,0
    
.elseif ( bl == 1)

    neg speed_ball_y
    block2 400,150, 0EH
    
    ; jmp exit_lvl1
.elseif( bl == 2)
    add score_var, 10

    neg speed_ball_y
    block2 400,150,0

.elseif( bl == 4)
    neg speed_ball_y
    block2 400,150, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 400,150, 0FH

.elseif( bl == 6)
    add score_var, 10
    neg speed_ball_y
    block2 400,150,0
.endif

    call sound
    ret
    coll14:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;7th
    cmp block_arr[15], 0
    je coll15
    cmp var15,3
    je coll15
    cmp var15,7
    je coll15
    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 470
    jng coll15

    mov bx, 0
    mov bx, 50
    add bx, 470
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl coll15

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 150
    cmp bx, ax
    jng coll15

    mov bx, 0
    mov ax, 0
    mov bx, 150
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl coll15
    

    mov bx, 0
    mov bl, var15
    inc var15

.if( bl == 0)
    add score_var, 12
    mov al, 0
    mov block_arr[15], al
    neg speed_ball_y
    block2 470,150,0
    
.elseif ( bl == 1)

    neg speed_ball_y
    block2 470,150, 0EH
    
    ; jmp exit_lvl1
.elseif( bl == 2)
    add score_var, 16

    neg speed_ball_y
    block2 470,150,0


.elseif( bl == 4)
    neg speed_ball_y
    block2 470,150, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 470,150, 0FH

.elseif( bl == 6)
    add score_var, 12
    neg speed_ball_y
    block2 470,150,0
.endif

    call sound
    ret
    coll15:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;8th
    cmp block_arr[16], 0
    je c_coll_w_block
    cmp var16, 3
    je c_coll_w_block
    cmp var16, 7
    je c_coll_w_block
    

    mov bx, 0
    mov bx, ball_x
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    cmp bx, 540
    jng c_coll_w_block

    mov bx, 0
    mov bx, 50
    add bx, 540
    mov ax, 0
    mov ax, ball_x
    cmp ax, bx
    jnl c_coll_w_block

    mov bx, 0
    mov bx, ball_y
    mov ax, 0
    mov ax, ball_size
    add bx, ax
    mov ax, 0
    mov ax, 150
    cmp bx, ax
    jng c_coll_w_block

    mov bx, 0
    mov ax, 0
    mov bx, 150
    mov ax, 30
    add bx, ax
    mov ax, 0
    mov ax, ball_y
    cmp ax, bx
    jnl c_coll_w_block
    
   


    mov bx, 0
    mov bl, var16
    inc var16

.if( bl == 0)
    add score_var, 10
    mov ax, 0
    mov al, 0
    mov block_arr[16], al

    neg speed_ball_y
    block2 540,150,0
    

    
.elseif ( bl == 1)

    neg speed_ball_y
    block2 540,150, 0EH
    
    ; jmp exit_lvl1
.elseif( bl == 2)
    add score_var, 10

    neg speed_ball_y
    block2 540,150,0
   

.elseif( bl == 4)
    neg speed_ball_y
    block2 540,150, 0CH

.elseif ( bl == 5)
    neg speed_ball_y
    block2 540,150, 0FH

.elseif( bl == 6)
    add score_var, 10
    neg speed_ball_y
    block2 540,150,0
.endif

    call sound
    ret
c_coll_w_block:
        ret

; height = 320 = 640
; widh = 200 = 480
    collisionx:
        neg speed_ball_x
        ret
    collisiony:
        neg speed_ball_y
        ret
Time_Of_Ball Endp

Time_Of_Ball_2 Proc ;For reset level 
    
    mov bx, 0
    mov bx, ball_x
    add bx, speed_ball_x
    mov ball_x, bx

    ;;;;;; COLLISION ;;;;;;;;;; 
    ;if ball_x is less than 0 or if ball_x > boundary, y has collided
    ;mov si, 0
    cmp ball_x, 40
    jl reset

    mov ax, width_max
    cmp ball_x, ax
    jg reset
    ;;;;;;;;;;;;;;;;;
    mov bx, ball_y
    sub bx, speed_ball_y
    mov ball_y, bx

    mov si, 0
    cmp ball_y, 40
    jl collisiony

    mov ax, height_max
    cmp ball_y, ax
    jg collisiony

    lmao:
    ret 
; height = 320 = 640
; widh = 200 = 480
    reset:
        call New_Level_Reset_Pos
        ret
    collisiony:
        neg speed_ball_y
        ret
Time_Of_Ball_2 Endp



New_Level_Reset_Pos Proc
mov bx, 0 
mov bx, ball_restart_pos_x
mov ball_x, bx
mov bx, 0
mov bx, ball_restart_pos_y
mov ball_y, bx

New_Level_Reset_Pos Endp

Draw_Ball Proc

mov cx, ball_x
mov dx, ball_y
mov ball_x_2, cx
mov ball_y_2, dx
B1_horizontal:
    mov ah, 0Ch
    mov al, 0FH
    mov bh, 0
    int 10h
    inc cx
    mov bx, 0
    mov bx, cx
    sub bx, ball_x
    cmp bx, ball_size
jng B1_horizontal
    mov cx, ball_x
    inc dx
    mov bx, 0
    mov bx, dx
    sub bx, ball_y
    cmp bx, ball_size
jng B1_horizontal

ret
Draw_Ball Endp

Draw_Ball_Black Proc;previous ball position black

mov cx, 0
mov cx, ball_x_2
mov dx, 0
mov dx, ball_y_2
B2_horizontal:
    mov ah, 0Ch
    mov al, 0h
    mov bh, 0
    int 10h
    inc cx
    mov bx, 0
    mov bx, cx
    sub bx, ball_x_2
    cmp bx, ball_size
jng B2_horizontal
    mov cx, ball_x_2
    inc dx
    mov bx, 0
    mov bx, dx
    sub bx, ball_y_2
    cmp bx, ball_size
jng B2_horizontal
;call Draw_Ball
ret
Draw_Ball_Black Endp

SET_DISPLAY_MODE    PROC
    ; MOV AH,0
    ; MOV AL,12H
    ; INT 10H
     
                    
    ; MOV AH,0CH
    ; INT 10H
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    DRAW_ROW    40
    DRAW_COLUMN 38
    DRAW_COLUMN 600 
    DRAW_ROW    41
    DRAW_COLUMN 39
    DRAW_COLUMN 601      
    DRAW_ROW    42              ; outside frame
    DRAW_COLUMN 40
    DRAW_COLUMN 602  
    DRAW_ROW    43
    DRAW_COLUMN 41
    DRAW_COLUMN 603  
    DRAW_ROW    425
    DRAW_ROW    426
    DRAW_ROW    427

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    RET
SET_DISPLAY_MODE ENDP

Menu Proc
    MOV AH,02H
    MOV BX,0
    MOV DH, 3 ;Row Number
    MOV DL, 29 ;Column Number
    INT 10H
    mov dx, offset menu_1
    MOV AH, 9
    INT 21H
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MOV AH,02H
    MOV BX,0
    MOV DH, 6 ;Row Number
    MOV DL, 29 ;Column Number
    INT 10H
    mov dx, offset menu_2_0
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 7 ;Row Number
    MOV DL, 29 ;Column Number
    INT 10H
    mov dx, offset menu_2_1
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 8 ;Row Number
    MOV DL, 29 ;Column Number
    INT 10H
    mov dx, offset menu_2_2
    MOV AH, 9
    INT 21H
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    MOV AH,02H
    MOV BX,0
    MOV DH, 10 ;Row Number
    MOV DL, 29 ;Column Number
    INT 10H
    mov dx, offset menu_2_0
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 11 ;Row Number
    MOV DL, 29 ;Column Number
    INT 10H
    mov dx, offset menu_3
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 12 ;Row Number
    MOV DL, 29 ;Column Number
    INT 10H
    mov dx, offset menu_2_2
    MOV AH, 9
    INT 21H
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    MOV AH,02H
    MOV BX,0
    MOV DH, 14 ;Row Number
    MOV DL, 29 ;Column Number
    INT 10H
    mov dx, offset menu_2_0
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 15 ;Row Number
    MOV DL, 29 ;Column Number
    INT 10H
    mov dx, offset menu_4
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 16 ;Row Number
    MOV DL, 29 ;Column Number
    INT 10H
    mov dx, offset menu_2_2
    MOV AH, 9
    INT 21H
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    MOV AH,02H
    MOV BX,0
    MOV DH, 18 ;Row Number
    MOV DL, 29 ;Column Number
    INT 10H
    mov dx, offset menu_2_0
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 19 ;Row Number
    MOV DL, 29 ;Column Number
    INT 10H
    mov dx, offset menu_5
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 20 ;Row Number
    MOV DL, 29 ;Column Number
    INT 10H
    mov dx, offset menu_2_2
    MOV AH, 9
    INT 21H

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MOV AH,02H
    MOV BX,0
    MOV DH, arrow_row ;Row Number
    MOV DL, arrow_col ;Column Number
    INT 10H
    mov dx, offset arrow
    MOV AH, 9
    INT 21H

    ret
Menu Endp

Menu_Keys Proc

menu_start:
mov ah, 1
int 16h
jz menu_start
mov ah, 0
int 16h
cmp al, 13
je skipper

cmp ah, 48h
je Up
cmp ah, 50h
je Down
jmp skipper

    Down:
        MOV AH,02H
        MOV BX,0
        MOV DH, arrow_row ;Row Number
        MOV DL, arrow_col ;Column Number
        INT 10H
        mov dx, offset arrow_clear
        MOV AH, 9
        INT 21H

        add arrow_row, 4
        inc number_arrow

        MOV AH,02H
        MOV BX,0
        MOV DH, arrow_row ;Row Number
        MOV DL, arrow_col ;Column Number
        INT 10H
        mov dx, offset arrow
        MOV AH, 9
        INT 21H
        
        jmp menu_start

    Up:
        MOV AH,02H
        MOV BX,0
        MOV DH, arrow_row ;Row Number
        MOV DL, arrow_col ;Column Number
        INT 10H
        mov dx, offset arrow_clear
        MOV AH, 9
        INT 21H

        dec number_arrow
        sub arrow_row, 4

        MOV AH,02H
        MOV BX,0
        MOV DH, arrow_row ;Row Number
        MOV DL, arrow_col ;Column Number
        INT 10H
        mov dx, offset arrow
        MOV AH, 9
        INT 21H
        
jmp menu_start

skipper:
    ret
Menu_Keys Endp

Instructions Proc
    MOV AH,02H
    MOV BX,0
    MOV DH, 3 ;Row Number
    MOV DL, 26 ;Column Number
    INT 10H
    mov dx, offset instructions_1
    MOV AH, 9
    INT 21H 

    MOV AH,02H
    MOV BX,0
    MOV DH, 7 ;Row Number
    MOV DL, 8 ;Column Number
    INT 10H
    mov dx, offset instructions_2
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 9 ;Row Number
    MOV DL, 8 ;Column Number
    INT 10H
    mov dx, offset instructions_3
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 11 ;Row Number
    MOV DL, 8 ;Column Number
    INT 10H
    mov dx, offset instructions_4
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 13 ;Row Number
    MOV DL, 8 ;Column Number
    INT 10H
    mov dx, offset instructions_5
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 15 ;Row Number
    MOV DL, 8 ;Column Number
    INT 10H
    mov dx, offset instructions_6
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 17 ;Row Number
    MOV DL, 8 ;Column Number
    INT 10H
    mov dx, offset instructions_7
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 19 ;Row Number
    MOV DL, 8 ;Column Number
    INT 10H
    mov dx, offset instructions_8
    MOV AH, 9
    INT 21H

    MOV AH,02H
    MOV BX,0
    MOV DH, 24 ;Row Number
    MOV DL, 49 ;Column Number
    INT 10H
    mov dx, offset instructions_exit
    MOV AH, 9
    INT 21H

    mov ah, 1
    int 21h
    ret
Instructions Endp

Make_Paddle Proc

mov cx, 0
mov cx, bar_x
mov dx, 0
mov dx, bar_y
mov bar_x_2, cx
mov bar_y_2, dx
Paddle:
    mov ax, 0
    mov ah, 0Ch
    mov al, 011H
    mov bx, 0
    int 10H

    mov bx, 0
    inc cx
    mov bx, cx
    sub bx, bar_x
    cmp bx, bar_width
jng Paddle

    mov cx, 0
    mov cx, bar_x
    inc dx
    mov bx, 0
    mov bx, dx
    sub bx, bar_y
    cmp bx, bar_height
jng Paddle
;call Make_Paddle_Black
ret
Make_Paddle Endp

Paddle_Movement Proc

mov ah, 1
int 16h
jz L11
mov ah, 0
int 16h
cmp ah, 4Bh
je Left
cmp ah, 4Dh
je Right
cmp al, 112
je Pauser

jmp L11

Right:
    mov bx, 0
    mov bx, speed_paddle
    mov ax, 0
    mov ax, width_max2
    sub ax, 100
    cmp bar_x, ax
    ja L11
    add bar_x, bx
    jmp L11
Left:
    mov bx, 0d
    mov bx, speed_paddle
    mov ax, 0
    mov ax, width_least2
    cmp bar_x, ax
    jbe L11
    sub bar_x, bx
    jmp L11
Pauser: 
    MOV AH,02H
    MOV BX,0
    MOV DH, 15 ;Row Number
    MOV DL, 27 ;Column Number
    INT 10H
    mov dx, offset pause1
    MOV AH, 9
    INT 21H 

    MOV AH,02H
    MOV BX,0
    MOV DH, 17 ;Row Number
    MOV DL, 27 ;Column Number
    INT 10H
    mov dx, offset pause2
    MOV AH, 9
    INT 21H

    mov ah,1
    int 16h
    jz Pauser
    mov ah,0
    int 16h
    cmp al,112
    je L11_chenk
    
jmp Pauser

L11_chenk:
    MOV AH,02H
    MOV BX,0
    MOV DH, 15 ;Row Number
    MOV DL, 27 ;Column Number
    INT 10H
    mov dx, offset pause_clear1
    MOV AH, 9
    INT 21H 

    MOV AH,02H
    MOV BX,0
    MOV DH, 17 ;Row Number
    MOV DL, 27 ;Column Number
    INT 10H
    mov dx, offset pause_clear2
    MOV AH, 9
    INT 21H
L11:
;call Make_Paddle_Black
ret
Paddle_Movement Endp

Make_Paddle_Black Proc

mov cx, 0
mov cx, bar_x_2
mov dx, 0
mov dx, bar_y_2

Paddle:
    mov ax, 0
    mov ah, 0Ch
    mov al, 0H
    mov bx, 0
    int 10H

    mov bx, 0
    inc cx
    mov bx, cx
    sub bx, bar_x_2
    cmp bx, bar_width
jng Paddle

    mov cx, 0
    mov cx, bar_x_2
    inc dx
    mov bx, 0
    mov bx, dx
    sub bx, bar_y_2
    cmp bx, bar_height
jng Paddle
;call Make_Paddle_Black
ret
Make_Paddle_Black Endp

Paddle_Movement_Black Proc

mov ah, 1
int 16h
jz L11
mov ah, 0
int 16h
cmp ah, 4Bh
je Left
cmp ah, 4Dh
je Right

jmp L11

Right:
    mov bx, 0
    mov bx, speed_paddle
    mov ax, 0
    mov ax, width_max2
    sub ax, 100
    cmp bar_x_2, ax
    ja L11
    add bar_x_2, bx
    jmp L11
Left:
    mov bx, 0
    mov bx, speed_paddle
    mov ax, 0
    mov ax, 40
    cmp bar_x_2, ax
    jbe L11
    sub bar_x_2, bx
    jmp L11
L11:
;call Make_Paddle_Black
ret
Paddle_Movement_Black Endp

lives proc

    mov ah,02h
    mov bx,0
    mov dh,1
    mov dl,0
    int 10h 
mov dx,offset lives_str
mov ah,09h
int 21h 

; mov dx, 00
; mov dx, heart_var
; mov heart_var2, dx

;     mov ah,09h
;     mov al,03h                  ;heart symbol
;     mov bh,0
;     mov bl,4h
;     mov cx,heart_var
;     int 10h

mov cx, heart_var 
; mov ah, 09h
; mov bl, 02h
; mov cx, 01h
; int 10h
heartloop:
    ; mov ah,09h
    ; mov al,03h                  ;heart symbol
    ; mov bh,0
    ; mov bl,4h
    mov dl, 3h
    mov ah,02h
    int 21h
loop heartloop
mov dx,00
mov ah, 02h
int 21h
mov ax, ball_y
cmp ax, 382
jb dont_decrease_heartvar
dec heart_var
cmp heart_var, 0
jne nothinggg
call ENDGAME2
call File_H
mov ah, 4ch
int 21h

nothinggg:
mov bx, 0
mov bx, ball_restart_pos_x
mov ball_x, bx
mov bx, 0
mov bx, ball_restart_pos_y
mov ball_y, bx
mov bx, 0
mov bx, bar_restart_x
mov bar_x, bx
mov bx, 0
mov bx, bar_restart_y
mov bar_y, bx

dont_decrease_heartvar:
ret
lives endp

spawn_block proc
mov ax,50
mov blockx,ax
mov blocky,ax
add blocky, 30
MOV AH, 00h  ; calling interrupts        
INT 1AH      ; random generator    

mov  ax, dx
mov dx, 0
mov  cx, 15    
div  cx       

cmp dl, 0
jne finito2
inc dl

finito2:
mov block_color, dl
mov cx,8
start:
    mov dummy, cx
    block2 blockx, blocky,block_color
    add blockx, 70
    inc block_color
    
    mov cx, dummy
Loop start

mov ax,50
mov blockx,ax
mov ax,150
mov blocky,ax


MOV AH, 00h  ; calling interrupts        
INT 1AH      ; random generator    

mov  ax, dx
mov dx, 0
mov  cx, 15    
div  cx       

cmp dl, 0
jne finito
inc dl

finito:
mov block_color, dl
mov cx, 8
start2:
    mov dummy, cx
    block2 blockx, blocky,block_color
    add blockx, 70
    inc block_color
    
    mov cx, dummy
Loop start2
ret
spawn_block endp

Score_P Proc
OUTPP:
MOV AX, score_var
MOV DX,0
    HEREE:
        CMP AX,0
        JE DISPP
        MOV BL,10
        DIV BL
        MOV DL,AH
        MOV DH,0
        PUSH DX
        MOV CL,AL
        MOV CH,0
        MOV AX,CX
        INC COUNTT
    JMP HEREE

    DISPP:
        CMP COUNTT,0
        JBE EX22
        POP DX
        ADD DL,48
        MOV AH,02H
        INT 21H
    DEC COUNTT
JMP DISPP
EX22:
ret
Score_P Endp

sound proc
    mov al, 182        
    out 67, al        
    mov ax, 400        
    out 66, al
    mov al, ah 
    out 66, al 
    in al, 97       
    or al, 3 
    out 97, al
    mov bx, 2
    sound1:
        mov cx, 0FFFFH
    sound2:
        sub cx, 1
        jne sound2
        sub bx, 1
        jne sound1
        in al, 97         
        and al, 252  
        out 97, al        
ret
sound endp

ENDGAME Proc
mov ax, 0
;Video Game Mode
mov ah, 00h
mov al, 12h
int 10h
; BACKGROUND COLOR
MOV AH, 0Bh
MOV AL, 0
MOV CX, 0
MOV DX, 8080
MOV BH, 00h
;mov bl, 02h
INT 10h

MOV AH,02H
MOV BX,0
MOV DH, lose_x1 ;Row Number
MOV DL, lose_y1 ;Column Number
INT 10H
mov dx, offset lose1
MOV AH, 9
INT 21H 

MOV AH,02H
MOV BX,0
MOV DH, lose_x2 ;Row Number
MOV DL, lose_y2 ;Column Number
INT 10H
mov dx, offset lose2
MOV AH, 9
INT 21H

MOV AH,02H
MOV BX,0
MOV DH, lose_x3 ;Row Number
MOV DL, lose_y3 ;Column Number
INT 10H
mov dx, offset lose3
MOV AH, 9
INT 21H

MOV AH,02H
MOV BX,0
MOV DH, lose_x4 ;Row Number
MOV DL, lose_y4 ;Column Number
INT 10H
mov dx, offset lose4
MOV AH, 9
INT 21H

MOV AH,02H
MOV BX,0
MOV DH, lose_x5 ;Row Number
MOV DL, lose_y5 ;Column Number
INT 10H
mov dx, offset lose5
MOV AH, 9
INT 21H

MOV AH,02H
MOV BX,0
MOV DH, lose_x6 ;Row Number
MOV DL, lose_y6 ;Column Number
INT 10H
mov dx, offset lose6
MOV AH, 9
INT 21H



MOV AH,1
INT 21H 
ret
ENDGAME Endp
File_H Proc
mov ah,3dh 
mov al,1
mov dx,offset file ; File Open 
int 21h 
mov h, ax 

;;;;; Read File
mov ah,3fh
mov cx,1 
mov dx,offset buff
mov bx, h 
int 21h 

mov dx, offset buff
mov ah, 9h
int 21h

mov cx,cor_x
mov dx, cor_y
mov ah,42h
mov al,2
int 21h
mov ah, 40h 
mov bx, h
mov cx, 12 
mov dx, offset STR1
int 21h

inc cor_y
mov ax, 0
mov ax, score_var
mov cx, 0
integralL1:
    mov dx, 0
    mov bx, 0Ah
    div bx
    add dx, 30h
    push dx ; number in reverse
    inc cx
    cmp ax, 0
jne integralL1
;9
pop dx
mov score_str[0], dl
pop dx
mov score_str[1], dl
pop dx
mov score_str[2], dl

mov cx,0
mov dx, 0
mov ah,42h
mov al,2
int 21h
mov ah, 40h 
mov bx, h
mov cx, 3 
mov dx, offset score_str
int 21h

;;;;;;;Close File
mov ah, 3eh 
mov bx, h
int 21h

mov ah, 4ch
int 21h
ret
File_H Endp

ENDGAME2 Proc
mov ax, 0
;Video Game Mode
mov ah, 00h
mov al, 12h
int 10h
; BACKGROUND COLOR
MOV AH, 0Bh
MOV AL, 0
MOV CX, 0
MOV DX, 8080
MOV BH, 00h
;mov bl, 02h
INT 10h

MOV AH,02H
MOV BX,0
MOV DH, lose_x1 ;Row Number
MOV DL, lose_y1 ;Column Number
INT 10H
mov dx, offset lose1
MOV AH, 9
INT 21H 

MOV AH,02H
MOV BX,0
MOV DH, lose_x2 ;Row Number
MOV DL, lose_y2 ;Column Number
INT 10H
mov dx, offset lose2
MOV AH, 9
INT 21H

MOV AH,02H
MOV BX,0
MOV DH, lose_x3 ;Row Number
MOV DL, lose_y3 ;Column Number
INT 10H
mov dx, offset lose3_1
MOV AH, 9
INT 21H

MOV AH,02H
MOV BX,0
MOV DH, lose_x4 ;Row Number
MOV DL, lose_y4 ;Column Number
INT 10H
mov dx, offset lose4
MOV AH, 9
INT 21H

MOV AH,02H
MOV BX,0
MOV DH, lose_x5 ;Row Number
MOV DL, lose_y5 ;Column Number
INT 10H
mov dx, offset lose5
MOV AH, 9
INT 21H

MOV AH,02H
MOV BX,0
MOV DH, lose_x6 ;Row Number
MOV DL, lose_y6 ;Column Number
INT 10H
mov dx, offset lose6
MOV AH, 9
INT 21H

MOV AH,1
INT 21H 
ret
ENDGAME2 Endp

WINGAME Proc
mov ax, 0
;Video Game Mode
mov ah, 00h
mov al, 12h
int 10h
; BACKGROUND COLOR
MOV AH, 0Bh
MOV AL, 0
MOV CX, 0
MOV DX, 8080
MOV BH, 00h
;mov bl, 02h
INT 10h

MOV AH,02H
MOV BX,0
MOV DH, lose_x1 ;Row Number
MOV DL, lose_y1 ;Column Number
INT 10H
mov dx, offset lose1
MOV AH, 9
INT 21H 

MOV AH,02H
MOV BX,0
MOV DH, lose_x2 ;Row Number
MOV DL, lose_y2 ;Column Number
INT 10H
mov dx, offset lose2
MOV AH, 9
INT 21H

MOV AH,02H
MOV BX,0
MOV DH, lose_x3 ;Row Number
MOV DL, lose_y3 ;Column Number
INT 10H
mov dx, offset win3
MOV AH, 9
INT 21H

MOV AH,02H
MOV BX,0
MOV DH, lose_x4 ;Row Number
MOV DL, lose_y4 ;Column Number
INT 10H
mov dx, offset win4
MOV AH, 9
INT 21H

MOV AH,02H
MOV BX,0
MOV DH, lose_x5 ;Row Number
MOV DL, lose_y5 ;Column Number
INT 10H
mov dx, offset lose5
MOV AH, 9
INT 21H

MOV AH,02H
MOV BX,0
MOV DH, lose_x6 ;Row Number
MOV DL, lose_y6 ;Column Number
INT 10H
mov dx, offset lose6
MOV AH, 9
INT 21H

MOV AH,1
INT 21H 
ret
WINGAME Endp

end
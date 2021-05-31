	PRESERVE8
	THUMB   
		

; ====================== zone de r�servation de donn�es,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
VarTime	dcd 0 ; Permet d'initialiser la variable VarTime � 0
	export VarTime

	
; ===============================================================================================
	
;constantes (�quivalent du #define en C)
TimeValue	equ 900000 ; #define TimeValue 900000


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette mani�re de cr�er une temporisation n'est clairement pas la bonne mani�re de proc�der :
; - elle est peu pr�cise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'acc�s �cr/lec de variable en RAM
; - le m�canisme d'appel / retour sous programme
;
; et donc poss�de un int�r�t pour d�buter en ASM pur

Delay_100ms proc ; Rep�re visuelle (ne fait rien)
	
	    ldr r0,=VarTime ; r0 = VarTime
						  
		ldr r1,=TimeValue ; r1 = TimeValue
		str r1,[r0] ; r0 = TimeValue
		
BoucleTempo	; D�but de la Boucle
		ldr r1,[r0] ; r1 = TimeValue
						
		subs r1,#1 ; TimeValue = TimeValue - 1
		str  r1,[r0] ; r0 = TimeValue
		bne	 BoucleTempo ; Retour au d�but de la boucle tant que r0 > 0 (BoucleTempo)
			
		bx lr ; Ex�cute la suite du programme (ce qui se trouve apr�s BoucleTempo dans le code C)
		endp ; Rep�re visuelle (ne fait rien)
		
		
	END	
	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
VarTime	dcd 0 ; Permet d'initialiser la variable VarTime à 0
	export VarTime

	
; ===============================================================================================
	
;constantes (équivalent du #define en C)
TimeValue	equ 900000 ; #define TimeValue 900000


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette manière de créer une temporisation n'est clairement pas la bonne manière de procéder :
; - elle est peu précise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'accés écr/lec de variable en RAM
; - le mécanisme d'appel / retour sous programme
;
; et donc possède un intérêt pour débuter en ASM pur

Delay_100ms proc ; Repère visuelle (ne fait rien)
	
	    ldr r0,=VarTime ; r0 = VarTime
						  
		ldr r1,=TimeValue ; r1 = TimeValue
		str r1,[r0] ; r0 = TimeValue
		
BoucleTempo	; Début de la Boucle
		ldr r1,[r0] ; r1 = TimeValue
						
		subs r1,#1 ; TimeValue = TimeValue - 1
		str  r1,[r0] ; r0 = TimeValue
		bne	 BoucleTempo ; Retour au début de la boucle tant que r0 > 0 (BoucleTempo)
			
		bx lr ; Exécute la suite du programme (ce qui se trouve après BoucleTempo dans le code C)
		endp ; Repère visuelle (ne fait rien)
		
		
	END	
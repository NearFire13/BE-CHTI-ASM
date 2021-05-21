	PRESERVE8
	THUMB   
	include DriverJeuLaser.inc

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		

	
; ===============================================================================================
	
Index 		dcd 1
SortieSon 	dcd 0

;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		
	export CallbackSon
	export SortieSon
	extern Son
	extern LongueurSon
	
CallbackSon proc
	push	{lr}
	
	; Lecture du Son
	ldr		r0, =Son				; r0 = Adresse de Son;
	ldr		r1, =Index				; r1 = Adresse de Index;
	ldr		r12, [r1]
	ldrsh 	r12, [r0, r12, lsl #1]	; r2 = r0 + r12 * (2^1)
	
	ldr		r0, [r1]
	ldr		r2, =LongueurSon		; Adresse de r0
	ldr		r2, [r2]
	cmp 	r0, r2					; if Index > LongueurSon
	bgt		Fin
	; Mise à l'échelle ET stockage dans SortieSon
	; [0; 719]
	; [-32768; 32767] (2^16 = 65 536 valeurs possibles)
	; 0 -> -32768
	; 719 -> 32767
	ldr		r3, =SortieSon			; r3 = Adresse de SortieSon;
	add		r12, #32768				; r2 = r2 + 32768
	mov		r2, #719				; Stock le paramètre 719 dans R12
	mul		r12, r2					; r2 = r2 * 719
	lsr		r12, #16
	str 	r12, [r3]				; SortieSon = Valeur de r12*
	
	; Incrémentation de l'index
	ldr		r0, [r1]
	add		r0, #1
	str		r0, [r1]
	
	mov		r0, r12
	bl 		PWM_Set_Value_TIM3_Ch3 	; PWM_Set_Value_TIM3_Ch3(r12);
	
Fin
	pop		{lr}
	bx 		lr
	
	endp

	END	
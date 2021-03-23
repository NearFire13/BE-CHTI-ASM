	PRESERVE8
	THUMB
	include DriverJeuLaser.inc
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
	
; ===============================================================================================
	
FlagCligno dcd	0
		
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
	export timer_callback
	export FlagCligno

;code
timer_callback proc
	ldr 	r0, =FlagCligno 	; r0 = &FlagCligno
	ldr 	r1, [r0] 			; r1 = FlagCligno
	cmp 	r1, #1 				; if FlagCligno == 1
	bne 	FlagClignoElse 		; else
	push	{LR}				; empiler l'adresse de retour
	mov		r1, #0				; FlagCligno=0
	str		r1, [r0]			; 0 --> FlagCligno
	mov 	r0, #1				; Stock le paramètre 1 dans R0
	bl 		GPIOB_Set 			; GPIOB_Set(1);
	pop		{PC}				; dépiler directement dans PC
FlagClignoElse
	push	{LR}				; empiler l'adresse de retour
	mov		r1, #1				; FlagCligno=1;
	str		r1, [r0]			; 1 --> FlagCligno
	mov 	r0, #1				; Stock le paramètre 1 dans R0
	bl 		GPIOB_Clear 		; GPIOB_Clear(1);
	pop		{PC}				; dépiler directement dans PC
	
	endp
		
	END	
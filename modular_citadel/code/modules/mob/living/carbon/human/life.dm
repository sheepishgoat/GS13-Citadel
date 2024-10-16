//GS13 Port - arousal
/mob/living/carbon/human/Life()
		//citadel code
	if(stat != DEAD)
		handle_arousal()
	. = ..()

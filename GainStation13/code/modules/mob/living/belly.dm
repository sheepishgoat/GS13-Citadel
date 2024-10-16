/obj/item/organ/genital/belly //I know, I know a belly aint a genital. but it is in the sake of code.
	name 					= "belly"
	desc 					= "You see a belly on their midsection."
	icon_state 				= "belly"
	icon 					= 'hyperstation/icons/obj/genitals/belly.dmi'
	zone 					= BODY_ZONE_CHEST
	slot 					= ORGAN_SLOT_BELLY
	w_class 				= 3
	size 					= 0
	var/statuscheck			= FALSE
	shape					= "belly"
	masturbation_verb 		= "massage"
	var/sent_full_message	= TRUE //defaults to 1 since they're full to start
	var/inflatable			= FALSE //For inflation connoisseurs
	var/size_cached			= 0
	var/prev_size			= 0
	layer_index = BELLY_LAYER_INDEX

/obj/item/organ/genital/belly/modify_size(modifier, min = BELLY_SIZE_DEF, max = BELLY_SIZE_MAX)
	var/new_value = clamp(size_cached + modifier, min, max)
	if(new_value == size_cached)
		return
	prev_size = size_cached
	size_cached = new_value
	size = round(size_cached)
	update()
	..()

/obj/item/organ/genital/belly/update_appearance()
	icon_state = "belly_[shape]_[size]"
	if(owner)
		if(owner.dna.species.use_skintones && owner.dna.features["genitals_use_skintone"])
			if(ishuman(owner)) // Check before recasting type, although someone fucked up if you're not human AND have use_skintones somehow...
				var/mob/living/carbon/human/H = owner // only human mobs have skin_tone, which we need.
				color = SKINTONE2HEX(H.skin_tone)
				if(!H.dna.skin_tone_override)
					icon_state += "_s"
		else
			color = "#[owner.dna.features["belly_color"]]"

/obj/item/organ/genital/belly/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.species.use_skintones && D.features["genitals_use_skintone"])
		color = SKINTONE2HEX(H.skin_tone)
	else
		color = "#[D.features["belly_color"]]"
	size = D.features["belly_size"]
	inflatable = D.features["inflatable_belly"]
	toggle_visibility(D.features["belly_visibility"], FALSE)



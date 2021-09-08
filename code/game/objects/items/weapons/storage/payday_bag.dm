/obj/item/storage/payday_bag
	name = "Payday Bag"
	desc = "Bag for holding items in it (including your payments)"
	icon = 'icons/obj/payday_bag.dmi'
	icon_state = "icon"
	w_class = ITEM_SIZE_HUGE
	allow_quick_gather = 1
	allow_quick_empty = 1
	use_to_pickup = 1
	slot_flags = SLOT_BACK
	max_storage_space = DEFAULT_BACKPACK_STORAGE

	var/mob/living/stored_body

/obj/item/storage/payday_bag/MouseDrop_T(mob/living/M, mob/living/user)
	if (stored_body || !istype(M, /mob/living) || M == user)
		return
	to_chat(user, SPAN_DANGER("You start to pull [M] into [src]"))
	if (do_after(user, 2 SECONDS, M))
		stored_body = M
		if (M.client)
			M.client.perspective = EYE_PERSPECTIVE
			M.client.eye = src
		M.forceMove(src)

/obj/item/storage/payday_bag/attack_self(mob/user)
	if (stored_body)
		to_chat(user, SPAN_DANGER("You start to pull [stored_body] out of [src]"))
		if (do_after(user, 2 SECONDS, stored_body))
			if (!stored_body)
				return
			if (stored_body.client)
				stored_body.client.eye = stored_body
			stored_body.forceMove(get_turf(src))
			stored_body = null
	else
		..()

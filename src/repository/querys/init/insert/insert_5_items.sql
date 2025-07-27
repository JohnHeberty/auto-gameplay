COPY public.itens (id_item, name, dname, img, qual, cost, dmg_type, notes, mc, hc, cd, lore, created, charges, id_game) FROM stdin;
1154	royale_with_cheese	Block of Cheese	data\\processed\\dota2\\items\\img\\royale_with_cheese.png	consumable	2	\N		\N	\N	40	First there was the Belt of Strength. Then there were the Boots of Travel. Now, at long last, the Block of Cheese.	f	1	1
39	flask	Healing Salve	data\\processed\\dota2\\items\\img\\flask.png	consumable	100	\N		\N	\N	\N	A magical salve that can quickly mend even the deepest of wounds.	f	1	1
40	dust	Dust of Appearance	data\\processed\\dota2\\items\\img\\dust.png	consumable	80	\N	Places a debuff on enemy units in the area that reveals them when they are invisible.	\N	\N	30	One may hide visage, but never volume.	f	1	1
41	bottle	Bottle	data\\processed\\dota2\\items\\img\\bottle.png	common	675	\N	Bottle is shareable. Stored runes cannot be shared.\nUsing a stored Bounty or Water rune fully refills the bottle if the bottle was full when the rune was stored; otherwise, it refills two charges.	\N	\N	\N	An old bottle that survived the ages, the contents placed inside become enchanted.	f	3	1
42	ward_observer	Observer Ward	data\\processed\\dota2\\items\\img\\ward_observer.png	consumable	0	\N		\N	\N	1	A form of half-sentient plant, often cultivated by apprentice wizards.	f	1	1
43	ward_sentry	Sentry Ward	data\\processed\\dota2\\items\\img\\ward_sentry.png	consumable	50	\N		\N	\N	1	A form of plant originally grown in the garden of a fearful king.	f	1	1
218	ward_dispenser	Observer and Sentry Wards	data\\processed\\dota2\\items\\img\\ward_dispenser.png	consumable;laning	50	\N	Hold Control to give one ward to an allied hero.	\N	\N	\N	Advancements in stacking efficiency have made wards easier to carry than ever.	t	\N	1
44	tango	Tango	data\\processed\\dota2\\items\\img\\tango.png	consumable	90	\N		\N	\N	\N	Forage to survive on the battlefield.	f	3	1
241	tango_single	Tango (Shared)	data\\processed\\dota2\\items\\img\\tango_single.png	consumable	30	\N		\N	\N	\N	Om nom nom.	f	1	1
45	courier	Animal Courier	data\\processed\\dota2\\items\\img\\courier.png	consumable	50	\N		\N	\N	\N		f	\N	1
286	flying_courier	Flying Courier	data\\processed\\dota2\\items\\img\\flying_courier.png	consumable	100	\N		\N	\N	\N		f	\N	1
46	tpscroll	Town Portal Scroll	data\\processed\\dota2\\items\\img\\tpscroll.png	consumable	100	\N	If multiple heroes teleport to the same location in succession, the channeling time will be increased for each successive hero.\nTeleport can be prevented or canceled by Root abilities.	75	\N	80	What a hero truly needs.	f	1	1
47	recipe_travel_boots	Boots of Travel Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	2000	\N		\N	\N	\N		f	\N	1
48	travel_boots	Boots of Travel	data\\processed\\dota2\\items\\img\\travel_boots.png	common	2500	\N		\N	\N	\N	Winged boots that grant omnipresence.	t	\N	1
220	travel_boots_2	Boots of Travel 2	data\\processed\\dota2\\items\\img\\travel_boots_2.png	common	4500	\N		\N	\N	\N	Winged boots that grant omnipresence.	t	\N	1
50	phase_boots	Phase Boots	data\\processed\\dota2\\items\\img\\phase_boots.png	common	1500	\N		\N	\N	8	Boots that allow the wearer to travel between the ether.	t	\N	1
51	demon_edge	Demon Edge	data\\processed\\dota2\\items\\img\\demon_edge.png	secret_shop	2200	\N		\N	\N	\N	One of the oldest weapons forged by the Demon-Smith Abzidian, it killed its maker when he tested its edge.	f	\N	1
52	eagle	Eaglesong	data\\processed\\dota2\\items\\img\\eagle.png	secret_shop	2800	\N		\N	\N	\N	Capturing the majestic call of an eagle, this mystical horn brings limitless dexterity to those who hear it.	f	\N	1
53	reaver	Reaver	data\\processed\\dota2\\items\\img\\reaver.png	secret_shop	2800	\N		\N	\N	\N	A massive axe capable of tearing whole mountains down.	f	\N	1
54	relic	Sacred Relic	data\\processed\\dota2\\items\\img\\relic.png	secret_shop	3400	\N		\N	\N	\N	An ancient weapon that often turns the tides of war.	f	\N	1
55	hyperstone	Hyperstone	data\\processed\\dota2\\items\\img\\hyperstone.png	secret_shop	2000	\N		\N	\N	\N	A mystical, carved stone that boosts the fervor of the holder.	f	\N	1
56	ring_of_health	Ring of Health	data\\processed\\dota2\\items\\img\\ring_of_health.png	component	700	\N		\N	\N	\N	A shiny ring found beneath a fat halflings corpse.	f	\N	1
279	ring_of_tarrasque	Ring of Tarrasque	data\\processed\\dota2\\items\\img\\ring_of_tarrasque.png	component	1800	\N		\N	\N	\N	An ageless ring forged with an otherwise simple blood magic amplified by the presumed source of its key component.	f	\N	1
57	void_stone	Void Stone	data\\processed\\dota2\\items\\img\\void_stone.png	component	700	\N		\N	\N	\N	Jewelry that was once used to channel nether realm magic, this ring pulses with energy.	f	\N	1
1802	tiara_of_selemene	Tiara of Selemene	data\\processed\\dota2\\items\\img\\tiara_of_selemene.png	component	1800	\N		\N	\N	\N	A symbol of favor bestowed upon the high priestess of Selemene.	f	\N	1
58	mystic_staff	Mystic Staff	data\\processed\\dota2\\items\\img\\mystic_staff.png	secret_shop	2800	\N		\N	\N	\N	Enigmatic staff made of only the most expensive crystals.	f	\N	1
59	energy_booster	Energy Booster	data\\processed\\dota2\\items\\img\\energy_booster.png	secret_shop	800	\N		\N	\N	\N	This lapis gemstone is commonly added to the collection of wizards seeking to improve their presence in combat.	f	\N	1
60	point_booster	Point Booster	data\\processed\\dota2\\items\\img\\point_booster.png	secret_shop	1200	\N		\N	\N	\N	A perfectly formed amethyst that nourishes body and mind when held.	f	\N	1
61	vitality_booster	Vitality Booster	data\\processed\\dota2\\items\\img\\vitality_booster.png	secret_shop	1000	\N		\N	\N	\N	A ruby gemstone that has been passed down through generations of warrior kin.	f	\N	1
593	fluffy_hat	Fluffy Hat	data\\processed\\dota2\\items\\img\\fluffy_hat.png	secret_shop	250	\N		\N	\N	\N	Fine and functional foppery for the fashion-forward fighter.	f	\N	1
63	power_treads	Power Treads	data\\processed\\dota2\\items\\img\\power_treads.png	common	1400	\N	Power Treads can be built using a Belt of Strength, Band of Elvenskin, or a Robe of the Magi.	\N	\N	\N	A pair of tough-skinned boots that change to meet the demands of the wearer.	t	\N	1
1098	recipe_samurai_tabi		data\\processed\\dota2\\items\\img\\recipe.png	\N	1100	\N		\N	\N	\N		f	\N	1
203	dagon_4	Dagon	data\\processed\\dota2\\items\\img\\dagon_4.png	rare	6300	\N	Instantly kills illusions.	120	\N	27	A lesser wand that grows in power the longer it is used, it brings magic to the fingertips of the user.	t	\N	1
204	dagon_5	Dagon	data\\processed\\dota2\\items\\img\\dagon_5.png	rare	7450	\N	Instantly kills illusions.	120	\N	27	A lesser wand that grows in power the longer it is used, it brings magic to the fingertips of the user.	t	\N	1
105	recipe_necronomicon	Necronomicon Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1250	\N		\N	\N	\N		f	\N	1
106	necronomicon	Necronomicon	data\\processed\\dota2\\items\\img\\necronomicon.png	rare	2050	\N		150	\N	80	Considered the ultimate in necromancy and demonology, a powerful malefic force is locked within its pages.	t	\N	1
266	recipe_spirit_vessel	Spirit Vessel Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	900	\N		\N	\N	\N		f	\N	1
1091	samurai_tabi		data\\processed\\dota2\\items\\img\\samurai_tabi.png	common	5250	\N		\N	\N	\N		t	\N	1
1092	recipe_hermes_sandals		data\\processed\\dota2\\items\\img\\recipe.png	\N	500	\N		\N	\N	\N		f	\N	1
1093	hermes_sandals		data\\processed\\dota2\\items\\img\\hermes_sandals.png	common	4800	\N		\N	\N	10		t	\N	1
1099	recipe_witches_switch		data\\processed\\dota2\\items\\img\\recipe.png	\N	625	\N		\N	\N	\N		f	\N	1
1100	witches_switch		data\\processed\\dota2\\items\\img\\witches_switch.png	common	1900	\N		\N	\N	1		t	\N	1
1094	recipe_lunar_crest		data\\processed\\dota2\\items\\img\\recipe.png	\N	250	\N		\N	\N	\N		f	\N	1
1095	lunar_crest	Lunar Crest	data\\processed\\dota2\\items\\img\\lunar_crest.png	common	2275	\N		\N	\N	30		t	\N	1
1106	recipe_phylactery	Phylactery Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	400	\N		\N	\N	\N		f	\N	1
1107	phylactery	Phylactery	data\\processed\\dota2\\items\\img\\phylactery.png	common	2600	\N		\N	\N	10	An amulet overflowing with powerful magics.	t	\N	1
1807	recipe_angels_demise	Khanda Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1300	\N		\N	\N	\N		f	\N	1
1808	angels_demise	Khanda	data\\processed\\dota2\\items\\img\\angels_demise.png	common	5700	\N		\N	\N	10	A blade sharp enough to slice through magic itself.	t	\N	1
655	grandmasters_glaive		data\\processed\\dota2\\items\\img\\grandmasters_glaive.png	common	5000	\N		\N	\N	\N		f	\N	1
64	recipe_hand_of_midas	Hand of Midas Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1750	\N		\N	\N	\N		f	\N	1
65	hand_of_midas	Hand of Midas	data\\processed\\dota2\\items\\img\\hand_of_midas.png	common	2200	\N	The gold given is reliable gold (you do not get the normal creep bounty).\nExperience gained by using Transmute is not shared.	\N	\N	\N	Preserved through unknown magical means, the Hand of Midas is a weapon of greed, sacrificing animals to line the owners pockets.	t	1	1
1164	aetherial_halo		data\\processed\\dota2\\items\\img\\aetherial_halo.png	common	5900	Magical		100	\N	24		f	\N	1
67	oblivion_staff	Oblivion Staff	data\\processed\\dota2\\items\\img\\oblivion_staff.png	common	1625	\N		\N	\N	\N	Deceptively hidden as an ordinary staff, it is actually very powerful, much like the Eldritch who originally possessed it.	t	\N	1
533	recipe_witch_blade	Witch Blade Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	250	\N		\N	\N	\N		f	\N	1
534	witch_blade	Witch Blade	data\\processed\\dota2\\items\\img\\witch_blade.png	common	2775	\N		\N	\N	9	A spiteful blade inadvertently possessed by the soul of its incautious creator.	t	\N	1
69	pers	Perseverance	data\\processed\\dota2\\items\\img\\pers.png	common	1400	\N		\N	\N	\N	A gem that grants heart to the bearer.	t	\N	1
1125	cornucopia	Cornucopia	data\\processed\\dota2\\items\\img\\cornucopia.png	common	1200	\N		\N	\N	\N	A source of spiritual and physical nourishment.	f	\N	1
71	poor_mans_shield	Poor Mans Shield	data\\processed\\dota2\\items\\img\\poor_mans_shield.png	common	0	\N	Multiple sources of damage block do not stack.	\N	\N	\N	A busted old shield that seems to block more than it should.	f	\N	1
731	satchel		data\\processed\\dota2\\items\\img\\satchel.png	common	0	\N		\N	\N	\N		f	\N	1
72	recipe_bracer	Bracer Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	210	\N		\N	\N	\N		f	\N	1
73	bracer	Bracer	data\\processed\\dota2\\items\\img\\bracer.png	common	505	\N		\N	\N	\N	The bracer is a common choice to toughen up defenses and increase longevity.	t	\N	1
74	recipe_wraith_band	Wraith Band Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	210	\N		\N	\N	\N		f	\N	1
75	wraith_band	Wraith Band	data\\processed\\dota2\\items\\img\\wraith_band.png	common	505	\N		\N	\N	\N	A circlet with faint whispers echoing about it.	t	\N	1
76	recipe_null_talisman	Null Talisman Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	210	\N		\N	\N	\N		f	\N	1
77	null_talisman	Null Talisman	data\\processed\\dota2\\items\\img\\null_talisman.png	common	505	\N		\N	\N	\N	A small gemstone attached to several chains.	t	\N	1
78	recipe_mekansm	Mekansm Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	800	\N		\N	\N	\N		f	\N	1
79	mekansm	Mekansm	data\\processed\\dota2\\items\\img\\mekansm.png	rare	1775	\N	Restore does not affect units that have been affected by Restore or Guardian Greaves Mend within Mekansms cooldown.\nMultiple instances of Mekansm Aura do not stack.	100	\N	50	A glowing jewel formed out of assorted parts that somehow fit together perfectly.	t	\N	1
81	vladmir	Vladmirs Offering	data\\processed\\dota2\\items\\img\\vladmir.png	rare	2200	\N	Lifesteal on attacks against creeps is reduced to 12%.	\N	\N	\N	An eerie mask that is haunted with the malice of a fallen vampire.	t	\N	1
907	recipe_wraith_pact		data\\processed\\dota2\\items\\img\\recipe.png	\N	400	\N		\N	\N	\N		f	\N	1
908	wraith_pact	Wraith Pact	data\\processed\\dota2\\items\\img\\wraith_pact.png	rare	3800	Magical		100	\N	60		t	\N	1
85	recipe_buckler	Buckler Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	250	\N		\N	\N	\N		f	\N	1
86	buckler	Buckler	data\\processed\\dota2\\items\\img\\buckler.png	rare	425	\N		\N	\N	\N	A powerful shield that imbues the bearer with the strength of heroes past, it is capable of protecting entire armies in battle.	t	\N	1
87	recipe_ring_of_basilius	Ring of Basilius Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	250	\N		\N	\N	\N		f	\N	1
88	ring_of_basilius	Ring of Basilius	data\\processed\\dota2\\items\\img\\ring_of_basilius.png	rare	425	\N		\N	\N	\N	Ring given as a reward to the greatest mages.	t	\N	1
268	recipe_holy_locket	Holy Locket Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	800	\N		\N	\N	\N		f	\N	1
269	holy_locket	Holy Locket	data\\processed\\dota2\\items\\img\\holy_locket.png	rare	2250	\N		\N	\N	\N	A prized relic long thought lost forever in a failed crusade.	t	1	1
89	recipe_pipe	Pipe of Insight Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	700	\N		\N	\N	\N		f	\N	1
90	pipe	Pipe of Insight	data\\processed\\dota2\\items\\img\\pipe.png	rare	3725	\N	Multiple instances of Barrier do not stack.\nStacks multiplicatively with other sources of magic resistance.	150	\N	60	A powerful artifact of mysterious origin, it creates barriers against magical forces.	t	\N	1
91	recipe_urn_of_shadows	Urn of Shadows Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	320	\N		\N	\N	\N		f	\N	1
92	urn_of_shadows	Urn of Shadows	data\\processed\\dota2\\items\\img\\urn_of_shadows.png	rare	825	\N	Empty urns gain 2 charges.\nIf used on a hero with Soul Release already active on them, it will refresh its duration.\nDoes not trigger spell block or spell reflect.	\N	\N	10	Contains the ashes of powerful demons.	t	\N	1
93	recipe_headdress	Headdress Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	250	\N		\N	\N	\N		f	\N	1
94	headdress	Headdress	data\\processed\\dota2\\items\\img\\headdress.png	rare	425	\N		\N	\N	\N	Creates a soothing aura that restores allies in battle.	t	\N	1
95	recipe_sheepstick	Scythe of Vyse Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	600	\N		\N	\N	\N		f	\N	1
96	sheepstick	Scythe of Vyse	data\\processed\\dota2\\items\\img\\sheepstick.png	rare	5200	\N	The target will have a base movement speed of 140, but buffs granting maximum movement speed wont be disabled.	250	\N	20	The most guarded relic among the cult of Vyse, it is the most coveted weapon among magi.	t	\N	1
1801	caster_rapier		data\\processed\\dota2\\items\\img\\caster_rapier.png	rare	5600	\N		\N	\N	9		f	\N	1
97	recipe_orchid	Orchid Malevolence Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	450	\N		\N	\N	\N		f	\N	1
98	orchid	Orchid Malevolence	data\\processed\\dota2\\items\\img\\orchid.png	rare	3275	\N		125	\N	18	A garnet rod constructed from the essence of a fire demon.	t	\N	1
245	recipe_bloodthorn	Bloodthorn Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	450	\N		\N	\N	\N		f	\N	1
250	bloodthorn	Bloodthorn	data\\processed\\dota2\\items\\img\\bloodthorn.png	epic	6625	Magical		125	\N	15	A reviled blade that bites deeper with each wriggle of its victims final throes.	t	\N	1
252	echo_sabre	Echo Sabre	data\\processed\\dota2\\items\\img\\echo_sabre.png	artifact	2700	\N		\N	\N	5	A deceptively swift blade imbued with resonant magic.	t	\N	1
99	recipe_cyclone	Euls Scepter Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	675	\N		\N	\N	\N		f	\N	1
100	cyclone	Euls Scepter of Divinity	data\\processed\\dota2\\items\\img\\cyclone.png	rare	2600	\N	You cannot cyclone allies.\nCyclones cast on yourself go through spell immunity.\nCyclone can dispel some buffs and debuffs.\nCyclone duration is unaffected by status resistance.	175	\N	23	A mysterious scepter passed down through the ages, its disruptive winds can be used for good or evil.	t	\N	1
612	recipe_wind_waker	Wind Waker Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1400	\N		\N	\N	\N		f	\N	1
610	wind_waker	Wind Waker	data\\processed\\dota2\\items\\img\\wind_waker.png	rare	6800	\N	Cyclone can dispel some buffs and debuffs.\nWhen cast on yourself, the cyclone can be moved anywhere at a speed of 360.\nCyclone duration is unaffected by status resistance.	175	\N	16	Proof enough to some that unseen forces manipulate the happenings of the material plane.	t	\N	1
233	recipe_aether_lens	Aether Lens Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	775	\N		\N	\N	\N		f	\N	1
232	aether_lens	Aether Lens	data\\processed\\dota2\\items\\img\\aether_lens.png	rare	2275	\N	Passive does not stack.	\N	\N	\N	Polished with the incantation of his final breath, the gift of a dying mage to his sickly son.	t	\N	1
101	recipe_force_staff	Force Staff Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	950	\N		\N	\N	\N		f	\N	1
102	force_staff	Force Staff	data\\processed\\dota2\\items\\img\\force_staff.png	rare	2200	\N	Self-cast will cause you to use Force on yourself.\nForce Staff doesnt interrupt the targets actions.\nWill not work on a unit inside Chronosphere, Duel, or Black Hole.\nForce Staff has 850 cast range when cast on enemies.	150	\N	19	Allows you to manipulate others, for good or evil.	t	\N	1
262	recipe_hurricane_pike	Hurricane Pike Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	350	\N		\N	\N	\N		f	\N	1
263	hurricane_pike	Hurricane Pike	data\\processed\\dota2\\items\\img\\hurricane_pike.png	epic	4450	\N	Self-cast will use Hurricane Pike on yourself.\nHurricane Pike doesnt interrupt the targets actions.\nWill not work on a unit inside Chronosphere, Duel, or Black Hole.	150	\N	19	A legendary pike once held as royal sigil of the ancient wyvern riders.	t	\N	1
103	recipe_dagon	Dagon Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1150	\N		\N	\N	\N		f	\N	1
2097	duelist_gloves	Duelist Gloves	data\\processed\\dota2\\items\\img\\duelist_gloves.png	\N	0	\N		\N	\N	\N		f	\N	1
1	blink	Blink Dagger	data\\processed\\dota2\\items\\img\\blink.png	component	2250	\N	Self-casting will cause you to teleport in the direction of your teams fountain.	\N	\N	15	The fabled dagger used by the fastest assassin ever to walk the lands.	f	\N	1
600	overwhelming_blink	Overwhelming Blink	data\\processed\\dota2\\items\\img\\overwhelming_blink.png	component	6800	Magical	Self-casting will cause you to teleport in the direction of your teams fountain.	\N	\N	15	A horrifying dagger forged in the chaos maw and nigh untouchable by mortal hands.	t	\N	1
603	swift_blink	Swift Blink	data\\processed\\dota2\\items\\img\\swift_blink.png	component	6800	\N	Self-casting will cause you to teleport in the direction of your teams fountain.	\N	\N	15	A cunning blade able to anticipate and enable its bearers movements.	t	\N	1
604	arcane_blink	Arcane Blink	data\\processed\\dota2\\items\\img\\arcane_blink.png	component	6800	\N	Self-casting will cause you to teleport in the direction of your teams fountain.	\N	\N	9	A revitalizing tool to help bear the weight of arcane expenditure.	t	\N	1
606	recipe_arcane_blink	Arcane Blink Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1750	\N		\N	\N	\N		f	\N	1
607	recipe_swift_blink	Swift Blink Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1750	\N		\N	\N	\N		f	\N	1
608	recipe_overwhelming_blink	Overwhelming Blink Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1750	\N		\N	\N	\N		f	\N	1
2	blades_of_attack	Blades of Attack	data\\processed\\dota2\\items\\img\\blades_of_attack.png	component	450	\N		\N	\N	\N	The damage of these small, concealable blades should not be underestimated.	f	\N	1
3	broadsword	Broadsword	data\\processed\\dota2\\items\\img\\broadsword.png	component	1000	\N		\N	\N	\N	The classic weapon of choice for knights, this blade is sturdy and reliable for slaying enemies.	f	\N	1
4	chainmail	Chainmail	data\\processed\\dota2\\items\\img\\chainmail.png	component	550	\N		\N	\N	\N	A medium weave of metal chains.	f	\N	1
5	claymore	Claymore	data\\processed\\dota2\\items\\img\\claymore.png	component	1350	\N		\N	\N	\N	A sword that can cut through armor, its a commonly chosen first weapon for budding swordsmen.	f	\N	1
6	helm_of_iron_will	Helm of Iron Will	data\\processed\\dota2\\items\\img\\helm_of_iron_will.png	component	975	\N		\N	\N	\N	The helmet of a legendary warrior who fell in battle.	f	\N	1
7	javelin	Javelin	data\\processed\\dota2\\items\\img\\javelin.png	component	900	\N		\N	\N	\N	A rather typical spear that can sometimes pierce through an enemys armor when used to attack.	f	\N	1
8	mithril_hammer	Mithril Hammer	data\\processed\\dota2\\items\\img\\mithril_hammer.png	component	1600	\N		\N	\N	\N	A hammer forged of pure mithril.	f	\N	1
9	platemail	Platemail	data\\processed\\dota2\\items\\img\\platemail.png	secret_shop	1400	\N		\N	\N	\N	Thick metal plates that protect the entire upper body. Avoid dropping on feet.	f	\N	1
10	quarterstaff	Quarterstaff	data\\processed\\dota2\\items\\img\\quarterstaff.png	component	875	\N		\N	\N	\N	A basic staff that allows you to strike quickly.	f	\N	1
11	quelling_blade	Quelling Blade	data\\processed\\dota2\\items\\img\\quelling_blade.png	component	100	\N	Effects of multiple quelling blades do not stack.	\N	\N	4	The axe of a fallen gnome, it allows you to effectively maneuver the forest.	f	\N	1
237	faerie_fire	Faerie Fire	data\\processed\\dota2\\items\\img\\faerie_fire.png	consumable	65	\N		\N	\N	5	The ethereal flames from the ever-burning ruins of Kindertree ignite across realities.	f	1	1
265	infused_raindrop	Infused Raindrops	data\\processed\\dota2\\items\\img\\infused_raindrop.png	component	225	\N	Uses at most one charge per damage instance.	\N	\N	7	Elemental protection from magical assaults.	f	6	1
244	wind_lace	Wind Lace	data\\processed\\dota2\\items\\img\\wind_lace.png	component	225	\N		\N	\N	\N	Hasten to battle on wind-touched heels.	f	\N	1
12	ring_of_protection	Ring of Protection	data\\processed\\dota2\\items\\img\\ring_of_protection.png	component	175	\N		\N	\N	\N	A glimmering ring that defends its bearer.	f	\N	1
182	stout_shield	Stout Shield	data\\processed\\dota2\\items\\img\\stout_shield.png	component	100	\N	Multiple sources of damage block do not stack.	\N	\N	\N	One mans wine barrel bottom is another mans shield.	f	\N	1
247	moon_shard	Moon Shard	data\\processed\\dota2\\items\\img\\moon_shard.png	consumable	4000	\N		\N	\N	\N	Said to be a tear from the lunar goddess Selemene.	t	\N	1
13	gauntlets	Gauntlets of Strength	data\\processed\\dota2\\items\\img\\gauntlets.png	component	140	\N		\N	\N	\N	Studded leather gloves that add brute strength.	f	\N	1
14	slippers	Slippers of Agility	data\\processed\\dota2\\items\\img\\slippers.png	component	140	\N		\N	\N	\N	Light boots made from spider skin that tingles your senses.	f	\N	1
15	mantle	Mantle of Intelligence	data\\processed\\dota2\\items\\img\\mantle.png	component	140	\N		\N	\N	\N	A beautiful sapphire mantle worn by generations of queens.	f	\N	1
16	branches	Iron Branch	data\\processed\\dota2\\items\\img\\branches.png	consumable	50	\N		\N	\N	\N	A seemingly ordinary branch, its ironlike qualities are bestowed upon the bearer.	f	\N	1
17	belt_of_strength	Belt of Strength	data\\processed\\dota2\\items\\img\\belt_of_strength.png	component	450	\N		\N	\N	\N	A valued accessory for improving vitality.	f	\N	1
18	boots_of_elves	Band of Elvenskin	data\\processed\\dota2\\items\\img\\boots_of_elves.png	component	450	\N		\N	\N	\N	A tensile fabric often used for its light weight and ease of movement.	f	\N	1
19	robe	Robe of the Magi	data\\processed\\dota2\\items\\img\\robe.png	component	450	\N		\N	\N	\N	This robe corrupts the soul of the user, but provides wisdom in return.	f	\N	1
20	circlet	Circlet	data\\processed\\dota2\\items\\img\\circlet.png	component	155	\N		\N	\N	\N	An elegant circlet designed for human princesses.	f	\N	1
261	crown	Crown	data\\processed\\dota2\\items\\img\\crown.png	component	450	\N		\N	\N	\N	A stately crown created to ensure a well-meaning but ungifted heir could fend off usurpers and govern with a strong hand.	f	\N	1
1122	diadem	Diadem	data\\processed\\dota2\\items\\img\\diadem.png	component	1000	\N		\N	\N	\N	A crown that can never be removed.	f	\N	1
21	ogre_axe	Ogre Axe	data\\processed\\dota2\\items\\img\\ogre_axe.png	component	1000	\N		\N	\N	\N	You grow stronger just by holding it.	f	\N	1
22	blade_of_alacrity	Blade of Alacrity	data\\processed\\dota2\\items\\img\\blade_of_alacrity.png	component	1000	\N		\N	\N	\N	A long blade imbued with time magic.	f	\N	1
23	staff_of_wizardry	Staff of Wizardry	data\\processed\\dota2\\items\\img\\staff_of_wizardry.png	component	1000	\N		\N	\N	\N	A staff of magical powers passed down from the eldest mages.	f	\N	1
24	ultimate_orb	Ultimate Orb	data\\processed\\dota2\\items\\img\\ultimate_orb.png	secret_shop	2800	\N		\N	\N	\N	A mystical orb containing the essence of life.	f	\N	1
25	gloves	Gloves of Haste	data\\processed\\dota2\\items\\img\\gloves.png	component	450	\N		\N	\N	\N	A pair of magical gloves that seems to render weapons weightless.	f	\N	1
485	blitz_knuckles	Blitz Knuckles	data\\processed\\dota2\\items\\img\\blitz_knuckles.png	component	1000	\N		\N	\N	\N	An underground arcanists update of a back-alley classic.	f	\N	1
26	lifesteal	Morbid Mask	data\\processed\\dota2\\items\\img\\lifesteal.png	component	900	\N		\N	\N	\N	A mask that drains the energy of those caught in its gaze.	f	\N	1
473	voodoo_mask	Voodoo Mask	data\\processed\\dota2\\items\\img\\voodoo_mask.png	component	700	\N		\N	\N	\N	A mask tuned to sip the arcane bindings that pass between caster and foe.	f	\N	1
27	ring_of_regen	Ring of Regen	data\\processed\\dota2\\items\\img\\ring_of_regen.png	component	175	\N		\N	\N	\N	This ring is considered a good luck charm among the Gnomes.	f	\N	1
28	sobi_mask	Sages Mask	data\\processed\\dota2\\items\\img\\sobi_mask.png	component	175	\N		\N	\N	\N	A mask commonly used by mages and warlocks for various rituals.	f	\N	1
29	boots	Boots of Speed	data\\processed\\dota2\\items\\img\\boots.png	component	500	\N		\N	\N	\N	Fleet footwear, increasing movement.	f	\N	1
30	gem	Gem of TRUE Sight	data\\processed\\dota2\\items\\img\\gem.png	component	900	\N	Disabled while on a courier.	\N	\N	12	Not one thrall creature of the depths,\r\nNor spirit bound in drownings keep,\r\nNor Maelrawn the Tentacular,\r\nShall rest till seas, gem comes to sleep.	f	\N	1
31	cloak	Cloak	data\\processed\\dota2\\items\\img\\cloak.png	component	800	\N	Stacks multiplicatively with other sources of spell resistance.	\N	\N	\N	A cloak made of a magical material that works to dispel any magic cast on it.	f	\N	1
32	talisman_of_evasion	Talisman of Evasion	data\\processed\\dota2\\items\\img\\talisman_of_evasion.png	secret_shop	1300	\N	Stacks diminishingly with other sources of Evasion.	\N	\N	\N	A necklace that allows you to anticipate enemy attacks.	f	\N	1
33	cheese	Cheese	data\\processed\\dota2\\items\\img\\cheese.png	consumable	1000	\N	Cheese is shareable.	\N	\N	40	Made from the milk of a long lost Furbolg vendor, it restores the vitality of those who taste it.	f	1	1
34	magic_stick	Magic Stick	data\\processed\\dota2\\items\\img\\magic_stick.png	component	200	\N	Gains charges for spells cast by visible enemies in 1200 range.\nCertain abilities and item abilities will not add charges.	\N	\N	17	A simple wand used to channel magic energies, it is favored by apprentice wizards and great warlocks alike.	f	\N	1
35	recipe_magic_wand	Magic Wand Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	150	\N		\N	\N	\N		f	\N	1
36	magic_wand	Magic Wand	data\\processed\\dota2\\items\\img\\magic_wand.png	common	450	\N	Gains charges for spells cast by visible enemies in 1200 range.\nCertain abilities and item abilities will not add charges.	\N	\N	15	A simple wand used to channel magic energies, it is favored by apprentice wizards and great warlocks alike.	t	\N	1
37	ghost	Ghost Scepter	data\\processed\\dota2\\items\\img\\ghost.png	component	1500	\N	Ends if you become Spell Immune, and will have no effect if you are already Spell Immune.\nShares cooldown with Ethereal Blade.	\N	\N	22	Imbues the wielder with a ghostly presence, allowing them to evade physical damage.	f	\N	1
38	clarity	Clarity	data\\processed\\dota2\\items\\img\\clarity.png	consumable	50	\N		\N	\N	\N	Clear water that enhances the ability to meditate.	f	1	1
216	enchanted_mango	Enchanted Mango	data\\processed\\dota2\\items\\img\\enchanted_mango.png	consumable	65	\N	Hold Control to use on a nearby allied hero.	\N	\N	\N	The bittersweet flavors of Jidi Isle are irresistible to amphibians.	f	1	1
4204	famango	Healing Lotus	data\\processed\\dota2\\items\\img\\famango.png	consumable	0	\N	Hold Control to use on a nearby allied hero.	\N	\N	5		f	1	1
4205	great_famango	Great Healing Lotus	data\\processed\\dota2\\items\\img\\great_famango.png	consumable	0	\N	Hold Control to use on a nearby allied hero.	\N	\N	5		t	1	1
4206	greater_famango	Greater Healing Lotus	data\\processed\\dota2\\items\\img\\greater_famango.png	consumable	0	\N	Hold Control to use on a nearby allied hero.	\N	\N	5		t	1	1
1123	blood_grenade	Blood Grenade	data\\processed\\dota2\\items\\img\\blood_grenade.png	consumable	50	\N		\N	75	10	Both the hunter and the hunted must pay the blood price.	f	1	1
104	dagon	Dagon	data\\processed\\dota2\\items\\img\\dagon.png	rare	2850	\N	Instantly kills illusions.	120	\N	27	A lesser wand that grows in power the longer it is used, it brings magic to the fingertips of the user.	t	\N	1
201	dagon_2	Dagon	data\\processed\\dota2\\items\\img\\dagon_2.png	rare	4000	\N	Instantly kills illusions.	120	\N	27	A lesser wand that grows in power the longer it is used, it brings magic to the fingertips of the user.	t	\N	1
202	dagon_3	Dagon	data\\processed\\dota2\\items\\img\\dagon_3.png	rare	5150	\N	Instantly kills illusions.	120	\N	27	A lesser wand that grows in power the longer it is used, it brings magic to the fingertips of the user.	t	\N	1
193	necronomicon_2	Necronomicon	data\\processed\\dota2\\items\\img\\necronomicon_2.png	rare	3300	\N		150	\N	80	Considered the ultimate in necromancy and demonology, a powerful malefic force is locked within its pages.	t	\N	1
194	necronomicon_3	Necronomicon	data\\processed\\dota2\\items\\img\\necronomicon_3.png	rare	4550	\N		150	\N	80	Considered the ultimate in necromancy and demonology, a powerful malefic force is locked within its pages.	t	\N	1
108	ultimate_scepter	Aghanims Scepter	data\\processed\\dota2\\items\\img\\ultimate_scepter.png	rare	4200	\N		\N	\N	\N	The scepter of a wizard with demigod-like powers.	t	\N	1
270	recipe_ultimate_scepter_2	Aghanims Blessing Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1600	\N		\N	\N	\N		f	\N	1
271	ultimate_scepter_2	Aghanims Blessing	data\\processed\\dota2\\items\\img\\ultimate_scepter_2.png	rare	5800	\N		\N	\N	\N	The scepter of a wizard with demigod-like powers.	t	\N	1
727	ultimate_scepter_roshan	Aghanims Blessing - Roshan	data\\processed\\dota2\\items\\img\\ultimate_scepter_roshan.png	rare	5800	\N		\N	\N	\N	The scepter of a wizard with demigod-like powers.	f	\N	1
609	aghanims_shard	Aghanims Shard	data\\processed\\dota2\\items\\img\\aghanims_shard.png	rare	1400	\N		\N	\N	\N	With origins known only to a single wizard, fragments of this impossible crystal are nearly as coveted as the renowned scepter itself.	f	\N	1
725	aghanims_shard_roshan	Aghanims Shard - Consumable	data\\processed\\dota2\\items\\img\\aghanims_shard_roshan.png	rare	1400	\N		\N	\N	\N	With origins known only to a single wizard, fragments of this impossible crystal are nearly as coveted as the renowned scepter itself.	f	\N	1
109	recipe_refresher	Refresher Orb Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	200	\N		\N	\N	\N		f	\N	1
110	refresher	Refresher Orb	data\\processed\\dota2\\items\\img\\refresher.png	rare	5000	\N		350	\N	180	A powerful artifact created for wizards.	t	\N	1
111	recipe_assault	Assault Cuirass Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1300	\N		\N	\N	\N		f	\N	1
112	assault	Assault Cuirass	data\\processed\\dota2\\items\\img\\assault.png	epic	5125	\N		\N	\N	\N	Forged in the depths of the nether reaches, this hellish mail provides an army with increased armor and attack speed.	t	\N	1
113	recipe_heart	Heart of Tarrasque Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	600	\N		\N	\N	\N		f	\N	1
114	heart	Heart of Tarrasque	data\\processed\\dota2\\items\\img\\heart.png	epic	5200	\N		\N	\N	\N	Preserved heart of an extinct monster, it bolsters the bearers fortitude.	t	\N	1
115	recipe_black_king_bar	Black King Bar Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1450	\N		\N	\N	\N		f	\N	1
116	black_king_bar	Black King Bar	data\\processed\\dota2\\items\\img\\black_king_bar.png	epic	4050	\N	Purchasing another Black King Bar will not reset its immunity duration.\nAbilities that pierce magic immunity will work fully even when Avatar is activated	50	\N	95	A powerful staff imbued with the strength of giants.	t	\N	1
117	aegis	Aegis of the Immortal	data\\processed\\dota2\\items\\img\\aegis.png	artifact	0	\N	Pronounced as ayy jis.	\N	\N	\N	The Immortal was said to own a shield that protected him from death itself.	f	\N	1
118	recipe_shivas_guard	Shivas Guard Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	2050	\N		\N	\N	\N		f	\N	1
119	shivas_guard	Shivas Guard	data\\processed\\dota2\\items\\img\\shivas_guard.png	epic	5175	\N	The wave extends at a speed of 400 to a max size of 900.\nThe Arctic Blast follows its caster.\nMultiple instances of Freezing Aura do not stack.	75	\N	27	Said to have belonged to a goddess, today it retains much of its former power.	t	\N	1
121	bloodstone	Bloodstone	data\\processed\\dota2\\items\\img\\bloodstone.png	epic	4400	Magical	Using Bloodpact leaves you drained for 40 seconds and cant benefit from Bloodpact again during that time.	\N	\N	30	The Bloodstones bright ruby color is unmistakable on the battlefield, as the owner seems to have infinite vitality and spirit.	t	\N	1
122	recipe_sphere	Linkens Sphere Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	600	\N		\N	\N	\N		f	\N	1
123	sphere	Linkens Sphere	data\\processed\\dota2\\items\\img\\sphere.png	epic	4800	\N	Targeted abilities from neutral items do not trigger Spellblock.	\N	\N	14	This magical sphere once protected one of the most famous heroes in history.	t	\N	1
221	recipe_lotus_orb	Lotus Orb Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	250	\N		\N	\N	\N		f	\N	1
226	lotus_orb	Lotus Orb	data\\processed\\dota2\\items\\img\\lotus_orb.png	epic	3850	\N	Targeted abilities from neutral items do not trigger Echo Shell.	175	\N	15	The jewel at its center still reflects a pale image of its creator.	t	\N	1
222	recipe_meteor_hammer	Meteor Hammer Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	300	\N		\N	\N	\N		f	\N	1
223	meteor_hammer	Meteor Hammer	data\\processed\\dota2\\items\\img\\meteor_hammer.png	epic	2850	Magical		75	\N	24		t	\N	1
225	nullifier	Nullifier	data\\processed\\dota2\\items\\img\\nullifier.png	epic	4375	\N	Can be cast on invulnerable units.	\N	\N	10		t	\N	1
255	recipe_aeon_disk	Aeon Disk Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1200	\N		\N	\N	\N		f	\N	1
256	aeon_disk	Aeon Disk	data\\processed\\dota2\\items\\img\\aeon_disk.png	epic	3000	\N		\N	\N	105		t	\N	1
258	recipe_kaya	Kaya Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	650	\N		\N	\N	\N		f	\N	1
259	kaya	Kaya	data\\processed\\dota2\\items\\img\\kaya.png	epic	2100	\N		\N	\N	\N		t	\N	1
369	trident	Trident	data\\processed\\dota2\\items\\img\\trident.png	\N	6301	\N		\N	\N	\N		t	\N	1
276	combo_breaker		data\\processed\\dota2\\items\\img\\combo_breaker.png	\N	\N	\N		\N	\N	\N		f	\N	1
260	refresher_shard	Refresher Shard	data\\processed\\dota2\\items\\img\\refresher_shard.png	consumable	1000	\N	Refresher Shard is shareable.	200	\N	180		f	1	1
267	spirit_vessel	Spirit Vessel	data\\processed\\dota2\\items\\img\\spirit_vessel.png	rare	2725	\N	Does not trigger spell block or spell reflect.	\N	\N	10		t	\N	1
125	vanguard	Vanguard	data\\processed\\dota2\\items\\img\\vanguard.png	epic	1700	\N	Multiple sources of damage block do not stack.	\N	\N	\N	A powerful shield that defends its wielder from even the most vicious of attacks.	t	\N	1
243	recipe_crimson_guard	Crimson Guard Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1050	\N		\N	\N	\N		f	\N	1
242	crimson_guard	Crimson Guard	data\\processed\\dota2\\items\\img\\crimson_guard.png	epic	3725	\N	Multiple sources of damage block do not stack.	75	\N	40	A cuirass originally built to protect against the dreaded Year Beast.	t	\N	1
126	recipe_blade_mail	Blade Mail Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	750	\N		\N	\N	\N		f	\N	1
127	blade_mail	Blade Mail	data\\processed\\dota2\\items\\img\\blade_mail.png	epic	2300	\N	Damage Return is calculated before any kind of reduction.\nDamage Return doesnt reflect damage from other forms of Blade Mail.\nReturned damage type is the same as it was received.	25	\N	25	A razor-sharp coat of mail, it is the choice of selfless martyrs in combat.	t	\N	1
129	soul_booster	Soul Booster	data\\processed\\dota2\\items\\img\\soul_booster.png	epic	3000	\N		\N	\N	\N	Regain lost courage.	t	\N	1
131	hood_of_defiance	Hood of Defiance	data\\processed\\dota2\\items\\img\\hood_of_defiance.png	epic	0	\N	Stacks multiplicatively with other sources of spell resistance.	50	\N	60	A furred, magic resistant headpiece that is feared by wizards.	f	\N	1
691	recipe_eternal_shroud	Eternal Shroud Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	900	\N		\N	\N	\N		f	\N	1
692	eternal_shroud	Eternal Shroud	data\\processed\\dota2\\items\\img\\eternal_shroud.png	epic	3700	\N		\N	\N	\N	A pristine hood that feeds upon strife to empower its owner.	t	\N	1
133	rapier	Divine Rapier	data\\processed\\dota2\\items\\img\\rapier.png	epic	5600	\N	If Divine Rapier is dropped and picked up by an enemy of its original owner, it cannot be dropped again except by death.	\N	\N	6	So powerful, it cannot have a single owner.	t	\N	1
134	recipe_monkey_king_bar	Monkey King Bar Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	600	\N		\N	\N	\N		f	\N	1
135	monkey_king_bar	Monkey King Bar	data\\processed\\dota2\\items\\img\\monkey_king_bar.png	epic	4700	\N		\N	\N	\N	A powerful staff used by a master warrior.	t	\N	1
137	radiance	Radiance	data\\processed\\dota2\\items\\img\\radiance.png	epic	4700	\N		\N	\N	\N	A divine weapon that causes damage and a bright burning effect that lays waste to nearby enemies.	t	\N	1
139	butterfly	Butterfly	data\\processed\\dota2\\items\\img\\butterfly.png	epic	5450	\N	Stacks diminishingly with other sources of Evasion.	\N	\N	\N	Only the mightiest and most experienced of warriors can wield the Butterfly, but it provides incredible dexterity in combat.	t	\N	1
140	recipe_greater_crit	Daedalus Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	900	\N		\N	\N	\N		f	\N	1
141	greater_crit	Daedalus	data\\processed\\dota2\\items\\img\\greater_crit.png	epic	5100	\N	Critical Strike does not work against buildings.	\N	\N	\N	A weapon of incredible power that is difficult for even the strongest of warriors to control.	t	\N	1
142	recipe_basher	Skull Basher Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	825	\N		\N	\N	\N		f	\N	1
143	basher	Skull Basher	data\\processed\\dota2\\items\\img\\basher.png	epic	2875	Physical	Does not stack with other sources of Bash.\nThe following heroes cannot trigger Bash on this item: Spirit Breaker, Faceless Void, Slardar, and Kez while in Sai mode.\nDoes not grant Bash to Clones and Tempest Doubles.	\N	\N	2	A feared weapon in the right hands, this mauls ability to shatter the defenses of its opponents should not be underestimated.	t	\N	1
144	recipe_bfury	Battle Fury Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	600	\N		\N	\N	\N		f	\N	1
145	bfury	Battle Fury	data\\processed\\dota2\\items\\img\\bfury.png	epic	3900	\N	Cleave damage goes through spell immunity.\nIf multiple sources of Cleave are present, each Cleaves damage is applied separately.	\N	\N	4	The bearer of this mighty axe gains the ability to cut down swaths of enemies at once.	t	\N	1
146	recipe_manta	Manta Style Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1550	\N		\N	\N	\N		f	\N	1
147	manta	Manta Style	data\\processed\\dota2\\items\\img\\manta.png	epic	4650	\N	Has a 0.1 second cast time during which you are invulnerable.\nMany effects are removed upon using Manta.\nYasha based movement speed bonuses from multiple items do not stack.	125	\N	34	An axe made of reflective materials that causes confusion amongst enemy ranks.	t	\N	1
148	recipe_lesser_crit	Crystalys Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	200	\N		\N	\N	\N		f	\N	1
149	lesser_crit	Crystalys	data\\processed\\dota2\\items\\img\\lesser_crit.png	epic	2000	\N	Critical Strike does not work against buildings.	\N	\N	\N	A blade forged from rare crystals, it seeks weak points in enemy armor.	t	\N	1
234	recipe_dragon_lance	Dragon Lance Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	450	\N		\N	\N	\N		f	\N	1
236	dragon_lance	Dragon Lance	data\\processed\\dota2\\items\\img\\dragon_lance.png	artifact	1900	\N	Passive does not stack.	\N	\N	\N	The forward charge of the wyvern host grants no quarter.	t	\N	1
150	recipe_armlet	Armlet of Mordiggian Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	625	\N		\N	\N	\N		f	\N	1
151	armlet	Armlet of Mordiggian	data\\processed\\dota2\\items\\img\\armlet.png	epic	2500	\N	The strength change will affect both maximum and current HP, but you cannot die from the change.\nThe strength change occurs over 0.6 seconds.\nActivating or deactivating Unholy Strength does not interrupt channeling.	\N	\N	\N	Weapon of choice among brutes, the bearer sacrifices his life energy to gain immense strength and power.	t	\N	1
152	invis_sword	Shadow Blade	data\\processed\\dota2\\items\\img\\invis_sword.png	epic	3350	\N	Has a 0.3 second fade time.\nIf the invisibility ends without attacking, the bonus damage is lost.	75	\N	25	The blade of a fallen king, it allows you to move unseen and strike from the shadows.	t	\N	1
248	recipe_silver_edge	Silver Edge Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	250	\N		\N	\N	\N		f	\N	1
249	silver_edge	Silver Edge	data\\processed\\dota2\\items\\img\\silver_edge.png	epic	5800	\N		75	\N	20	Once used to slay an unjust king, only to have the kingdom erupt into civil war in the aftermath.	t	\N	1
154	sange_and_yasha	Sange and Yasha	data\\processed\\dota2\\items\\img\\sange_and_yasha.png	artifact	4200	\N	Yasha-based movement speed bonuses from multiple items do not stack.	\N	\N	\N	Sange and Yasha, when attuned by the moonlight and used together, become a very powerful combination.	t	\N	1
273	kaya_and_sange	Kaya and Sange	data\\processed\\dota2\\items\\img\\kaya_and_sange.png	artifact	4200	\N		\N	\N	\N	Two of three known items of unimaginable power that many believe were crafted at the same enchanters forge.	t	\N	1
277	yasha_and_kaya	Yasha and Kaya	data\\processed\\dota2\\items\\img\\yasha_and_kaya.png	artifact	4200	\N		\N	\N	\N	Yasha and Kaya when paired together share a natural resonance.	t	\N	1
156	satanic	Satanic	data\\processed\\dota2\\items\\img\\satanic.png	artifact	5050	\N		\N	\N	30	Immense power at the cost of your soul.	t	\N	1
157	recipe_mjollnir	Mjollnir Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	550	\N		\N	\N	\N		f	\N	1
158	mjollnir	Mjollnir	data\\processed\\dota2\\items\\img\\mjollnir.png	artifact	5500	\N	Static Charge cannot trigger more than once per second.\nStatic Charges shock deals magical damage centered on hero with the Static Charge. Static Charges targets cannot be more than 900 range away.\nStatic Charge procs will not bounce to heroes that are invisible or hidden by Fog of War.	50	\N	35	Thors magical hammer, made for him by the dwarves Brok and Eitri.	t	\N	1
160	skadi	Eye of Skadi	data\\processed\\dota2\\items\\img\\skadi.png	artifact	5900	\N		\N	\N	\N	Extremely rare artifact, guarded by the azure dragons.	t	\N	1
161	recipe_sange	Sange Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	650	\N		\N	\N	\N		f	\N	1
162	sange	Sange	data\\processed\\dota2\\items\\img\\sange.png	artifact	2100	\N		\N	\N	\N	Sange is an unusually accurate weapon, seeking weak points automatically.	t	\N	1
163	recipe_helm_of_the_dominator	Helm of the Dominator Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1125	\N		\N	\N	\N		f	\N	1
164	helm_of_the_dominator	Helm of the Dominator	data\\processed\\dota2\\items\\img\\helm_of_the_dominator.png	artifact	2550	\N	Cannot dominate more than one unit at a time. If a new unit is dominated, the old one will die.\nCan also Dominate enemy lane creeps and summoned units.\nSelling Helm of the Dominator will cause dominated units to die.	\N	\N	45	The powerful headpiece of a dead necromancer.	t	\N	1
633	recipe_helm_of_the_overlord	Helm of the Overlord Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	300	\N		\N	\N	\N		f	\N	1
635	helm_of_the_overlord	Helm of the Overlord	data\\processed\\dota2\\items\\img\\helm_of_the_overlord.png	artifact	5650	\N	Can also Dominate enemy lane creeps and summoned units.\nSelling will cause dominated units to die.	\N	\N	45	The powerful headpiece of an undead necromancer.	t	\N	1
166	maelstrom	Maelstrom	data\\processed\\dota2\\items\\img\\maelstrom.png	artifact	2950	\N		\N	\N	\N	A hammer forged for the gods themselves, Maelstrom allows its user to harness the power of lightning.	t	\N	1
1565	recipe_gungir	Gleipnir Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1100	\N		\N	\N	\N		f	\N	1
1466	gungir	Gleipnir	data\\processed\\dota2\\items\\img\\gungir.png	artifact	4550	\N		150	\N	18	Bindings forged by impossible means to leash an ancient evil.	t	\N	1
168	desolator	Desolator	data\\processed\\dota2\\items\\img\\desolator.png	artifact	3500	\N	Armor reduction works on buildings.	\N	\N	\N	A wicked weapon, used in torturing political criminals.	t	\N	1
169	recipe_yasha	Yasha Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	650	\N		\N	\N	\N		f	\N	1
170	yasha	Yasha	data\\processed\\dota2\\items\\img\\yasha.png	artifact	2100	\N	Yasha-based movement speed bonuses from multiple items do not stack.	\N	\N	\N	Yasha is regarded as the swiftest weapon ever created.	t	\N	1
172	mask_of_madness	Mask of Madness	data\\processed\\dota2\\items\\img\\mask_of_madness.png	artifact	1900	\N		25	\N	16	Once this mask is worn, its bearer becomes an uncontrollable aggressive force.	t	\N	1
173	recipe_diffusal_blade	Diffusal Blade Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1050	\N		\N	\N	\N		f	\N	1
174	diffusal_blade	Diffusal Blade	data\\processed\\dota2\\items\\img\\diffusal_blade.png	artifact	2500	\N	Does not stack with other diffusal blades.	25	\N	15	An enchanted blade that allows the user to cut straight into the enemys soul.	t	\N	1
1096	recipe_disperser	Disperser Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	800	\N		\N	\N	\N		f	\N	1
1097	disperser	Disperser	data\\processed\\dota2\\items\\img\\disperser.png	artifact	6100	\N		75	\N	15	Once entrusted to an Apostle General of the Rumusque Faithfuls expeditionary force.	t	\N	1
175	recipe_ethereal_blade	Ethereal Blade Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1600	\N		\N	\N	\N		f	\N	1
176	ethereal_blade	Ethereal Blade	data\\processed\\dota2\\items\\img\\ethereal_blade.png	epic	5375	\N	Shares cooldown with Ghost Scepter.\nEthereal units take -40% bonus magic damage.\nFor Universal Heroes, their primary attribute is 45% of the sum of all their attributes.\nUsing a Town Portal Scroll or Boots of Travel will not dispel Ethereal Form.	100	\N	22	A flickering blade of a ghastly nature, it is capable of dealing damage in both magical and physical planes.	t	\N	1
177	recipe_soul_ring	Soul Ring Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	350	\N		\N	\N	\N		f	\N	1
178	soul_ring	Soul Ring	data\\processed\\dota2\\items\\img\\soul_ring.png	common	805	\N	If this mana is not used before the duration ends, the extra mana is lost.	\N	170	25	A ring that feeds on the souls of those who wear it.	t	\N	1
179	recipe_arcane_boots	Arcane Boots Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	475	\N		\N	\N	\N		f	\N	1
180	arcane_boots	Arcane Boots	data\\processed\\dota2\\items\\img\\arcane_boots.png	rare	1400	\N	Does not work on Meepo clones.	\N	\N	55	Magi equipped with these boots are valued in battle.	t	\N	1
235	octarine_core	Octarine Core	data\\processed\\dota2\\items\\img\\octarine_core.png	rare	4800	\N		\N	\N	\N	At the core of spellcraft are spectrums only the very gifted can sense.	t	\N	1
181	orb_of_venom	Orb of Venom	data\\processed\\dota2\\items\\img\\orb_of_venom.png	component	350	\N	Does not stack with its upgrades.	\N	\N	9	Envenoms your veapon with the venom of a venomous viper.	f	\N	1
240	blight_stone	Orb of Blight	data\\processed\\dota2\\items\\img\\blight_stone.png	component	300	\N	Does not stack with its upgrades, Desolator, or Stygian Desolator.	\N	\N	\N	An unnerving stone unearthed beneath the Fields of Endless Carnage.	f	\N	1
569	orb_of_corrosion	Orb of Corrosion	data\\processed\\dota2\\items\\img\\orb_of_corrosion.png	rare	1050	\N	Armor reduction does not stack with its components, Desolator, or Stygian Desolator.	\N	\N	\N	Seepage from the wounds of a warrior deity, sealed in an arcanists orb following a campaign of vicious slaughter.	t	\N	1
1575	orb_of_frost	Orb of Frost	data\\processed\\dota2\\items\\img\\orb_of_frost.png	rare	300	\N		\N	\N	\N	Slowly growing since the universe began, it will envelop everything when it ends.	f	\N	1
599	recipe_falcon_blade	Falcon Blade Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	250	\N		\N	\N	\N		f	\N	1
596	falcon_blade	Falcon Blade	data\\processed\\dota2\\items\\img\\falcon_blade.png	rare	1125	\N		\N	\N	\N	An enchanted blade that long ago raised a hopeless urchin from pauper to king.	t	\N	1
598	mage_slayer	Mage Slayer	data\\processed\\dota2\\items\\img\\mage_slayer.png	rare	2800	Magical		\N	\N	\N	Forged by a secret order in The Third Age of Praxacia to fell the FALSE King.	t	\N	1
184	recipe_ancient_janggo	Drum of Endurance Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	500	\N		\N	\N	\N		f	\N	1
185	ancient_janggo	Drum of Endurance	data\\processed\\dota2\\items\\img\\ancient_janggo.png	rare	1625	\N		\N	\N	45	A relic that enchants the bodies of those around it for swifter movement in times of crisis.	t	\N	1
930	recipe_boots_of_bearing	Boots of Bearing Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1700	\N		\N	\N	\N		f	\N	1
931	boots_of_bearing	Boots of Bearing	data\\processed\\dota2\\items\\img\\boots_of_bearing.png	rare	4225	\N		\N	\N	30	Resplendent footwear fashioned for the ancient herald that first dared spread the glory of Stonehall beyond the original borders of its nascent claim.	t	\N	1
187	medallion_of_courage	Medallion of Courage	data\\processed\\dota2\\items\\img\\medallion_of_courage.png	rare	1025	\N	Shares cooldown with Solar Crest.	\N	\N	16	The bearer has no fear of combat.	t	\N	1
227	recipe_solar_crest	Solar Crest Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	500	\N		\N	\N	\N		f	\N	1
229	solar_crest	Solar Crest	data\\processed\\dota2\\items\\img\\solar_crest.png	rare	2575	\N	Shares cooldown with Pavise.	100	\N	16	A talisman forged to honor the daytime sky.	t	\N	1
1127	recipe_pavise	Pavise Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	175	\N		\N	\N	\N		f	\N	1
1128	pavise	Pavise	data\\processed\\dota2\\items\\img\\pavise.png	rare	1400	\N		100	\N	16	Devised by a wizard who made one too many enemies.	t	\N	1
188	smoke_of_deceit	Smoke of Deceit	data\\processed\\dota2\\items\\img\\smoke_of_deceit.png	consumable	50	\N		\N	\N	1	The charlatan wizard Myrddins only true contribution to the arcane arts.	f	1	1
257	tome_of_knowledge	Tome of Knowledge	data\\processed\\dota2\\items\\img\\tome_of_knowledge.png	consumable	75	\N		\N	\N	\N	That which raises beast to man and man to god.	f	1	1
189	recipe_veil_of_discord	Veil of Discord Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	300	\N		\N	\N	\N		f	\N	1
190	veil_of_discord	Veil of Discord	data\\processed\\dota2\\items\\img\\veil_of_discord.png	rare	1725	\N		50	\N	16	The headwear of corrupt magi.	t	\N	1
910	recipe_revenants_brooch	Revenants Brooch Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	600	\N		\N	\N	\N		f	\N	1
911	revenants_brooch	Revenants Brooch	data\\processed\\dota2\\items\\img\\revenants_brooch.png	rare	3300	\N	Counts as a Critical Strike for purposes of stacking with other sources of Critical Strike.\nPhantom Critical does not work against buildings.	\N	\N	\N	The cursed brooch of a fallen guardian who stalks forever between the veil of life and death.	t	\N	1
1805	recipe_devastator	Parasma Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	400	\N		\N	\N	\N		f	\N	1
1806	devastator	Parasma	data\\processed\\dota2\\items\\img\\devastator.png	rare	5975	\N		\N	\N	7	Warning: There is no antidote if picked up by the wrong end.	t	\N	1
230	recipe_guardian_greaves	Guardian Greaves Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1450	\N		\N	\N	\N		f	\N	1
231	guardian_greaves	Guardian Greaves	data\\processed\\dota2\\items\\img\\guardian_greaves.png	rare	5050	\N	The aura boost only applies to heroes.\nMend does not affect units that have been affected by Mend or Mekansm Restore within Guardian Greaves cooldown.	\N	\N	45	One of many holy instruments constructed to honor the Omniscience.	t	\N	1
205	recipe_rod_of_atos	Rod of Atos Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	250	\N		\N	\N	\N		f	\N	1
206	rod_of_atos	Rod of Atos	data\\processed\\dota2\\items\\img\\rod_of_atos.png	rare	2250	\N		100	\N	18	Atos, the Lord of Blight, has his essence stored in this deceptively simple wand.	t	\N	1
238	recipe_iron_talon	Iron Talon Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	125	\N		\N	\N	\N		f	\N	1
239	iron_talon	Iron Talon	data\\processed\\dota2\\items\\img\\iron_talon.png	common	0	\N	Has a 4 second cooldown on Trees.	\N	\N	15	A simple but effective weapon devised to quell a great Hellbear uprising.	t	\N	1
207	recipe_abyssal_blade	Abyssal Blade Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1275	\N		\N	\N	\N		f	\N	1
208	abyssal_blade	Abyssal Blade	data\\processed\\dota2\\items\\img\\abyssal_blade.png	epic	6250	\N	The stun is melee range.\nDoes not stack with other bashes, and does not grant bash to Clones and Tempest Doubles.\nMultiple sources of damage block do not stack.\nThe following heroes cannot trigger Bash on this item: Spirit Breaker, Faceless Void, Slardar, and Kez while in Sai mode.	75	\N	35	The lost blade of the Commander of the Abyss, this edge cuts into an enemys soul.	t	\N	1
209	recipe_heavens_halberd	Heavens Halberd Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	450	\N		\N	\N	\N		f	\N	1
210	heavens_halberd	Heavens Halberd	data\\processed\\dota2\\items\\img\\heavens_halberd.png	artifact	2600	\N		25	\N	18	This halberd moves with the speed of a smaller weapon, allowing the bearer to win duels that a heavy edge would not.	t	\N	1
212	ring_of_aquila	Ring of Aquila	data\\processed\\dota2\\items\\img\\ring_of_aquila.png	\N	\N	\N	Multiple instances of Aquila Aura do not stack.	\N	\N	\N	The ring of the fallen Warlord Aquila continues to support armies in battle.	f	\N	1
214	tranquil_boots	Tranquil Boots	data\\processed\\dota2\\items\\img\\tranquil_boots.png	rare	900	\N		\N	\N	13	While they increase the longevity of the wearer, this boot is not particularly reliable.	t	\N	1
215	shadow_amulet	Shadow Amulet	data\\processed\\dota2\\items\\img\\shadow_amulet.png	\N	1000	\N	Takes 1.25s of the 3.5s for the hero to fully fade into invisibility.	\N	\N	18	A small talisman that clouds the senses of ones enemies when held perfectly still.	f	\N	1
253	recipe_glimmer_cape	Glimmer Cape Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	350	\N		\N	\N	\N		f	\N	1
254	glimmer_cape	Glimmer Cape	data\\processed\\dota2\\items\\img\\glimmer_cape.png	rare	2150	\N		125	\N	14	The stolen cape of a master illusionist.	t	\N	1
1021	river_painter	River Vial: Chrome	data\\processed\\dota2\\items\\img\\river_painter.png	component	0	\N		\N	\N	\N		f	\N	1
1022	river_painter2	River Vial: Dry	data\\processed\\dota2\\items\\img\\river_painter2.png	component	0	\N		\N	\N	\N		f	\N	1
1023	river_painter3	River Vial: Slime	data\\processed\\dota2\\items\\img\\river_painter3.png	component	0	\N		\N	\N	\N		f	\N	1
1024	river_painter4	River Vial: Oil	data\\processed\\dota2\\items\\img\\river_painter4.png	component	0	\N		\N	\N	\N		f	\N	1
1025	river_painter5	River Vial: Electrified	data\\processed\\dota2\\items\\img\\river_painter5.png	component	0	\N		\N	\N	\N		f	\N	1
1026	river_painter6	River Vial: Potion	data\\processed\\dota2\\items\\img\\river_painter6.png	component	0	\N		\N	\N	\N		f	\N	1
1027	river_painter7	River Vial: Blood	data\\processed\\dota2\\items\\img\\river_painter7.png	component	0	\N		\N	\N	\N		f	\N	1
1028	mutation_tombstone	Tombstone	data\\processed\\dota2\\items\\img\\mutation_tombstone.png	consumable	0	\N		\N	\N	\N		f	1	1
1029	super_blink		data\\processed\\dota2\\items\\img\\super_blink.png	\N	\N	\N		\N	\N	15		f	\N	1
1030	pocket_tower	Pocket Tower	data\\processed\\dota2\\items\\img\\pocket_tower.png	\N	\N	\N		\N	\N	15		f	\N	1
1032	pocket_roshan	Pocket Roshan	data\\processed\\dota2\\items\\img\\pocket_roshan.png	rare	1000	\N		\N	\N	60		f	\N	1
357	nether_shawl	Nether Shawl	data\\processed\\dota2\\items\\img\\nether_shawl.png	\N	0	\N		\N	\N	\N	An otherworldly garment tethered to our plane by unknown means.	f	\N	1
287	keen_optic	Keen Optic	data\\processed\\dota2\\items\\img\\keen_optic.png	\N	0	\N		\N	\N	\N	Stolen from a tinkers shop ages ago, this handy lens has seen service to many owners.	f	\N	1
288	grove_bow	Grove Bow	data\\processed\\dota2\\items\\img\\grove_bow.png	\N	0	\N		\N	\N	\N	A gift from the moon goddess to one of her prized disciples many memories ago.	f	\N	1
289	quickening_charm	Quickening Charm	data\\processed\\dota2\\items\\img\\quickening_charm.png	\N	0	\N		\N	\N	\N	An evergreen amulet of druidic origins.	f	\N	1
290	philosophers_stone	Philosophers Stone	data\\processed\\dota2\\items\\img\\philosophers_stone.png	\N	0	\N		\N	\N	\N	A weightless charm created by an enchanter with a powerful scorn for brute force.	f	750	1
291	force_boots	Force Boots	data\\processed\\dota2\\items\\img\\force_boots.png	\N	0	\N	Does not trigger spell block or spell reflect.	75	\N	8	Elusive marvels never successfully studied for proper classification in the archives.	f	\N	1
292	desolator_2	Stygian Desolator	data\\processed\\dota2\\items\\img\\desolator_2.png	\N	0	\N	Armor reduction works on buildings.	\N	\N	\N	The original demonic favorite that served as basis for the beloved mortal design.	f	\N	1
293	phoenix_ash	Phoenix Ash	data\\processed\\dota2\\items\\img\\phoenix_ash.png	\N	0	\N		\N	\N	\N		f	1	1
294	seer_stone	Seer Stone	data\\processed\\dota2\\items\\img\\seer_stone.png	\N	0	\N		\N	\N	60	The curious creation of a wizard who professed to hail from another time.	f	\N	1
295	greater_mango		data\\processed\\dota2\\items\\img\\greater_mango.png	\N	0	\N		\N	\N	\N		f	\N	1
302	elixer	Elixir	data\\processed\\dota2\\items\\img\\elixer.png	\N	0	\N		\N	\N	\N		f	3	1
297	vampire_fangs	Vampire Fangs	data\\processed\\dota2\\items\\img\\vampire_fangs.png	\N	0	\N		\N	\N	\N		f	\N	1
829	force_field	Arcanists Armor	data\\processed\\dota2\\items\\img\\force_field.png	\N	0	\N		\N	\N	35	An exquisite piece commissioned by a paranoid monarch who choked on a piece of fruit long before the item saw its intended use.	f	\N	1
834	black_powder_bag	Blast Rig	data\\processed\\dota2\\items\\img\\black_powder_bag.png	\N	0	\N		\N	\N	20	One of a set of custom rigs once worn by infamous road agents in the Outlands, its siblings have been lost to misfires and the various tides of time.	f	\N	1
849	mechanical_arm		data\\processed\\dota2\\items\\img\\mechanical_arm.png	\N	0	\N		\N	\N	\N		f	\N	1
298	craggy_coat	Craggy Coat	data\\processed\\dota2\\items\\img\\craggy_coat.png	\N	0	\N		\N	\N	12		f	\N	1
299	greater_faerie_fire	Greater Faerie Fire	data\\processed\\dota2\\items\\img\\greater_faerie_fire.png	consumable	0	\N		\N	\N	10		f	3	1
300	timeless_relic	Timeless Relic	data\\processed\\dota2\\items\\img\\timeless_relic.png	\N	0	\N		\N	\N	\N	An unmarred discovery from the excavated ruins of an ancient wizards academy.	f	\N	1
301	mirror_shield	Mirror Shield	data\\processed\\dota2\\items\\img\\mirror_shield.png	\N	0	\N		\N	\N	\N	The shield that long ago robbed the old one of his first memories.	f	\N	1
304	ironwood_tree	Ironwood Tree	data\\processed\\dota2\\items\\img\\ironwood_tree.png	\N	0	\N		\N	\N	15	Precious. And hearty as a weed.	f	\N	1
328	mango_tree	Mango Tree	data\\processed\\dota2\\items\\img\\mango_tree.png	consumable	\N	\N		\N	\N	\N		f	1	1
305	royal_jelly	Royal Jelly	data\\processed\\dota2\\items\\img\\royal_jelly.png	consumable	0	\N		\N	\N	\N	To those who harvest olgru jelly, success serves more than mere profit--its often the means to survival--for only the jelly itself can cure the ravages that follow a sting from the vigilant denizens of the giant hives.	f	5	1
306	pupils_gift	Pupils Gift	data\\processed\\dota2\\items\\img\\pupils_gift.png	\N	0	\N	Grants two-thirds value to each attribute for Universal Heroes	\N	\N	\N	An astounding plate of ever-replenishing, fortifying fruit.	f	\N	1
307	tome_of_aghanim	Tome of Aghanim	data\\processed\\dota2\\items\\img\\tome_of_aghanim.png	\N	0	\N		\N	\N	\N		f	1	1
308	repair_kit	Repair Kit	data\\processed\\dota2\\items\\img\\repair_kit.png	consumable	0	\N		\N	\N	60		f	3	1
309	mind_breaker	Mind Breaker	data\\processed\\dota2\\items\\img\\mind_breaker.png	\N	0	\N		\N	\N	16	A bewitching blade of indeterminate form capable of piercing the psyche of even the most willful foe.	f	\N	1
310	third_eye	Third Eye	data\\processed\\dota2\\items\\img\\third_eye.png	\N	0	\N		\N	\N	\N		f	3	1
311	spell_prism	Spell Prism	data\\processed\\dota2\\items\\img\\spell_prism.png	\N	0	\N		\N	\N	\N	Even the slightest flaw in the components of a spell prism can result in the death of its user.	f	\N	1
325	princes_knife	Princes Knife	data\\processed\\dota2\\items\\img\\princes_knife.png	\N	0	\N		\N	\N	10		f	\N	1
330	witless_shako	Witless Shako	data\\processed\\dota2\\items\\img\\witless_shako.png	\N	0	\N		\N	\N	\N		f	\N	1
334	imp_claw	Imp Claw	data\\processed\\dota2\\items\\img\\imp_claw.png	\N	0	\N		\N	\N	5	Though their tasks are largely thankless, demon hunters can often turn a profit bartering parts in Weeping Rose.	f	\N	1
335	flicker	Flicker	data\\processed\\dota2\\items\\img\\flicker.png	\N	0	\N		\N	\N	5	The technically-true-to-his-word teleportation device crafted by a notorious fae trickster.	f	\N	1
336	spy_gadget	Telescope	data\\processed\\dota2\\items\\img\\spy_gadget.png	\N	0	\N		\N	\N	\N	A handy tool that manages to make close what once was far.	f	\N	1
326	spider_legs	Spider Legs	data\\processed\\dota2\\items\\img\\spider_legs.png	\N	0	\N		\N	\N	20	A horrifying yet useful mixture of necromancy and artificing.	f	\N	1
327	helm_of_the_undying	Helm of the Undying	data\\processed\\dota2\\items\\img\\helm_of_the_undying.png	\N	0	\N		\N	\N	50	The price for wearing it is paid in the afterlife.	f	\N	1
331	vambrace	Vambrace	data\\processed\\dota2\\items\\img\\vambrace.png	common	0	\N		\N	\N	\N	The coveted treasure that divided the heirs of Queen Raiya upon her death, resulting in the eventual downfall of her kingdom.	f	\N	1
312	horizon		data\\processed\\dota2\\items\\img\\horizon.png	\N	0	\N		\N	\N	10		f	\N	1
313	fusion_rune	Fusion Rune	data\\processed\\dota2\\items\\img\\fusion_rune.png	\N	0	\N		\N	\N	120		f	3	1
354	ocean_heart	Ocean Heart	data\\processed\\dota2\\items\\img\\ocean_heart.png	\N	0	\N		\N	\N	\N	A charm blessed by the Council of the Brine.	f	\N	1
1124	spark_of_courage	Spark of Courage	data\\processed\\dota2\\items\\img\\spark_of_courage.png	\N	0	\N		\N	\N	\N	A common battle charm in the armies that served the Children of Light.	f	\N	1
355	broom_handle	Broom Handle	data\\processed\\dota2\\items\\img\\broom_handle.png	\N	0	\N		\N	\N	\N	The surprisingly dangerous creation of an apprentice sorcerer with a strange fondness for brooms.	f	\N	1
356	trusty_shovel	Trusty Shovel	data\\processed\\dota2\\items\\img\\trusty_shovel.png	\N	0	\N	16% chance for a Bounty Rune.\n28% chance each for a Flask, an Enchanted Mango, or a kobold.\nThe same Trusty Shovel cannot find the same reward twice in a row.	\N	\N	70	Former plaything of a young deity, received as a gift from his uncle.	f	\N	1
2095	tier5_token	Tier 5 Token	data\\processed\\dota2\\items\\img\\tier5_token.png	\N	\N	\N		\N	\N	\N		f	\N	1
358	dragon_scale	Dragon Scale	data\\processed\\dota2\\items\\img\\dragon_scale.png	\N	0	\N		\N	\N	\N	The remains of a dragon always outvalue the wealth of even the most prodigious hoard.	f	\N	1
359	essence_ring	Essence Ring	data\\processed\\dota2\\items\\img\\essence_ring.png	\N	0	\N		160	\N	25	An ancient bauble blessed by the breath of Verodicia.	f	\N	1
360	clumsy_net	Clumsy Net	data\\processed\\dota2\\items\\img\\clumsy_net.png	\N	0	\N		\N	\N	25		f	\N	1
361	enchanted_quiver	Enchanted Quiver	data\\processed\\dota2\\items\\img\\enchanted_quiver.png	\N	0	\N		\N	\N	4	A graceful gift blessed by the goddess of the hunt.	f	\N	1
362	ninja_gear	Ninja Gear	data\\processed\\dota2\\items\\img\\ninja_gear.png	\N	0	\N		100	\N	60	Valuable equipment recovered by a young explorer sifting through the flotsam and detritus drifting in the void.	f	\N	1
363	illusionsts_cape	Illusionists Cape	data\\processed\\dota2\\items\\img\\illusionsts_cape.png	\N	0	\N		\N	\N	30	A dashing cape whose creator insists on calling Cloak of Apparition as opposed to his assistants Illusion drivel.	f	\N	1
364	havoc_hammer	Havoc Hammer	data\\processed\\dota2\\items\\img\\havoc_hammer.png	\N	0	\N		\N	\N	10		f	\N	1
365	panic_button	Magic Lamp	data\\processed\\dota2\\items\\img\\panic_button.png	\N	0	\N		\N	\N	75		f	\N	1
366	apex	Apex	data\\processed\\dota2\\items\\img\\apex.png	\N	0	\N	Grants +24 to each attribute for Universal Heroes.	\N	\N	\N	Three orbs of remarkable power bound within a single scepter.	f	\N	1
367	ballista	Ballista	data\\processed\\dota2\\items\\img\\ballista.png	\N	0	\N		\N	\N	\N	A simple design much improved by a master smiths loving hand.	f	\N	1
368	woodland_striders	Woodland Striders	data\\processed\\dota2\\items\\img\\woodland_striders.png	\N	0	\N		\N	\N	20		f	\N	1
275	recipe_trident	Trident Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1	\N		\N	\N	\N		f	\N	1
370	demonicon	Book of the Dead	data\\processed\\dota2\\items\\img\\demonicon.png	\N	0	\N	The Demonic Warrior has 1600 Health, 4 Armor, 40% Magic Resistance, 380 Movement Speed, 134 Attack Damage, 50 Mana Burn on Hit, 800 Damage on Death, and 1000 TRUE Sight Radius.\nThe Demonic Archer has 1300 Health, 4 Armor, 40% Magic Resistance, 425 Movement Speed, 131 Attack Damage, a basic dispel ability with a slow on a 15s Cooldown, and a 9% Bonus Movement Speed Aura.	\N	\N	80	A record of the final reckoning. With one page torn out.	f	\N	1
371	fallen_sky	Fallen Sky	data\\processed\\dota2\\items\\img\\fallen_sky.png	\N	0	\N		\N	\N	25	One of the few surviving creations of the acolytes of the Wyrmforge.	f	\N	1
372	pirate_hat	Pirate Hat	data\\processed\\dota2\\items\\img\\pirate_hat.png	\N	0	\N		\N	\N	\N	A salty skulltopper cursed with endless good fortune.	f	\N	1
373	dimensional_doorway		data\\processed\\dota2\\items\\img\\dimensional_doorway.png	\N	0	\N		\N	\N	90		f	3	1
374	ex_machina	Ex Machina	data\\processed\\dota2\\items\\img\\ex_machina.png	\N	0	\N		350	\N	60	The remains of an ancient universe, preserved within a single sphere.	f	\N	1
375	faded_broach	Faded Broach	data\\processed\\dota2\\items\\img\\faded_broach.png	\N	0	\N		\N	\N	\N	A life-saving jewel bestowed upon a young queen by a kindly vizier.	f	\N	1
376	paladin_sword	Paladin Sword	data\\processed\\dota2\\items\\img\\paladin_sword.png	\N	0	\N		\N	\N	\N	The sigil blade of the legendary Brother Yhols of Gausra, stripped from its scabbard on the day of his controversial excommunication.	f	\N	1
377	minotaur_horn	Minotaur Horn	data\\processed\\dota2\\items\\img\\minotaur_horn.png	\N	0	\N		\N	\N	40	The trophy from a mighty beast ambushed and slain in the recesses of its own home.	f	\N	1
378	orb_of_destruction	Orb of Destruction	data\\processed\\dota2\\items\\img\\orb_of_destruction.png	\N	0	\N		\N	\N	\N	An ingot of chaos suspended in wizards ether, housed within an arcanists orb.	f	\N	1
379	the_leveller	The Leveller	data\\processed\\dota2\\items\\img\\the_leveller.png	\N	0	\N		\N	\N	\N	A demonic blade that struck the final blow to crack the gates of the Sanctum of Solanas.	f	\N	1
349	arcane_ring	Arcane Ring	data\\processed\\dota2\\items\\img\\arcane_ring.png	\N	0	\N		\N	\N	60	Once a prized heirloom of a minor lords house.	f	\N	1
381	titan_sliver	Titan Sliver	data\\processed\\dota2\\items\\img\\titan_sliver.png	\N	0	\N		\N	\N	\N	Though many desire this brilliant shard for its obvious qualities, a school of study exists to determine the true size and purpose of its incomprehensible whole.	f	\N	1
565	chipped_vest	Chipped Vest	data\\processed\\dota2\\items\\img\\chipped_vest.png	\N	0	\N		\N	\N	\N	It doesnt look like much, but its oddly comfy.	f	\N	1
566	wizard_glass		data\\processed\\dota2\\items\\img\\wizard_glass.png	\N	0	\N		\N	\N	15		f	\N	1
570	gloves_of_travel		data\\processed\\dota2\\items\\img\\gloves_of_travel.png	\N	0	\N		\N	\N	\N		f	\N	1
573	elven_tunic	Elven Tunic	data\\processed\\dota2\\items\\img\\elven_tunic.png	\N	0	\N		\N	\N	\N	Even simple items of elven make seem imbued with inexplicable efficacy.	f	\N	1
574	cloak_of_flames	Cloak of Flames	data\\processed\\dota2\\items\\img\\cloak_of_flames.png	\N	0	\N		\N	\N	\N	A very fine cloak that plays host to an overly-protective living flame.	f	\N	1
575	venom_gland		data\\processed\\dota2\\items\\img\\venom_gland.png	\N	0	\N		\N	\N	\N		f	\N	1
571	trickster_cloak	Trickster Cloak	data\\processed\\dota2\\items\\img\\trickster_cloak.png	\N	0	\N		\N	\N	25	A fantastic garment immediately misplaced by its creator upon completion.	f	\N	1
576	gladiator_helm		data\\processed\\dota2\\items\\img\\gladiator_helm.png	\N	0	\N		\N	\N	\N		f	\N	1
577	possessed_mask	Possessed Mask	data\\processed\\dota2\\items\\img\\possessed_mask.png	\N	0	\N	Grants 1/3rd of the value to each attribute for Universal Heroes.	\N	\N	\N	Even when discarded with specific purpose and great care, this frightening mask always finds its way onto the face of a new owner.	f	\N	1
578	ancient_perseverance		data\\processed\\dota2\\items\\img\\ancient_perseverance.png	\N	0	\N		\N	\N	\N		f	\N	1
637	star_mace		data\\processed\\dota2\\items\\img\\star_mace.png	\N	0	\N		\N	\N	\N		f	\N	1
638	penta_edged_sword	Penta-Edged Sword	data\\processed\\dota2\\items\\img\\penta_edged_sword.png	\N	0	\N		\N	\N	\N	The final, twisted work of a severely pious blacksmith, completed immediately before the taking of his own life.	f	\N	1
582	oakheart		data\\processed\\dota2\\items\\img\\oakheart.png	\N	0	\N		75	\N	18		f	\N	1
674	warhammer		data\\processed\\dota2\\items\\img\\warhammer.png	\N	0	\N		\N	\N	20		f	\N	1
680	bullwhip	Bullwhip	data\\processed\\dota2\\items\\img\\bullwhip.png	\N	0	\N	Does not trigger spell block or spell reflect.	\N	\N	11	Once the favored lash of an infamous broker of pit fighters and other live trade.	f	\N	1
675	psychic_headband	Psychic Headband	data\\processed\\dota2\\items\\img\\psychic_headband.png	\N	0	\N	Does not trigger spell block or spell reflect.	\N	\N	20	A failed experiment in finer telekinetic control, still fit for other ends.	f	\N	1
2096	vindicators_axe	Vindicators Axe	data\\processed\\dota2\\items\\img\\vindicators_axe.png	\N	0	\N		\N	\N	\N		f	\N	1
676	ceremonial_robe	Ceremonial Robe	data\\processed\\dota2\\items\\img\\ceremonial_robe.png	\N	0	\N		\N	\N	\N	One of many items lost in the looting of Zelenwyrs sacred reliquary.	f	\N	1
686	quicksilver_amulet	Quicksilver Amulet	data\\processed\\dota2\\items\\img\\quicksilver_amulet.png	\N	0	\N		\N	\N	\N	An enchanted talisman brimming with a mysterious substance.	f	\N	1
677	book_of_shadows	Book of Shadows	data\\processed\\dota2\\items\\img\\book_of_shadows.png	\N	0	\N	Does not trigger spell block or spell reflect.	\N	\N	8	An impossible tome filled with unreadable prose of unknowable thoughts.	f	\N	1
678	giants_ring	Giants Ring	data\\processed\\dota2\\items\\img\\giants_ring.png	\N	0	\N		\N	\N	\N	Prized procurement of an otherwise unremarkable ruler of Elze who abdicated his position and vanished.	f	\N	1
679	vengeances_shadow	Shadow of Vengeance	data\\processed\\dota2\\items\\img\\vengeances_shadow.png	\N	0	\N		\N	\N	\N		f	\N	1
585	stormcrafter	Stormcrafter	data\\processed\\dota2\\items\\img\\stormcrafter.png	\N	0	\N		\N	\N	3	The accidental byproduct of a spell conjured to entrap a lesser god.	f	\N	1
588	overflowing_elixir		data\\processed\\dota2\\items\\img\\overflowing_elixir.png	\N	0	\N		\N	\N	45		f	\N	1
589	mysterious_hat	Fairys Trinket	data\\processed\\dota2\\items\\img\\mysterious_hat.png	\N	0	\N		\N	\N	8	A small token imbued with the fortune of the fae in recognition of an intriguing display of mortal kindness.	f	\N	1
824	assassins_dagger		data\\processed\\dota2\\items\\img\\assassins_dagger.png	\N	0	\N		\N	\N	7		f	\N	1
825	ascetic_cap	Ascetics Cap	data\\processed\\dota2\\items\\img\\ascetic_cap.png	\N	0	\N		\N	\N	25	An austere hat thought to be of Turstarkuri origin.	f	\N	1
826	sample_picker		data\\processed\\dota2\\items\\img\\sample_picker.png	\N	0	\N		\N	\N	15		f	\N	1
827	icarus_wings		data\\processed\\dota2\\items\\img\\icarus_wings.png	\N	0	\N		\N	\N	45		f	\N	1
828	misericorde	Brigands Blade	data\\processed\\dota2\\items\\img\\misericorde.png	\N	0	\N		\N	\N	\N	An infamous assassins blade stolen and smuggled out of White Spire after its owners mysterious demise.	f	\N	1
836	light_robes		data\\processed\\dota2\\items\\img\\light_robes.png	\N	0	\N		\N	\N	\N		f	\N	1
837	heavy_blade	Witchbane	data\\processed\\dota2\\items\\img\\heavy_blade.png	\N	0	\N		75	\N	20	With ready access to test subjects, untold cruelties have been dreamed up and loosed upon the world from within the walls of the Tyler Estate.	f	\N	1
838	unstable_wand	Pig Pole	data\\processed\\dota2\\items\\img\\unstable_wand.png	\N	0	\N		\N	\N	20	A makeshift charm misplaced by a peace-loving, addlebrained enchanter.	f	\N	1
839	fortitude_ring		data\\processed\\dota2\\items\\img\\fortitude_ring.png	\N	0	\N		100	\N	30		f	\N	1
840	pogo_stick	Tumblers Toy	data\\processed\\dota2\\items\\img\\pogo_stick.png	\N	0	\N		\N	\N	15	An antique plaything found in the ruins of an Ozenja circus bazaar.	f	\N	1
835	paintball	Fae Grenade	data\\processed\\dota2\\items\\img\\paintball.png	\N	0	\N	Does not trigger spell block or spell reflect.	25	\N	20	Those marked for death by the fae shine brightly to all manner of creatures in the shadow realm.	f	\N	1
945	seeds_of_serenity	Seeds of Serenity	data\\processed\\dota2\\items\\img\\seeds_of_serenity.png	\N	0	\N		\N	\N	35	An evergreen sprout treasured by the woodkin and highly coveted by interlopers and their like.	f	\N	1
946	lance_of_pursuit	Lance of Pursuit	data\\processed\\dota2\\items\\img\\lance_of_pursuit.png	\N	0	\N		\N	\N	\N	The gleaming weapon of a tarnished knight haunted by his duties to an unworthy king.	f	\N	1
947	occult_bracelet	Occult Bracelet	data\\processed\\dota2\\items\\img\\occult_bracelet.png	\N	0	\N		\N	\N	\N	A band that bears effigy of the dark goddess Eloshars unsleeping eye.	f	\N	1
948	tome_of_omniscience		data\\processed\\dota2\\items\\img\\tome_of_omniscience.png	\N	0	\N		\N	\N	\N		f	\N	1
949	ogre_seal_totem	Ogre Seal Totem	data\\processed\\dota2\\items\\img\\ogre_seal_totem.png	\N	0	\N		25	\N	40		f	\N	1
940	wand_of_the_brine		data\\processed\\dota2\\items\\img\\wand_of_the_brine.png	\N	0	\N		90	\N	35		f	\N	1
938	slime_vial		data\\processed\\dota2\\items\\img\\slime_vial.png	\N	0	\N		\N	\N	27		f	\N	1
1101	recipe_harpoon	Harpoon Recipe	data\\processed\\dota2\\items\\img\\recipe.png	\N	1000	\N		\N	\N	\N		f	\N	1
939	harpoon	Harpoon	data\\processed\\dota2\\items\\img\\harpoon.png	\N	4700	\N		50	\N	19	A perfect solution for the flight of foes.	t	\N	1
950	defiant_shell	Defiant Shell	data\\processed\\dota2\\items\\img\\defiant_shell.png	\N	0	\N		\N	\N	\N		f	\N	1
968	arcane_scout		data\\processed\\dota2\\items\\img\\arcane_scout.png	\N	0	\N		\N	\N	40		f	\N	1
969	barricade		data\\processed\\dota2\\items\\img\\barricade.png	\N	0	\N		\N	\N	45		f	\N	1
990	eye_of_the_vizier	Eye of the Vizier	data\\processed\\dota2\\items\\img\\eye_of_the_vizier.png	\N	0	\N		\N	\N	\N	The ring of a cunning court mage who imprisoned a cadre of enemies to serve as his personal mana reserve.	f	\N	1
998	manacles_of_power		data\\processed\\dota2\\items\\img\\manacles_of_power.png	\N	0	\N		\N	\N	20		f	\N	1
1000	bottomless_chalice		data\\processed\\dota2\\items\\img\\bottomless_chalice.png	\N	0	\N		\N	\N	\N		f	6	1
1017	wand_of_sanctitude		data\\processed\\dota2\\items\\img\\wand_of_sanctitude.png	\N	0	\N		\N	\N	40		f	\N	1
1076	specialists_array	Specialists Array	data\\processed\\dota2\\items\\img\\specialists_array.png	\N	0	\N		\N	\N	8	An impressive kit of trigger enhancements born in an aging assassins idle mind.	f	\N	1
1077	dagger_of_ristul	Dagger of Ristul	data\\processed\\dota2\\items\\img\\dagger_of_ristul.png	\N	0	\N		\N	\N	30	A sinister shiv that grants favor to those willing to stain its blade with a sacrifice of their own blood.	f	\N	1
4300	ofrenda	Beloved Memory	data\\processed\\dota2\\items\\img\\ofrenda.png	\N	0	Magical		\N	\N	3	Take joy in remembering those beloved whove passed now beyond the veil.	f	\N	1
4301	ofrenda_shovel	Scrying Shovel	data\\processed\\dota2\\items\\img\\ofrenda_shovel.png	\N	0	\N		\N	\N	8	You dont know where it came from, but it knows where you need to go. All you need to do is dig.	f	\N	1
4302	ofrenda_pledge	Forebearers Fortune	data\\processed\\dota2\\items\\img\\ofrenda_pledge.png	\N	0	\N		\N	\N	\N	This item seems unstable. Like it might just disappear.	f	\N	1
1090	muertas_gun	Mercy & Grace	data\\processed\\dota2\\items\\img\\muertas_gun.png	\N	0	Magical	Feared enemies are phased and unslowable.\nThe ricochet will travel 1x Dead Shots cast range.	160	\N	10	One to deliver the body, the other to claim the soul.	f	\N	1
2091	tier1_token	Tier 1 Token	data\\processed\\dota2\\items\\img\\tier1_token.png	\N	\N	\N		\N	\N	\N		f	\N	1
2092	tier2_token	Tier 2 Token	data\\processed\\dota2\\items\\img\\tier2_token.png	\N	\N	\N		\N	\N	\N		f	\N	1
2093	tier3_token	Tier 3 Token	data\\processed\\dota2\\items\\img\\tier3_token.png	\N	\N	\N		\N	\N	\N		f	\N	1
2094	tier4_token	Tier 4 Token	data\\processed\\dota2\\items\\img\\tier4_token.png	\N	\N	\N		\N	\N	\N		f	\N	1
1156	ancient_guardian	Ancient Guardian	data\\processed\\dota2\\items\\img\\ancient_guardian.png	\N	0	\N		\N	\N	\N		f	\N	1
1157	safety_bubble	Safety Bubble	data\\processed\\dota2\\items\\img\\safety_bubble.png	\N	0	\N		\N	\N	\N		f	\N	1
1158	whisper_of_the_dread	Whisper of the Dread	data\\processed\\dota2\\items\\img\\whisper_of_the_dread.png	\N	0	\N		\N	\N	\N	The air that passes through this amulet makes a dreadful sound.	f	\N	1
1159	nemesis_curse	Nemesis Curse	data\\processed\\dota2\\items\\img\\nemesis_curse.png	\N	0	\N		\N	\N	\N		f	\N	1
1160	avianas_feather	Avianas Feather	data\\processed\\dota2\\items\\img\\avianas_feather.png	\N	0	\N		\N	\N	\N		f	\N	1
1161	unwavering_condition	Unwavering Condition	data\\processed\\dota2\\items\\img\\unwavering_condition.png	\N	0	\N		\N	\N	\N		f	\N	1
2098	horizons_equilibrium		data\\processed\\dota2\\items\\img\\horizons_equilibrium.png	\N	0	\N		\N	\N	\N		f	\N	1
2099	blighted_spirit		data\\processed\\dota2\\items\\img\\blighted_spirit.png	\N	0	\N		\N	\N	\N		f	\N	1
2190	dandelion_amulet	Dandelion Amulet	data\\processed\\dota2\\items\\img\\dandelion_amulet.png	\N	0	\N		\N	\N	12		f	\N	1
2191	turtle_shell		data\\processed\\dota2\\items\\img\\turtle_shell.png	\N	0	\N		\N	\N	30		f	\N	1
2192	martyrs_plate	Martyrs Plate	data\\processed\\dota2\\items\\img\\martyrs_plate.png	\N	0	\N		\N	\N	40		f	\N	1
2193	gossamer_cape	Gossamer Cape	data\\processed\\dota2\\items\\img\\gossamer_cape.png	\N	0	\N		\N	\N	6		f	\N	1
1167	light_collector	Light Collector	data\\processed\\dota2\\items\\img\\light_collector.png	\N	0	\N		\N	\N	30		f	\N	1
1168	rattlecage	Rattlecage	data\\processed\\dota2\\items\\img\\rattlecage.png	\N	0	\N		\N	\N	\N		f	\N	1
1803	doubloon	Doubloon	data\\processed\\dota2\\items\\img\\doubloon.png	\N	0	\N		\N	\N	5		f	\N	1
1804	roshans_banner	Roshans Banner	data\\processed\\dota2\\items\\img\\roshans_banner.png	artifact	0	\N		\N	\N	1		f	\N	1
1440	black_grimoire	Black Grimoire	data\\processed\\dota2\\items\\img\\black_grimoire.png	\N	0	\N		\N	\N	420		f	\N	1
1441	grisgris	Gris-Gris	data\\processed\\dota2\\items\\img\\grisgris.png	\N	0	\N		\N	\N	\N		f	\N	1
1576	enhancement_vast	Vast	data\\processed\\dota2\\items\\img\\enhancement_vast.png	\N	0	\N		\N	\N	\N		f	\N	1
1577	enhancement_quickened	Quickened	data\\processed\\dota2\\items\\img\\enhancement_quickened.png	\N	0	\N		\N	\N	\N		f	\N	1
1578	cursed_circlet	Accursed	data\\processed\\dota2\\items\\img\\cursed_circlet.png	\N	0	\N		\N	\N	\N		f	\N	1
1579	ogre_heart	Restorative	data\\processed\\dota2\\items\\img\\ogre_heart.png	\N	0	\N		\N	\N	\N		f	\N	1
1580	neutral_tabi	Elusive	data\\processed\\dota2\\items\\img\\neutral_tabi.png	\N	0	\N		\N	\N	\N		f	\N	1
1581	enhancement_audacious	Audacious	data\\processed\\dota2\\items\\img\\enhancement_audacious.png	\N	0	\N		\N	\N	\N		f	\N	1
1582	hellbear_totem		data\\processed\\dota2\\items\\img\\hellbear_totem.png	\N	0	\N		\N	\N	\N		f	\N	1
1583	enhancement_mystical	Mystical	data\\processed\\dota2\\items\\img\\enhancement_mystical.png	\N	0	\N		\N	\N	\N		f	\N	1
1584	enhancement_alert	Alert	data\\processed\\dota2\\items\\img\\enhancement_alert.png	\N	0	\N		\N	\N	\N		f	\N	1
1585	enhancement_brawny	Brawny	data\\processed\\dota2\\items\\img\\enhancement_brawny.png	\N	0	\N		\N	\N	\N		f	\N	1
1586	enhancement_tough	Tough	data\\processed\\dota2\\items\\img\\enhancement_tough.png	\N	0	\N		\N	\N	\N		f	\N	1
1587	enhancement_feverish	Feverish	data\\processed\\dota2\\items\\img\\enhancement_feverish.png	\N	0	\N		\N	\N	\N		f	\N	1
1588	enhancement_fleetfooted	Fleetfooted	data\\processed\\dota2\\items\\img\\enhancement_fleetfooted.png	\N	0	\N	Does not stack with Movement Speed bonuses from boots	\N	\N	\N		f	\N	1
1589	enhancement_crude	Crude	data\\processed\\dota2\\items\\img\\enhancement_crude.png	\N	0	\N		\N	\N	\N		f	\N	1
1590	enhancement_boundless	Boundless	data\\processed\\dota2\\items\\img\\enhancement_boundless.png	\N	0	\N		\N	\N	\N		f	\N	1
1591	enhancement_wise	Wise	data\\processed\\dota2\\items\\img\\enhancement_wise.png	\N	0	\N		\N	\N	\N		f	\N	1
1592	enhancement_timeless	Timeless	data\\processed\\dota2\\items\\img\\enhancement_timeless.png	\N	0	\N		\N	\N	\N		f	\N	1
1593	enhancement_greedy	Greedy	data\\processed\\dota2\\items\\img\\enhancement_greedy.png	\N	0	\N		\N	\N	\N		f	750	1
1594	enhancement_vampiric	Vampiric	data\\processed\\dota2\\items\\img\\enhancement_vampiric.png	\N	0	\N		\N	\N	\N		f	\N	1
1595	enhancement_keen_eyed	Keen-eyed	data\\processed\\dota2\\items\\img\\enhancement_keen_eyed.png	\N	0	\N		\N	\N	\N		f	\N	1
1596	enhancement_evolved	Evolved	data\\processed\\dota2\\items\\img\\enhancement_evolved.png	\N	0	\N	Grants +24 to each attribute for Universal Heroes.	\N	\N	\N		f	\N	1
1597	enhancement_titanic	Titanic	data\\processed\\dota2\\items\\img\\enhancement_titanic.png	\N	0	\N		\N	\N	\N		f	\N	1
1598	unrelenting_eye	Unrelenting Eye	data\\processed\\dota2\\items\\img\\unrelenting_eye.png	\N	0	\N		\N	\N	\N	A serpents eye the size of a melon (and just as moist).	f	\N	1
1599	mana_draught	Mana Draught	data\\processed\\dota2\\items\\img\\mana_draught.png	\N	0	\N		\N	\N	60	A refreshing drink best shared with friends.	f	\N	1
1600	rippers_lash	Rippers Lash	data\\processed\\dota2\\items\\img\\rippers_lash.png	\N	0	Physical		\N	\N	25	The Fae horticulturists of Revtel are known to push the boundaries of both cross pollination and safety.	f	\N	1
1601	crippling_crossbow	Crippling Crossbow	data\\processed\\dota2\\items\\img\\crippling_crossbow.png	\N	0	Magical		50	\N	12	The ever-weeping woodgrain of this crossbow coats every bolt in a potent but short-lived narcotic sap.	f	\N	1
1602	gale_guard	Gale Guard	data\\processed\\dota2\\items\\img\\gale_guard.png	\N	0	\N		\N	\N	30	If one truly listens, they can always rely upon the wind to make its will known.	f	\N	1
1603	gunpowder_gauntlets	Gunpowder Gauntlet	data\\processed\\dota2\\items\\img\\gunpowder_gauntlets.png	\N	0	\N		\N	\N	6	A harmless prank that went entirely too far.	f	\N	1
1604	searing_signet	Searing Signet	data\\processed\\dota2\\items\\img\\searing_signet.png	\N	0	\N		\N	\N	\N	To torture a magic user, one must devise means far beyond the mundane.	f	\N	1
1605	serrated_shiv	Serrated Shiv	data\\processed\\dota2\\items\\img\\serrated_shiv.png	\N	0	\N		\N	\N	1	Too dangerous for taskwork, this blades only purpose is vile murder.	f	\N	1
1606	polliwog_charm	Pollywog Charm	data\\processed\\dota2\\items\\img\\polliwog_charm.png	\N	0	\N		\N	\N	45	A tiny trinket that wriggles when wet.	f	\N	1
1607	magnifying_monocle	Magnifying Monocle	data\\processed\\dota2\\items\\img\\magnifying_monocle.png	\N	0	\N		\N	\N	\N	Deadly refinement.	f	\N	1
1608	pyrrhic_cloak	Pyrrhic Cloak	data\\processed\\dota2\\items\\img\\pyrrhic_cloak.png	\N	0	Physical		\N	\N	40	There are generals that care far less about the survival of their troops than the destruction of their enemies.	f	\N	1
1609	madstone_bundle	Madstone Bundle	data\\processed\\dota2\\items\\img\\madstone_bundle.png	consumable	0	\N		\N	\N	\N		f	1	1
1610	miniboss_minion_summoner		data\\processed\\dota2\\items\\img\\miniboss_minion_summoner.png	artifact	\N	\N		\N	\N	40		f	4	1
1636	crystal_raindrop	Crystal Raindrop	data\\processed\\dota2\\items\\img\\crystal_raindrop.png	\N	0	\N		\N	\N	70		f	\N	1
1637	kobold_cup	Kobold Cup	data\\processed\\dota2\\items\\img\\kobold_cup.png	\N	0	\N		40	\N	40	The Kobold King will sip when he damn well pleases.	f	\N	1
1638	dormant_curio	Dormant Curio	data\\processed\\dota2\\items\\img\\dormant_curio.png	\N	0	\N	Will amplify a stat on the next artifact by 30% other than cooldown, mana cost, or cast range.	\N	\N	\N	Everyone has an idea, but no one has a clue.	f	\N	1
1639	sisters_shroud	Sisters Shroud	data\\processed\\dota2\\items\\img\\sisters_shroud.png	\N	0	\N	Does not trigger from damage by non-player controlled creeps	\N	\N	\N	A pall that draped the sarcophagus of the First Sister.	f	\N	1
1640	jidi_pollen_bag	Jidi Pollen Bag	data\\processed\\dota2\\items\\img\\jidi_pollen_bag.png	\N	0	\N	Damage is non-lethal and classified as HP Loss.	\N	\N	45	Very dangerous. Very difficult to obtain more.	f	\N	1
1641	outworld_staff	Outworld Staff	data\\processed\\dota2\\items\\img\\outworld_staff.png	\N	0	\N	Damage taken when returning is non-lethal and disables Blink Dagger and other items that are muted upon taking damage.	40	\N	30	Proof that the lone sentinel was not always so.	f	\N	1
1642	dezun_bloodrite	Dezun Bloodrite	data\\processed\\dota2\\items\\img\\dezun_bloodrite.png	\N	0	\N		\N	\N	\N	The gateway to a lost lineage of power, unlocked only with blood.	f	\N	1
1643	giant_maul	Giants Maul	data\\processed\\dota2\\items\\img\\giant_maul.png	\N	0	\N		\N	\N	15	Crude but smashingly effective.	f	\N	1
1644	divine_regalia	Divine Regalia	data\\processed\\dota2\\items\\img\\divine_regalia.png	\N	0	\N		\N	\N	\N	So magnificent, it cannot abide failure.	f	\N	1
1645	divine_regalia_broken	Disgraced Regalia	data\\processed\\dota2\\items\\img\\divine_regalia_broken.png	\N	0	\N		\N	\N	\N	It cannot abide failure.	f	\N	1
1646	circlet_of_the_flayed_twins	Circlet of the Flayed Twins	data\\processed\\dota2\\items\\img\\circlet_of_the_flayed_twins.png	\N	0	\N		\N	\N	\N		f	\N	1
1647	enhancement_fierce	Fierce	data\\processed\\dota2\\items\\img\\enhancement_fierce.png	\N	0	\N		\N	\N	\N		f	\N	1
1648	enhancement_dominant	Dominant	data\\processed\\dota2\\items\\img\\enhancement_dominant.png	\N	0	\N		\N	\N	\N		f	\N	1
1649	enhancement_restorative	Restorative	data\\processed\\dota2\\items\\img\\enhancement_restorative.png	\N	0	\N		\N	\N	\N		f	\N	1
1650	enhancement_thick	Thick	data\\processed\\dota2\\items\\img\\enhancement_thick.png	\N	0	\N		\N	\N	\N		f	\N	1
1651	enhancement_curious	Unleashed	data\\processed\\dota2\\items\\img\\enhancement_curious.png	\N	0	\N		\N	\N	\N		f	\N	1
1652	furion_gold_bag	Bag of Gold	data\\processed\\dota2\\items\\img\\furion_gold_bag.png	\N	0	\N		\N	\N	\N		f	\N	1
196	diffusal_blade_2	Diffusal Blade	data\\processed\\dota2\\items\\img\\diffusal_blade_2.png	artifact	3850	\N	Does not stack with other manabreak abilities.	\N	\N	4	An enchanted blade that allows the user to cut straight into the enemys soul.	t	\N	1
\.
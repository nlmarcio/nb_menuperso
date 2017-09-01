local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local GUI                       = {}
GUI.Time                        = 0
local PlayerData              = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

--Notification joueur
function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, true)
end

--Message text joueur
function Text(text)
		SetTextColour(186, 186, 186, 255)
		SetTextFont(0)
		SetTextScale(0.378, 0.378)
		SetTextWrap(0.0, 1.0)
		SetTextCentre(false)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 205)
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(0.017, 0.977)
end

etatGPS = false
etatPHONE = false

function OpenPersonnelMenu()
	
	ESX.UI.Menu.CloseAll()
	
	ESX.TriggerServerCallback('NB:getUsergroup', function(group)
		playergroup = group
		
		local elements = {}
		
		if playergroup == 'user' then
			table.insert(elements, {label = 'Me concernant',		value = 'menuperso_moi'})
			table.insert(elements, {label = 'Actions',					value = 'menuperso_actions'})
			if (IsInVehicle()) then
				local vehicle = GetVehiclePedIsIn( GetPlayerPed(-1), false )
				if ( GetPedInVehicleSeat( vehicle, -1 ) == GetPlayerPed(-1) ) then
					table.insert(elements, {label = 'Véhicule',					value = 'menuperso_vehicule'})
				end
			end
			table.insert(elements, {label = 'GPS Rapide',			value = 'menuperso_gpsrapide'})
			if PlayerData.job.grade_name == 'boss' then
				table.insert(elements, {label = 'Gestion d\'entreprise',			value = 'menuperso_grade'})
			end
		end
		
		if playergroup == 'mod' then
			table.insert(elements, {label = 'Me concernant',		value = 'menuperso_moi'})
			table.insert(elements, {label = 'Actions',					value = 'menuperso_actions'})
			if (IsInVehicle()) then
				local vehicle = GetVehiclePedIsIn( GetPlayerPed(-1), false )
				if ( GetPedInVehicleSeat( vehicle, -1 ) == GetPlayerPed(-1) ) then
					table.insert(elements, {label = 'Véhicule',					value = 'menuperso_vehicule'})
				end
			end
			table.insert(elements, {label = 'GPS Rapide',			value = 'menuperso_gpsrapide'})
			if PlayerData.job.grade_name == 'boss' then
				table.insert(elements, {label = 'Gestion d\'entreprise',			value = 'menuperso_grade'})
			end
			table.insert(elements, {label = 'Modération',				value = 'menuperso_modo'})
		end
		
		if playergroup == 'admin' then
			table.insert(elements, {label = 'Me concernant',		value = 'menuperso_moi'})
			table.insert(elements, {label = 'Actions',					value = 'menuperso_actions'})
			if (IsInVehicle()) then
				local vehicle = GetVehiclePedIsIn( GetPlayerPed(-1), false )
				if ( GetPedInVehicleSeat( vehicle, -1 ) == GetPlayerPed(-1) ) then
					table.insert(elements, {label = 'Véhicule',					value = 'menuperso_vehicule'})
				end
			end
			table.insert(elements, {label = 'GPS Rapide',			value = 'menuperso_gpsrapide'})
			if PlayerData.job.grade_name == 'boss' then
				table.insert(elements, {label = 'Gestion d\'entreprise',			value = 'menuperso_grade'})
			end
			table.insert(elements, {label = 'Modération',				value = 'menuperso_modo'})
		end
		
		if playergroup == 'owner' then
			table.insert(elements, {label = 'Me concernant',		value = 'menuperso_moi'})
			table.insert(elements, {label = 'Actions',					value = 'menuperso_actions'})
			if (IsInVehicle()) then
				local vehicle = GetVehiclePedIsIn( GetPlayerPed(-1), false )
				if ( GetPedInVehicleSeat( vehicle, -1 ) == GetPlayerPed(-1) ) then
					table.insert(elements, {label = 'Véhicule',					value = 'menuperso_vehicule'})
				end
			end
			table.insert(elements, {label = 'GPS Rapide',			value = 'menuperso_gpsrapide'})
			if PlayerData.job.grade_name == 'boss' then
				table.insert(elements, {label = 'Gestion d\'entreprise',			value = 'menuperso_grade'})
			end
			table.insert(elements, {label = 'Modération',				value = 'menuperso_modo'})
		end
		
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'menu_perso',
			{
				title    = 'Menu Personnel',
				align    = 'top-left',
				elements = elements
			},
			function(data, menu)
	
				local elements = {}
				
				if playergroup == 'mod' then
					table.insert(elements, {label = 'TP sur joueur',    							value = 'menuperso_modo_tp_toplayer'})
					table.insert(elements, {label = 'TP joueur sur moi',             			value = 'menuperso_modo_tp_playertome'})
					--table.insert(elements, {label = 'TP sur coordonées [WIP]',						value = 'menuperso_modo_tp_pos'})
					--table.insert(elements, {label = 'No Clip',										value = 'menuperso_modo_no_clip'})
					--table.insert(elements, {label = 'GodMode',									value = 'menuperso_modo_godmode'})
					--table.insert(elements, {label = 'Mode fantôme',								value = 'menuperso_modo_mode_fantome'})
					--table.insert(elements, {label = 'Réparer véhicule',							value = 'menuperso_modo_vehicle_repair'})
					--table.insert(elements, {label = 'Spawn véhicule',							value = 'menuperso_modo_vehicle_spawn'})
					--table.insert(elements, {label = 'Flip véhicule',								value = 'menuperso_modo_vehicle_flip'})
					-- table.insert(elements, {label = 'Se give des $ argent',						value = 'menuperso_modo_give_money'})
					-- table.insert(elements, {label = 'Se give des $ en banque',						value = 'menuperso_modo_give_moneybank'})
					-- table.insert(elements, {label = 'Se give des $ argent sale',						value = 'menuperso_modo_give_moneydirty'})
					table.insert(elements, {label = 'Afficher/Cacher Coordonnées',		value = 'menuperso_modo_showcoord'})
					table.insert(elements, {label = 'Afficher/Cacher nom des joueurs',	value = 'menuperso_modo_showname'})
					--table.insert(elements, {label = 'TP sur le marker',							value = 'menuperso_modo_tp_marcker'})
					--table.insert(elements, {label = 'Soigner la personne',					value = 'menuperso_modo_heal_player'})
					--table.insert(elements, {label = 'Spéc la personne [WIP]',						value = 'menuperso_modo_spec_player'})
					--table.insert(elements, {label = 'Changer Skin',									value = 'menuperso_modo_changer_skin'})
					--table.insert(elements, {label = 'Save Skin',									value = 'menuperso_modo_save_skin'})
					
					
				end
			
				if playergroup == 'admin' then
					table.insert(elements, {label = 'TP sur joueur',    							value = 'menuperso_modo_tp_toplayer'})
					table.insert(elements, {label = 'TP joueur sur moi',             			value = 'menuperso_modo_tp_playertome'})
					--table.insert(elements, {label = 'TP sur coordonées [WIP]',						value = 'menuperso_modo_tp_pos'})
					table.insert(elements, {label = 'No Clip',										value = 'menuperso_modo_no_clip'})
					table.insert(elements, {label = 'GodMode',									value = 'menuperso_modo_godmode'})
					table.insert(elements, {label = 'Mode fantôme',								value = 'menuperso_modo_mode_fantome'})
					table.insert(elements, {label = 'Réparer véhicule',							value = 'menuperso_modo_vehicle_repair'})
					table.insert(elements, {label = 'Spawn véhicule',							value = 'menuperso_modo_vehicle_spawn'})
					table.insert(elements, {label = 'Flip véhicule',								value = 'menuperso_modo_vehicle_flip'})
					table.insert(elements, {label = 'Se give des $ argent',						value = 'menuperso_modo_give_money'})
					table.insert(elements, {label = 'Se give des $ en banque',						value = 'menuperso_modo_give_moneybank'})
					table.insert(elements, {label = 'Se give des $ argent sale',						value = 'menuperso_modo_give_moneydirty'})
					table.insert(elements, {label = 'Afficher/Cacher Coordonnées',		value = 'menuperso_modo_showcoord'})
					table.insert(elements, {label = 'Afficher/Cacher nom des joueurs',	value = 'menuperso_modo_showname'})
					table.insert(elements, {label = 'TP sur le marker',							value = 'menuperso_modo_tp_marcker'})
					table.insert(elements, {label = 'Soigner la personne',					value = 'menuperso_modo_heal_player'})
					--table.insert(elements, {label = 'Spéc la personne [WIP]',						value = 'menuperso_modo_spec_player'})
					table.insert(elements, {label = 'Changer Skin',									value = 'menuperso_modo_changer_skin'})
					table.insert(elements, {label = 'Save Skin',									value = 'menuperso_modo_save_skin'})
				end
			
				if playergroup == 'owner' then
					table.insert(elements, {label = 'TP sur joueur',    							value = 'menuperso_modo_tp_toplayer'})
					table.insert(elements, {label = 'TP joueur sur moi',             			value = 'menuperso_modo_tp_playertome'})
					table.insert(elements, {label = 'TP sur coordonées [WIP]',						value = 'menuperso_modo_tp_pos'})
					table.insert(elements, {label = 'No Clip',										value = 'menuperso_modo_no_clip'})
					table.insert(elements, {label = 'GodMode',									value = 'menuperso_modo_godmode'})
					table.insert(elements, {label = 'Mode fantôme',								value = 'menuperso_modo_mode_fantome'})
					table.insert(elements, {label = 'Réparer véhicule',							value = 'menuperso_modo_vehicle_repair'})
					table.insert(elements, {label = 'Spawn véhicule',							value = 'menuperso_modo_vehicle_spawn'})
					table.insert(elements, {label = 'Flip véhicule',								value = 'menuperso_modo_vehicle_flip'})
					table.insert(elements, {label = 'Se give des $ argent',						value = 'menuperso_modo_give_money'})
					table.insert(elements, {label = 'Se give des $ en banque',						value = 'menuperso_modo_give_moneybank'})
					table.insert(elements, {label = 'Se give des $ argent sale',						value = 'menuperso_modo_give_moneydirty'})
					table.insert(elements, {label = 'Afficher/Cacher Coordonnées',		value = 'menuperso_modo_showcoord'})
					table.insert(elements, {label = 'Afficher/Cacher nom des joueurs',	value = 'menuperso_modo_showname'})
					table.insert(elements, {label = 'TP sur le marker',							value = 'menuperso_modo_tp_marcker'})
					table.insert(elements, {label = 'Soigner la personne',					value = 'menuperso_modo_heal_player'})
					table.insert(elements, {label = 'Spéc la personne [WIP]',						value = 'menuperso_modo_spec_player'})
					table.insert(elements, {label = 'Changer Skin',									value = 'menuperso_modo_changer_skin'})
					table.insert(elements, {label = 'Save Skin',									value = 'menuperso_modo_save_skin'})
				end

				if data.current.value == 'menuperso_modo' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_modo',
						{
							title    = 'Modération',
							align    = 'top-left',
							elements = elements
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_modo_tp_toplayer' then
								admin_tp_toplayer()
							end

							if data2.current.value == 'menuperso_modo_tp_playertome' then
								admin_tp_playertome()
							end

							if data2.current.value == 'menuperso_modo_tp_pos' then
								admin_tp_pos()
							end

							if data2.current.value == 'menuperso_modo_no_clip' then
								admin_no_clip()
							end

							if data2.current.value == 'menuperso_modo_godmode' then
								admin_godmode()
							end

							if data2.current.value == 'menuperso_modo_mode_fantome' then
								admin_mode_fantome()
							end

							if data2.current.value == 'menuperso_modo_vehicle_repair' then
								admin_vehicle_repair()
							end

							if data2.current.value == 'menuperso_modo_vehicle_spawn' then
								admin_vehicle_spawn()
							end

							if data2.current.value == 'menuperso_modo_vehicle_flip' then
								admin_vehicle_flip()
							end

							if data2.current.value == 'menuperso_modo_give_money' then
								admin_give_money()
							end

							if data2.current.value == 'menuperso_modo_give_moneybank' then
								admin_give_bank()
							end

							if data2.current.value == 'menuperso_modo_give_moneydirty' then
								admin_give_dirty()
							end

							if data2.current.value == 'menuperso_modo_showcoord' then
								modo_showcoord()
							end

							if data2.current.value == 'menuperso_modo_showname' then
								modo_showname()
							end

							if data2.current.value == 'menuperso_modo_tp_marcker' then
								admin_tp_marcker()
							end

							if data2.current.value == 'menuperso_modo_heal_player' then
								admin_heal_player()
							end

							if data2.current.value == 'menuperso_modo_spec_player' then
								admin_spec_player()
							end

							if data2.current.value == 'menuperso_modo_changer_skin' then
								changer_skin()
							end
							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end

				if data.current.value == 'menuperso_moi' then
	
					local elements = {}
					
					table.insert(elements, {label = 'Téléphone',    							value = 'menuperso_moi_telephone'})
					table.insert(elements, {label = 'Inventaire',             					value = 'menuperso_moi_inventaire'})
					table.insert(elements, {label = 'Mes factures',							value = 'menuperso_moi_factures'})
						
					ESX.UI.Menu.Open(
						
						'default', GetCurrentResourceName(), 'menuperso_moi',
						{
							title    = 'Me concernant',
							align    = 'top-left',
							elements = elements
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_moi_telephone' then
								openTelephone()
							end

							if data2.current.value == 'menuperso_moi_inventaire' then
								openInventaire()
							end

							if data2.current.value == 'menuperso_moi_factures' then
								openFacture()
							end

							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end

				if data.current.value == 'menuperso_actions' then

					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_actions',
						{
							title    = 'Actions',
							align    = 'top-left',
							elements = {
								{label = 'Annuler Animations',  value = 'menuperso_actions__annuler'},
								--{label = 'Faire ses besoins [WIP]',     value = 'menuperso_actions_pipi'},
								{label = 'Animations de Salutations',  value = 'menuperso_actions_Salute'},
								{label = 'Animations d\'Humeurs',  value = 'menuperso_actions_Humor'},
								{label = 'Animations de Travail',  value = 'menuperso_actions_Travail'},
								{label = 'Animations Festives',  value = 'menuperso_actions_Festives'},
								{label = 'Animations Diverses',  value = 'menuperso_actions_Others'},
							},
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_actions__annuler' then
								local ped = GetPlayerPed(-1);
								if ped then
									ClearPedTasks(ped);
								end
							end

							if data2.current.value == 'menuperso_actions_pipi' then
								ESX.UI.Menu.CloseAll()
							end

							if data2.current.value == 'menuperso_actions_Salute' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Salute',
									{
										title    = 'Animations Salutations',
										align    = 'top-left',
										elements = {
											{label = 'Saluer',  value = 'menuperso_actions_Salute_saluer'},
											{label = 'Serrer la main',     value = 'menuperso_actions_Salute_serrerlamain'},
											{label = 'Tape en 5',     value = 'menuperso_actions_Salute_tapeen5'},
											{label = 'Salut Militaire',  value = 'menuperso_actions_Salute_salutmilitaire'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Salute_saluer' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_hello" })
										end

										if data3.current.value == 'menuperso_actions_Salute_serrerlamain' then
											animsAction({ lib = "mp_common", anim = "givetake1_a" })
										end

										if data3.current.value == 'menuperso_actions_Salute_tapeen5' then
											animsAction({ lib = "mp_ped_interaction", anim = "highfive_guy_a" })
										end

										if data3.current.value == 'menuperso_actions_Salute_salutmilitaire' then
											animsAction({ lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_actions_Humor' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Humor',
									{
										title    = 'Animations Humeurs',
										align    = 'top-left',
										elements = {
											{label = 'Féliciter',  value = 'menuperso_actions_Humor_feliciter'},
											{label = 'Super',     value = 'menuperso_actions_Humor_super'},
											{label = 'Calme-toi',     value = 'menuperso_actions_Humor_calmetoi'},
											{label = 'Avoir peur',  value = 'menuperso_actions_Humor_avoirpeur'},
											{label = 'C\'est pas Possible!',  value = 'menuperso_actions_Humor_cestpaspossible'},
											{label = 'Enlacer',  value = 'menuperso_actions_Humor_enlacer'},
											{label = 'Doigt d\'honneur',  value = 'menuperso_actions_Humor_doightdhonneur'},
											{label = 'Branleur',  value = 'menuperso_actions_Humor_branleur'},
											{label = 'Balle dans la tete',  value = 'menuperso_actions_Humor_balledanslatete'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Humor_feliciter' then
											animsActionScenario({anim = "WORLD_HUMAN_CHEERING" })
										end

										if data3.current.value == 'menuperso_actions_Humor_super' then
											animsAction({ lib = "anim@mp_player_intcelebrationmale@thumbs_up", anim = "thumbs_up" })
										end

										if data3.current.value == 'menuperso_actions_Humor_calmetoi' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_easy_now" })
										end

										if data3.current.value == 'menuperso_actions_Humor_avoirpeur' then
											animsAction({ lib = "amb@code_human_cower_stand@female@idle_a", anim = "idle_c" })
										end

										if data3.current.value == 'menuperso_actions_Humor_cestpaspossible' then
											animsAction({ lib = "gestures@m@standing@casual", anim = "gesture_damn" })
										end

										if data3.current.value == 'menuperso_actions_Humor_enlacer' then
											animsAction({ lib = "mp_ped_interaction", anim = "kisses_guy_a" })
										end

										if data3.current.value == 'menuperso_actions_Humor_doightdhonneur' then
											animsAction({ lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter" })
										end

										if data3.current.value == 'menuperso_actions_Humor_branleur' then
											animsAction({ lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01" })
										end

										if data3.current.value == 'menuperso_actions_Humor_balledanslatete' then
											animsAction({ lib = "mp_suicide", anim = "pistol" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_actions_Travail' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Travail',
									{
										title    = 'Animations Travail',
										align    = 'top-left',
										elements = {
											{label = 'Pêcheur',  value = 'menuperso_actions_Travail_pecheur'},
											{label = 'Agriculteur',     value = 'menuperso_actions_Travail_agriculteur'},
											{label = 'Dépanneur',     value = 'menuperso_actions_Travail_depanneur'},
											{label = 'Prendre des notes',  value = 'menuperso_actions_Travail_prendredesnotes'},
											{label = 'Inspecter',  value = 'menuperso_actions_Travail_inspecter'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Travail_pecheur' then
											animsActionScenario({anim = "world_human_stand_fishing" })
										end

										if data3.current.value == 'menuperso_actions_Travail_agriculteur' then
											animsActionScenario({anim = "world_human_gardener_plant" })
										end

										if data3.current.value == 'menuperso_actions_Travail_depanneur' then
											animsActionScenario({anim = "world_human_vehicle_mechanic" })
										end

										if data3.current.value == 'menuperso_actions_Travail_prendredesnotes' then
											animsActionScenario({anim = "WORLD_HUMAN_CLIPBOARD" })
										end

										if data3.current.value == 'menuperso_actions_Travail_inspecter' then
											animsActionScenario({anim = "CODE_HUMAN_MEDIC_KNEEL" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_actions_Festives' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Festives',
									{
										title    = 'Animations Festives',
										align    = 'top-left',
										elements = {
											{label = 'Danser',  value = 'menuperso_actions_Festives_danser'},
											{label = 'Jouer de la musique',     value = 'menuperso_actions_Festives_jouerdelamusique'},
											{label = 'Boire une biere',     value = 'menuperso_actions_Festives_boireunebiere'},
											{label = 'Air Guitar',  value = 'menuperso_actions_Festives_airguitar'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Festives_danser' then
											animsAction({ lib = "amb@world_human_partying@female@partying_beer@base", anim = "base" })
										end

										if data3.current.value == 'menuperso_actions_Festives_jouerdelamusique' then
											animsActionScenario({anim = "WORLD_HUMAN_MUSICIAN" })
										end

										if data3.current.value == 'menuperso_actions_Festives_boireunebiere' then
											animsActionScenario({anim = "WORLD_HUMAN_DRINKING" })
										end

										if data3.current.value == 'menuperso_actions_Festives_airguitar' then
											animsAction({ lib = "anim@mp_player_intcelebrationfemale@air_guitar", anim = "air_guitar" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_actions_Others' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_actions_Others',
									{
										title    = 'Animations Diverses',
										align    = 'top-left',
										elements = {
											{label = 'Fumer une clope',     value = 'menuperso_actions_Others_fumeruneclope'},
											{label = 'Faire des pompes',     value = 'menuperso_actions_Others_fairedespompes'},
											{label = 'Regarder aux jumelles',     value = 'menuperso_actions_Others_regarderauxjumelles'},
											{label = 'Faire du Yoga',     value = 'menuperso_actions_Others_faireduyoga'},
											{label = 'Faire la statue',     value = 'menuperso_actions_Others_fairelastatut'},
											{label = 'Faire du jogging',     value = 'menuperso_actions_Others_fairedujogging'},
											{label = 'Montrer ses muscles',     value = 'menuperso_actions_Others_fairedesetirements'},
											{label = 'Racoller',     value = 'menuperso_actions_Others_racoller'},
											{label = 'Racoller 2',     value = 'menuperso_actions_Others_racoller2'},
											{label = 'S\'asseoir',     value = 'menuperso_actions_Others_sasseoir'},
											{label = 'S\'asseoir (Par terre)',     value = 'menuperso_actions_Others_sasseoirparterre'},
											{label = 'Attendre',     value = 'menuperso_actions_Others_attendre'},
											{label = 'Nettoyer quelque chose',     value = 'menuperso_actions_Others_nettoyerquelquechose'},
											{label = 'Lever les mains',     value = 'menuperso_actions_Others_leverlesmains'},
											{label = 'Position de Fouille',     value = 'menuperso_actions_Others_positiondefouille'},
											{label = 'Se gratter les c**',     value = 'menuperso_actions_Others_segratterlesc'},
											{label = 'Prendre un selfie',     value = 'menuperso_actions_Others_prendreunselfie'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_actions_Others_fumeruneclope' then
											animsActionScenario({ anim = "WORLD_HUMAN_SMOKING" })
										end

										if data3.current.value == 'menuperso_actions_Others_fairedespompes' then
											animsActionScenario({ anim = "WORLD_HUMAN_PUSH_UPS" })
										end

										if data3.current.value == 'menuperso_actions_Others_regarderauxjumelles' then
											animsActionScenario({ anim = "WORLD_HUMAN_BINOCULARS" })
										end

										if data3.current.value == 'menuperso_actions_Others_faireduyoga' then
											animsActionScenario({ anim = "WORLD_HUMAN_YOGA" })
										end

										if data3.current.value == 'menuperso_actions_Others_fairelastatut' then
											animsActionScenario({ anim = "WORLD_HUMAN_HUMAN_STATUE" })
										end

										if data3.current.value == 'menuperso_actions_Others_fairedujogging' then
											animsActionScenario({ anim = "WORLD_HUMAN_JOG_STANDING" })
										end

										if data3.current.value == 'menuperso_actions_Others_fairedesetirements' then
											animsActionScenario({ anim = "WORLD_HUMAN_MUSCLE_FLEX" })
										end

										if data3.current.value == 'menuperso_actions_Others_racoller' then
											animsActionScenario({ anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS" })
										end

										if data3.current.value == 'menuperso_actions_Others_racoller2' then
											animsActionScenario({ anim = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS" })
										end

										if data3.current.value == 'menuperso_actions_Others_sasseoir' then
											animsAction({ lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle" })
										end

										if data3.current.value == 'menuperso_actions_Others_sasseoirparterre' then
											animsActionScenario({ anim = "WORLD_HUMAN_PICNIC" })
										end

										if data3.current.value == 'menuperso_actions_Others_attendre' then
											animsActionScenario({ anim = "world_human_leaning" })
										end

										if data3.current.value == 'menuperso_actions_Others_nettoyerquelquechose' then
											animsActionScenario({ anim = "world_human_maid_clean" })
										end

										if data3.current.value == 'menuperso_actions_Others_leverlesmains' then
											animsAction({ lib = "random@mugging3", anim = "handsup_standing_base" })
										end

										if data3.current.value == 'menuperso_actions_Others_positiondefouille' then
											animsAction({ lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female" })
										end

										if data3.current.value == 'menuperso_actions_Others_segratterlesc' then
											animsAction({ lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch" })
										end

										if data3.current.value == 'menuperso_actions_Others_prendreunselfie' then
											animsActionScenario({ anim = "world_human_tourist_mobile" })
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end
							
							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)

				end

				if data.current.value == 'menuperso_vehicule' then

					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_vehicule',
						{
							title    = 'Véhicule',
							align    = 'top-left',
							elements = {
								{label = 'Ouvrir les portes',     value = 'menuperso_vehicule_ouvrirportes'},
								{label = 'Fermer les portes',     value = 'menuperso_vehicule_fermerportes'},
								{label = 'Demarrer le moteur',     value = 'menuperso_vehicule_MoteurOn'},
								{label = 'Couper le moteur',     value = 'menuperso_vehicule_MoteurOff'},
							},
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_vehicule_MoteurOn' then
								local Action = true
								vehicule_Moteur(Action)
							end

							if data2.current.value == 'menuperso_vehicule_MoteurOff' then
								local Action = false
								vehicule_Moteur(Action)
							end

							if data2.current.value == 'menuperso_vehicule_ouvrirportes' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_vehicule_ouvrirportes',
									{
										title    = 'Ouvrir Portes',
										align    = 'top-left',
										elements = {
											{label = 'Ouvrir porte gauche',     value = 'menuperso_vehicule_ouvrirportes_ouvrirportegauche'},
											{label = 'Ouvrir porte droite',     value = 'menuperso_vehicule_ouvrirportes_ouvrirportedroite'},
											{label = 'Ouvrir porte arriere gauche',     value = 'menuperso_vehicule_ouvrirportes_ouvrirportearrieregauche'},
											{label = 'Ouvrir porte arriere droite',     value = 'menuperso_vehicule_ouvrirportes_ouvrirportearrieredroite'},
											{label = 'Ouvrir capot',     value = 'menuperso_vehicule_ouvrirportes_ouvrircapot'},
											{label = 'Ouvrir coffre',     value = 'menuperso_vehicule_ouvrirportes_ouvrircoffre'},
											{label = 'Ouvrir autre 1',     value = 'menuperso_vehicule_ouvrirportes_ouvrirAutre1'},
											{label = 'Ouvrir autre 2',     value = 'menuperso_vehicule_ouvrirportes_ouvrirAutre2'},
											{label = 'Ouvrir TOUT',     value = 'menuperso_vehicule_ouvrirportes_ouvrirTout'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirportegauche' then
											local porte = 0
											vehicule_ouvrirporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirportedroite' then
											local porte = 1
											vehicule_ouvrirporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirportearrieregauche' then
											local porte = 2
											vehicule_ouvrirporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirportearrieredroite' then
											local porte = 3
											vehicule_ouvrirporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_ouvrirportes_ouvrircapot' then
											local porte = 4
											vehicule_ouvrirporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_ouvrirportes_ouvrircoffre' then
											local porte = 5
											vehicule_ouvrirporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirAutre1' then
											local porte = 6
											vehicule_ouvrirporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirAutre2' then
											local porte = 7
											vehicule_ouvrirporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_ouvrirportes_ouvrirTout' then
											local porte = 99
											vehicule_ouvrirporte(porte)
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end

							if data2.current.value == 'menuperso_vehicule_fermerportes' then
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'menuperso_vehicule_fermerportes',
									{
										title    = 'Fermer Portes',
										align    = 'top-left',
										elements = {
											{label = 'Fermer porte gauche',     value = 'menuperso_vehicule_fermerportes_fermerportegauche'},
											{label = 'Fermer porte droite',     value = 'menuperso_vehicule_fermerportes_fermerportedroite'},
											{label = 'Fermer porte arriere gauche',     value = 'menuperso_vehicule_fermerportes_fermerportearrieregauche'},
											{label = 'Fermer porte arriere droite',     value = 'menuperso_vehicule_fermerportes_fermerportearrieredroite'},
											{label = 'Fermer capot',     value = 'menuperso_vehicule_fermerportes_fermercapot'},
											{label = 'Fermer coffre',     value = 'menuperso_vehicule_fermerportes_fermercoffre'},
											{label = 'Fermer autre 1',     value = 'menuperso_vehicule_fermerportes_fermerAutre1'},
											{label = 'Fermer autre 2',     value = 'menuperso_vehicule_fermerportes_fermerAutre2'},
											{label = 'Fermer TOUT',     value = 'menuperso_vehicule_fermerportes_fermerTout'},
										},
									},
									function(data3, menu3)

										if data3.current.value == 'menuperso_vehicule_fermerportes_fermerportegauche' then
											local porte = 0
											vehicule_fermerporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_fermerportes_fermerportedroite' then
											local porte = 1
											vehicule_fermerporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_fermerportes_fermerportearrieregauche' then
											local porte = 2
											vehicule_fermerporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_fermerportes_fermerportearrieredroite' then
											local porte = 3
											vehicule_fermerporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_fermerportes_fermercapot' then
											local porte = 4
											vehicule_fermerporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_fermerportes_fermercoffre' then
											local porte = 5
											vehicule_fermerporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_fermerportes_fermerAutre1' then
											local porte = 6
											vehicule_fermerporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_fermerportes_fermerAutre2' then
											local porte = 7
											vehicule_fermerporte(porte)
										end

										if data3.current.value == 'menuperso_vehicule_fermerportes_fermerTout' then
											local porte = 99
											vehicule_fermerporte(porte)
										end

									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							end							
							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)

				end

				if data.current.value == 'menuperso_gpsrapide' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_gpsrapide',
						{
							title    = 'GPS Rapide',
							align    = 'top-left',
							elements = {
								{label = 'Pôle emploi',     value = 'menuperso_gpsrapide_poleemploi'},
								{label = 'Comissariat Principal',              value = 'menuperso_gpsrapide_comico'},
								{label = 'Hopital Principal', value = 'menuperso_gpsrapide_hopital'},
								{label = 'Concessionnaire',  value = 'menuperso_gpsrapide_concessionnaire'}
							},
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_gpsrapide_poleemploi' then
								x, y, z = -259.08557128906, -974.677734375, 31.220008850098
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajouté au GPS !")
							end

							if data2.current.value == 'menuperso_gpsrapide_comico' then
								x, y, z = -44.385055541992, -1109.7479248047, 26.437595367432
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajouté au GPS !")
							end

							if data2.current.value == 'menuperso_gpsrapide_hopital' then
								x, y, z = 430.91763305664, -980.24694824218, 31.710563659668
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajouté au GPS !")
							end

							if data2.current.value == 'menuperso_gpsrapide_concessionnaire' then
								x, y, z = 336.87603759766, -1396.2689208984, 23.509273529053
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								ESX.ShowNotification("Destination ajouté au GPS !")
							end

							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)

				end
				
				if data.current.value == 'menuperso_grade' then
					ESX.UI.Menu.Open(
						'default', GetCurrentResourceName(), 'menuperso_grade',
						{
							title    = 'Grade',
							align    = 'top-left',
							elements = {
								{label = 'Recruter',     value = 'menuperso_grade_recruter'},
								{label = 'Virer',              value = 'menuperso_grade_virer'},
								{label = 'Promouvoir', value = 'menuperso_grade_promouvoir'},
								{label = 'Destituer',  value = 'menuperso_grade_destituer'}
							},
						},
						function(data2, menu2)

							if data2.current.value == 'menuperso_grade_recruter' then
								if PlayerData.job.grade_name == 'boss' then
										local job =  PlayerData.job.name
										local grade = 0
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("Aucun joueur à proximité")
									else
										TriggerServerEvent('NB:recruterplayer', GetPlayerServerId(closestPlayer), job,grade)
									end

								else
									Notify("Vous n'avez pas les ~r~droits~w~.")

								end
								
							end

							if data2.current.value == 'menuperso_grade_virer' then
								if PlayerData.job.grade_name == 'boss' then
										local job =  PlayerData.job.name
										local grade = 0
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("Aucun joueur à proximité")
									else
										TriggerServerEvent('NB:virerplayer', GetPlayerServerId(closestPlayer))
									end

								else
									Notify("Vous n'avez pas les ~r~droits~w~.")

								end
								
							end

							if data2.current.value == 'menuperso_grade_promouvoir' then

								if PlayerData.job.grade_name == 'boss' then
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("Aucun joueur à proximité")
									else
										TriggerServerEvent('NB:promouvoirplayer', GetPlayerServerId(closestPlayer))
									end

								else
									Notify("Vous n'avez pas les ~r~droits~w~.")

								end
								
								
							end

							if data2.current.value == 'menuperso_grade_destituer' then

								if PlayerData.job.grade_name == 'boss' then
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
									if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("Aucun joueur à proximité")
									else
										TriggerServerEvent('NB:destituerplayer', GetPlayerServerId(closestPlayer))
									end

								else
									Notify("Vous n'avez pas les ~r~droits~w~.")

								end
								
								
							end

							
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end	
				
				
			end,
			function(data, menu)
				menu.close()
			end
		)
		
	end)
end
	

---------------------------------------------------------------------------Modération

-- GOTO JOUEUR
function admin_tp_toplayer()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez l'id du joueur...")
	inputgoto = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputgoto == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputgoto = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputgoto = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputgoto = 0
			end
		end
		if inputgoto == 2 then
        --local x,y,z = getPosition()
		local gotoply = GetOnscreenKeyboardResult()
        --local tplayer = GetPlayerPed(GetPlayerFromServerId(id))
        --x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(gotoply) , true))
        -- x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(gotoply) , true)))
        -- SetEntityCoords(GetPlayerPed(-1), x+0.0001, y+0.0001, z+0.0001, 1, 0, 0, 1)
	    local playerPed = GetPlayerPed(-1)
	    local teleportPed = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tonumber(gotoply))))
	    SetEntityCoords(playerPed, teleportPed)
		
        inputgoto = 0
		end
	end
end)
-- FIN GOTO JOUEUR

-- TP UN JOUEUR A MOI
function admin_tp_playertome()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez l'id du joueur...")
	inputteleport = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputteleport == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputteleport = 0
			elseif UpdateOnscreenKeyboard() == 1 then
				inputteleport = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputteleport = 0
			end
		end
		if inputteleport == 2 then
		local teleportply = GetOnscreenKeyboardResult()
	    local playerPed = GetPlayerFromServerId(tonumber(teleportply))
	    local teleportPed = GetEntityCoords(GetPlayerPed(-1))
	    SetEntityCoords(playerPed, teleportPed)
		inputteleport = 0
		end
	end
end)
-- FIN TP UN JOUEUR A MOI

-- TP A POSITION
function admin_tp_pos()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez la position...")
	inputpos = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputpos == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputpos = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputpos = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputpos = 0
			end
		end
		if inputpos == 2 then
			local pos = GetOnscreenKeyboardResult() -- GetOnscreenKeyboardResult RECUPERE LA POSITION RENTRER PAR LE JOUEUR
			local _,_,x,y,z = string.find( pos or "0,0,0", "([%d%.]+),([%d%.]+),([%d%.]+)" )
			
			--SetEntityCoords(GetPlayerPed(-1), x, y, z)
		    SetEntityCoords(GetPlayerPed(-1), x+0.0001, y+0.0001, z+0.0001) -- TP LE JOUEUR A LA POSITION
			inputpos = 0
		end
	end
end)
-- FIN TP A POSITION

-- FONCTION NOCLIP 
local noclip = false
local noclip_speed = 1.0

function admin_no_clip()
  noclip = not noclip
  local ped = GetPlayerPed(-1)
  if noclip then -- activé
    SetEntityInvincible(ped, true)
    SetEntityVisible(ped, false, false)
	Notify("Noclip ~g~activé")
  else -- désactivé
    SetEntityInvincible(ped, false)
    SetEntityVisible(ped, true, false)
	Notify("Noclip ~r~désactivé")
  end
end

function getPosition()
  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
  return x,y,z
end

function getCamDirection()
  local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
  local pitch = GetGameplayCamRelativePitch()

  local x = -math.sin(heading*math.pi/180.0)
  local y = math.cos(heading*math.pi/180.0)
  local z = math.sin(pitch*math.pi/180.0)

  local len = math.sqrt(x*x+y*y+z*z)
  if len ~= 0 then
    x = x/len
    y = y/len
    z = z/len
  end

  return x,y,z
end

function isNoclip()
  return noclip
end

-- noclip/invisible
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if noclip then
      local ped = GetPlayerPed(-1)
      local x,y,z = getPosition()
      local dx,dy,dz = getCamDirection()
      local speed = noclip_speed

      -- reset du velocity
      SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)

      -- aller vers le haut
      if IsControlPressed(0,32) then -- MOVE UP
        x = x+speed*dx
        y = y+speed*dy
        z = z+speed*dz
      end

      -- aller vers le bas
      if IsControlPressed(0,269) then -- MOVE DOWN
        x = x-speed*dx
        y = y-speed*dy
        z = z-speed*dz
      end

      SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
    end
  end
end)
-- FIN NOCLIP

-- GOD MODE
function admin_godmode()
  godmode = not godmode
  local ped = GetPlayerPed(-1)
  
  if godmode then -- activé
		SetEntityInvincible(ped, true)
		Notify("GodMode ~g~activé")
	else
		SetEntityInvincible(ped, false)
		Notify("GodMode ~r~désactivé")
  end
end
-- FIN GOD MODE

-- INVISIBLE
function admin_mode_fantome()
  invisible = not invisible
  local ped = GetPlayerPed(-1)
  
  if invisible then -- activé
		SetEntityVisible(ped, false, false)
		Notify("Mode fantôme : activé")
	else
		SetEntityVisible(ped, true, false)
		Notify("Mode fantôme : désactivé")
  end
end
-- FIN INVISIBLE

-- Réparer vehicule
function admin_vehicle_repair()

    local ped = GetPlayerPed(-1)
    local car = GetVehiclePedIsUsing(ped)
	
		SetVehicleFixed(car)
		SetVehicleDirtLevel(car, 0.0)

end
-- FIN Réparer vehicule

-- Spawn vehicule
function admin_vehicle_spawn()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez le nom du véhicule...")
	inputvehicle = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputvehicle == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputvehicle = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputvehicle = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputvehicle = 0
			end
		end
		if inputvehicle == 2 then
		local vehicleidd = GetOnscreenKeyboardResult()

				local car = GetHashKey(vehicleidd)
				
				Citizen.CreateThread(function()
					Citizen.Wait(10)
					RequestModel(car)
					while not HasModelLoaded(car) do
						Citizen.Wait(0)
					end
                    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
					veh = CreateVehicle(car, x,y,z, 0.0, true, false)
					SetEntityVelocity(veh, 2000)
					SetVehicleOnGroundProperly(veh)
					SetVehicleHasBeenOwnedByPlayer(veh,true)
					local id = NetworkGetNetworkIdFromEntity(veh)
					SetNetworkIdCanMigrate(id, true)
					SetVehRadioStation(veh, "OFF")
					SetPedIntoVehicle(GetPlayerPed(-1),  veh,  -1)
					Notify("Véhicule spawn, bonne route")
				end)
		
        inputvehicle = 0
		end
	end
end)
-- FIN Spawn vehicule

-- Spawn vehicule
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputvehicle == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputvehicle = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputvehicle = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputvehicle = 0
			end
		end
		if inputvehicle == 2 then
		local vehicleidd = GetOnscreenKeyboardResult()

				local car = GetHashKey(vehicleidd)
				
				Citizen.CreateThread(function()
					Citizen.Wait(10)
					RequestModel(car)
					while not HasModelLoaded(car) do
						Citizen.Wait(0)
					end
                    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
					veh = CreateVehicle(car, x,y,z, 0.0, true, false)
					SetEntityVelocity(veh, 2000)
					SetVehicleOnGroundProperly(veh)
					SetVehicleHasBeenOwnedByPlayer(veh,true)
					local id = NetworkGetNetworkIdFromEntity(veh)
					SetNetworkIdCanMigrate(id, true)
					SetVehRadioStation(veh, "OFF")
					SetPedIntoVehicle(GetPlayerPed(-1),  veh,  -1)
					Notify("Véhicule spawn, bonne route")
				end)
		
        inputvehicle = 0
		end
	end
end)
-- FIN Spawn vehicule

-- flipVehicle
function admin_vehicle_flip()

    local player = GetPlayerPed(-1)
    posdepmenu = GetEntityCoords(player)
    carTargetDep = GetClosestVehicle(posdepmenu['x'], posdepmenu['y'], posdepmenu['z'], 10.0,0,70)
	if carTargetDep ~= nil then
			platecarTargetDep = GetVehicleNumberPlateText(carTargetDep)
	end
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    playerCoords = playerCoords + vector3(0, 2, 0)
	
	SetEntityCoords(carTargetDep, playerCoords)
	
	Notify("Voiture retourné")

end
-- FIN flipVehicle

-- GIVE DE L'ARGENT
function admin_give_money()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez le montant a vous GIVE...")
	inputmoney = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputmoney == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputmoney = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputmoney = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputmoney = 0
			end
		end
		if inputmoney == 2 then
			local repMoney = GetOnscreenKeyboardResult()
			local money = tonumber(repMoney)
			
			TriggerServerEvent('AdminMenu:giveCash', money)
			inputmoney = 0
		end
	end
end)
-- FIN GIVE DE L'ARGENT

-- GIVE DE L'ARGENT EN BANQUE
function admin_give_bank()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez le montant a vous GIVE...")
	inputmoneybank = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputmoneybank == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputmoneybank = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputmoneybank = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputmoneybank = 0
			end
		end
		if inputmoneybank == 2 then
			local repMoney = GetOnscreenKeyboardResult()
			local money = tonumber(repMoney)
			
			TriggerServerEvent('AdminMenu:giveBank', money)
			inputmoneybank = 0
		end
	end
end)
-- FIN GIVE DE L'ARGENT EN BANQUE

-- GIVE DE L'ARGENT SALE
function admin_give_dirty()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez le montant a vous GIVE...")
	inputmoneydirty = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputmoneydirty == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputmoneydirty = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputmoneydirty = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputmoneydirty = 0
			end
		end
		if inputmoneydirty == 2 then
			local repMoney = GetOnscreenKeyboardResult()
			local money = tonumber(repMoney)
			
			TriggerServerEvent('AdminMenu:giveDirtyMoney', money)
			inputmoneydirty = 0
		end
	end
end)
-- FIN GIVE DE L'ARGENT SALE

-- Afficher Coord
function modo_showcoord()
	if showcoord then
		showcoord = false
	else
		showcoord = true
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		
		if showcoord then
			local playerPos = GetEntityCoords(GetPlayerPed(-1))
			local playerHeading = GetEntityHeading(GetPlayerPed(-1))
			Text("~r~X~s~: " ..playerPos.x.." ~b~Y~s~: " ..playerPos.y.." ~g~Z~s~: " ..playerPos.z.." ~y~Angle~s~: " ..playerHeading.."")
		end
		
	end
end)
-- FIN Afficher Coord

-- Afficher Nom
function modo_showname()
	if showname then
		showname = false
	else
		Notify("Ouvrir et fermer le menu pause pour afficher les nom")
		showname = true
	end
end

Citizen.CreateThread(function()
	while true do
		Wait( 1 )
		if showname then
			for id = 0, 200 do
				if NetworkIsPlayerActive( id ) and GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
					ped = GetPlayerPed( id )
					blip = GetBlipFromEntity( ped )
					headId = Citizen.InvokeNative( 0xBFEFE3321A3F5015, ped, (GetPlayerServerId( id )..' - '..GetPlayerName( id )), false, false, "", false )
				end
			end
		else
			for id = 0, 200 do
				if NetworkIsPlayerActive( id ) and GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
					ped = GetPlayerPed( id )
					blip = GetBlipFromEntity( ped )
					headId = Citizen.InvokeNative( 0xBFEFE3321A3F5015, ped, (' '), false, false, "", false )
				end
			end
		end
	end
end)
-- FIN Afficher Nom

-- TP MARCKER
function admin_tp_marcker()
	
	ESX.TriggerServerCallback('NB:getUsergroup', function(group)
		playergroup = group
		
		if playergroup == 'admin' or playergroup == 'owner' then
			local playerPed = GetPlayerPed(-1)
			local WaypointHandle = GetFirstBlipInfoId(8)
			if DoesBlipExist(WaypointHandle) then
				local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
				--SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, coord.z, false, false, false, true)
				SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.5, false, false, false, true)
				Notify("Téléporté sur le marcker !")
			else
				Notify("Pas de marcker sur la map !")
			end
		end
		
	end)
end
-- FIN TP MARCKER

-- HEAL JOUEUR
function admin_heal_player()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez l'id du joueur...")
	inputheal = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputheal == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputheal = 0
			elseif UpdateOnscreenKeyboard() == 1 then
				inputheal = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputheal = 0
			end
		end
		if inputheal == 2 then
		local healply = GetOnscreenKeyboardResult()
		TriggerServerEvent('esx_ambulancejob:revive', healply)
		
        inputheal = 0
		end
	end
end)
-- FIN HEAL JOUEUR

-- SPEC JOUEUR
function admin_spec_player()
	DisplayOnscreenKeyboard(true, "FMMC_KEY_TIP8", "", "", "", "", "", 120)
	Notify("~b~Entrez l'id du joueur...")
	inputspec = 1
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputspec == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputspec = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputspec = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputspec = 0
			end
		end
		if inputspec == 2 then
		local target = GetOnscreenKeyboardResult()
		
		TriggerEvent('es_camera:spectate', source, target)
		
        inputspec = 0
		end
	end
end)
-- FIN SPEC JOUEUR

---------------------------------------------------------------------------Me concernant

function openTelephone()
	TriggerEvent('NB:closeAllSubMenu')
	TriggerEvent('NB:closeAllMenu')
	TriggerEvent('NB:closeMenuKey')
	
	TriggerEvent('NB:openMenuTelephone')
end

function openInventaire()
	TriggerEvent('NB:closeAllSubMenu')
	TriggerEvent('NB:closeAllMenu')
	TriggerEvent('NB:closeMenuKey')
	
	TriggerEvent('NB:openMenuInventaire')
end

function openFacture()
	TriggerEvent('NB:closeAllSubMenu')
	TriggerEvent('NB:closeAllMenu')
	TriggerEvent('NB:closeMenuKey')
	
	TriggerEvent('NB:openMenuFactures')
end

---------------------------------------------------------------------------Actions

local playAnim = false
local dataAnim = {}

function animsAction(animObj)
	if (IsInVehicle()) then
		local source = GetPlayerServerId();
		ESX.ShowNotification("Sortez de votre véhicule pour faire cela !")
	else
		Citizen.CreateThread(function()
			if not playAnim then
				local playerPed = GetPlayerPed(-1);
				if DoesEntityExist(playerPed) then -- Ckeck if ped exist
					dataAnim = animObj

					-- Play Animation
					RequestAnimDict(dataAnim.lib)
					while not HasAnimDictLoaded(dataAnim.lib) do
						Citizen.Wait(0)
					end
					if HasAnimDictLoaded(dataAnim.lib) then
						local flag = 0
						if dataAnim.loop ~= nil and dataAnim.loop then
							flag = 1
						elseif dataAnim.move ~= nil and dataAnim.move then
							flag = 49
						end

						TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
						playAnimation = true
					end

					-- Wait end annimation
					while true do
						Citizen.Wait(0)
						if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
							playAnim = false
							TriggerEvent('ft_animation:ClFinish')
							break
						end
					end
				end -- end ped exist
			end
		end)
	end
end
	

function animsActionScenario(animObj)
	if (IsInVehicle()) then
		local source = GetPlayerServerId();
		ESX.ShowNotification("Sortez de votre véhicule pour faire cela !")
	else
		Citizen.CreateThread(function()
			if not playAnim then
				local playerPed = GetPlayerPed(-1);
				if DoesEntityExist(playerPed) then
					dataAnim = animObj
					TaskStartScenarioInPlace(playerPed, dataAnim.anim, 0, false)
					playAnimation = true
				end
			end
		end)
	end
end

---------------------------------------------------------------------------Véhicule

function vehicule_Moteur(Action)
	if (IsInVehicle()) then
		local vehicle = GetVehiclePedIsIn( GetPlayerPed(-1), false )
		if ( GetPedInVehicleSeat( vehicle, -1 ) == GetPlayerPed(-1) ) then
			SetVehicleEngineOn(vehicle, Action, false, true)
			if Action then
				SetVehicleUndriveable(vehicle, false)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Moteur démarré !")
			else
				SetVehicleUndriveable(vehicle, true)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Moteur coupé !")
			end
		else
			local source = GetPlayerServerId();
				ESX.ShowNotification("Vous devez etre a la place du conducteur !")
		end
	else
		local source = GetPlayerServerId();
				ESX.ShowNotification("Vous devez etre dans un véhicule !")
	end
end

function OuvrirLaPorte(porte, vehicle)
	SetVehicleDoorOpen(vehicle, porte, false, false)
end

function OuvrirTOUTPorte(porte, vehicle)
	SetVehicleDoorOpen(vehicle, 0, false, false)
	SetVehicleDoorOpen(vehicle, 1, false, false)
	SetVehicleDoorOpen(vehicle, 2, false, false)
	SetVehicleDoorOpen(vehicle, 3, false, false)
	SetVehicleDoorOpen(vehicle, 4, false, false)
	SetVehicleDoorOpen(vehicle, 5, false, false)
	SetVehicleDoorOpen(vehicle, 6, false, false)
	SetVehicleDoorOpen(vehicle, 7, false, false)
end

function vehicule_ouvrirporte(porte)
	if (IsInVehicle()) then
		local vehicle = GetVehiclePedIsIn( GetPlayerPed(-1), false )
		if ( GetPedInVehicleSeat( vehicle, -1 ) == GetPlayerPed(-1) ) then
			if porte == 0 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Porte avant gauche : Ouverte")
			elseif porte == 1 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Porte avant droite : Ouverte")
			elseif porte == 2 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Porte arrière gauche : Ouverte")
			elseif porte == 3 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Porte arrière droite : Ouverte")
			elseif porte == 4 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Capot : Ouvert")
			elseif porte == 5 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Capot : Ouvert")
			elseif porte == 6 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Autre 1 : Ouvert")
			elseif porte == 7 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Autre 2 : Ouvert")
			elseif porte == 99 then
				OuvrirTOUTPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Tout : Ouvert")
			end
		else
			local source = GetPlayerServerId();
			ESX.ShowNotification("Vous devez etre a la place du conducteur !")
		end
	else
		local source = GetPlayerServerId();
		ESX.ShowNotification("Vous devez etre dans un véhicule pour faire cela !")
	end
end

function FermerLaPorte(porte, vehicle)
	SetVehicleDoorShut(vehicle, porte, false, false)
end

function FermerTOUTPorte(porte, vehicle)
	SetVehicleDoorShut(vehicle, 0, false, false)
	SetVehicleDoorShut(vehicle, 1, false, false)
	SetVehicleDoorShut(vehicle, 2, false, false)
	SetVehicleDoorShut(vehicle, 3, false, false)
	SetVehicleDoorShut(vehicle, 4, false, false)
	SetVehicleDoorShut(vehicle, 5, false, false)
	SetVehicleDoorShut(vehicle, 6, false, false)
	SetVehicleDoorShut(vehicle, 7, false, false)
end

function vehicule_fermerporte(porte)
	if (IsInVehicle()) then
		local vehicle = GetVehiclePedIsIn( GetPlayerPed(-1), false )
		if ( GetPedInVehicleSeat( vehicle, -1 ) == GetPlayerPed(-1) ) then
			if porte == 0 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Porte avant gauche : Fermé")
			elseif porte == 1 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Porte avant droite : Fermé")
			elseif porte == 2 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Porte arrière gauche : Fermé")
			elseif porte == 3 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Porte arrière droite : Fermé")
			elseif porte == 4 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Capot : Fermé")
			elseif porte == 5 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Capot : Fermé")
			elseif porte == 6 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Autre 1 : Fermé")
			elseif porte == 7 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Autre 2 : Fermé")
			elseif porte == 99 then
				FermerTOUTPorte(porte, vehicle)
				local source = GetPlayerServerId();
				ESX.ShowNotification("Tout : Fermé")
			end
		else
			local source = GetPlayerServerId();
			ESX.ShowNotification("Vous devez etre a la place du conducteur !")
		end
	else
		local source = GetPlayerServerId();
		ESX.ShowNotification("Vous devez etre dans un véhicule pour faire cela !")
	end
end

-- Verifie si le joueurs est dans un vehicule ou pas
function IsInVehicle()
	local ply = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(ply) then
		return true
	else
		return false
	end
end

function changer_skin()
	TriggerEvent('esx_skin:openSaveableMenu', source)
end

function save_skin()
	TriggerEvent('esx_skin:requestSaveSkin', source)
end

---------------------------------------------------------------------------------------------------------
--NB : gestion des menu
---------------------------------------------------------------------------------------------------------

RegisterNetEvent('NB:goTpMarcker')
AddEventHandler('NB:goTpMarcker', function()
	admin_tp_marcker()
end)

RegisterNetEvent('NB:openMenuPersonnel')
AddEventHandler('NB:openMenuPersonnel', function()
	OpenPersonnelMenu()
end)

RegisterNetEvent('NB:closeMenuPersonnel')
AddEventHandler('NB:closeMenuPersonnel', function()

	if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuperso_moi') then
		ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'menuperso_moi')
		
	elseif ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuperso_actions') then
		if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuperso_actions_Salute') then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'menuperso_actions_Salute')
		elseif ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuperso_actions_Humor') then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'menuperso_actions_Humor')
		elseif ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuperso_actions_Travail') then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'menuperso_actions_Travail')
		elseif ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuperso_actions_Festives') then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'menuperso_actions_Festives')
		elseif ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuperso_actions_Others') then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'menuperso_actions_Others')
		end
		ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'menuperso_actions')
		
	elseif ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuperso_vehicule') then
		if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuperso_vehicule_ouvrirportes') then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'menuperso_vehicule_ouvrirportes')
		elseif ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuperso_vehicule_fermerportes') then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'menuperso_vehicule_fermerportes')
		end
		ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'menuperso_vehicule')
		
	elseif ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuperso_gpsrapide') then
		ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'menuperso_gpsrapide')
		
	elseif ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuperso_grade') then
		ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'menuperso_grade')
		
	elseif ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menuperso_modo') then
		ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'menuperso_modo')
		
	end
end)

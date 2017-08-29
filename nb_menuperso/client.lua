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

function OpenPersonnelMenu()
		
	ESX.UI.Menu.CloseAll()
		
		local elements = {}
		
		table.insert(elements, {label = 'Me concernant',		value = 'menuperso_moi'})
		table.insert(elements, {label = 'Actions',					value = 'menuperso_actions'})
		table.insert(elements, {label = 'Véhicule',					value = 'menuperso_vehicule'})
		table.insert(elements, {label = 'GPS Rapide',			value = 'menuperso_gpsrapide'})
		table.insert(elements, {label = 'Grade',			value = 'menuperso_grade'})
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'menu_perso',
			{
				title    = 'Menu Personnel',
				align    = 'top-left',
				elements = elements
			},
			function(data, menu)

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
								Notify("Destination ajouté au GPS !")
							end

							if data2.current.value == 'menuperso_gpsrapide_comico' then
								x, y, z = -44.385055541992, -1109.7479248047, 26.437595367432
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								Notify("Destination ajouté au GPS !")
							end

							if data2.current.value == 'menuperso_gpsrapide_hopital' then
								x, y, z = 430.91763305664, -980.24694824218, 31.710563659668
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								Notify("Destination ajouté au GPS !")
							end

							if data2.current.value == 'menuperso_gpsrapide_concessionnaire' then
								x, y, z = 336.87603759766, -1396.2689208984, 23.509273529053
								SetNewWaypoint(x, y, z)
								local source = GetPlayerServerId();
								Notify("Destination ajouté au GPS !")
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
										TriggerServerEvent('esx:recruterplayer', GetPlayerServerId(closestPlayer), job,grade)
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
										TriggerServerEvent('esx:virerplayer', GetPlayerServerId(closestPlayer))
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
										TriggerServerEvent('esx:promouvoirplayer', GetPlayerServerId(closestPlayer))
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
										TriggerServerEvent('esx:destituerplayer', GetPlayerServerId(closestPlayer))
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
end

---------------------------------------------------------------------------Me concernant

function openTelephone()
	TriggerEvent('nb:closeAllSubMenu')
	TriggerEvent('nb:closeAllMenu')
	TriggerEvent('nb:openMenuTelephone')
end

function openInventaire()
	TriggerEvent('nb:closeAllSubMenu')
	TriggerEvent('nb:closeAllMenu')
	TriggerEvent('nb:openMenuInventaire')
end

function openFacture()
	TriggerEvent('nb:closeAllSubMenu')
	TriggerEvent('nb:closeAllMenu')
	TriggerEvent('nb:openMenuFactures')
end



l


---------------------------------------------------------------------------Actions

local playAnim = false
local dataAnim = {}

function animsAction(animObj)
	if (IsInVehicle()) then
		local source = GetPlayerServerId();
		Notify("Sortez de votre véhicule pour faire cela !")
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
		Notify("Sortez de votre véhicule pour faire cela !")
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
				Notify("Moteur démarré !")
			else
				SetVehicleUndriveable(vehicle, true)
				local source = GetPlayerServerId();
				Notify("Moteur coupé !")
			end
		else
			local source = GetPlayerServerId();
			Notify("Vous devez etre a la place du conducteur !")
		end
	else
		local source = GetPlayerServerId();
		Notify("Vous devez etre dans un véhicule pour faire cela !")
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
				Notify("Porte avant gauche : Ouverte")
			elseif porte == 1 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Porte avant droite : Ouverte")
			elseif porte == 2 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Porte arrière gauche : Ouverte")
			elseif porte == 3 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Porte arrière droite : Ouverte")
			elseif porte == 4 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Capot : Ouvert")
			elseif porte == 5 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Capot : Ouvert")
			elseif porte == 6 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Autre 1 : Ouvert")
			elseif porte == 7 then
				OuvrirLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Autre 2 : Ouvert")
			elseif porte == 99 then
				OuvrirTOUTPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Tout : Ouvert")
			end
		else
			local source = GetPlayerServerId();
			Notify("Vous devez etre a la place du conducteur !")
		end
	else
		local source = GetPlayerServerId();
		Notify("Vous devez etre dans un véhicule pour faire cela !")
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
				Notify("Porte avant gauche : Fermé")
			elseif porte == 1 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Porte avant droite : Fermé")
			elseif porte == 2 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Porte arrière gauche : Fermé")
			elseif porte == 3 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Porte arrière droite : Fermé")
			elseif porte == 4 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Capot : Fermé")
			elseif porte == 5 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Capot : Fermé")
			elseif porte == 6 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Autre 1 : Fermé")
			elseif porte == 7 then
				FermerLaPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Autre 2 : Fermé")
			elseif porte == 99 then
				FermerTOUTPorte(porte, vehicle)
				local source = GetPlayerServerId();
				Notify("Tout : Fermé")
			end
		else
			local source = GetPlayerServerId();
			Notify("Vous devez etre a la place du conducteur !")
		end
	else
		local source = GetPlayerServerId();
		Notify("Vous devez etre dans un véhicule pour faire cela !")
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

---------------------------------------------------------------------------------------------------------
--NB : Fermeture des sous menu
---------------------------------------------------------------------------------------------------------

RegisterNetEvent('nb:openMenuPersonnel')
AddEventHandler('nb:openMenuPersonnel', function()
	OpenPersonnelMenu()
end)

RegisterNetEvent('nb:closeMenuPersonnel')
AddEventHandler('nb:closeMenuPersonnel', function()

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
		
	end
end)

--------------------------------------------------------------------------------------------
-- NB : gestion des touches menu
--------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Wait(0)
--------------------------------------------------------------------------------------------
-- Menu personnel -> nb_menuperso
--------------------------------------------------------------------------------------------
		
		if (IsControlPressed(0,  Keys["F5"]) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menu_perso') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			TriggerEvent('nb:openMenuPersonnel')
			GUI.Time  = GetGameTimer()
		end
		
		if (IsControlPressed(0,  Keys["F5"]) and ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menu_perso') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			GUI.Time  = GetGameTimer()
		end
		
--------------------------------------- MANETTE
		
		if (IsControlPressed(1, Keys["SPACE"]) and IsControlPressed(0, Keys["TOP"]) and not ESX.UI.Menu.IsOpen('default',  GetCurrentResourceName(), 'menu_perso') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			TriggerEvent('nb:openMenuPersonnel')
			GUI.Time  = GetGameTimer()
		end
		
		if (IsControlPressed(1, Keys["SPACE"]) and IsControlPressed(0, Keys["TOP"]) and ESX.UI.Menu.IsOpen('default',  GetCurrentResourceName(), 'menu_perso') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			GUI.Time  = GetGameTimer()
		end

--------------------------------------------------------------------------------------------
-- Menu inventaire -> es_extended
--------------------------------------------------------------------------------------------

		if (IsControlPressed(1, Keys["LEFTSHIFT"]) and IsControlPressed(0, Keys["G"]) and not ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') and (GetGameTimer() - GUI.Time) > 150)  then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			TriggerEvent('nb:openMenuInventaire')
			GUI.Time = GetGameTimer()
		end
		
		if (IsControlPressed(1, Keys["LEFTSHIFT"]) and IsControlPressed(0, Keys["G"]) and ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') and (GetGameTimer() - GUI.Time) > 150)  then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			GUI.Time  = GetGameTimer()
		end

--------------------------------------------------------------------------------------------
-- Menu telephone -> esx_phone
--------------------------------------------------------------------------------------------
		
		if (IsControlPressed(1, Keys["LEFTSHIFT"]) and IsControlPressed(0, Keys["U"]) and not ESX.UI.Menu.IsOpen('phone', 'esx_phone', 'main') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			TriggerEvent('nb:openMenuTelephone')
			GUI.Time = GetGameTimer()
		end
		
		if (IsControlPressed(1, Keys["LEFTSHIFT"]) and IsControlPressed(0, Keys["U"]) and not ESX.UI.Menu.IsOpen('phone', 'esx_phone', 'main') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			GUI.Time = GetGameTimer()
		end

--------------------------------------------------------------------------------------------
-- Menu factures -> esx_billing
--------------------------------------------------------------------------------------------
		
		if (IsControlPressed(1, Keys["LEFTSHIFT"]) and IsControlPressed(0, Keys["Y"]) and not ESX.UI.Menu.IsOpen('default', 'esx_billing', 'billing') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			TriggerEvent('nb:openMenuFactures')
			GUI.Time = GetGameTimer()
		end

		if (IsControlPressed(1, Keys["LEFTSHIFT"]) and IsControlPressed(0, Keys["Y"]) and ESX.UI.Menu.IsOpen('default', 'esx_billing', 'billing') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			GUI.Time = GetGameTimer()
		end

--------------------------------------------------------------------------------------------
-- Menu police -> esx_policejob
--------------------------------------------------------------------------------------------

		if (IsControlPressed(0, Keys["F6"]) and PlayerData.job ~= nil and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', 'esx_policejob', 'police_actions') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			TriggerEvent('nb:openMenuPolice')
			GUI.Time = GetGameTimer()
		end

  	if (IsControlPressed(0, Keys["F6"]) and PlayerData.job ~= nil and PlayerData.job.name == 'police' and ESX.UI.Menu.IsOpen('default', 'esx_policejob', 'police_actions') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			GUI.Time = GetGameTimer()
		end
		
--------------------------------------- MANETTE
		
		if (IsControlPressed(1, Keys["SPACE"]) and IsControlPressed(0, Keys["DOWN"]) and PlayerData.job ~= nil and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', 'esx_policejob', 'police_actions') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			TriggerEvent('nb:openMenuPolice')
			GUI.Time  = GetGameTimer()
		end
		
		if (IsControlPressed(1, Keys["SPACE"]) and IsControlPressed(0, Keys["DOWN"]) and PlayerData.job ~= nil and PlayerData.job.name == 'police' and ESX.UI.Menu.IsOpen('default', 'esx_policejob', 'police_actions') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			GUI.Time  = GetGameTimer()
		end

--------------------------------------------------------------------------------------------
-- Menu ambulance -> esx_ambulancejob
--------------------------------------------------------------------------------------------

		if (IsControlPressed(0, Keys["F6"]) and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' and not ESX.UI.Menu.IsOpen('default', 'esx_ambulancejob', 'mobile_ambulance_actions') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			TriggerEvent('nb:openMenuAmbulance')
			GUI.Time = GetGameTimer()
		end

		if (IsControlPressed(0, Keys["F6"]) and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' and ESX.UI.Menu.IsOpen('default', 'esx_ambulancejob', 'mobile_ambulance_actions') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			GUI.Time = GetGameTimer()
		end
		
--------------------------------------- MANETTE
		
		if (IsControlPressed(1, Keys["SPACE"]) and IsControlPressed(0, Keys["DOWN"]) and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' and not ESX.UI.Menu.IsOpen('default', 'esx_ambulancejob', 'mobile_ambulance_actions') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			TriggerEvent('nb:openMenuAmbulance')
			GUI.Time  = GetGameTimer()
		end
		
		if (IsControlPressed(1, Keys["SPACE"]) and IsControlPressed(0, Keys["DOWN"]) and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' and ESX.UI.Menu.IsOpen('default', 'esx_ambulancejob', 'mobile_ambulance_actions') and (GetGameTimer() - GUI.Time) > 150) then
			TriggerEvent('nb:closeAllSubMenu')
			TriggerEvent('nb:closeAllMenu')
			GUI.Time  = GetGameTimer()
		end

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
	end
end)

RegisterNetEvent('nb:closeAllSubMenu')
AddEventHandler('nb:closeAllSubMenu', function()
	TriggerEvent('nb:closeMenuAmbulance')
	TriggerEvent('nb:closeMenuPolice')
	TriggerEvent('nb:closeMenuInventaire')
	TriggerEvent('nb:closeMenuPersonnel')
end)

RegisterNetEvent('nb:closeAllMenu')
AddEventHandler('nb:closeAllMenu', function()
	ESX.UI.Menu.CloseAll()
end)
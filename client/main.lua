Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        local playerPed = PlayerPedId()

        if DoesEntityExist(playerPed) then
			--get components
            local armour = GetPedArmour(playerPed)
            local jbib = GetPedDrawableVariation(playerPed, 11)
            local jbibTexture = GetPedTextureVariation(playerPed, 11)
            local task = GetPedDrawableVariation(playerPed, 9)
            local taskTexture = GetPedTextureVariation(playerPed, 9)

            -- Detect gender
            local model = GetEntityModel(playerPed)
            local isMale = (model == GetHashKey("mp_m_freemode_01"))
            local isFemale = (model == GetHashKey("mp_f_freemode_01"))

            -- Detect gamebuild
            local gameBuild = GetGameBuildNumber()

            -- Get list of compatible tasks
			local TaskList = TaskList or require("client.data.tasklist")
			-- Get list of exception tasks
			local ExceptionList = ExceptionList or require("client.data.exceptionlist")
			
            -- Get list of compatible tasks per gender
            local TaskTable = TaskList[isFemale]
			-- Get list of exception tasks per gender
			local ExceptionTable = ExceptionList[isFemale]

            -- Choose correct gamebuild (lowest available <= current used)
            local buildToUse = nil
            for build, _ in pairs(TaskTable) do
                if gameBuild >= build and (not buildToUse or build > buildToUse) then
                    buildToUse = build
                end
            end

            -- Get list of compatible tasks per gender and gamebuild
            local drawables = TaskTable[buildToUse]
			-- Get list of exception tasks per gender and gamebuild
            local exceptiondrawables = ExceptionTable[buildToUse]
			
			--Check if the current task is an exception
            local expectedTask = exceptiondrawables[task] or 0
			
			--find correct task drawable per jbib
			if (expectedTask == 0) then 
				expectedTask = drawables[jbib] or -1
			end
			
			--set expected task texture
			local expectedTaskTexture = taskTexture
			
			--task cannot be changed automatically
            local fixedTask = exceptiondrawables[task] or 0
			
			--set here how you want your texture changing expectedTaskTexture to the one of your liking:
			-- expectedTaskTexture = 0 (gray, perfect for city civilian and gangs)
			-- expectedTaskTexture = 1 (black, perfect for police department)
			-- expectedTaskTexture = 2 (dark green, perfect for sheriff department)
			-- expectedTaskTexture = 3 (brown camouflage, perfect for country civilians and gangs)
			-- expectedTaskTexture = 4 (green camouflage, perfect for military)
			
			--set correct task texture for task 0
			if (expectedTask == 0) then
				expectedTaskTexture = 0
			end
			
			--avoid broken textures in basegame jbib models (extra functionality, can be removed)
			--male broken textures
			if isMale and jbib < 16 then
				--tshirt broken textures
				if jbib == 0 then
					if jbibTexture == 6 then
						jbibTexture = 7
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 9 or jbibTexture == 10 then
						jbibTexture = 11
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 11 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--vneck broken textures
				elseif jbib == 1 then
					if jbibTexture == 2 then
						jbibTexture = 3
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 9 or jbibTexture == 10 then
						jbibTexture = 11
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 13 then
						jbibTexture = 14
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 14 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--top broken textures
				elseif jbib == 2 then
					if jbibTexture ~= 9 then
						jbibTexture = 9
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--coat broken textures
				elseif jbib == 4 then
					if jbibTexture == 1 then
						jbibTexture = 2
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 3 and jbibTexture < 11 then
						jbibTexture = 11
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 12 or jbibTexture == 13 then
						jbibTexture = 14
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 14 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--tank broken textures
				elseif jbib == 5 then
					if jbibTexture > 2 and jbibTexture < 7 then
						jbibTexture = 7
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 7 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--leather jacket broken textures
				elseif jbib == 6 then
					if jbibTexture == 2 then
						jbibTexture = 3
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 3 and jbibTexture < 11 then
						jbibTexture = 11
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 7 then
						jbibTexture = 8
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 10 then
						jbibTexture = 11
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 11 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--tee broken textures
				elseif jbib == 8 then
					if jbibTexture > 0 and jbibTexture < 10 then
						jbibTexture = 10
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 11 or jbibTexture == 12 then
						jbibTexture = 13
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 14 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--polo shirt broken textures
				elseif jbib == 9 then
					if jbibTexture == 8 or jbibTexture == 9 then
						jbibTexture = 10
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--jacket broken textures
				elseif jbib == 10 then
					if jbibTexture > 2 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--vest broken textures
				elseif jbib == 11 then
					if jbibTexture > 1 and jbibTexture < 7 then
						jbibTexture = 7
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 7 and jbibTexture < 14 then
						jbibTexture = 14
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 14 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--untucked broken textures
				elseif jbib == 12 then
					if jbibTexture > 11 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--tucked broken textures
				elseif jbib == 13 then
					if jbibTexture == 4 then
						jbibTexture = 5
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 5 and jbibTexture < 13 then
						jbibTexture = 13
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 13 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				end
			--female broken textures
			elseif isFemale and jbib < 16 then
				--denim jacket broken textures
				if jbib == 1 then
					if jbibTexture == 3 then
						jbibTexture = 4
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 7 or jbibTexture == 8 then
						jbibTexture = 9
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 10 then
						jbibTexture = 11
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 12 or jbibTexture == 13 then
						jbibTexture = 14
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 14 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--hoodie broken textures
				elseif jbib == 3 then
					if jbibTexture > 4 and jbibTexture < 10 then
						jbibTexture = 10
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 14 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--tank broken textures
				elseif jbib == 4 then
					if jbibTexture ~= 13 and jbibTexture ~= 14 then
						jbibTexture = 13
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--cropped tank broken textures
				elseif jbib == 5 then
					if jbibTexture > 1 and jbibTexture < 7 then
						jbibTexture = 7
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 8 then
						jbibTexture = 9
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 9 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--tux broken textures
				elseif jbib == 6 then
					if jbibTexture == 3 then
						jbibTexture = 4
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 4 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--blazer broken textures
				elseif jbib == 7 then
					if jbibTexture > 2 and jbibTexture < 8 then
						jbibTexture = 8
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 8 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--cropped biker broken textures
				elseif jbib == 8 then
					if jbibTexture > 2 and jbibTexture < 12 then
						jbibTexture = 12
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 12 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--shirt broken textures
				elseif jbib == 9 then
					if jbibTexture > 14 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--track jacket broken textures
				elseif jbib == 10 then
					if jbibTexture > 2 and jbibTexture < 7 then
						jbibTexture = 7
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 8 or jbibTexture == 9 then
						jbibTexture = 10
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 12 then
						jbibTexture = 13
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture == 14 then
						jbibTexture = 15
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--racerback broken textures
				elseif jbib == 11 then
					if jbibTexture > 2 and jbibTexture < 10 then
						jbibTexture = 10
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 11 and jbibTexture < 15 then
						jbibTexture = 15
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				elseif jbib == 12 then
					if jbibTexture < 7 or jbibTexture > 9 then
						jbibTexture = 7
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				--bikini broken textures
				elseif jbib == 15 then
					if jbibTexture == 1 or jbibTexture == 2 then
						jbibTexture = 3
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 3 and jbibTexture < 10 then
						jbibTexture = 10
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					elseif jbibTexture > 11 then
						jbibTexture = 0
						SetPedComponentVariation(playerPed, 11, jbib, jbibTexture, 2)
						TriggerServerEvent("taskchecker:syncClothing", 11, jbib, jbibTexture)
					end
				end
			end
			
			--armor jbib variants for old female shirt model (do not remove)
			if isFemale and armour > 0 and (jbib == 9 or jbib == 17) then
				if (jbib == 9) then
					if jbibTexture > 14 then
						jbibTexture = 0
					end
					SetPedComponentVariation(playerPed, 11, 29, jbibTexture, 2)
					TriggerServerEvent("taskchecker:syncClothing", 11, 29, jbibTexture)
				elseif (jbib == 17) then
					SetPedComponentVariation(playerPed, 11, 29, 15, 2)
					TriggerServerEvent("taskchecker:syncClothing", 11, 29, 15)
				end
			elseif isFemale and armour == 0 and (jbib == 29) then
				if (jbibTexture < 15) then
					SetPedComponentVariation(playerPed, 11, 9, jbibTexture, 2)
					TriggerServerEvent("taskchecker:syncClothing", 11, 9, jbibTexture)
				elseif (jbibTexture == 15) then
					SetPedComponentVariation(playerPed, 11, 17, 0, 2)
					TriggerServerEvent("taskchecker:syncClothing", 11, 17, 0)
				end
			end
			
			--if the task is fixed maintain the current texture
			if fixedTask then
				expectedTaskTexture = taskTexture
			end
			
			--if no specified model is applied to the task, set expected texture to 0
			if expectedTaskTexture == -1 then
				expectedTaskTexture = 0
			end
			
            -- Condition 1: no armor and active task
            if armour == 0 and task ~= 0 and expectedTask ~= -1 and fixedTask == 0 and (isMale or isFemale) then
                SetPedComponentVariation(playerPed, 9, 0, 0, 2)
				TriggerServerEvent("taskchecker:syncClothing", 9, 0, 0)
                print("[taskchecker] Compatible armor broken: cleaning task model (taskDrawable 9).")
            -- Condition 2: with armor but has not specific task
            elseif armour > 0 and expectedTask and expectedTask ~= -1 and (task ~= expectedTask or taskTexture ~= expectedTaskTexture) and (isMale or isFemale) then
                SetPedComponentVariation(playerPed, 9, expectedTask, expectedTaskTexture, 2)
				TriggerServerEvent("taskchecker:syncClothing", 9, expectedTask, expectedTaskTexture)
                print("[taskchecker] Compatible armor detected: setting task model (taskDrawable 9) to " .. expectedTask)
            end
        end
    end
end)

RegisterNetEvent("taskchecker:changeClothing", function(playerId, component, drawable, texture)

    local targetPlayer = GetPlayerFromServerId(playerId)
    if targetPlayer ~= -1 then
        local targetPed = GetPlayerPed(targetPlayer)
        if DoesEntityExist(targetPed) then
            SetPedComponentVariation(targetPed, component, drawable, texture, 0)
        end
    end
end)
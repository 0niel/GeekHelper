---------[ Script Meta ]--------------------------------
script_name('GeekHelper')
script_author('Oniel, CzarAlex')
script_version('0.1')

require 'lib.moonloader'
local sampev = require 'lib.samp.events'
local key = require 'vkeys'
local imgui = require 'imgui'
local bNotf, notf = pcall(import, 'imgui_notf.lua')
local inicfg = require 'inicfg'
local fa = require 'faIcons'
encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

---------[ Начальные переменные ]--------------------------------
local vk = nil -- иконка вк
local info = nil -- иконка информации
local rx, ry = getScreenResolution() -- получаем размер экрана
local wx, wy = 550, 350 -- размер окна imgui
local help = imgui.ImBool(false) -- не запускаем при старте

-- Если нет папки fonts - создаем
if not doesDirectoryExist(getWorkingDirectory().."/config/GeekHelper/fonts/") or not doesDirectoryExist(getWorkingDirectory().."/config/GeekHelper/images/") then
	createDirectory(getWorkingDirectory().."/config/GeekHelper/fonts/")
	createDirectory(getWorkingDirectory().."/config/GeekHelper/images/")
end
-- Если нет шрифта - скачаем
if not doesFileExist(getWorkingDirectory().."/config/GeekHelper/fonts/fontawesome.ttf") then
	downloadUrlToFile("http://geekhub.pro/samp/file/GeekHelper/fontawesome-webfont.ttf", getWorkingDirectory().."/config/GeekHelper/fonts/fontawesome.ttf")
end
-- Если нет картинок - скачаем
if not doesFileExist(getWorkingDirectory().."/config/GeekHelper/images/button.png") or not doesFileExist(getWorkingDirectory().."/config/GeekHelper/images/button2.png") then
	downloadUrlToFile("http://geekhub.pro/samp/file/GeekHelper/button.png", getWorkingDirectory().."/config/GeekHelper/images/button.png")
	downloadUrlToFile("http://geekhub.pro/samp/file/GeekHelper/button2.png", getWorkingDirectory().."/config/GeekHelper/images/button2.png")
end

local iniconfig = inicfg.load(nil, "GeekHelper/GeekHelper")
if iniconfig == nil then
	ini = {
		settings = {
			prefix = "LS:PD",
		}
	}
	inicfg.save(ini, "GeekHelper/GeekHelper")
	iniconfig = inicfg.load(nil, "GeekHelper/GeekHelper")
end

if not doesFileExist("moonloader/config/GeekHelper/settings.json") then
		local f = io.open("moonloader/config/GeekHelper/settings.json", "w")
		f:write(encodeJson({
			nick = {
				'Barry_Bradley',
				'Ник друга',
				'Ник друга2',
				'Ник друга3'
			},
			color = {
				4282655487,
				4280963554
			},
			skins = {
				280,
				281,
				282,
				283,
				284,
				285,
				286,
				288,
				71,
				265,
				163,
				164,
				165,
				166,
				266,
				267,
				300,
				301,
				302,
				306,
				307,
				309,
				310,
				311
			},
		}))
		f:close()
		local f = io.open("moonloader/config/GeekHelper/settings.json", 'r')
		if f then
			settings = decodeJson(f:read('*a'))
			f:close()
		end

else
	local f = io.open("moonloader/config/GeekHelper/settings.json", 'r')
	if f then
		settings = decodeJson(f:read('*a'))
		f:close()
	end

end
local color = settings["color"]
local skins = settings["skins"]
local nick = settings["nick"]

---------[ Стили окна imgui ]--------------------------------
function apply_custom_style()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	style.WindowRounding = 2
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
	style.ChildWindowRounding = 2.0
	style.FrameRounding = 3
	style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
	style.ScrollbarSize = 13.0
	style.ScrollbarRounding = 0
	style.GrabMinSize = 8.0
	style.GrabRounding = 1.0
	style.WindowPadding = imgui.ImVec2(4.0, 4.0)
	style.FramePadding = imgui.ImVec2(3.5, 3.5)
	style.ButtonTextAlign = imgui.ImVec2(0.0, 0.5)
	colors[clr.WindowBg] 			   = ImVec4(0.06, 0.06, 0.06, 0.91)
	colors[clr.Button]                 = ImVec4(0.86, 0.07, 0.23, 0.94)
	colors[clr.ButtonHovered]          = ImVec4(0.89, 0.14, 0.21, 0.89)
	colors[clr.ButtonActive]           = ImVec4(0.21, 0.21, 0.21, 0.81)
end
apply_custom_style()

local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
	if fa_font == nil then
		local font_config = imgui.ImFontConfig()
		font_config.MergeMode = true
		fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/config/GeekHelper/fonts/fontawesome.ttf', 14.0, font_config, fa_glyph_ranges)
	end
end

function sampev.onServerMessage(color, message)
	if string.find(message, "Это транспортное средство не оборудовано мегафоном") then
		local playerID = getPlayer()
        if playerID ~= -1 then
			sampSendChat('/s '..sampGetPlayerNickname(playerID)..', это '..iniconfig["settings"]["prefix"]..', остановитесь на проверку запрещенных веществ.')
		else
			sampAddChatMessage('> Не найдено ни одного игрока в радиусе 60 метров', 0xAAAAAA)
		end
	end
	if string.find(message, "Поблизости нет точек, оборудованных мегафонами, к которым вы имеете доступ.") then
		local playerID = getPlayer()
        if playerID ~= -1 then
			sampSendChat('/s '..sampGetPlayerNickname(playerID)..', это '..iniconfig["settings"]["prefix"]..', остановитесь на проверку запрещенных веществ.')
		else
			sampAddChatMessage('> Не найдено ни одного игрока в радиусе 60 метров', 0xAAAAAA)
		end
	end
end


function main()
    repeat wait(0) until isSampAvailable()
	vk = imgui.CreateTextureFromFile(getGameDirectory() .. '\\moonloader\\config\\GeekHelper\\images\\button.png') -- подгрузка иконки
	info = imgui.CreateTextureFromFile(getGameDirectory() .. '\\moonloader\\config\\GeekHelper\\images\\button2.png') -- подгрузка иконки
	sampAddChatMessage('Скрипт GeekHelper - авторы Oniel & CzarAlex | Команда: /myhelp', -1)
	if bNotf then
		notf.addNotification('Скрипт для ПО запущен - /myhelp', 5.0, 2)
	end
    sampRegisterChatCommand('pp', function()
        lua_thread.create(function()
            local playerID = getPlayer()
            if playerID ~= -1 then
				local result, ped = sampGetCharHandleBySampPlayerId(playerID)
				local score = sampGetPlayerScore(playerID)
				if (score >= 3) then
					if not isCharInAnyCar(ped) then
						sampSendChat('/ens')
						sampSendChat('['..iniconfig["settings"]["prefix"]..'] Здраствуйте, '..sampGetPlayerNickname(playerID)..', предьявите ваши документы для проверки - [/show]')
						sampSendChat('['..iniconfig["settings"]["prefix"]..'] У Вас есть 30 секунд чтоб исполнить это указание.')
						wait(1000)
						sampSendChat('/frisk '..playerID)
						if bNotf then
							notf.addNotification('У '..sampGetPlayerNickname(playerID)..' [id '..playerID..'] - '..score.. ' ур.', 5.0, 2)
						end
					else
						sampProcessChatInput('/stat '..playerID)
						sampSendChat('['..iniconfig["settings"]["prefix"]..'] '..sampGetPlayerNickname(playerID)..', покиньте ваше транспортное средство для проверки.')
					end
				else
					if bNotf then
						notf.addNotification('У '..sampGetPlayerNickname(playerID)..' [id '..playerID..'] - '..score.. ' ур.', 5.0, 3)
					end
				end
            else
				sampAddChatMessage('> Не найдено ни одного игрока в радиусе 60 метров', 0xAAAAAA)
			end
        end)
    end)
	sampRegisterChatCommand('nn', function()
        lua_thread.create(function()
            local playerID = getPlayer()
            if playerID ~= -1 then
				local score = sampGetPlayerScore(playerID)
				if (score >= 3) then
					sampSendChat('/ens')
					sampSendChat('['..iniconfig["settings"]["prefix"]..'] '..sampGetPlayerNickname(playerID)..', покиньте ваше транспортное средство для проверки на запрещенные вещества.')
					sampSendChat('['..iniconfig["settings"]["prefix"]..'] У Вас есть 30 секунд чтоб исполнить это указание.')
						wait(1000)
					sampSendChat('/friskcar')
				else
					if bNotf then
						notf.addNotification('У '..sampGetPlayerNickname(playerID)..' [id '..playerID..'] - '..score.. ' ур.', 5.0, 3)
					end
				end
            else
				sampAddChatMessage('> Не найдено ни одного игрока в радиусе 60 метров', 0xAAAAAA)
			end
        end)
    end)
    sampRegisterChatCommand('ss', function()
		local playerID = getPlayer()
        if playerID ~= -1 then
			local score = sampGetPlayerScore(playerID)
			if (score >= 3) then -- чекаем какой лвл, если меньше 3 то ничего не выводим игроку
				sampSendChat('/m '..sampGetPlayerNickname(playerID)..', это '..iniconfig["settings"]["prefix"]..', остановитесь на проверку запрещенных веществ.')
				if bNotf then
					notf.addNotification('У '..sampGetPlayerNickname(playerID)..' [id '..playerID..'] - '..score.. ' ур.', 5.0, 2)
				end
			else
				if bNotf then
					notf.addNotification('У '..sampGetPlayerNickname(playerID)..' [id '..playerID..'] - '..score.. ' ур.', 5.0, 3)
				end
			end
		else
			sampAddChatMessage('> Не найдено ни одного игрока в радиусе 60 метров', 0xAAAAAA)
		end
	end)
	sampRegisterChatCommand('cc', function()
        lua_thread.create(function()
            local playerID = getPlayer()
            if playerID ~= -1 then
				sampSendChat('['..iniconfig["settings"]["prefix"]..'] '..sampGetPlayerNickname(playerID)..', Вы свободны, не нарушайте закон USA.')
				if bNotf then
					notf.addNotification('Вы попрощались с '..sampGetPlayerNickname(playerID), 5.0, 2)
				end
            else
				sampAddChatMessage('> Не найдено ни одного игрока в радиусе 60 метров', 0xAAAAAA)
			end
        end)
    end)
	sampRegisterChatCommand('fri', function()
        lua_thread.create(function()
            local playerID = getPlayer()
            if playerID ~= -1 then
				sampSendChat('/frisk '..playerID)
				if bNotf then
					notf.addNotification('Вы обыскали: '..sampGetPlayerNickname(playerID), 5.0, 2)
				end
            end
        end)
    end)
	sampRegisterChatCommand('cu', function()
        lua_thread.create(function()
            local playerID = getPlayer()
            if playerID ~= -1 then
				sampSendChat('/cuff '..playerID)
				if bNotf then
					notf.addNotification('Вы надели наручники на '..sampGetPlayerNickname(playerID), 5.0, 2)
				end
            end
        end)
    end)
	sampRegisterChatCommand('uncu', function()
        lua_thread.create(function()
            local playerID = getPlayer()
            if playerID ~= -1 then
				sampSendChat('/uncuff '..playerID)
				if bNotf then
					notf.addNotification('Вы сняли наручники с '..sampGetPlayerNickname(playerID), 5.0, 2)
				end
            end
        end)
    end)
	sampRegisterChatCommand('ze', function()
        lua_thread.create(function()
            local playerID = getPlayer()
            if playerID ~= -1 then
				sampSendChat('/z '..playerID)
				if bNotf then
					notf.addNotification('Вы начали погоню за '..sampGetPlayerNickname(playerID), 5.0, 2)
				end
            end
        end)
    end)
    sampRegisterChatCommand('addid', function(id)
        if tonumber(id) then
			if sampIsPlayerConnected(id) then
				nickname = sampGetPlayerNickname(tonumber(id))
				if bNotf then
						notf.addNotification('Вы добавили '..nickname..' [ID '..id..']', 5.0, 2)
				end
			else
				sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}Игрока не обнаружено на сервере', -1)
			end
		else
            sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}Введите /addid [ID]', -1)
        end
    end)
	sampRegisterChatCommand('addprefix', function(prefix)
        if prefix ~= nil and prefix ~= '' then
			iniconfig["settings"]["prefix"] = prefix
			inicfg.save(iniconfig, "GeekHelper/GeekHelper")
			sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}Вы успешно заменили префикс на: '..prefix, -1)
		else
            sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}Введите /addprefix [PREFIX]', -1)
        end
    end)
	sampRegisterChatCommand('finder', function()
        if nickname then
            sampSendChat('/find '..nickname)
        else
			if bNotf then
					notf.addNotification('Вы не указали игрока', 5.0, 3)
			end
        end
    end)
    sampRegisterChatCommand('zgo', function()
        if nickname then
            sampSendChat('/z '..nickname)
			if bNotf then
					notf.addNotification('Вы начали погоню за '..nickname, 5.0, 2)
			end
        else
            if bNotf then
					notf.addNotification('Вы не указали игрока', 5.0, 3)
			end
        end
    end)
	sampRegisterChatCommand('deli', function()
       	if nickname then
			sampSendChat('/deliver '..nickname)
			if bNotf then
					notf.addNotification('Вы конвоировали игрока '..nickname, 5.0, 2)
			end
		else
			if bNotf then
					notf.addNotification('Вы не указали игрока', 5.0, 3)
			end
		end
    end)
	sampRegisterChatCommand('deti', function()
		if nickname then
			sampSendChat('/det '..nickname)
			if bNotf then
					notf.addNotification('Вы начали конвоирование игроа '..nickname, 5.0, 2)
			end
		else
			if bNotf then
					notf.addNotification('Вы не указали игрока', 5.0, 3)
			end
		end
    end)
	sampRegisterChatCommand('unb', function()
		if nickname then
			sampSendChat('/unbail '..nickname)
			if bNotf then
					notf.addNotification('Вы запретили выход за $ для '..nickname, 5.0, 2)
			end
		else
			if bNotf then
					notf.addNotification('Вы не указали игрока', 5.0, 3)
			end
		end
    end)
	sampRegisterChatCommand('lvl', function(id)
        if tonumber(id) then
			if sampIsPlayerConnected(id) then
				sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}У игрока {A4A4A4}'..sampGetPlayerNickname(id)..'[ID: '..id..'] {FFFFFF}уровень в игре {00FF00}'..sampGetPlayerScore(id)..'{FFFFFF}.', -1)
			else
				sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}Такого игрока нет на сервере', -1)
			end
        else
            sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}Введите /lvl [ID]', -1)
        end
    end)
	sampRegisterChatCommand('myhelp', function()
		help.v = not help.v
	end)
    while true do
		wait(0)
		local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
		if valid and wasKeyPressed(key.VK_1) then
			local result, id = sampGetPlayerIdByCharHandle(ped)
			if result and not sampIsPlayerPaused(id) then
				sampSendChat('/cuff '..id)
				if bNotf then
					notf.addNotification('Вы надели наручники на '..sampGetPlayerNickname(id), 5.0, 2)
				end
			end
		end
		if valid and wasKeyPressed(key.VK_2) then
			local result, id = sampGetPlayerIdByCharHandle(ped)
			if result and not sampIsPlayerPaused(id) then
				sampSendChat('/z '..id)
				if bNotf then
					notf.addNotification('Вы начали преследовать '..sampGetPlayerNickname(id), 5.0, 2)
				end
			end
		end
		if valid and wasKeyPressed(key.VK_3) then
			local result, id = sampGetPlayerIdByCharHandle(ped)
			if result and not sampIsPlayerPaused(id) then
				sampSendChat('/uncuff '..id)
				if bNotf then
					notf.addNotification('Вы сняли наручники с '..sampGetPlayerNickname(id), 5.0, 2)
				end
			end
		end
		if valid and wasKeyPressed(key.VK_4) then
			local result, id = sampGetPlayerIdByCharHandle(ped)
			if result then
				local score = sampGetPlayerScore(id)
				if (score >= 3) then
					sampAddChatMessage('{00FF00}> У игрока {FFFFFF}'..sampGetPlayerNickname(id)..' {A4A4A4}[id '..id..'] {00FF00}- '..score.. ' уровень.', -1)
					sampSendChat('/ens')
					sampSendChat('['..iniconfig["settings"]["prefix"]..'] Здраствуйте '..sampGetPlayerNickname(id)..', предьявите ваши документы для проверки - [/show]')
					sampSendChat('/frisk '..id)
				else
					if bNotf then
						notf.addNotification('У '..sampGetPlayerNickname(id)..' [id '..id..'] - '..score.. ' ур.', 5.0, 3)
					end
				end
			end
		end
		if valid and wasKeyPressed(key.VK_5) then
			local result, id = sampGetPlayerIdByCharHandle(ped)
			if result then
				sampSendChat('['..iniconfig["settings"]["prefix"]..'] Всего доброго '..sampGetPlayerNickname(id)..', спасибо за сотрудничество.')
			end
		end
		if valid and wasKeyPressed(key.VK_6) then
			local result, id = sampGetPlayerIdByCharHandle(ped)
			if result then
				sampSendChat('/frisk '..id)
				if bNotf then
					notf.addNotification('Вы обыскали '..sampGetPlayerNickname(id), 5.0, 2)
				end
			end
		end
		if valid and wasKeyPressed(key.VK_0) then
			local result, id = sampGetPlayerIdByCharHandle(ped)
			if result then
				sampSendChat('/su '..id)
			end
		end
		if valid and wasKeyPressed(key.VK_Z) then
			local result, id = sampGetPlayerIdByCharHandle(ped)
			if result then
				nickname = sampGetPlayerNickname(id)
				if bNotf then
					notf.addNotification('Вы добавили '..sampGetPlayerNickname(id)..' в список.', 5.0, 2)
				end
			end
		end
		imgui.Process = help.v -- окно помощи
	end
end



---------[ Меню помощи ]--------------------------------
function imgui.OnDrawFrame()
    if help.v then
        imgui.LockPlayer = true
		imgui.SetNextWindowSize(imgui.ImVec2(wx, wy))
		imgui.SetNextWindowPos(imgui.ImVec2(rx/2-wx/2, ry/2-wy/2))

        imgui.Begin(u8('POLICE HELP'), help, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
        imgui.BeginChild('left', imgui.ImVec2(128, 0), true)
			if imgui.ImageButton(vk, imgui.ImVec2(120, 30), imgui.ImVec2(0, 0), imgui.ImVec2(1, 1), 0, imgui.ImVec4(0, 0, 0, 1)) then
				sampAddChatMessage("{32CD32}[BB]{FFFFF0} Подпишись на сообщество о скриптах для Trinity - {4682B4}vk.com/trinity_mod", -1)
			end
			if imgui.ImageButton(info, imgui.ImVec2(120, 30), imgui.ImVec2(0, 0), imgui.ImVec2(1, 1), 0, imgui.ImVec4(0, 0, 0, 1)) then
				sampAddChatMessage("{32CD32}[BB]{FFFFF0} Скрипт был создан для упрощение жизни на Trinity. Автор: {DC143C}vk.com/null_lol", -1)
			end
		imgui.EndChild()
		imgui.SameLine()

		imgui.BeginChild('right', imgui.ImVec2(0, 0), true)
			imgui.Spacing()
			imgui.Separator()


				imgui.Text('  ' .. fa.ICON_THUMB_TACK .. u8(' Команды скрипта:'))
			imgui.Spacing()
			imgui.Separator()
			--imgui.NewLine()

			imgui.Text('           ' .. fa.ICON_INFO_CIRCLE .. u8(' Основная команда, помощь -')); imgui.SameLine()
				if imgui.Button(u8(" /myhelp ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Выводит список всех команд и действий скрипта", -1)
				end
			imgui.SameLine()
			ShowHelpMarker(u8("> Если нажать на кнопку с командой, то можно узнать больше информации"))

			imgui.Text('           ' .. fa.ICON_ID_CARD_O .. u8(' Спросить документы -')); imgui.SameLine()
				if imgui.Button(u8(" /pp ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Автоматически спросит документы у ближнего игрока, а так же покажет /ens и сделает /frisk", -1)
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Но если игрок который ближе всего к вам (не ПО), в машине, то скрипт автоматически скажет чтоб покинули ТС", -1)
				end
			imgui.Text('           ' .. fa.ICON_CAR .. u8(' Попросить покинуть ТС -')); imgui.SameLine()
				if imgui.Button(u8(" /nn ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Автоматически попросит покинуть ТС у ближайшего игрока (не ПО). Но лучше используйте /pp", -1)
				end
			imgui.Text('           ' .. fa.ICON_CAR .. u8(' Попросить остановить ТС -')); imgui.SameLine()
				if imgui.Button(u8(" /ss ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Автоматически берет ID ближайшего игрока и говорит ему в рупорт об остановке (если нет рупорта или вы не в ТС, то говорит в /s)", -1)
				end
			imgui.Text('           ' .. fa.ICON_HANDSHAKE_O .. u8(' Попрощаться с игроком -')); imgui.SameLine()
				if imgui.Button(u8(" /cc ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Автоматически берет ID ближайшего игрока и прощаеться с ним", -1)
				end
			imgui.Text('           ' .. fa.ICON_SEARCH .. u8(' Обыск ближайшего игрока -')); imgui.SameLine()
				if imgui.Button(u8(" /fri ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Обыскивает ближайшего игрока (так же как: /frisk [ID] только ID подставит скрипт сам)", -1)
				end
			imgui.Text('           ' .. fa.ICON_SIGN_LANGUAGE .. u8(' Надеть наручники на ближайшего игрока -')); imgui.SameLine()
				if imgui.Button(u8(" /cu ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Надеть наручники на ближайшего игрока (так же как: /cuff [ID] только ID подставит скрипт сам)", -1)
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Перед тем как надеть нужно ударить игрока ТАЙЗЕРОМ", -1)
				end
			imgui.Text('           ' .. fa.ICON_SIGN_LANGUAGE .. u8(' Снять наручники с ближайшего игрока -')); imgui.SameLine()
				if imgui.Button(u8(" /uncu ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Снимает наручники в ближайшего игрока (так же как: /uncuff [ID] только ID подставит скрипт сам)", -1)
				end
			imgui.Text('           ' .. fa.ICON_STAR .. u8(' Начать преследовать ближайшего игрока -')); imgui.SameLine()
				if imgui.Button(u8(" /ze ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Начать преследовать ближайшего игрока (так же как: /z [ID] только ID подставит скрипт сам)", -1)
				end
			imgui.Text('           ' .. fa.ICON_LANGUAGE .. u8(' Сменить префикс возле сообщений -')); imgui.SameLine()
				if imgui.Button(u8(" /addprefix ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Изменение префикса возле каждого сообщения что скрипт пишит игроку. Пример префикса: [LS:PD], [FBI] и т.д", -1)
				end

			imgui.Spacing()
			imgui.Separator()
				imgui.Text('  ' .. fa.ICON_THUMB_TACK .. u8(' Команды которые работають через /addid :'));
			imgui.Spacing()
			imgui.Separator()

			imgui.Text('           ' .. fa.ICON_PLUS_CIRCLE .. u8(' Добавляем ID игрока -')); imgui.SameLine()
				if imgui.Button(u8(" /addid ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Если Вы добавите ID игрока то сможете использовать команды в которых нужен ID.", -1)
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Полезная функция если Вы преследуете кого либо, раз ввели ID и преследуете.", -1)
				end
			imgui.Text('           ' .. fa.ICON_STREET_VIEW .. u8(' Поиск игрока -')); imgui.SameLine()
				if imgui.Button(u8(" /finder ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Поиск игрока (так же как: /find [ID] только ID добавляем через /addid [ID])", -1)
				end
			imgui.Text('           ' .. fa.ICON_STAR .. u8(' Начать преследовать -')); imgui.SameLine()
				if imgui.Button(u8(" /zgo ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Начать преследовать игрока (так же как: /z [ID] только ID добавляем через /addid [ID])", -1)
				end
			imgui.Text('           ' .. fa.ICON_CAR .. u8(' Начать конвоирование -')); imgui.SameLine()
				if imgui.Button(u8(" /deti ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Начать конвоирование игрока (так же как: /det [ID] только ID добавляем через /addid [ID])", -1)
				end
			imgui.Text('           ' .. fa.ICON_STAR_HALF_O .. u8(' Закончить конвоирование -')); imgui.SameLine()
				if imgui.Button(u8(" /deli ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Закончить конвоирование игрока (так же как: /delive [ID] только ID добавляем через /addid [ID])", -1)
				end
			imgui.Text('           ' .. fa.ICON_TIMES_CIRCLE .. u8(' Запретить выход игрока через [/bail] -')); imgui.SameLine()
				if imgui.Button(u8(" /unb ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Запретить выход игрока за деньги (так же как: /unbail [ID] только ID добавляем через /addid [ID])", -1)
				end
			imgui.Text('           ' .. fa.ICON_STAR_O .. u8(' Узнать уровень игрока -')); imgui.SameLine()
				if imgui.Button(u8(" /lvl [ID] ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Узнаем уровень игрока по его ID.", -1)
				end

				--imgui.NewLine()

			imgui.Spacing()
			imgui.Separator()
				imgui.Text('  ' .. fa.ICON_THUMB_TACK .. u8(' Доп. функции скрипта:'));
			imgui.Spacing()
			imgui.Separator()

			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' Надеть наручники на игрока -')); imgui.SameLine()
				if imgui.Button(u8(" ПКМ + 1 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Надевает наручники на игрока на которого вы нацелились и в это время нажали '1'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' Начать преследовать игрока -')); imgui.SameLine()
				if imgui.Button(u8(" ПКМ + 2 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Начинает преследовать игрока на которого вы нацелились и в это время нажали '2'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' Снять наручники с игрока -')); imgui.SameLine()
				if imgui.Button(u8(" ПКМ + 3 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Снимает наручники с игрока на которого вы прицелились и в это время нажали '3'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' Попросить документы -')); imgui.SameLine()
				if imgui.Button(u8(" ПКМ + 4 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Просит документы в игрока на которого вы прицелились и в это время нажали '4'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' Попрощаться с игроком -')); imgui.SameLine()
				if imgui.Button(u8(" ПКМ + 5 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Попрощаться с игроком на которого вы прицелились и в это время нажали '5'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' Обыскать игрока -')); imgui.SameLine()
				if imgui.Button(u8(" ПКМ + 6 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Обыскивает игрока на которого вы прицелились и в это время нажали '6'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' Выдать розыск -')); imgui.SameLine()
				if imgui.Button(u8(" ПКМ + 0 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Выдает зв (/su [ID]) игроку на которого вы прицелились и в это время нажали '0'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' Получить ID -')); imgui.SameLine()
				if imgui.Button(u8(" ПКМ + Z ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} Получает ID игрока на которого вы прицелились и в это время нажали 'Z'. Функция заносит автоматически /addid [ID]", -1)
				end
		imgui.EndChild()
		imgui.End()
    end
end
-- Функция которая создает текст при наводе на  знак "?" || Использовать: ShowHelpMarker('Text')
function ShowHelpMarker(desc)
    imgui.TextDisabled(fa.ICON_QUESTION_CIRCLE)
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(imgui.GetFontSize() * 35.0)
        imgui.TextUnformatted(desc)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

-- Остальные функции
function hasValue (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function getPlayer()
    local maxDist = 60.0
    local closestPlayer = -1
    for i = 0, sampGetMaxPlayerId(true) do
		if sampIsPlayerConnected(i) and not sampIsPlayerNpc(i) then
			if sampGetCharHandleBySampPlayerId(i) then
				local playerPosX, playerPosY, playerPosZ = getCharCoordinates(select(2, sampGetCharHandleBySampPlayerId(i)))
				local myPosX, myPosY, myPosZ = getCharCoordinates(PLAYER_PED)
				local dist = getDistanceBetweenCoords3d(myPosX, myPosY, myPosZ, playerPosX, playerPosY, playerPosZ)
				if dist < maxDist then
					local result, handle = sampGetCharHandleBySampPlayerId(i)
					if not hasValue(nick, sampGetPlayerNickname(i)) and not hasValue(color, sampGetPlayerColor(i)) and not hasValue(skins, getCharModel(handle)) then
						maxDist, closestPlayer = dist, i
					end
				end
			end
        end
    end
    return closestPlayer
end

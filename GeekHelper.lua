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

---------[ ��������� ���������� ]--------------------------------
local vk = nil -- ������ ��
local info = nil -- ������ ����������
local rx, ry = getScreenResolution() -- �������� ������ ������
local wx, wy = 550, 350 -- ������ ���� imgui
local help = imgui.ImBool(false) -- �� ��������� ��� ������

-- ���� ��� ����� fonts - �������
if not doesDirectoryExist(getWorkingDirectory().."/config/GeekHelper/fonts/") or not doesDirectoryExist(getWorkingDirectory().."/config/GeekHelper/images/") then
	createDirectory(getWorkingDirectory().."/config/GeekHelper/fonts/")
	createDirectory(getWorkingDirectory().."/config/GeekHelper/images/")
end
-- ���� ��� ������ - �������
if not doesFileExist(getWorkingDirectory().."/config/GeekHelper/fonts/fontawesome.ttf") then
	downloadUrlToFile("http://geekhub.pro/samp/file/GeekHelper/fontawesome-webfont.ttf", getWorkingDirectory().."/config/GeekHelper/fonts/fontawesome.ttf")
end
-- ���� ��� �������� - �������
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
				'��� �����',
				'��� �����2',
				'��� �����3'
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

---------[ ����� ���� imgui ]--------------------------------
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
	if string.find(message, "��� ������������ �������� �� ����������� ���������") then
		local playerID = getPlayer()
        if playerID ~= -1 then
			sampSendChat('/s '..sampGetPlayerNickname(playerID)..', ��� '..iniconfig["settings"]["prefix"]..', ������������ �� �������� ����������� �������.')
		else
			sampAddChatMessage('> �� ������� �� ������ ������ � ������� 60 ������', 0xAAAAAA)
		end
	end
	if string.find(message, "���������� ��� �����, ������������� ����������, � ������� �� ������ ������.") then
		local playerID = getPlayer()
        if playerID ~= -1 then
			sampSendChat('/s '..sampGetPlayerNickname(playerID)..', ��� '..iniconfig["settings"]["prefix"]..', ������������ �� �������� ����������� �������.')
		else
			sampAddChatMessage('> �� ������� �� ������ ������ � ������� 60 ������', 0xAAAAAA)
		end
	end
end


function main()
    repeat wait(0) until isSampAvailable()
	vk = imgui.CreateTextureFromFile(getGameDirectory() .. '\\moonloader\\config\\GeekHelper\\images\\button.png') -- ��������� ������
	info = imgui.CreateTextureFromFile(getGameDirectory() .. '\\moonloader\\config\\GeekHelper\\images\\button2.png') -- ��������� ������
	sampAddChatMessage('������ GeekHelper - ������ Oniel & CzarAlex | �������: /myhelp', -1)
	if bNotf then
		notf.addNotification('������ ��� �� ������� - /myhelp', 5.0, 2)
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
						sampSendChat('['..iniconfig["settings"]["prefix"]..'] �����������, '..sampGetPlayerNickname(playerID)..', ���������� ���� ��������� ��� �������� - [/show]')
						sampSendChat('['..iniconfig["settings"]["prefix"]..'] � ��� ���� 30 ������ ���� ��������� ��� ��������.')
						wait(1000)
						sampSendChat('/frisk '..playerID)
						if bNotf then
							notf.addNotification('� '..sampGetPlayerNickname(playerID)..' [id '..playerID..'] - '..score.. ' ��.', 5.0, 2)
						end
					else
						sampProcessChatInput('/stat '..playerID)
						sampSendChat('['..iniconfig["settings"]["prefix"]..'] '..sampGetPlayerNickname(playerID)..', �������� ���� ������������ �������� ��� ��������.')
					end
				else
					if bNotf then
						notf.addNotification('� '..sampGetPlayerNickname(playerID)..' [id '..playerID..'] - '..score.. ' ��.', 5.0, 3)
					end
				end
            else
				sampAddChatMessage('> �� ������� �� ������ ������ � ������� 60 ������', 0xAAAAAA)
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
					sampSendChat('['..iniconfig["settings"]["prefix"]..'] '..sampGetPlayerNickname(playerID)..', �������� ���� ������������ �������� ��� �������� �� ����������� ��������.')
					sampSendChat('['..iniconfig["settings"]["prefix"]..'] � ��� ���� 30 ������ ���� ��������� ��� ��������.')
						wait(1000)
					sampSendChat('/friskcar')
				else
					if bNotf then
						notf.addNotification('� '..sampGetPlayerNickname(playerID)..' [id '..playerID..'] - '..score.. ' ��.', 5.0, 3)
					end
				end
            else
				sampAddChatMessage('> �� ������� �� ������ ������ � ������� 60 ������', 0xAAAAAA)
			end
        end)
    end)
    sampRegisterChatCommand('ss', function()
		local playerID = getPlayer()
        if playerID ~= -1 then
			local score = sampGetPlayerScore(playerID)
			if (score >= 3) then -- ������ ����� ���, ���� ������ 3 �� ������ �� ������� ������
				sampSendChat('/m '..sampGetPlayerNickname(playerID)..', ��� '..iniconfig["settings"]["prefix"]..', ������������ �� �������� ����������� �������.')
				if bNotf then
					notf.addNotification('� '..sampGetPlayerNickname(playerID)..' [id '..playerID..'] - '..score.. ' ��.', 5.0, 2)
				end
			else
				if bNotf then
					notf.addNotification('� '..sampGetPlayerNickname(playerID)..' [id '..playerID..'] - '..score.. ' ��.', 5.0, 3)
				end
			end
		else
			sampAddChatMessage('> �� ������� �� ������ ������ � ������� 60 ������', 0xAAAAAA)
		end
	end)
	sampRegisterChatCommand('cc', function()
        lua_thread.create(function()
            local playerID = getPlayer()
            if playerID ~= -1 then
				sampSendChat('['..iniconfig["settings"]["prefix"]..'] '..sampGetPlayerNickname(playerID)..', �� ��������, �� ��������� ����� USA.')
				if bNotf then
					notf.addNotification('�� ����������� � '..sampGetPlayerNickname(playerID), 5.0, 2)
				end
            else
				sampAddChatMessage('> �� ������� �� ������ ������ � ������� 60 ������', 0xAAAAAA)
			end
        end)
    end)
	sampRegisterChatCommand('fri', function()
        lua_thread.create(function()
            local playerID = getPlayer()
            if playerID ~= -1 then
				sampSendChat('/frisk '..playerID)
				if bNotf then
					notf.addNotification('�� ��������: '..sampGetPlayerNickname(playerID), 5.0, 2)
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
					notf.addNotification('�� ������ ��������� �� '..sampGetPlayerNickname(playerID), 5.0, 2)
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
					notf.addNotification('�� ����� ��������� � '..sampGetPlayerNickname(playerID), 5.0, 2)
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
					notf.addNotification('�� ������ ������ �� '..sampGetPlayerNickname(playerID), 5.0, 2)
				end
            end
        end)
    end)
    sampRegisterChatCommand('addid', function(id)
        if tonumber(id) then
			if sampIsPlayerConnected(id) then
				nickname = sampGetPlayerNickname(tonumber(id))
				if bNotf then
						notf.addNotification('�� �������� '..nickname..' [ID '..id..']', 5.0, 2)
				end
			else
				sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}������ �� ���������� �� �������', -1)
			end
		else
            sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}������� /addid [ID]', -1)
        end
    end)
	sampRegisterChatCommand('addprefix', function(prefix)
        if prefix ~= nil and prefix ~= '' then
			iniconfig["settings"]["prefix"] = prefix
			inicfg.save(iniconfig, "GeekHelper/GeekHelper")
			sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}�� ������� �������� ������� ��: '..prefix, -1)
		else
            sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}������� /addprefix [PREFIX]', -1)
        end
    end)
	sampRegisterChatCommand('finder', function()
        if nickname then
            sampSendChat('/find '..nickname)
        else
			if bNotf then
					notf.addNotification('�� �� ������� ������', 5.0, 3)
			end
        end
    end)
    sampRegisterChatCommand('zgo', function()
        if nickname then
            sampSendChat('/z '..nickname)
			if bNotf then
					notf.addNotification('�� ������ ������ �� '..nickname, 5.0, 2)
			end
        else
            if bNotf then
					notf.addNotification('�� �� ������� ������', 5.0, 3)
			end
        end
    end)
	sampRegisterChatCommand('deli', function()
       	if nickname then
			sampSendChat('/deliver '..nickname)
			if bNotf then
					notf.addNotification('�� ������������ ������ '..nickname, 5.0, 2)
			end
		else
			if bNotf then
					notf.addNotification('�� �� ������� ������', 5.0, 3)
			end
		end
    end)
	sampRegisterChatCommand('deti', function()
		if nickname then
			sampSendChat('/det '..nickname)
			if bNotf then
					notf.addNotification('�� ������ ������������� ����� '..nickname, 5.0, 2)
			end
		else
			if bNotf then
					notf.addNotification('�� �� ������� ������', 5.0, 3)
			end
		end
    end)
	sampRegisterChatCommand('unb', function()
		if nickname then
			sampSendChat('/unbail '..nickname)
			if bNotf then
					notf.addNotification('�� ��������� ����� �� $ ��� '..nickname, 5.0, 2)
			end
		else
			if bNotf then
					notf.addNotification('�� �� ������� ������', 5.0, 3)
			end
		end
    end)
	sampRegisterChatCommand('lvl', function(id)
        if tonumber(id) then
			if sampIsPlayerConnected(id) then
				sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}� ������ {A4A4A4}'..sampGetPlayerNickname(id)..'[ID: '..id..'] {FFFFFF}������� � ���� {00FF00}'..sampGetPlayerScore(id)..'{FFFFFF}.', -1)
			else
				sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}������ ������ ��� �� �������', -1)
			end
        else
            sampAddChatMessage('{ffffff}* [{cd0000}Trinity{ffffff}Police]: {cd0000}������� /lvl [ID]', -1)
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
					notf.addNotification('�� ������ ��������� �� '..sampGetPlayerNickname(id), 5.0, 2)
				end
			end
		end
		if valid and wasKeyPressed(key.VK_2) then
			local result, id = sampGetPlayerIdByCharHandle(ped)
			if result and not sampIsPlayerPaused(id) then
				sampSendChat('/z '..id)
				if bNotf then
					notf.addNotification('�� ������ ������������ '..sampGetPlayerNickname(id), 5.0, 2)
				end
			end
		end
		if valid and wasKeyPressed(key.VK_3) then
			local result, id = sampGetPlayerIdByCharHandle(ped)
			if result and not sampIsPlayerPaused(id) then
				sampSendChat('/uncuff '..id)
				if bNotf then
					notf.addNotification('�� ����� ��������� � '..sampGetPlayerNickname(id), 5.0, 2)
				end
			end
		end
		if valid and wasKeyPressed(key.VK_4) then
			local result, id = sampGetPlayerIdByCharHandle(ped)
			if result then
				local score = sampGetPlayerScore(id)
				if (score >= 3) then
					sampAddChatMessage('{00FF00}> � ������ {FFFFFF}'..sampGetPlayerNickname(id)..' {A4A4A4}[id '..id..'] {00FF00}- '..score.. ' �������.', -1)
					sampSendChat('/ens')
					sampSendChat('['..iniconfig["settings"]["prefix"]..'] ����������� '..sampGetPlayerNickname(id)..', ���������� ���� ��������� ��� �������� - [/show]')
					sampSendChat('/frisk '..id)
				else
					if bNotf then
						notf.addNotification('� '..sampGetPlayerNickname(id)..' [id '..id..'] - '..score.. ' ��.', 5.0, 3)
					end
				end
			end
		end
		if valid and wasKeyPressed(key.VK_5) then
			local result, id = sampGetPlayerIdByCharHandle(ped)
			if result then
				sampSendChat('['..iniconfig["settings"]["prefix"]..'] ����� ������� '..sampGetPlayerNickname(id)..', ������� �� ��������������.')
			end
		end
		if valid and wasKeyPressed(key.VK_6) then
			local result, id = sampGetPlayerIdByCharHandle(ped)
			if result then
				sampSendChat('/frisk '..id)
				if bNotf then
					notf.addNotification('�� �������� '..sampGetPlayerNickname(id), 5.0, 2)
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
					notf.addNotification('�� �������� '..sampGetPlayerNickname(id)..' � ������.', 5.0, 2)
				end
			end
		end
		imgui.Process = help.v -- ���� ������
	end
end



---------[ ���� ������ ]--------------------------------
function imgui.OnDrawFrame()
    if help.v then
        imgui.LockPlayer = true
		imgui.SetNextWindowSize(imgui.ImVec2(wx, wy))
		imgui.SetNextWindowPos(imgui.ImVec2(rx/2-wx/2, ry/2-wy/2))

        imgui.Begin(u8('POLICE HELP'), help, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
        imgui.BeginChild('left', imgui.ImVec2(128, 0), true)
			if imgui.ImageButton(vk, imgui.ImVec2(120, 30), imgui.ImVec2(0, 0), imgui.ImVec2(1, 1), 0, imgui.ImVec4(0, 0, 0, 1)) then
				sampAddChatMessage("{32CD32}[BB]{FFFFF0} ��������� �� ���������� � �������� ��� Trinity - {4682B4}vk.com/trinity_mod", -1)
			end
			if imgui.ImageButton(info, imgui.ImVec2(120, 30), imgui.ImVec2(0, 0), imgui.ImVec2(1, 1), 0, imgui.ImVec4(0, 0, 0, 1)) then
				sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������ ��� ������ ��� ��������� ����� �� Trinity. �����: {DC143C}vk.com/null_lol", -1)
			end
		imgui.EndChild()
		imgui.SameLine()

		imgui.BeginChild('right', imgui.ImVec2(0, 0), true)
			imgui.Spacing()
			imgui.Separator()


				imgui.Text('  ' .. fa.ICON_THUMB_TACK .. u8(' ������� �������:'))
			imgui.Spacing()
			imgui.Separator()
			--imgui.NewLine()

			imgui.Text('           ' .. fa.ICON_INFO_CIRCLE .. u8(' �������� �������, ������ -')); imgui.SameLine()
				if imgui.Button(u8(" /myhelp ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������� ������ ���� ������ � �������� �������", -1)
				end
			imgui.SameLine()
			ShowHelpMarker(u8("> ���� ������ �� ������ � ��������, �� ����� ������ ������ ����������"))

			imgui.Text('           ' .. fa.ICON_ID_CARD_O .. u8(' �������� ��������� -')); imgui.SameLine()
				if imgui.Button(u8(" /pp ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������������� ������� ��������� � �������� ������, � ��� �� ������� /ens � ������� /frisk", -1)
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} �� ���� ����� ������� ����� ����� � ��� (�� ��), � ������, �� ������ ������������� ������ ���� �������� ��", -1)
				end
			imgui.Text('           ' .. fa.ICON_CAR .. u8(' ��������� �������� �� -')); imgui.SameLine()
				if imgui.Button(u8(" /nn ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������������� �������� �������� �� � ���������� ������ (�� ��). �� ����� ����������� /pp", -1)
				end
			imgui.Text('           ' .. fa.ICON_CAR .. u8(' ��������� ���������� �� -')); imgui.SameLine()
				if imgui.Button(u8(" /ss ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������������� ����� ID ���������� ������ � ������� ��� � ������ �� ��������� (���� ��� ������� ��� �� �� � ��, �� ������� � /s)", -1)
				end
			imgui.Text('           ' .. fa.ICON_HANDSHAKE_O .. u8(' ����������� � ������� -')); imgui.SameLine()
				if imgui.Button(u8(" /cc ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������������� ����� ID ���������� ������ � ���������� � ���", -1)
				end
			imgui.Text('           ' .. fa.ICON_SEARCH .. u8(' ����� ���������� ������ -')); imgui.SameLine()
				if imgui.Button(u8(" /fri ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ���������� ���������� ������ (��� �� ���: /frisk [ID] ������ ID ��������� ������ ���)", -1)
				end
			imgui.Text('           ' .. fa.ICON_SIGN_LANGUAGE .. u8(' ������ ��������� �� ���������� ������ -')); imgui.SameLine()
				if imgui.Button(u8(" /cu ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������ ��������� �� ���������� ������ (��� �� ���: /cuff [ID] ������ ID ��������� ������ ���)", -1)
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ����� ��� ��� ������ ����� ������� ������ ��������", -1)
				end
			imgui.Text('           ' .. fa.ICON_SIGN_LANGUAGE .. u8(' ����� ��������� � ���������� ������ -')); imgui.SameLine()
				if imgui.Button(u8(" /uncu ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������� ��������� � ���������� ������ (��� �� ���: /uncuff [ID] ������ ID ��������� ������ ���)", -1)
				end
			imgui.Text('           ' .. fa.ICON_STAR .. u8(' ������ ������������ ���������� ������ -')); imgui.SameLine()
				if imgui.Button(u8(" /ze ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������ ������������ ���������� ������ (��� �� ���: /z [ID] ������ ID ��������� ������ ���)", -1)
				end
			imgui.Text('           ' .. fa.ICON_LANGUAGE .. u8(' ������� ������� ����� ��������� -')); imgui.SameLine()
				if imgui.Button(u8(" /addprefix ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ��������� �������� ����� ������� ��������� ��� ������ ����� ������. ������ ��������: [LS:PD], [FBI] � �.�", -1)
				end

			imgui.Spacing()
			imgui.Separator()
				imgui.Text('  ' .. fa.ICON_THUMB_TACK .. u8(' ������� ������� ��������� ����� /addid :'));
			imgui.Spacing()
			imgui.Separator()

			imgui.Text('           ' .. fa.ICON_PLUS_CIRCLE .. u8(' ��������� ID ������ -')); imgui.SameLine()
				if imgui.Button(u8(" /addid ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ���� �� �������� ID ������ �� ������� ������������ ������� � ������� ����� ID.", -1)
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} �������� ������� ���� �� ����������� ���� ����, ��� ����� ID � �����������.", -1)
				end
			imgui.Text('           ' .. fa.ICON_STREET_VIEW .. u8(' ����� ������ -')); imgui.SameLine()
				if imgui.Button(u8(" /finder ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ����� ������ (��� �� ���: /find [ID] ������ ID ��������� ����� /addid [ID])", -1)
				end
			imgui.Text('           ' .. fa.ICON_STAR .. u8(' ������ ������������ -')); imgui.SameLine()
				if imgui.Button(u8(" /zgo ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������ ������������ ������ (��� �� ���: /z [ID] ������ ID ��������� ����� /addid [ID])", -1)
				end
			imgui.Text('           ' .. fa.ICON_CAR .. u8(' ������ ������������� -')); imgui.SameLine()
				if imgui.Button(u8(" /deti ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������ ������������� ������ (��� �� ���: /det [ID] ������ ID ��������� ����� /addid [ID])", -1)
				end
			imgui.Text('           ' .. fa.ICON_STAR_HALF_O .. u8(' ��������� ������������� -')); imgui.SameLine()
				if imgui.Button(u8(" /deli ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ��������� ������������� ������ (��� �� ���: /delive [ID] ������ ID ��������� ����� /addid [ID])", -1)
				end
			imgui.Text('           ' .. fa.ICON_TIMES_CIRCLE .. u8(' ��������� ����� ������ ����� [/bail] -')); imgui.SameLine()
				if imgui.Button(u8(" /unb ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ��������� ����� ������ �� ������ (��� �� ���: /unbail [ID] ������ ID ��������� ����� /addid [ID])", -1)
				end
			imgui.Text('           ' .. fa.ICON_STAR_O .. u8(' ������ ������� ������ -')); imgui.SameLine()
				if imgui.Button(u8(" /lvl [ID] ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������ ������� ������ �� ��� ID.", -1)
				end

				--imgui.NewLine()

			imgui.Spacing()
			imgui.Separator()
				imgui.Text('  ' .. fa.ICON_THUMB_TACK .. u8(' ���. ������� �������:'));
			imgui.Spacing()
			imgui.Separator()

			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' ������ ��������� �� ������ -')); imgui.SameLine()
				if imgui.Button(u8(" ��� + 1 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} �������� ��������� �� ������ �� �������� �� ���������� � � ��� ����� ������ '1'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' ������ ������������ ������ -')); imgui.SameLine()
				if imgui.Button(u8(" ��� + 2 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} �������� ������������ ������ �� �������� �� ���������� � � ��� ����� ������ '2'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' ����� ��������� � ������ -')); imgui.SameLine()
				if imgui.Button(u8(" ��� + 3 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������� ��������� � ������ �� �������� �� ����������� � � ��� ����� ������ '3'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' ��������� ��������� -')); imgui.SameLine()
				if imgui.Button(u8(" ��� + 4 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������ ��������� � ������ �� �������� �� ����������� � � ��� ����� ������ '4'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' ����������� � ������� -')); imgui.SameLine()
				if imgui.Button(u8(" ��� + 5 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ����������� � ������� �� �������� �� ����������� � � ��� ����� ������ '5'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' �������� ������ -')); imgui.SameLine()
				if imgui.Button(u8(" ��� + 6 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ���������� ������ �� �������� �� ����������� � � ��� ����� ������ '6'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' ������ ������ -')); imgui.SameLine()
				if imgui.Button(u8(" ��� + 0 ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} ������ �� (/su [ID]) ������ �� �������� �� ����������� � � ��� ����� ������ '0'", -1)
				end
			imgui.Text('           ' .. fa.ICON_CROSSHAIRS .. u8(' �������� ID -')); imgui.SameLine()
				if imgui.Button(u8(" ��� + Z ")) then
					sampAddChatMessage("{32CD32}[BB]{FFFFF0} �������� ID ������ �� �������� �� ����������� � � ��� ����� ������ 'Z'. ������� ������� ������������� /addid [ID]", -1)
				end
		imgui.EndChild()
		imgui.End()
    end
end
-- ������� ������� ������� ����� ��� ������ ��  ���� "?" || ������������: ShowHelpMarker('Text')
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

-- ��������� �������
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

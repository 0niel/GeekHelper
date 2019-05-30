---------[ Script Meta ]--------------------------------
script_name('GeekHelper')
script_authors('Oniel', 'CzarAlex')
script_version_number(1)
script_version("0.1")

local res = pcall(require, "lib.moonloader")
assert(res, 'Library lib.moonloader not found')
---------------------------------------------------------------
local res, ffi = pcall(require, 'ffi')
assert(res, 'Library ffi not found')
---------------------------------------------------------------
local dlstatus = require('moonloader').download_status
---------------------------------------------------------------
local res = pcall(require, 'lib.sampfuncs')
assert(res, 'Library lib.sampfuncs not found')
---------------------------------------------------------------
local res, sampev = pcall(require, 'lib.samp.events')
assert(res, 'Library SAMP Events not found')
---------------------------------------------------------------
local res, bass = pcall(require, "lib.bass")
assert(res, 'Library BASS not found.')
---------------------------------------------------------------
local res, key = pcall(require, "vkeys")
assert(res, 'Library vkeys not found')
---------------------------------------------------------------
local res, imgui = pcall(require, "imgui")
assert(res, 'Library imgui not found')
---------------------------------------------------------------
local res, encoding = pcall(require, "encoding")
assert(res, 'Library encoding not found')
---------------------------------------------------------------
local res, inicfg = pcall(require, "inicfg")
assert(res, 'Library inicfg not found')
---------------------------------------------------------------
local res, memory = pcall(require, "memory")
assert(res, 'Library memory not found')
---------------------------------------------------------------
local res, rkeys = pcall(require, "rkeys")
assert(res, 'Library rkeys not found')
---------------------------------------------------------------
local res, hk = pcall(require, 'lib.imcustom.hotkey')
assert(res, 'Library imcustom not found')
---------------------------------------------------------------
local res, https = pcall(require, 'ssl.https')
assert(res, 'Library ssl.https not found')
---------------------------------------------------------------
local lanes = require('lanes').configure()
---------------------------------------------------------------
local res, sha1 = pcall(require, 'sha1')
assert(res, 'Library sha1 not found')
---------------------------------------------------------------
local res, basexx = pcall(require, 'basexx')
assert(res, 'Library basexx not found')
---------------------------------------------------------------
local res, fa = pcall(require, 'faIcons')
assert(res, 'Library faIcons not found')
local bNotf, notf = pcall(import, "imgui_notf.lua")
-----------------------------------------------------------------------------------

encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

---------[ ����� ��� ��������� ���������� ]---------------------------------------
-- ������ ��� ����
local win_state = {}
win_state['update'] = imgui.ImBool(false)
win_state['main'] = imgui.ImBool(false)
win_state['settings'] = imgui.ImBool(false)


local SET = {
 	settings = {
		autologin = false,
		autogoogle = false,
		autopass = '',
		googlekey = '',
		strobes = false,
		test = false,
	}
	}
-----------------------------------------------------------------------------------
------------------------------- ����� ---------------------------------------------
-----------------------------------------------------------------------------------

-- ���� ����������� ���� alt+tab(������ ����� ����� ��������� � ����)
writeMemory(0x555854, 4, -1869574000, true)
writeMemory(0x555858, 1, 144, true)

-- ������� �������� �������� ����. BY KEP4Ik
function patch()
	if memory.getuint8(0x748C2B) == 0xE8 then
		memory.fill(0x748C2B, 0x90, 5, true)
	elseif memory.getuint8(0x748C7B) == 0xE8 then
		memory.fill(0x748C7B, 0x90, 5, true)
	end
	if memory.getuint8(0x5909AA) == 0xBE then
		memory.write(0x5909AB, 1, 1, true)
	end
	if memory.getuint8(0x590A1D) == 0xBE then
		memory.write(0x590A1D, 0xE9, 1, true)
		memory.write(0x590A1E, 0x8D, 4, true)
	end
	if memory.getuint8(0x748C6B) == 0xC6 then
		memory.fill(0x748C6B, 0x90, 7, true)
	elseif memory.getuint8(0x748CBB) == 0xC6 then
		memory.fill(0x748CBB, 0x90, 7, true)
	end
	if memory.getuint8(0x590AF0) == 0xA1 then
		memory.write(0x590AF0, 0xE9, 1, true)
		memory.write(0x590AF1, 0x140, 4, true)
	end
end
patch()
-----------------------------------------------------------------------------------
------------------------------- MAIN ----------------------------------------------
-----------------------------------------------------------------------------------
function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then -- ���� SF ��� SA:MP �� ���������
    return -- ��������� ������ �������
end
while not isSampAvailable() do -- ���� ���� ������� isSampAvailable() ������ true
    wait(0) -- ������������� ����������� ��������, ��� �� ���� ���� �� �������
    -- �������� 0 ������� ��� �� ���� ��������� ���� (Frame)
end
print("�������� ��������� ������� � ��� ������������")
sampAddChatMessage("[GeekHelper] {FFFFFF}������ ��������� � ����, ������: {00C2BB}"..thisScript().version.."{ffffff}, �������� �������������.", 0x046D63)
print("�������� �������� ����������.")
updateCheck()
imgui.Process = win_state['update'].v or win_state['main'].v
while not isUpdateCheck do wait(0) end -- ���� �� �������� ���������� �������� ������
sampRegisterChatCommand("gh", mainmenu)
end

function mainmenu() -- ������� �������� ��������� ���� �������
	win_state['main'].v = not win_state['main'].v
end

function load_settings() -- �������� ��������
	-- CONFIG CREATE/LOAD
	ini = inicfg.load(SET, getGameDirectory()..'\\moonloader\\config\\GeekHelper\\settings.ini')

	-- LOAD CONFIG INFO
	test = imgui.ImBool(ini.settings.test)
end
function saveSettings(args, key) -- ������� ���������� ��������, args 1 = ��� ���������� �������, 2 = ��� ������ �� ����, 3 = ���������� ������ + ����� key, 4 = ������� ����������.

	if aaudio ~= nil then
		bass.BASS_StreamFree(aaudio)
	end
	if doesFileExist(bfile) then
		os.remove(bfile)
	end
	local f = io.open(bfile, "w")
	if f then
		f:write(encodeJson(tBindList))
		f:close()
	end

	if doesFileExist(bindfile) then
		os.remove(bindfile)
	end
	local f2 = io.open(bindfile, "w")
	if f2 then
		f2:write(encodeJson(mass_bind))
		f2:close()
	end

	ini.settings.test = test.v
	inicfg.save(SET, "/MoD-Helper/settings.ini")
	if args == 1 then
		print("============== SCRIPT WAS TERMINATED ==============")
		print("��������� � ������� ��������� � �����.")
		print("GeekHelper, version: "..thisScript().version)

		if doesFileExist(getWorkingDirectory() .. '\\GeekHelper\\files\\regst.data') then
			print("File regst.data is finded")
		else
			print("File regst.data not finded")
		end
		print("==================================================")
	elseif args == 2 then
		print("============== GAME WAS TERMINATED ===============")
		print("==================================================")
	elseif args == 3 and key ~= nil then
		print("============== "..key.." SAVED ==============")
	elseif args == 4 then
		print("============== SAVED ==============")
	end
end
-----------------------------------------------------------------------------------
function updateCheck() -- �������� ����������
	local zapros = https.request("https://geekhub.pro/samp/geekhelper/version.json")

	if zapros ~= nil then
		local info2 = decodeJson(zapros)

		if info2.latest_number ~= nil and info2.latest ~= nil then
			updatever = info2.latest
			version = tonumber(info2.latest_number)

			print("[GeekHelper] �������� �������� ������")

			if version > tonumber(thisScript().version_num) then
				print("[GeekHelper] ���������� ����������")
				if bNotf then
					notf.addNotification(" ���������� ���������� �� ������ "..updatever..".", 5, 2)
				end
				sampAddChatMessage("[GeekHelper]{FFFFFF} ���������� ���������� �� ������ "..updatever..".", 0x046D63)
				win_state['update'].v = true
				isUpdateCheck = true
			else
				print("[GeekHelper] ����� ���������� ���, �������� ������ �������")
				if checkupd then
					if bNotf then
						notf.addNotification("� ��� ����� ���������� ������ �������: "..thisScript().version..".\n������������� ��������� ������ ���, ��������� �����������.", 5, 2)
					end
					sampAddChatMessage("[GeekHelper]{FFFFFF} � ��� ����� ���������� ������ �������: "..thisScript().version..".", 0x046D63)
					sampAddChatMessage("[GeekHelper]{FFFFFF} ������������� ��������� ������ - ���, ��������� �����������.", 0x046D63)
					checkupd = false
				end
				isUpdateCheck = true
			end
		else
			sampAddChatMessage("[GeekHelper]{FFFFFF} ������ ��� ��������� ���������� �� ����������.", 0x046D63)
			print("[GeekHelper] JSON file read error")
			isUpdateCheck = true
		end
	else
		sampAddChatMessage("[GeekHelper]{FFFFFF} �� ������� ��������� ������� ����������, ���������� �����.", 0x046D63)
		isUpdateCheck = true
	end
end
-------------------------------------------------IMGUI ZONE---------------------------------------

-- ����������� ������ ��� ������ ������
local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
	if fa_font == nil then
		local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
		font_config.MergeMode = true

		fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/GeekHelper/files/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
	end
end


function async_http_request(method, url, args, resolve, reject) -- ����������� �������, ������� ����� �������, ��� ��� ������������ ������������� ���� ����� ������� � ��� ;D
	local request_lane = lanes.gen('*', {package = {path = package.path, cpath = package.cpath}}, function()
		local requests = require 'requests'
        local ok, result = pcall(requests.request, method, url, args)
        if ok then
            result.json, result.xml = nil, nil -- cannot be passed through a lane
            return true, result
        else
            return false, result -- return error
        end
    end)
    if not reject then reject = function() end end
    lua_thread.create(function()
        local lh = request_lane()
        while true do
            local status = lh.status
            if status == 'done' then
                local ok, result = lh[1], lh[2]
                if ok then resolve(result) else reject(result) end
                return
            elseif status == 'error' then
                return reject(lh[1])
            elseif status == 'killed' or status == 'cancelled' then
                return reject(status)
            end
            wait(0)
        end
    end)
end

function imgui.OnDrawFrame()
	local tLastKeys = {} -- ��� � ��� ��� ������
	local sw, sh = getScreenResolution() -- �������� ���������� ������
	local btn_size = imgui.ImVec2(-0.1, 0) -- � ��� "�������" �������� ������
	local btn_size2 = imgui.ImVec2(160, 0)
	local btn_size3 = imgui.ImVec2(140, 0)

	-- ��� �� ������������ ������ ��� ������������
	imgui.ShowCursor = win_state['update'].v
	if win_state['main'].v then -- �������� ������

		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(280, 250), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' GeekHelper', win_state['main'], imgui.WindowFlags.NoResize)
		-- ������ ��������, ������
		if imgui.Button(fa.ICON_COGS..u8' ���������', btn_size) then print("������� � ������ ��������") win_state['settings'].v = not win_state['settings'].v end
		imgui.End()
	end
	if win_state['settings'].v then -- ���� ��������
	end
	if win_state['update'].v then -- ���� ���������� �������
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(450, 200), imgui.Cond.FirstUseEver)
        imgui.Begin(u8('����������'), nil, imgui.WindowFlags.NoResize)
		imgui.Text(u8'���������� ���������� �� ������: '..updatever)
		imgui.Separator()
		imgui.TextWrapped(u8("��� ��������� ���������� ���������� ������������� ������������, ����������� ������������ ����������� ��������� ���������� ����� ����, ��� ������� ������ ����� ������������ ����� ����������� � ����� �� ��������."))
		if imgui.Button(u8'������� � ���������� ����������', btn_size) then
			async_http_request('GET', 'https://geekhub.pro/samp/geekhelper/GeekHelper.lua', nil,
				function(response) -- ��������� ��� �������� ���������� � ��������� ������
				local f = assert(io.open(getWorkingDirectory() .. '/GeekHelper.lua', 'wb'))
				f:write(response.text)
				f:close()
				sampAddChatMessage("[GeekHelper]{FFFFFF} ���������� �������, ������������� ������.", 0x046D63)
				thisScript():reload()
			end,
			function(err) -- ��������� ��� ������, err - ����� ������. ��� ������� ����� �� ���������
				print(err)
				sampAddChatMessage("[GeekHelper]{FFFFFF} ��������� ������ ��� ����������, ���������� �����.", 0x046D63)
				win_state['update'].v = not win_state['update'].v
				return
			end)
		end
		if imgui.Button(u8'�������', btn_size) then win_state['update'].v = not win_state['update'].v end
		imgui.End()
	end
end

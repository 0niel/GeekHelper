
script_name('GeekHelper')
script_authors('Oniel', 'CzarAlex')
script_version_number(1)
script_version("0.1")

local res = pcall(require, "lib.moonloader")
assert(res, 'Library lib.moonloader not found')

local res, ffi = pcall(require, 'ffi')
assert(res, 'Library ffi not found')

local dlstatus = require('moonloader').download_status

local res = pcall(require, 'lib.sampfuncs')
assert(res, 'Library lib.sampfuncs not found')

local res, sampev = pcall(require, 'lib.samp.events')
assert(res, 'Library SAMP Events not found')

local res, bass = pcall(require, "lib.bass")
assert(res, 'Library BASS not found.')

local res, key = pcall(require, "vkeys")
assert(res, 'Library vkeys not found')

local res, imgui = pcall(require, "imgui")
assert(res, 'Library imgui not found')

local res, encoding = pcall(require, "encoding")
assert(res, 'Library encoding not found')

local res, inicfg = pcall(require, "inicfg")
assert(res, 'Library inicfg not found')

local res, memory = pcall(require, "memory")
assert(res, 'Library memory not found')

local res, rkeys = pcall(require, "rkeys")
assert(res, 'Library rkeys not found')

local res, hk = pcall(require, 'lib.imcustom.hotkey')
assert(res, 'Library imcustom not found')

local res, https = pcall(require, 'ssl.https')
assert(res, 'Library ssl.https not found')

local lanes = require('lanes').configure()

local res, sha1 = pcall(require, 'sha1')
assert(res, 'Library sha1 not found')

local res, basexx = pcall(require, 'basexx')
assert(res, 'Library basexx not found')

local res, fa = pcall(require, 'faIcons')
assert(res, 'Library faIcons not found')

local bNotf, notf = pcall(import, "imgui_notf.lua")

local res, md5 = pcall(require, 'md5')
assert(res, 'Library md5 not found')

require "luairc"

IRCLogs = {}
local ansi_decode={
  [128]='\208\130',[129]='\208\131',[130]='\226\128\154',[131]='\209\147',[132]='\226\128\158',[133]='\226\128\166',
  [134]='\226\128\160',[135]='\226\128\161',[136]='\226\130\172',[137]='\226\128\176',[138]='\208\137',[139]='\226\128\185',
  [140]='\208\138',[141]='\208\140',[142]='\208\139',[143]='\208\143',[144]='\209\146',[145]='\226\128\152',
  [146]='\226\128\153',[147]='\226\128\156',[148]='\226\128\157',[149]='\226\128\162',[150]='\226\128\147',[151]='\226\128\148',
  [152]='\194\152',[153]='\226\132\162',[154]='\209\153',[155]='\226\128\186',[156]='\209\154',[157]='\209\156',
  [158]='\209\155',[159]='\209\159',[160]='\194\160',[161]='\209\142',[162]='\209\158',[163]='\208\136',
  [164]='\194\164',[165]='\210\144',[166]='\194\166',[167]='\194\167',[168]='\208\129',[169]='\194\169',
  [170]='\208\132',[171]='\194\171',[172]='\194\172',[173]='\194\173',[174]='\194\174',[175]='\208\135',
  [176]='\194\176',[177]='\194\177',[178]='\208\134',[179]='\209\150',[180]='\210\145',[181]='\194\181',
  [182]='\194\182',[183]='\194\183',[184]='\209\145',[185]='\226\132\150',[186]='\209\148',[187]='\194\187',
  [188]='\209\152',[189]='\208\133',[190]='\209\149',[191]='\209\151'
}
local utf8_decode={
  [128]={[147]='\150',[148]='\151',[152]='\145',[153]='\146',[154]='\130',[156]='\147',[157]='\148',[158]='\132',[160]='\134',[161]='\135',[162]='\149',[166]='\133',[176]='\137',[185]='\139',[186]='\155'},
  [130]={[172]='\136'},
  [132]={[150]='\185',[162]='\153'},
  [194]={[152]='\152',[160]='\160',[164]='\164',[166]='\166',[167]='\167',[169]='\169',[171]='\171',[172]='\172',[173]='\173',[174]='\174',[176]='\176',[177]='\177',[181]='\181',[182]='\182',[183]='\183',[187]='\187'},
  [208]={[129]='\168',[130]='\128',[131]='\129',[132]='\170',[133]='\189',[134]='\178',[135]='\175',[136]='\163',[137]='\138',[138]='\140',[139]='\142',[140]='\141',[143]='\143',[144]='\192',[145]='\193',[146]='\194',[147]='\195',[148]='\196',
  [149]='\197',[150]='\198',[151]='\199',[152]='\200',[153]='\201',[154]='\202',[155]='\203',[156]='\204',[157]='\205',[158]='\206',[159]='\207',[160]='\208',[161]='\209',[162]='\210',[163]='\211',[164]='\212',[165]='\213',[166]='\214',
  [167]='\215',[168]='\216',[169]='\217',[170]='\218',[171]='\219',[172]='\220',[173]='\221',[174]='\222',[175]='\223',[176]='\224',[177]='\225',[178]='\226',[179]='\227',[180]='\228',[181]='\229',[182]='\230',[183]='\231',[184]='\232',
  [185]='\233',[186]='\234',[187]='\235',[188]='\236',[189]='\237',[190]='\238',[191]='\239'},
  [209]={[128]='\240',[129]='\241',[130]='\242',[131]='\243',[132]='\244',[133]='\245',[134]='\246',[135]='\247',[136]='\248',[137]='\249',[138]='\250',[139]='\251',[140]='\252',[141]='\253',[142]='\254',[143]='\255',[144]='\161',[145]='\184',
  [146]='\144',[147]='\131',[148]='\186',[149]='\190',[150]='\179',[151]='\191',[152]='\188',[153]='\154',[154]='\156',[155]='\158',[156]='\157',[158]='\162',[159]='\159'},[210]={[144]='\165',[145]='\180'}
}

local nmdc = {
  [36] = '$',
  [124] = '|',
}


lfs = require('lfs')
encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local as_action = require('moonloader').audiostream_state
local volume = imgui.ImFloat('50')
local antiafkmode = imgui.ImBool(false)
local selected = 1
local searchBuf = imgui.ImBuffer(256)


local win_state = {}
win_state['chat_settings'] = imgui.ImBool(false)
win_state['image'] = imgui.ImBool(true)
win_state['update'] = imgui.ImBool(false)
win_state['main'] = imgui.ImBool(false)
win_state['settings'] = imgui.ImBool(false)
win_state['mods'] = imgui.ImBool(false)
win_state['style'] = imgui.ImBool(false)
win_state['about'] = imgui.ImBool(false)
win_state['mp3'] = imgui.ImBool(false)
win_state['mp3_informer'] = imgui.ImBool(false)
win_state['chat'] = imgui.ImBool(false)

ffi.cdef[[
	short GetKeyState(int nVirtKey);
	bool GetKeyboardLayoutNameA(char* pwszKLID);
	int GetLocaleInfoA(int Locale, int LCType, char* lpLCData, int cchData);

	void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
	uint32_t __stdcall CoInitializeEx(void*, uint32_t);

]]

local BuffSize = 32
local KeyboardLayoutName = ffi.new("char[?]", BuffSize)
local LocalInfo = ffi.new("char[?]", BuffSize)
local shell32 = ffi.load 'Shell32'
local ole32 = ffi.load 'Ole32'
hparmCout = imgui.ImBool(false)
chatInfo = imgui.ImBool(false)

strobesOn = imgui.ImBool(false)
cb1 = imgui.ImBool(false)
cb2 = imgui.ImBool(false)
rb = imgui.ImInt(1)
c = imgui.ImInt(1)
it = imgui.ImBuffer(256)
df = imgui.ImFloat(1)
sf = imgui.ImFloat(1)
lb = imgui.ImInt(1)
s = imgui.ImBool(false)
f4 = imgui.ImFloat4(0, 0, 0, 0)
pres = 0

test_chat_data = decodeJson([[
[
	{
		"username": "Alex",
		"status": "user",
		"message": "hello czar",
		"time": "09:03:12"
	},
	{
		"username": "Czar",
		"status": "vip",
		"message": "hello alex",
		"time": "09:03:16"
	},
	{
		"username": "Lex",
		"status": "helper",
		"message": "lol",
		"time": "09:03:23"
	},
	{
		"username": "Kreyn",
		"status": "developer",
		"message": "test mess",
		"time": "09:03:24"
	}
]
]])
chat_text = imgui.ImBuffer(256)

musicpath_mp3 = imgui.ImBuffer(256)
lang_num = imgui.ImInt(1)
fpsUnlock = imgui.ImBool(false)
fpsChange = fpsUnlock.v

notf_text = imgui.ImBuffer(256)
notf_duration = imgui.ImInt(1)
notf_type = imgui.ImInt(1)

keyShow = VK_M
reduceZoom = true

function AnsiToUtf8(s)
	local r, b = ''
	for i = 1, s and s:len() or 0 do
		b = s:byte(i)
		if b < 128 then
			r = r..string.char(b)
		else
			if b > 239 then
				r = r..'\209'..string.char(b - 112)
			elseif b > 191 then
				r = r..'\208'..string.char(b - 48)
			elseif ansi_decode[b] then
				r = r..ansi_decode[b]
			else
				r = r..'_'
			end
		end
	end
	return r
end
function Utf8ToAnsi(s)
	local a, j, r, b = 0, 0, ''
	for i = 1, s and s:len() or 0 do
		b = s:byte(i)
		if b < 128 then
			if nmdc[b] then
				r = r..nmdc[b]
			else
				r = r..string.char(b)
			end
		elseif a == 2 then
			a, j = a - 1, b
		elseif a == 1 then
			if (utf8_decode[j] or {})[b] then
				a, r = a - 1, r..utf8_decode[j][b]
			end
		elseif b == 226 then
			a = 2
		elseif b == 194 or b == 208 or b == 209 or b == 210 then
			j, a = b, 1
		else
			r = r..'_'
		end
	end
	return r
end
require("config.SAMPIRC_Config") -- load configuration
Channel = "#GeekHelper"
Server = "irc.ircnet.ru"

DebugMode = false
local s = irc.new{nick = Nick}
connected = false
function GetState(var)
	if var then
	return "{00FF00}On"
	else
	return "{FF0000}Off"
	end
end
function secondThread()
	while not isSampfuncsLoaded() do
		wait(1000)
	end
	if AutoConnect then
		connected = true
	end
	sampRegisterChatCommand("irc_connection", ircmenu)
	while true do
		wait(0)
		local resultMain, buttonMain, listMain = sampHasDialogRespond(154)
		if resultMain == true then
			if buttonMain == 1 then
				if listMain == 0 then
					sampShowDialog(1289, "Input", "Ник:", "Ok", "Exit", 1)
				end
				if listMain == 1 then
					sampAddChatMessage("Connecting... (It may hang for a while, but it's normal!)", 0x00ff00)
					connected = true
				end
				if listMain == 2 then
					sampAddChatMessage("You disconnected", 0xff0000)
					thisScript():reload()
				end
				if listMain == 3 then
				sampAddChatMessage("Changed value!", -1)
				irclogs = not irclogs
				end
				if listMain == 4 then
				sampAddChatMessage("Changed value!", -1)
				AutoConnect = not AutoConnect
				end
				if listMain == 5 then
					sampAddChatMessage("Forceing save...", 0xB9C9BF)
					saveChanges()
					sampAddChatMessage("Save complete!", 0x00ff00)
				end
				if listMain == 6 then
					sampShowDialog(1292, "Change value", "Enter 0 to off sound\nSound ID:", "Ok", "Exit", 1)
				end
				if listMain == 7 then
					sampShowDialog(1293, "Change value", "{FF0000}This option may cause performance problems \nIRC Latency:", "Ok", "Exit", 1)
				end
				if listMain == 8 then
				DebugMode = not DebugMode
				sampAddChatMessage("Debug mode: "..GetState(DebugMode))
				end
			end
			saveChanges()
		end
		local resultInput, buttonInput, listInput, stringInput = sampHasDialogRespond(1289)
		if resultInput == true then
		saveChanges()
			if buttonInput == 1 then
				Nick = stringInput
				sampAddChatMessage("Now nick: " .. Nick, -1)
			else sampAddChatMessage("You pressed Exit", -1)
			end
		end
		local resultInput, buttonInput, listInput, stringInput = sampHasDialogRespond(1290)
		if resultInput == true then
			if buttonInput == 1 then
				Server = stringInput
				sampAddChatMessage("Now server: " .. Server, -1)
			else sampAddChatMessage("You pressed Exit", -1)
			end
		end
		local resultInput, buttonInput, listInput, stringInput = sampHasDialogRespond(1291)
		if resultInput == true then
			if buttonInput == 1 then
				Channel = stringInput
				sampAddChatMessage("Now channel: " .. Channel, -1)
			else sampAddChatMessage("You pressed Exit", -1)
			end
		end
		local resultInput, buttonInput, listInput, stringInput = sampHasDialogRespond(1292)
		if resultInput == true then
			if buttonInput == 1 then
				MessageSound = stringInput
				sampAddChatMessage("Now message sound ID: " .. MessageSound, -1)
			else sampAddChatMessage("You pressed Exit", -1)
			end
		end
		local resultInput, buttonInput, listInput, stringInput = sampHasDialogRespond(1293)
		if resultInput == true then
			if buttonInput == 1 then
				IRCLatency = stringInput
				sampAddChatMessage("Now IRC Latency: " .. IRCLatency, -1)
			else sampAddChatMessage("You pressed Exit", -1)
			end
		end
	end
end
function saveChanges()
	file = io.open("moonloader/config/SAMPIRC_Config.lua", "w")
	StrforSave = string.format('Nick = "%s"\nirclogs = %s\nAutoConnect = %s\nMessageSound = %d\nIRCLatency = %d',Nick, tostring(irclogs), tostring(AutoConnect), MessageSound, IRCLatency)
	file:write(StrforSave)
	file:close()
end

function imgui.TextColoredRGB(string)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col

    local function color_imvec4(color)
        if color:upper() == 'SSSSSS' then return colors[clr.Text] end
        local color = type(color) == 'number' and ('%X'):format(color):upper() or color:upper()
        local rgb = {}
        for i = 1, #color/2 do rgb[#rgb+1] = tonumber(color:sub(2*i-1, 2*i), 16) end
        return imgui.ImVec4(rgb[1]/255, rgb[2]/255, rgb[3]/255, rgb[4] and rgb[4]/255 or colors[clr.Text].w)
    end

    local function render_text(string)
        local text, color = {}, {}
        local m = 1
        while string:find('{......}') do
            local n, k = string:find('{......}')
            text[#text], text[#text+1] = string:sub(m, n-1), string:sub(k+1, #string)
            color[#color+1] = color_imvec4(string:sub(n+1, k-1))
            local t1, t2 = string:sub(1, n-1), string:sub(k+1, #string)
            string = t1..t2
            m = k-7
        end
        if text[0] then
            for i, _ in ipairs(text) do
                imgui.TextColored(color[i] or colors[clr.Text], u8(text[i]))
                imgui.SameLine(nil, 0)
            end
            imgui.NewLine()
        else imgui.Text(u8(string)) end
    end

    render_text(string)
end

function doesDirExist(dir)
	return os.rename(dir, dir)
end

function SCM(text)
	sampAddChatMessage("[GeekHelper]" .. text, 0x046D63)
end

ini = {}
function ini:save(data, path, name)
	lfs.mkdir(path)
	res = ''
	for sec, tbl in pairs(data) do
		res = res..'['..sec..']\n'
		for key, val in pairs(tbl) do
			if sec == 'imgui' then
				res = res..key..'='..type(val.v)..'.'..tostring(val.v)..'\n'
			else
				res = res..key..'='..tostring(val)..'\n'
			end
		end
	end
	local fw
	fw = io.open(path..name, 'w')
	fw:write(res)
	fw:close()
end

function ini:load(path)
	local fw
	fw = io.open(path, 'r')
	if txt == nil then return nil end
	txt = fw:read('*a')
	local new1 = {}
	local sec1 = ''
	for line in string.gmatch(txt, '([^'..'\n'..']+)') do
		t = {}
		line:gsub('.', function(c) table.insert(t, c) end)
		if t[1] == '[' then
			for tmp in string.gmatch(line, '(%w+)') do
				new1[tmp] = {}
				sec1 = tmp
			end
		else
			f = false
			t1 = nil
			t2 = nil
			for tmp in string.gmatch(line, '([^'..'='..']+)') do
				if not f then t1 = tmp
				else t2 = tmp end
				f = not f
			end
			if sec1 == 'imgui' then
				local k = false
				local tp = nil
				local vl = nil
				for tt in string.gmatch(t2, '([^'..'.'..']+)') do
					if not k then tp = tt
					else vl = tt end
					k = not k
				end
				if tp == 'boolean' then
					if vl == 'false' then new1[sec1][t1] = imgui.ImBool(false)
					else new1[sec1][t1] = imgui.ImBool(true) end
				elseif tp == 'number' ~= nil then
					if string.match(vl, '%.') == nil then new1[sec1][t1] = imgui.ImInt(t2)
					else new1[sec1][t1] = imgui.ImFloat(t2) end
				end
			else
				new1[sec1][t1] = t2
			end
		end
	end
	fw:close()
	return new1
end

local Config = {
	ini = {
		style = {
			name = 'Midnight'
		},
		global = {
			language = 'ru',
			musicpath = ''
		}
	},
	name = 'settings.ini',
	path = '\\moonloader\\config\\GeekHelper\\',
	lang = {}
}

local Localization = {}

function Localization:get(k)
	local t = Localization[Config.ini.global.language][k]
	if t ~= nil then return t
	else return 'Localization.'..Config.ini.global.language..'.'..k
	end
end

function ChangeLanguage()
	Config.ini.global.language = Config.lang[lang_num.v + 1]
end

function InitializeLocalizations()
	for tt in io.popen([[dir "moonloader\GeekHelper\localizations" /b]]):lines() do
		tw = tt:match('(.*).json')
		table.insert(Config.lang, tw)
	end

	for _, lang in pairs(Config.lang) do
		f = io.open(getGameDirectory()..'\\moonloader\\GeekHelper\\localizations\\'..lang..'.json')
		if f ~= nil then
			local txt = f:read('*a')
			Localization[lang] = decodeJson(txt)
			if bNotf then notf.addNotification('Файл с '..lang..' локализацией успешно загружен.', 4, 2) end
		else
			if bNotf then notf.addNotification('Ошибка загрузки '..lang..' локализации.', 4, 3) end
		end
	end
end

function Config:Save()
	ini:save(Config.ini, getGameDirectory()..Config.path, Config.name)
	if bNotf then notf.addNotification('Конфигурация успешно загружена.', 4, 2) end
end

function Config:Load()
	if not doesFileExist(getGameDirectory()..Config.path..Config.name) then
		inicfg.save(Config.ini, 'GeekHelper\\settings.ini')
	end
	local tmpn = ini:load(getGameDirectory()..Config.path..Config.name)
	if tmpn ~= nil then
		for sec, tbl in pairs(tmpn) do
			if Config.ini[sec] == nil then Config.ini[sec] = {} end
			for key, val in pairs(tbl) do Config.ini[sec][key] = val end
		end
	else
		if bNotf then notf.addNotification('Конфигурация не загружена.', 4, 3) end
	end
	Style(Config.ini.style.name)
	if bNotf then notf.addNotification('Конфигурация успешно загружена.', 4, 2) end
end

function Style(name)
	ok = true
	if name == 'Androvira' then
		imgui.GetStyle().Colors[imgui.Col.Text]                 = imgui.ImVec4(0.80, 0.80, 0.83, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.24, 0.23, 0.29, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.07, 0.07, 0.09, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PopupBg]              = imgui.ImVec4(0.07, 0.07, 0.09, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.Border]               = imgui.ImVec4(0.80, 0.80, 0.83, 0.88)
	    imgui.GetStyle().Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(0.92, 0.91, 0.88, 0.00)
	    imgui.GetStyle().Colors[imgui.Col.FrameBg]              = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.24, 0.23, 0.29, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(1.00, 0.98, 0.95, 0.75)
	    imgui.GetStyle().Colors[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.07, 0.07, 0.09, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.80, 0.80, 0.83, 0.31)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ComboBg]              = imgui.ImVec4(0.19, 0.18, 0.21, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.80, 0.80, 0.83, 0.31)
	    imgui.GetStyle().Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(0.80, 0.80, 0.83, 0.31)
	    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.24, 0.23, 0.29, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
	    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.CloseButton]          = imgui.ImVec4(0.40, 0.39, 0.38, 0.16)
	    imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]   = imgui.ImVec4(0.40, 0.39, 0.38, 0.39)
	    imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]    = imgui.ImVec4(0.40, 0.39, 0.38, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PlotLines]            = imgui.ImVec4(0.40, 0.39, 0.38, 0.63)
	    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]     = imgui.ImVec4(0.25, 1.00, 0.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PlotHistogram]        = imgui.ImVec4(0.40, 0.39, 0.38, 0.63)
	    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.25, 1.00, 0.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(0.25, 1.00, 0.00, 0.43)
	    imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(1.00, 0.98, 0.95, 0.73)

	elseif name == 'Hacker' then
	    imgui.GetStyle().Colors[imgui.Col.Text]                 = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.00, 0.54, 0.98, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.00, 0.00, 0.00, 0.89)
	    imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
	    imgui.GetStyle().Colors[imgui.Col.PopupBg]              = imgui.ImVec4(0.07, 0.07, 0.09, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.Border]               = imgui.ImVec4(0.18, 0.87, 0.00, 0.50)
	    imgui.GetStyle().Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(1.00, 1.00, 1.00, 0.10)
	    imgui.GetStyle().Colors[imgui.Col.FrameBg]              = imgui.ImVec4(0.16, 0.16, 0.16, 0.31)
	    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.16, 0.16, 0.16, 0.31)
	    imgui.GetStyle().Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.21, 0.21, 0.21, 0.67)
	    imgui.GetStyle().Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.02, 0.59, 0.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(0.09, 0.31, 0.00, 0.00)
	    imgui.GetStyle().Colors[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.02, 0.59, 0.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.86, 0.86, 0.86, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.00, 0.00, 0.00, 0.80)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.23, 0.23, 0.23, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.23, 0.23, 0.23, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.00, 0.38, 0.00, 1.00)
	    --imgui.GetStyle().Colors[imgui.Col.ComboBg]              = imgui.ImVec4(0.86, 0.86, 0.86, 0.99)
	    imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.00, 0.84, 0.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(0.13, 0.50, 0.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.13, 0.50, 0.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(0.00, 0.00, 0.00, 0.40)
	    imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.00, 0.61, 0.01, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.06, 0.53, 0.98, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.26, 0.59, 0.98, 0.31)
	    imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.26, 0.59, 0.98, 0.80)
	    imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
	    --imgui.GetStyle().Colors[imgui.Col.Column]               = imgui.ImVec4(0.39, 0.39, 0.39, 1.00)
	    --imgui.GetStyle().Colors[imgui.Col.ColumnHovered]        = imgui.ImVec4(0.26, 0.59, 0.98, 0.78)
	    --imgui.GetStyle().Colors[imgui.Col.ColumnActive]         = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(0.00, 1.00, 0.22, 0.59)
	    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(0.26, 0.59, 0.98, 0.67)
	    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(0.26, 0.59, 0.98, 0.95)
	    --imgui.GetStyle().Colors[imgui.Col.CloseButton]          = imgui.ImVec4(0.59, 0.59, 0.59, 0.50)
	    --imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]   = imgui.ImVec4(0.98, 0.39, 0.36, 1.00)
	    --imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]    = imgui.ImVec4(0.98, 0.39, 0.36, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PlotLines]            = imgui.ImVec4(0.39, 0.39, 0.39, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]     = imgui.ImVec4(1.00, 0.43, 0.35, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PlotHistogram]        = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(0.26, 0.59, 0.98, 0.35)
	    imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)
	elseif name == 'Orange' then
		imgui.GetStyle().Colors[imgui.Col.Text]                 = imgui.ImVec4(0.80, 0.80, 0.83, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.24, 0.23, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.07, 0.07, 0.09, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]              = imgui.ImVec4(0.07, 0.07, 0.09, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Border]               = imgui.ImVec4(0.80, 0.80, 0.83, 0.88)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(0.92, 0.91, 0.88, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]              = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.24, 0.23, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.76, 0.31, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(1.00, 0.98, 0.95, 0.75)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.80, 0.33, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.80, 0.80, 0.83, 0.31)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ComboBg]              = imgui.ImVec4(0.19, 0.18, 0.21, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(1.00, 0.42, 0.00, 0.53)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(1.00, 0.42, 0.00, 0.53)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(1.00, 0.42, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.24, 0.23, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButton]          = imgui.ImVec4(0.40, 0.39, 0.38, 0.16)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]   = imgui.ImVec4(0.40, 0.39, 0.38, 0.39)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]    = imgui.ImVec4(0.40, 0.39, 0.38, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines]            = imgui.ImVec4(0.40, 0.39, 0.38, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]     = imgui.ImVec4(0.25, 1.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram]        = imgui.ImVec4(0.40, 0.39, 0.38, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.25, 1.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(0.25, 1.00, 0.00, 0.43)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(1.00, 0.98, 0.95, 0.73)
	elseif name == 'Monsieur' then
		imgui.GetStyle().Colors[imgui.Col.Text]                 = imgui.ImVec4(0.31, 0.25, 0.24, 1.00)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.94, 0.94, 0.94, 1.00)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.74, 0.74, 0.94, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.68, 0.68, 0.68, 0.00)
		imgui.GetStyle().Colors[imgui.Col.Border]               = imgui.ImVec4(0.50, 0.50, 0.50, 0.60)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]              = imgui.ImVec4(0.62, 0.70, 0.72, 0.56)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.95, 0.33, 0.14, 0.47)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.97, 0.31, 0.13, 0.81)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.42, 0.75, 1.00, 0.53)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(0.40, 0.65, 0.80, 0.20)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.40, 0.62, 0.80, 0.15)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.39, 0.64, 0.80, 0.30)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.28, 0.67, 0.80, 0.59)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.25, 0.48, 0.53, 0.67)
		imgui.GetStyle().Colors[imgui.Col.ComboBg]              = imgui.ImVec4(0.89, 0.98, 1.00, 0.99)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.48, 0.47, 0.47, 0.71)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.31, 0.47, 0.99, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(1.00, 0.79, 0.18, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.42, 0.82, 1.00, 0.81)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.72, 1.00, 1.00, 0.86)
		imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.65, 0.78, 0.84, 0.80)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.75, 0.88, 0.94, 0.80)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.55, 0.68, 0.74, 0.80)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(0.60, 0.60, 0.80, 0.30)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(1.00, 1.00, 1.00, 0.60)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(1.00, 1.00, 1.00, 0.90)
		imgui.GetStyle().Colors[imgui.Col.CloseButton]          = imgui.ImVec4(0.41, 0.75, 0.98, 0.50)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]   = imgui.ImVec4(1.00, 0.47, 0.41, 0.60)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]    = imgui.ImVec4(1.00, 0.16, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(1.00, 0.99, 0.54, 0.43)
		--imgui.GetStyle().Colors[imgui.Col.TooltipBg]            = imgui.ImVec4(0.82, 0.92, 1.00, 0.90)
	elseif name == 'Dark' then
		imgui.GetStyle().Colors[imgui.Col.Text]                  = imgui.ImVec4(1.00, 1.00, 1.00, 0.95)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]          = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]              = imgui.ImVec4(0.13, 0.12, 0.12, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ChildBg]               = imgui.ImVec4(1.00, 1.00, 1.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]               = imgui.ImVec4(0.05, 0.05, 0.05, 0.94)
		imgui.GetStyle().Colors[imgui.Col.Border]                = imgui.ImVec4(0.53, 0.53, 0.53, 0.46)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]          = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]               = imgui.ImVec4(0.00, 0.00, 0.00, 0.85)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]        = imgui.ImVec4(0.22, 0.22, 0.22, 0.40)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]         = imgui.ImVec4(0.16, 0.16, 0.16, 0.53)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]               = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive]         = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]      = imgui.ImVec4(0.00, 0.00, 0.00, 0.51)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]             = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]           = imgui.ImVec4(0.02, 0.02, 0.02, 0.53)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]         = imgui.ImVec4(0.31, 0.31, 0.31, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]  = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]   = imgui.ImVec4(0.48, 0.48, 0.48, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]             = imgui.ImVec4(0.79, 0.79, 0.79, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]            = imgui.ImVec4(0.48, 0.47, 0.47, 0.91)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]      = imgui.ImVec4(0.56, 0.55, 0.55, 0.62)
		imgui.GetStyle().Colors[imgui.Col.Button]                = imgui.ImVec4(0.50, 0.50, 0.50, 0.63)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]         = imgui.ImVec4(0.67, 0.67, 0.68, 0.63)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]          = imgui.ImVec4(0.26, 0.26, 0.26, 0.63)
		imgui.GetStyle().Colors[imgui.Col.Header]                = imgui.ImVec4(0.54, 0.54, 0.54, 0.58)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]         = imgui.ImVec4(0.64, 0.65, 0.65, 0.80)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]          = imgui.ImVec4(0.25, 0.25, 0.25, 0.80)
		imgui.GetStyle().Colors[imgui.Col.Separator]             = imgui.ImVec4(0.58, 0.58, 0.58, 0.50)
		imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]      = imgui.ImVec4(0.81, 0.81, 0.81, 0.64)
		imgui.GetStyle().Colors[imgui.Col.SeparatorActive]       = imgui.ImVec4(0.81, 0.81, 0.81, 0.64)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]            = imgui.ImVec4(0.87, 0.87, 0.87, 0.53)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]     = imgui.ImVec4(0.87, 0.87, 0.87, 0.74)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]      = imgui.ImVec4(0.87, 0.87, 0.87, 0.74)
		--imgui.GetStyle().Colors[imgui.Col.Tab]                   = imgui.ImVec4(0.01, 0.01, 0.01, 0.86)
		--imgui.GetStyle().Colors[imgui.Col.TabHovered]            = imgui.ImVec4(0.29, 0.29, 0.29, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.TabActive]             = imgui.ImVec4(0.31, 0.31, 0.31, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.TabUnocused]           = imgui.ImVec4(0.02, 0.02, 0.02, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.TabUnocusedActive]     = imgui.ImVec4(0.19, 0.19, 0.19, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.DockingPreview]        = imgui.ImVec4(0.38, 0.48, 0.60, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.DockingEmptyBg]        = imgui.ImVec4(0.20, 0.20, 0.20, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines]             = imgui.ImVec4(0.61, 0.61, 0.61, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]      = imgui.ImVec4(0.68, 0.68, 0.68, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram]         = imgui.ImVec4(0.90, 0.77, 0.33, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]  = imgui.ImVec4(0.87, 0.55, 0.08, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]        = imgui.ImVec4(0.47, 0.60, 0.76, 0.47)
		--imgui.GetStyle().Colors[imgui.Col.DragDropTarget]        = imgui.ImVec4(0.58, 0.58, 0.58, 0.90)
		--imgui.GetStyle().Colors[imgui.Col.NavHighlight]          = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.NavWindowingHighlight] = imgui.ImVec4(1.00, 1.00, 1.00, 0.70)
		--imgui.GetStyle().Colors[imgui.Col.NavWindowingDimBg]     = imgui.ImVec4(0.80, 0.80, 0.80, 0.20)
		--imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg]      = imgui.ImVec4(0.80, 0.80, 0.80, 0.35)
	elseif name == 'Purple' then
		imgui.GetStyle().Colors[imgui.Col.Text]                 = imgui.ImVec4(0.87, 0.85, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.87, 0.85, 0.92, 0.58)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.13, 0.12, 0.16, 0.71)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.27, 0.20, 0.39, 0.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]              = imgui.ImVec4(0.05, 0.05, 0.10, 0.90)
		imgui.GetStyle().Colors[imgui.Col.Border]               = imgui.ImVec4(0.87, 0.85, 0.92, 0.30)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]              = imgui.ImVec4(0.27, 0.20, 0.39, 1.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.34, 0.19, 0.63, 0.68)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.46, 0.27, 0.80, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.34, 0.19, 0.63, 0.45)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(0.34, 0.19, 0.63, 0.35)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.34, 0.19, 0.63, 0.78)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.27, 0.20, 0.39, 0.57)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.27, 0.20, 0.39, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.34, 0.19, 0.63, 0.31)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.34, 0.19, 0.63, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.34, 0.19, 0.63, 0.80)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(0.34, 0.19, 0.63, 0.24)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(0.34, 0.19, 0.63, 0.44)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.34, 0.19, 0.63, 0.86)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.34, 0.19, 0.63, 0.76)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.34, 0.19, 0.63, 0.86)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column]               = imgui.ImVec4(0.87, 0.85, 0.92, 0.32)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered]        = imgui.ImVec4(0.87, 0.85, 0.92, 0.78)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive]         = imgui.ImVec4(0.87, 0.85, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(0.34, 0.19, 0.63, 0.20)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(0.34, 0.19, 0.63, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButton]          = imgui.ImVec4(0.87, 0.85, 0.92, 0.16)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]   = imgui.ImVec4(0.87, 0.85, 0.92, 0.39)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]    = imgui.ImVec4(0.87, 0.85, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines]            = imgui.ImVec4(0.87, 0.85, 0.92, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]     = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram]        = imgui.ImVec4(0.87, 0.85, 0.92, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(0.34, 0.19, 0.63, 0.43)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)
	elseif name == 'Green' then
		imgui.GetStyle().Colors[imgui.Col.Text]                 = imgui.ImVec4(0.90, 0.90, 0.90, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.00, 0.00, 0.00, 0.90)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.00, 0.00, 0.00, 0.95)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]              = imgui.ImVec4(0.05, 0.05, 0.10, 0.90)
		imgui.GetStyle().Colors[imgui.Col.Border]               = imgui.ImVec4(0.08, 0.51, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]              = imgui.ImVec4(0.08, 0.51, 0.10, 0.39)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.08, 0.51, 0.10, 0.63)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.08, 0.51, 0.10, 0.71)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.08, 0.51, 0.10, 0.63)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(0.08, 0.51, 0.10, 0.51)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.08, 0.51, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.40, 0.40, 0.55, 0.80)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.08, 0.39, 0.10, 0.39)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.08, 0.27, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.08, 0.39, 0.10, 0.74)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.08, 0.39, 0.10, 0.59)
		imgui.GetStyle().Colors[imgui.Col.ComboBg]              = imgui.ImVec4(0.00, 0.00, 0.00, 0.94)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.08, 0.51, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(0.08, 0.51, 0.10, 0.63)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.08, 0.51, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(0.08, 0.51, 0.10, 0.59)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.08, 0.51, 0.10, 0.75)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.08, 0.51, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.08, 0.27, 0.10, 0.67)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.08, 0.35, 0.10, 0.80)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.08, 0.39, 0.10, 0.80)
		--imgui.GetStyle().Colors[imgui.Col.Column]               = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered]        = imgui.ImVec4(0.70, 0.60, 0.60, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive]         = imgui.ImVec4(0.90, 0.70, 0.70, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(0.08, 0.27, 0.10, 0.30)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(0.08, 0.27, 0.10, 0.60)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(0.08, 0.27, 0.10, 0.90)
		imgui.GetStyle().Colors[imgui.Col.CloseButton]          = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]   = imgui.ImVec4(0.00, 0.01, 0.00, 0.60)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]    = imgui.ImVec4(0.70, 0.70, 0.70, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines]            = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]     = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram]        = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(0.00, 0.00, 1.00, 0.35)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)
	elseif name == 'Violet' then
		imgui.GetStyle().Colors[imgui.Col.Text]                 = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.00, 0.00, 0.00, 0.88)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]              = imgui.ImVec4(0.05, 0.05, 0.10, 0.90)
		imgui.GetStyle().Colors[imgui.Col.Border]               = imgui.ImVec4(0.31, 0.00, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]              = imgui.ImVec4(0.31, 0.13, 0.37, 0.55)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.31, 0.00, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.31, 0.18, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(0.40, 0.40, 0.80, 0.20)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.31, 0.00, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.40, 0.40, 0.55, 0.80)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.31, 0.13, 0.37, 0.22)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.31, 0.13, 0.37, 0.51)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.31, 0.13, 0.37, 0.71)
		imgui.GetStyle().Colors[imgui.Col.ComboBg]              = imgui.ImVec4(0.00, 0.00, 0.00, 0.92)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.31, 0.13, 0.37, 0.67)
		imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(0.31, 0.00, 0.37, 0.65)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.31, 0.00, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.31, 0.00, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.31, 0.13, 0.37, 0.55)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column]               = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered]        = imgui.ImVec4(0.70, 0.60, 0.60, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive]         = imgui.ImVec4(0.90, 0.70, 0.70, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(0.31, 0.13, 0.37, 0.60)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(0.31, 0.13, 0.37, 0.78)
		imgui.GetStyle().Colors[imgui.Col.CloseButton]          = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]   = imgui.ImVec4(0.00, 0.00, 0.00, 0.60)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]    = imgui.ImVec4(0.70, 0.70, 0.70, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines]            = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]     = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram]        = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(0.00, 0.00, 1.00, 0.35)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)
	
	elseif name == 'Indigo' then
		imgui.GetStyle().Colors[imgui.Col.Text]                 = imgui.ImVec4(0.86, 0.93, 0.89, 0.78)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.92, 0.18, 0.29, 0.78)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.13, 0.14, 0.17, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.20, 0.22, 0.27, 0.58)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]              = imgui.ImVec4(0.20, 0.22, 0.27, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Border]               = imgui.ImVec4(0.00, 0.00, 0.00, 0.35)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]              = imgui.ImVec4(0.20, 0.22, 0.27, 1.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.92, 0.18, 0.29, 0.78)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.20, 0.22, 0.27, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(0.20, 0.22, 0.27, 0.75)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.20, 0.22, 0.27, 0.47)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.20, 0.22, 0.27, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.09, 0.15, 0.16, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.92, 0.18, 0.29, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.71, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(0.92, 0.18, 0.29, 0.37)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(0.92, 0.18, 0.29, 0.75)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.92, 0.18, 0.29, 0.86)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.92, 0.18, 0.29, 0.76)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.92, 0.18, 0.29, 0.86)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column]               = imgui.ImVec4(0.15, 0.00, 0.00, 0.35)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered]        = imgui.ImVec4(0.92, 0.18, 0.29, 0.59)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive]         = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(0.92, 0.18, 0.29, 0.63)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(0.92, 0.18, 0.29, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButton]          = imgui.ImVec4(1.00, 1.00, 1.00, 0.51)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]   = imgui.ImVec4(1.00, 1.00, 1.00, 0.67)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]    = imgui.ImVec4(1.00, 1.00, 1.00, 0.78)
		imgui.GetStyle().Colors[imgui.Col.PlotLines]            = imgui.ImVec4(0.86, 0.93, 0.89, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]     = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram]        = imgui.ImVec4(0.86, 0.93, 0.89, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(0.92, 0.18, 0.29, 0.43)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.22, 0.27, 0.73)
	elseif name == 'Night' then
	imgui.GetStyle().Colors[imgui.Col.Text]                     = imgui.ImVec4(0.85, 0.87, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.85, 0.87, 0.92, 0.58)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.14, 0.19, 0.36, 0.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]              = imgui.ImVec4(0.05, 0.05, 0.10, 0.90)
		imgui.GetStyle().Colors[imgui.Col.Border]               = imgui.ImVec4(0.85, 0.87, 0.92, 0.30)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]              = imgui.ImVec4(0.14, 0.19, 0.36, 1.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.10, 0.19, 0.49, 0.68)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.10, 0.19, 0.49, 0.45)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(0.10, 0.19, 0.49, 0.35)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.10, 0.19, 0.49, 0.78)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.14, 0.19, 0.36, 0.57)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.14, 0.19, 0.36, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.10, 0.19, 0.49, 0.31)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.10, 0.19, 0.49, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.16, 0.86, 0.90, 0.80)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(0.10, 0.19, 0.49, 0.24)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.07, 0.26, 0.53, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(0.10, 0.19, 0.49, 0.44)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.10, 0.19, 0.49, 0.86)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.10, 0.19, 0.49, 0.76)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.10, 0.19, 0.49, 0.86)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column]               = imgui.ImVec4(0.85, 0.87, 0.92, 0.32)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered]        = imgui.ImVec4(0.85, 0.87, 0.92, 0.78)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive]         = imgui.ImVec4(0.85, 0.87, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(0.10, 0.19, 0.49, 0.20)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(0.10, 0.19, 0.49, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButton]          = imgui.ImVec4(0.85, 0.87, 0.92, 0.16)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]   = imgui.ImVec4(0.85, 0.87, 0.92, 0.39)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]    = imgui.ImVec4(0.85, 0.87, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines]            = imgui.ImVec4(0.85, 0.87, 0.92, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]     = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram]        = imgui.ImVec4(0.85, 0.87, 0.92, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(0.10, 0.19, 0.49, 0.43)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)

	elseif name == 'Dunno' then
		imgui.GetStyle().Colors[imgui.Col.Text]                 = imgui.ImVec4(0.90, 0.90, 0.90, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.65, 0.00, 0.06, 0.03)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]              = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
		imgui.GetStyle().Colors[imgui.Col.Border]               = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]              = imgui.ImVec4(0.00, 0.00, 0.06, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.00, 0.00, 0.06, 0.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.00, 0.00, 0.00, 3.14)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.00, 0.00, 0.00, 3.14)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.90, 0.90, 0.90, 0.50)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(0.00, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(0.00, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.00, 0.42, 0.44, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.05, 0.27, 0.48, 0.59)
		imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.00, 0.24, 0.44, 1.00)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.00, 0.42, 0.44, 1.00)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.00, 0.42, 0.44, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column]               = imgui.ImVec4(0.85, 0.89, 0.92, 0.32)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered]        = imgui.ImVec4(0.85, 0.89, 0.92, 0.78)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive]         = imgui.ImVec4(0.85, 0.89, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(0.19, 0.43, 0.63, 0.20)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(0.19, 0.43, 0.63, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(0.19, 0.43, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButton]          = imgui.ImVec4(0.85, 0.89, 0.92, 0.16)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]   = imgui.ImVec4(0.85, 0.89, 0.92, 0.39)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]    = imgui.ImVec4(0.85, 0.89, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines]            = imgui.ImVec4(0.85, 0.89, 0.92, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]     = imgui.ImVec4(0.19, 0.43, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram]        = imgui.ImVec4(0.85, 0.89, 0.92, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.19, 0.43, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(0.19, 0.43, 0.63, 0.43)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)

	elseif name == 'Blue' then
		imgui.GetStyle().Colors[imgui.Col.Text]                 = imgui.ImVec4(0.86, 0.93, 0.89, 0.78)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.13, 0.65, 0.92, 0.78)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.13, 0.14, 0.17, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.20, 0.22, 0.27, 0.58)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]              = imgui.ImVec4(0.20, 0.22, 0.27, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Border]               = imgui.ImVec4(0.00, 0.00, 0.00, 0.35)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]              = imgui.ImVec4(0.20, 0.22, 0.27, 1.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.13, 0.65, 0.92, 0.78)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.13, 0.65, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.20, 0.22, 0.27, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(0.20, 0.22, 0.27, 0.75)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.13, 0.65, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.20, 0.22, 0.27, 0.47)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.20, 0.22, 0.27, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.09, 0.15, 0.16, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.13, 0.65, 0.92, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.13, 0.65, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.13, 0.65, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(0.13, 0.65, 0.92, 0.37)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.13, 0.65, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(0.13, 0.65, 0.92, 0.75)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.13, 0.65, 0.92, 0.86)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.13, 0.65, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.13, 0.65, 0.92, 0.76)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.13, 0.65, 0.92, 0.86)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.13, 0.65, 0.92, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column]               = imgui.ImVec4(0.15, 0.00, 0.00, 0.35)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered]        = imgui.ImVec4(0.13, 0.65, 0.92, 0.59)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive]         = imgui.ImVec4(0.13, 0.65, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(0.13, 0.65, 0.92, 0.63)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(0.13, 0.65, 0.92, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(0.13, 0.65, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButton]          = imgui.ImVec4(1.00, 1.00, 1.00, 0.51)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]   = imgui.ImVec4(1.00, 1.00, 1.00, 0.67)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]    = imgui.ImVec4(1.00, 1.00, 1.00, 0.78)
		imgui.GetStyle().Colors[imgui.Col.PlotLines]            = imgui.ImVec4(0.86, 0.93, 0.89, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]     = imgui.ImVec4(0.13, 0.65, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram]        = imgui.ImVec4(0.86, 0.93, 0.89, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.13, 0.65, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(0.13, 0.65, 0.92, 0.43)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.22, 0.27, 0.73)

	elseif name == 'Midnight' then
		imgui.GetStyle().Colors[imgui.Col.Text]                 = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.94, 0.94, 0.94, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]              = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Border]               = imgui.ImVec4(0.00, 0.00, 0.00, 0.39)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(1.00, 1.00, 1.00, 0.10)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]              = imgui.ImVec4(1.00, 1.00, 1.00, 0.94)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.26, 0.59, 0.98, 0.40)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.26, 0.59, 0.98, 0.67)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.96, 0.96, 0.96, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(1.00, 1.00, 1.00, 0.51)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.82, 0.82, 0.82, 1.00)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.86, 0.86, 0.86, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.98, 0.98, 0.98, 0.53)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.69, 0.69, 0.69, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.59, 0.59, 0.59, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.49, 0.49, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(0.24, 0.52, 0.88, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(0.26, 0.59, 0.98, 0.40)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.06, 0.53, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.26, 0.59, 0.98, 0.31)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.26, 0.59, 0.98, 0.80)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column]               = imgui.ImVec4(0.39, 0.39, 0.39, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered]        = imgui.ImVec4(0.26, 0.59, 0.98, 0.78)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive]         = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(1.00, 1.00, 1.00, 0.50)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(0.26, 0.59, 0.98, 0.67)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(0.26, 0.59, 0.98, 0.95)
		imgui.GetStyle().Colors[imgui.Col.CloseButton]          = imgui.ImVec4(0.59, 0.59, 0.59, 0.50)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]   = imgui.ImVec4(0.98, 0.39, 0.36, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]    = imgui.ImVec4(0.98, 0.39, 0.36, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines]            = imgui.ImVec4(0.39, 0.39, 0.39, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]     = imgui.ImVec4(1.00, 0.43, 0.35, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram]        = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(0.26, 0.59, 0.98, 0.35)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)
	elseif name == 'Black' then
		imgui.GetStyle().Colors[imgui.Col.Text]                 = imgui.ImVec4(0.80, 0.80, 0.80, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(0.00, 0.00, 1.00, 0.35)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.10, 0.10, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.10, 0.10, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]              = imgui.ImVec4(0.05, 0.05, 0.10, 0.90)
		imgui.GetStyle().Colors[imgui.Col.Border]               = imgui.ImVec4(0.70, 0.70, 0.70, 0.65)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]              = imgui.ImVec4(0.10, 0.10, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.90, 0.80, 0.80, 0.40)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.90, 0.65, 0.65, 0.45)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.00, 0.25, 0.90, 0.83)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(0.00, 0.25, 0.90, 0.20)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.00, 0.25, 0.90, 0.87)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.40, 0.40, 0.55, 0.80)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.20, 0.25, 0.30, 0.60)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.40, 0.40, 0.80, 0.30)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.40, 0.40, 0.80, 0.40)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.80, 0.50, 0.50, 0.40)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.90, 0.90, 0.90, 0.50)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(1.00, 1.00, 1.00, 0.30)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.80, 0.50, 0.50, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(0.00, 0.66, 0.40, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.00, 0.46, 0.65, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.00, 0.25, 0.90, 0.83)
		imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.40, 0.40, 0.90, 0.45)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.45, 0.45, 0.90, 0.80)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.53, 0.53, 0.87, 0.80)
		--imgui.GetStyle().Colors[imgui.Col.Column]               = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered]        = imgui.ImVec4(0.70, 0.60, 0.60, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive]         = imgui.ImVec4(0.90, 0.70, 0.70, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(1.00, 1.00, 1.00, 0.30)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(1.00, 1.00, 1.00, 0.60)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(1.00, 1.00, 1.00, 0.90)
		imgui.GetStyle().Colors[imgui.Col.CloseButton]          = imgui.ImVec4(0.50, 0.50, 0.90, 0.50)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]   = imgui.ImVec4(0.70, 0.70, 0.90, 0.60)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]    = imgui.ImVec4(0.70, 0.70, 0.70, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines]            = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]     = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram]        = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)
	else
		ok = false
	end
	if ok then
		Config.ini.style.name = name
		if bNotf then notf.addNotification('Тема "'..name..'" применена.', 4, 2) end
	else
		if bNotf then notf.addNotification('Тема "'..name..'" не найдена.', 4, 2) end
	end
end


--[ImGuiCol_Text] = The color for the text that will be used for the whole menu.
--[ImGuiCol_TextDisabled] = Color for "not active / disabled text".
--[ImGuiCol_WindowBg] = Background color.
--[ImGuiCol_PopupBg] = The color used for the background in ImGui :: Combo and ImGui :: MenuBar.
--[ImGuiCol_Border] = The color that is used to outline your menu.
--[ImGuiCol_BorderShadow] = Color for the stroke shadow.
--[ImGuiCol_FrameBg] = Color for ImGui :: InputText and for background ImGui :: Checkbox
--[ImGuiCol_FrameBgHovered] = The color that is used in almost the same way as the one above, except that it changes color when guiding it to ImGui :: Checkbox.
--[ImGuiCol_FrameBgActive] = Active color.
--[ImGuiCol_TitleBg] = The color for changing the main place at the very top of the menu (where the name of your "top-of-the-table" is shown.
--ImGuiCol_TitleBgCollapsed = ImguiCol_TitleBgActive
--= The color of the active title window, ie if you have a menu with several windows , this color will be used for the window in which you will be at the moment.
--[ImGuiCol_MenuBarBg] = The color for the bar menu. (Not all sawes saw this, but still)
--[ImGuiCol_ScrollbarBg] = The color for the background of the "strip", through which you can "flip" functions in the software vertically.
--[ImGuiCol_ScrollbarGrab] = Color for the scoll bar, ie for the "strip", which is used to move the menu vertically.
--[ImGuiCol_ScrollbarGrabHovered] = Color for the "minimized / unused" scroll bar.
--[ImGuiCol_ScrollbarGrabActive] = The color for the "active" activity in the window where the scroll bar is located.
--[ImGuiCol_ComboBg] = Color for the background for ImGui :: Combo.
--[ImGuiCol_CheckMark] = Color for your ImGui :: Checkbox.
--[ImGuiCol_SliderGrab] = Color for the slider ImGui :: SliderInt and ImGui :: SliderFloat.
--[ImGuiCol_SliderGrabActive] = Color of the slider,
--[ImGuiCol_Button] = the color for the button.
--[ImGuiCol_ButtonHovered] = Color when hovering over the button.
--[ImGuiCol_ButtonActive] = Button color used.
--[ImGuiCol_Header] = Color for ImGui :: CollapsingHeader.
--[ImGuiCol_HeaderHovered] = Color, when hovering over ImGui :: CollapsingHeader.
--[ImGuiCol_HeaderActive] = Used color ImGui :: CollapsingHeader.
--[ImGuiCol_Column] = Color for the "separation strip" ImGui :: Column and ImGui :: NextColumn.
--[ImGuiCol_ColumnHovered] = Color, when hovering on the "strip strip" ImGui :: Column and ImGui :: NextColumn.
--[ImGuiCol_ColumnActive] = The color used for the "separation strip" ImGui :: Column and ImGui :: NextColumn.
--[ImGuiCol_ResizeGrip] = The color for the "triangle" in the lower right corner, which is used to increase or decrease the size of the menu.
--[ImGuiCol_ResizeGripHovered] = Color, when hovering to the "triangle" in the lower right corner, which is used to increase or decrease the size of the menu.
--[ImGuiCol_ResizeGripActive] = The color used for the "triangle" in the lower right corner, which is used to increase or decrease the size of the menu.
--[ImGuiCol_CloseButton] = The color for the button-closing menu.
--[ImGuiCol_CloseButtonHovered] = Color, when you hover over the button-close menu.
--[ImGuiCol_CloseButtonActive] = The color used for the button-closing menu.
--[ImGuiCol_TextSelectedBg] = The color of the selected text, in ImGui :: MenuBar.
--[ImGuiCol_ModalWindowDarkening] = The color of the "Blackout Window" of your menu.
--I rarely see these designations, but still decided to put them here.
--[ImGuiCol_Tab] = The color for tabs in the menu.
--[ImGuiCol_TabActive] = The active color of tabs, ie when you click on the tab you will have this color.
--[ImGuiCol_TabHovered] = The color that will be displayed when hovering on the table.
--[ImGuiCol_TabSelected] = The color that is used when you are in one of the tabs.
--[ImGuiCol_TabText] = Text color that only applies to tabs.
--[ImGuiCol_TabTextActive] = Active text color for tabs.

writeMemory(0x555854, 4, -1869574000, true)
writeMemory(0x555858, 1, 144, true)


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

function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do wait(0) end
	wait(1000)
	local thread1 = lua_thread.create(secondThread, false)
	print("Начинаем подгрузку скрипта и его составляющих")
	sampAddChatMessage("[GeekHelper] {FFFFFF}Скрипт подгружен в игру, версия: {00C2BB}"..thisScript().version.."{ffffff}, начинаем инициализацию.", 0x046D63)
	print("Начинаем проверку обновлений.")
	updateCheck()
	while not isUpdateCheck do wait(0) end
	imgui.Process = win_state['update'].v or win_state['main'].v or win_state['mp3_informer'].v

	inputHelpText = renderCreateFont("Arial", 10, FCR_BORDER + FCR_BOLD) -- шрифт для chatinfo
	lua_thread.create(showInputHelp)
	------------------COMMANDS--------------
	sampRegisterChatCommand("gh", mainmenu)
	----------------------------------------
	------------------------------------------------------------ используем bass.lua
	aaudio = bass.BASS_StreamCreateFile(false, "moonloader/GeekHelper/audio/ad.wav", 0, 0, 0) -- уведомление при включении скрипта
	bass.BASS_ChannelSetAttribute(aaudio, BASS_ATTRIB_VOL, 0.1)
	bass.BASS_ChannelPlay(aaudio, false)

	aerr = bass.BASS_StreamCreateFile(false, "moonloader/GeekHelper/audio/crash.mp3", 0, 0, 0) -- краш звук
	bass.BASS_ChannelSetAttribute(aerr, BASS_ATTRIB_VOL, 3.0)
	------------------------------------------------------------
	local sleep = require "socket".sleep
	sampRegisterChatCommand("irc", ircsend)
	sampRegisterChatCommand("irc_pm", ircquery)
	sampRegisterChatCommand("irc_raw", ircraw)
	s:hook("OnChat", function(user, channel, message)
	msgStr = Utf8ToAnsi(("[Chat] %s: %s"):format(user.nick, message))
	sampAddChatMessage(msgStr, 0xffff00)
	if irclogs then
		table.insert(IRCLogs, #IRCLogs + 1, "["..os.date("%H:%M").."] "..msgStr)
		fileLog = io.open("moonloader/IRCLOG.log", "w")
		for i = 1, #IRCLogs do
			fileLog:write(IRCLogs[i].."\n")
		end
		fileLog:close()
	end
	addOneOffSound(0.0, 0.0, 0.0, 1054)
	end)
	s:hook("OnRaw", function(line)
	if DebugMode then
		msgStrs = Utf8ToAnsi("[IRC] RAW: "..line)
		sampAddChatMessage(msgStrs, 0xffff00)
	end
	end)
	s:connect("irc.ircnet.ru")
	SCM("Успешно подключились к чату!")
	s:send("NICK %s", Nick)
	wait(2500)
	sampAddChatMessage("[Info] You can write messages with command - /irc <message> or /irc_pm <nick> <message> to write private message." , 0xffff00)
	s:join("#GeekHelper")

	Config:Load()
	InitializeLocalizations()

	if wasKeyPressed(key.VK_H) and not sampIsChatInputActive() and not sampIsDialogActive() and strobesOn.v then strobes() end -- стробоскопы на H, не делал на гудок ибо не хочу

	while true do
		imgui.Process = win_state['main'].v or win_state['mp3_informer'].v
		wait(IRCLatency)
		s:think()
		if hparmCout.v then
			hparmRender()
		end
		if fpsChange ~= fpsUnlock.v then
			if fpsUnlock.v then writeMemory(12677196, 1, 60, false)
			else writeMemory(12677196, 1, 30, false) end
			fpsChange = fpsUnlock.v
		end
		wait(0)
	end
																														   
end

function ircsend(param)
	sampAddChatMessage(u8"[ЧАТ]: "..param, 0xffff00)
	sendstr = AnsiToUtf8(param)
	s:sendChat(Channel, sendstr)
end

function ircquery(param)
	nick_send, msg = string.match(param, "^(%S*)%s(.*)$")
	sampAddChatMessage("[IRC] [PM Send]: "..tostring(nick_send).." "..tostring(msg), 0xffff00)
	sendstr = AnsiToUtf8(string.format("PRIVMSG %s :%s", nick_send, msg))
	s:send(sendstr)
end
function ircraw(param)
	sampAddChatMessage("[IRC] [RAW SEND]: "..param, 0xffff00)
	sendstr = AnsiToUtf8(param)
	s:send("%s", sendstr)
end
function ircmenu()
	sampShowDialog(154, "SAMPIrcClient Menu | Connected: {0000FF}"..GetState(connected), string.format("Nickname: %s \n{00ff00}Connect\n{ff0000}Disconnect\nLogging: {FF0000}%s\nAuto connect: {FF0000}%s\nForce save settings\nMessage Sound: {FF0000}%d\nIRC Latency: {FF0000}%d\nDebug: {FF0000}%s", Nick, GetState(irclogs), GetState(AutoConnect), MessageSound, IRCLatency, GetState(DebugMode)), "Select", "Exit", 2)
end

function hparmRender()
	useRenderCommands(true) -- use lua render
	setTextCentre(true) -- set text centered
	setTextScale(0.2, 0.5) -- x y size
	setTextColour(255, 255, 255, 255) -- r, g, b, a
	setTextEdge(1, 0, 0, 0, 255) -- outline size, r , g, b, a
	displayTextWithNumber(578.0, 68.5, 'NUMBER', getCharHealth(PLAYER_PED))
	if getCharArmour(PLAYER_PED) > 0 then
		setTextCentre(true) -- set text centered
		setTextScale(0.2, 0.5) -- x y size
		setTextColour(255, 255, 255, 255) -- r, g, b, a
		setTextEdge(1, 0, 0, 0, 255) -- outline size, r , g, b, a
		displayTextWithNumber(578.0, 47.0, 'NUMBER', getCharArmour(PLAYER_PED))
	end
end

function mainmenu()
	win_state['main'].v = not win_state['main'].v
end

function getMusicList()
	local files = {}
	local path = nil
	if Config.ini.global.musicpath ~= '' then path = Config.ini.global.musicpath
	elseif musicpath_mp3.v ~= '' then path = musicpath_mp3.v
	else path = getGameDirectory()..'\\moonloader\\GeekHelper\\audio\\MP3\\' end
	local handleFile, nameFile = findFirstFile(path..'*.mp3')
	while nameFile do
		if handleFile then
			if not nameFile then
				findClose(handleFile)
			else
				--files[#files+1] = nameFile
				table.insert(files, nameFile)
				nameFile = findNextFile(handleFile)
			end
		end
	end
	return files
end

function updateCheck()
	local zapros = https.request("https://geekhub.pro/samp/geekhelper/version.json")

	if zapros ~= nil then
		local info2 = decodeJson(zapros)

		if info2.latest_number ~= nil and info2.latest ~= nil then
			updatever = info2.latest
			version = tonumber(info2.latest_number)

			print("[GeekHelper] Начинаем контроль версий")

			if version > tonumber(thisScript().version_num) then
				print("[GeekHelper] Обнаружено обновление")
				if bNotf then
					notf.addNotification(" Обнаружено обновление до версии "..updatever..".", 5, 2)
				end
				sampAddChatMessage("[GeekHelper]{FFFFFF} Обнаружено обновление до версии "..updatever..".", 0x046D63)
				win_state['update'].v = true
				isUpdateCheck = true
			else
				print("[GeekHelper] Новых обновлений нет, контроль версий пройден")
				if checkupd then
					if bNotf then
						notf.addNotification("У вас стоит актуальная версия скрипта: "..thisScript().version..".\nНеобходимости обновлять скрипт нет, приятного пользования.", 5, 2)
					end
					sampAddChatMessage("[GeekHelper]{FFFFFF} У вас стоит актуальная версия скрипта: "..thisScript().version..".", 0x046D63)
					sampAddChatMessage("[GeekHelper]{FFFFFF} Необходимости обновлять скрипт - нет, приятного пользования.", 0x046D63)
					checkupd = false
				end
				isUpdateCheck = true
			end
		else
			sampAddChatMessage("[GeekHelper]{FFFFFF} Ошибка при получении информации об обновлении.", 0x046D63)
			print("[GeekHelper] JSON file read error")
			isUpdateCheck = true
		end
	else
		sampAddChatMessage("[GeekHelper]{FFFFFF} Не удалось проверить наличие обновлений, попробуйте позже.", 0x046D63)
		isUpdateCheck = true
	end
end



local fa_font = nil
local menubar_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
	if fa_font == nil then
		local font_config = imgui.ImFontConfig()
		font_config.MergeMode = true

		local check
		check = io.open('moonloader/GeekHelper/fonts/fontawesome-webfont.ttf', 'r')
		if check:read('*a') == nil then error('fontawesome-webfont.ttf not found') end
		check = io.open('moonloader/GeekHelper/fonts/gtasa.otf', 'r')
		if check:read('*a') == nil then error('gtasa.otf not found') end

		fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/GeekHelper/fonts/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
		menubar_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/GeekHelper/fonts/gtasa.otf', 28.0)
		--imgui.Fonts:Build()
		--imgui.ImFontAtlas:Build()

		fa_font_file = io.open('moonloader/GeekHelper/fonts/fontawesome-webfont.ttf', 'r')
		fa_font_file_read = fa_font_file:read('*a')
		menubar_file = io.open('moonloader/GeekHelper/fonts/gtasa.otf', 'r')
		menubar_file_read = menubar_file:read('*a')

		fa_font_md5 = md5.sumhexa(tostring(fa_font_file_read))
		menubar_font_md5 = md5.sumhexa(tostring(menubar_file_read))

		if fa_font_md5 ~= '85f23caa7d317e546e22e79ac9bae2e1' then error('fontawesome-webfont.ttf not original('..fa_font_md5..')') end
		if menubar_font_md5 ~= 'f19844f9bd08074ec6a5dfe398ba8bf7' then error('gtasa.otf not original ('..menubar_font_md5..')') end
	end
end


function async_http_request(method, url, args, resolve, reject)
	local request_lane = lanes.gen('*', {package = {path = package.path, cpath = package.cpath}}, function()
		local requests = require 'requests'
		local ok, result = pcall(requests.request, method, url, args)
		if ok then
			result.json, result.xml = nil, nil
			return true, result
		else
			return false, result
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

img = imgui.CreateTextureFromFile(getGameDirectory()..'\\moonloader\\GeekHelper\\images\\anime2.png')
function anime()
	w, h = getScreenResolution()
	aw, ah = 313, 320
	
	imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0, 0, 0, 0))
	imgui.SetNextWindowPos(imgui.ImVec2(0, h - ah))
	
	imgui.Begin('', win_state['image'], imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize)

	imgui.Image(img, imgui.ImVec2(aw, ah))
	
	imgui.End()

	imgui.PopStyleColor()
end

function showInputHelp() -- chatinfo(для меня)
	while true do
		local chat = sampIsChatInputActive()
		if chat == true then
			local in1 = getStructElement(sampGetInputInfoPtr(), 0x8, 4)
			local in2 = getStructElement(in1, 0x8, 4)
			local in3 = getStructElement(in1, 0xC, 4)
			fib = in3 + 48
			fib2 = in2 + 10
			local _, mmyID = sampGetPlayerIdByCharHandle(PLAYER_PED)
			local nname = sampGetPlayerNickname(mmyID)
			local score = sampGetPlayerScore(mmyID)
			local color = sampGetPlayerColor(mmyID)
			local capsState = ffi.C.GetKeyState(20)
			local success = ffi.C.GetKeyboardLayoutNameA(KeyboardLayoutName)
			local errorCode = ffi.C.GetLocaleInfoA(tonumber(ffi.string(KeyboardLayoutName), 16), 0x00000002, LocalInfo, BuffSize)
			local localName = ffi.string(LocalInfo)

			local text = string.format(
				"%s :: {%0.6x}%s[%d] {ffffff}:: Капс: %s {FFFFFF}:: Язык: {ffeeaa}%s{ffffff}",
				os.date("%H:%M:%S"), bit.band(color,0xffffff), nname, mmyID, getStrByState(capsState), string.match(localName, "([^%(]*)")
			)

			if chatInfo.v and sampIsLocalPlayerSpawned() and nname ~= nil then renderFontDrawText(inputHelpText, text, fib2, fib, 0xD7FFFFFF) end
			end
		wait(0)
	end
end
function getStrByState(keyState) -- состояние клавиш для chatinfo
	if keyState == 0 then
		return "{ffeeaa}Выкл{ffffff}"
	end
	return "{9EC73D}Вкл{ffffff}"
end


function imgui.OnDrawFrame()
	local tLastKeys = {}
	local sw, sh = getScreenResolution()
	local btn_size = imgui.ImVec2(-0.1, 0)
	local btn_size2 = imgui.ImVec2(160, 0)
	local btn_size3 = imgui.ImVec2(140, 0)
	imgui.ShowCursor = win_state['main'].v or win_state['update'].v or win_state['settings'].v or win_state['mods'].v or win_state['style'].v or win_state['about'].v
	--imgui.ShowCursor = imgui.Process
	imgui.PushStyleVar(imgui.StyleVar.FramePadding, imgui.ImVec2(500, 20))
	imgui.PushFont(menubar_font)
	if imgui.BeginMainMenuBar() then
		if imgui.BeginMenu('Styles') then
			if imgui.MenuItem('Androvira') then Style('Androvira') end
			if imgui.MenuItem('Hacker')    then Style('Hacker')    end
			if imgui.MenuItem('Orange')    then Style('Orange')    end
			if imgui.MenuItem('Monsieur')  then Style('Monsieur')  end
			if imgui.MenuItem('Dark')      then Style('Dark')      end
			if imgui.MenuItem('Purple')    then Style('Purple')    end
			if imgui.MenuItem('Violet')    then Style('Violet')    end
			if imgui.MenuItem('Green')     then Style('Green')     end
			if imgui.MenuItem('Indigo')    then Style('Indigo')    end
			if imgui.MenuItem('Night')     then Style('Night')     end
			if imgui.MenuItem('Dunno')     then Style('Dunno')     end
			if imgui.MenuItem('Blue')      then Style('Blue')      end
			if imgui.MenuItem('Midnight')  then Style('Midnight')  end
			if imgui.MenuItem('Black')     then Style('Black')     end
			imgui.EndMenu()
		end
		if imgui.BeginMenu('Config') then
			if imgui.MenuItem('Load') then Config:Load() end
			if imgui.MenuItem('Save') then Config:Save() end
			imgui.EndMenu()
		end
		--if imgui.BeginMenu(Config.ini.global.language) then
		--	for _, lng in pairs(Config.lang) do
		--		if lng ~= Config.ini.global.language then
		--			if imgui.MenuItem(lng) then
		--				ChangeLanguage(lng)
		--				--Config.ini.global.language = lang
		--			end
		--		end
		--	end
		--end
		if imgui.BeginMenu('Fps: '..tostring(math.floor(memory.getfloat(0xB7CB50, 4, false)))) then imgui.EndMenu() end
		imgui.EndMainMenuBar()
	end
	imgui.PopFont()
	imgui.PopStyleVar()

	--imgui.Image(getGameDirectory()..'\\moonloader\\GeekHelper\\files\\anime.png', imgui.ImVec2(589, 782))

	--imgui.ShowCursor = win_state['update'].v

	lua_thread.create(anime)
	lua_thread.create(ChangeLanguage)

	if win_state['main'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(280, 250), imgui.Cond.FirstUseEver)

		--imgui.Begin(fa(0xf121)..u8' GeekHelper', win_state['main'], imgui.WindowFlags.NoResize)
		imgui.Begin(fa(0xf121)..u8(Localization:get('title')..'###MainTitle'), win_state['main'], imgui.WindowFlags.NoResize)
		
		if imgui.Button(fa(0xf085)..u8' Настройки', btn_size) then
			win_state['settings'].v = not win_state['settings'].v
		end

		if imgui.Button(fa(0xf0ad)..u8' Модификации', btn_size) then
			win_state['mods'].v = not win_state['mods'].v
		end

		if imgui.Button(fa(0xf06a)..u8' О скрипте', btn_size) then
			win_state['about'].v = not win_state['about'].v
		end

		if imgui.Button(fa(0xf043)..u8' Style', btn_size) then
			win_state['style'].v = not win_state['style'].v
		end

		if imgui.Button(fa.ICON_PLAY..u8' MP3 Player', btn_size) then
			win_state['mp3'].v = not win_state['mp3'].v
		end

		if imgui.Button(fa(0xf0e0)..u8' Чат', btn_size) then
			win_state['chat'].v = not win_state['chat'].v
		end

		if imgui.Button(u8' Chat Settings', btn_size) then
			win_state['chat_settings'].v = not win_state['chat_settings'].v
		end

		imgui.End()
	end
	if win_state['mods'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(600, 900), imgui.Cond.FirstUseEver)

		imgui.Begin(fa(0xf0ad)..u8' Модификации', win_state['mods'])

		imgui.Checkbox(u8'Стробоскопы', strobesOn)
		imgui.Checkbox(u8'ChatInfo', chatInfo)
		imgui.Checkbox(u8'ХП и Броня в цифрах', hparmCout)
		imgui.Checkbox(u8'FPS Unlock', fpsUnlock)

		imgui.End()
	end
	if win_state['settings'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(600, 900), imgui.Cond.FirstUseEver)
		
		imgui.Begin(fa(0xf085)..u8' Настройки', win_state['settings'])

		imgui.Text('text')

		imgui.Spacing()
		imgui.Separator()
		imgui.Spacing()

		if imgui.Button('button') then pres = pres + 1 end

		imgui.BeginGroup()
		imgui.Text('group')
		imgui.EndGroup()

		imgui.Columns(3, 'cols', true)

		imgui.Text('bullet')
		imgui.Bullet()

		imgui.Checkbox('checkbox1', cb1)

		imgui.Bullet()
		imgui.Checkbox('checkbox2', cb2)

		imgui.RadioButton('radio1', rb, 0)
		imgui.RadioButton('radio2', rb, 1)
		imgui.Text('radio: '..rb.v)
		
		imgui.Combo('combo', c, {'item1', 'item2', 'item3'}, 3)

		imgui.InputText('inputtext', it)
		imgui.Text('text: '..it.v)
		
		imgui.DragFloat('dragfloat', df, imgui.ImFloat(0.001), 0, 100, '%.3f', imgui.ImFloat(0.001))

		imgui.SliderFloat('sliderfloat', sf, 0, 100, '%.3f', imgui.ImFloat(0.001))

		imgui.Selectable('selectable1', false, 0, imgui.ImVec2(70, 20))
		imgui.Selectable('selectable2', s, 0, imgui.ImVec2(70, 20))
		text = 'selected'
		if not s.v then text = 'not '..text end
		imgui.Text(text)

		imgui.ListBox('listbox', lb, {'item1', 'item2', 'item3'})

		imgui.NextColumn()
		imgui.Text('nextcolumn: ')
		imgui.ColorEdit4('coloredit4', f4)

		for ind, lng in pairs(Config.lang) do
			imgui.RadioButton(lng, lang_num, ind - 1)
		end
		
		imgui.NextColumn()
		imgui.Text('button pressed: '..tostring(pres))
		imgui.ColorPicker4('colorpicker4', f4)

		imgui.End()
	end

	if win_state['mp3'].v then -- окно "mp3 player"
		local musiclist = getMusicList()
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(810, 310), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'MP3 Player', win_state['mp3'], imgui.WindowFlags.NoResize)

		local path = nil
		if imgui.Button(u8'Музыка оффлайн') then selected2 = 1 end
		imgui.SameLine()
		if imgui.Button(u8'Музыка онлайн') then selected2 = 2 end
		if selected2 == 1 then
			imgui.SameLine()
			if imgui.Button(u8'Открыть папку') then
				if not doesDirExist(path) then
					os.execute('mkdir "'..path..'"')
				end
				os.execute('explorer "'..path..'"')
			end
			imgui.SameLine()
			imgui.InputText(u8'Своя папка', musicpath_mp3)
		end
		imgui.Separator()

		if Config.ini.global.musicpath ~= '' then path = Config.ini.global.musicpath
		elseif musicpath_mp3.v ~= '' then path = musicpath_mp3.v
		else path = getGameDirectory()..'\\moonloader\\GeekHelper\\audio\\MP3\\' end

		if selected2 == 1 then
			imgui.BeginChild('##left', imgui.ImVec2(350, 0), true)
			for num, name in pairs(musiclist) do
				local name = name:gsub('.mp3', '')
				if imgui.Selectable(u8(name), false) then selected = num end
			end
			imgui.EndChild()
			imgui.SameLine()
			imgui.BeginChild('##right', imgui.ImVec2(0, 0), true)
			imgui.SameLine()
			for num, name in pairs(musiclist) do
				if num == selected then
					local namech = name:gsub('.mp3', '')
					imgui.Text(u8(namech))
					imgui.Spacing()
					imgui.Separator()
					imgui.Spacing()
					imgui.SameLine(160)
					if imgui.Button(u8'Включить') then
						if playsound ~= nil then setAudioStreamState(playsound, as_action.STOP) playsound = nil end
						playsound = loadAudioStream(path..name)
						print(path..name)
						setAudioStreamState(playsound, as_action.PLAY)
						setAudioStreamVolume(playsound, math.floor(volume.v))
						informer_song = name
						win_state['mp3_informer'].v = true
					end
					imgui.Spacing()
					imgui.Separator()
					imgui.Text(' ')
					imgui.SameLine(50)
					imgui.SliderFloat(u8'Громкость', volume, 0, 100)
					if playsound ~= nil then setAudioStreamVolume(playsound, math.floor(volume.v)) end
					imgui.Spacing()
					imgui.SameLine(160)
					if imgui.Button(fa.ICON_PAUSE, imgui.ImVec2(30, 30)) then if playsound ~= nil then setAudioStreamState(playsound, as_action.PAUSE) end end
					imgui.SameLine(nil, 3)
					if imgui.Button(fa.ICON_PLAY, imgui.ImVec2(30, 30)) then if playsound ~= nil then setAudioStreamState(playsound, as_action.RESUME) end end
				end
			end
			imgui.EndChild()
		else
			for i = 0, 3 do imgui.Text(' ') end
			imgui.SameLine(142)
			imgui.SliderFloat(u8'Громкость', volume, 0, 100)
			imgui.Spacing()
			imgui.SameLine(142)
			imgui.InputText(u8"Введите ссылку.", searchBuf, imgui.InputTextFlags.EnterReturnsTrue + imgui.InputTextFlags.CharsNoBlank)
			imgui.Spacing()
			imgui.SameLine(337)
			if imgui.Button(u8'Запустить по ссылке') then
				if searchBuf.v ~= '' and string.lower(searchBuf.v):find('http') then
					if onlinesong ~= nil then setAudioStreamState(onlinesong, as_action.STOP) end
					onlinesong = loadAudioStream(searchBuf.v)
					setAudioStreamState(onlinesong, as_action.PLAY)
					setAudioStreamVolume(onlinesong, math.floor(volume.v))
					informer_song = searchBuf.v
					win_state['mp3_informer'].v = true
				end
			end
			imgui.Spacing()
			imgui.SameLine(338)
			if imgui.Button(fa.ICON_PAUSE,imgui.ImVec2(62, 50)) then if onlinesong ~= nil then setAudioStreamState(onlinesong, as_action.PAUSE) end end
			imgui.SameLine(nil, 3)
			if imgui.Button(fa.ICON_PLAY,imgui.ImVec2(62, 50)) then if onlinesong ~= nil then setAudioStreamState(onlinesong, as_action.RESUME) end end
			imgui.Spacing()
			if onlinesong ~= nil then
				setAudioStreamVolume(onlinesong, math.floor(volume.v))
			end
		end
		imgui.End()
	end
	if win_state['mp3_informer'].v then -- окно информера
		infoX, infoY = getScreenResolution() -- получаем размер экрана 
		imgui.SetNextWindowPos(imgui.ImVec2(infoX-400, infoY-50), imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(200, 200), imgui.Cond.FirstUseEver)

		imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.0, 0.0, 0.0, 0.3))
		if imgui.Begin("MP3 Informer", win_state['mp3_informer'], imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoSavedSettings) then
			imgui.Separator()
			imgui.Text(u8("• Играет: "..informer_song))
			imgui.End()
		end
		imgui.PopStyleColor()
	end

	if win_state['style'].v then
		imgui.Begin(fa(0xf043)..' Style', win_state['style'])
		imgui.ShowStyleEditor()
		imgui.End()
	end
	if win_state['about'].v then -- окно "о скрипте"
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(360, 225), imgui.Cond.FirstUseEver)
		imgui.Begin(fa(0xf06a)..u8(' О скрипте'), win_state['about'], imgui.WindowFlags.NoResize)

		imgui.Text(u8'GeekHelper - игровой помощник')
		imgui.Text(u8'Разработчики: Oniel & CzarAlex')
		imgui.Text(u8'Версия скрипта: '..thisScript().version)
		imgui.Separator()
		if imgui.Button(u8'VK.Oniel') then
			sampAddChatMessage("[GeekHelper]{FFFFFF} Сейчас откроется ссылка ВКонтакте.", 0x046D63)
			print(shell32.ShellExecuteA(nil, 'open', 'https://vk.com/onie1', nil, nil, 1))
		end
		imgui.SameLine()
		if imgui.Button(u8'VK.CzarAlex') then
			sampAddChatMessage("[GeekHelper]{FFFFFF} Сейчас откроется ссылка ВКонтакте.", 0x046D63)
			print(shell32.ShellExecuteA(nil, 'open', 'https://vk.com/czar.alex', nil, nil, 1))
		end
		imgui.SameLine()
		if imgui.Button(u8'Перезагрузить скрипт', btn_size) then
			thisScript():reload()
		end
		if imgui.Button(u8'Отключить скрипт', btn_size) then
			thisScript():unload()
		end
		imgui.End()
	end
	if win_state['update'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(450, 200), imgui.Cond.FirstUseEver)

		imgui.Begin(fa(0xf0ed)..u8(' Обновление'), nil, imgui.WindowFlags.NoResize)

		imgui.Text(u8'Обнаружено обновление до версии: '..updatever)
		
		imgui.Separator()

		imgui.TextWrapped(u8("Для установки обновления необходимо подтверждение пользователя, разработчик настоятельно рекомендует принимать обновления ввиду того, что прошлые версии через определенное время отключаются и более не работают."))

		if imgui.Button(u8'Скачать и установить обновление', btn_size) then
			async_http_request('GET', 'https://geekhub.pro/samp/geekhelper/GeekHelper.lua', nil,
				function(response)
				local f = assert(io.open(getWorkingDirectory() .. '/GeekHelper.lua', 'wb'))
				f:write(response.text)
				f:close()
				sampAddChatMessage("[GeekHelper]{FFFFFF} Обновление успешно, перезагружаем скрипт.", 0x046D63)
				thisScript():reload()
			end,
			function(err)
				print(err)
				sampAddChatMessage("[GeekHelper]{FFFFFF} Произошла ошибка при обновлении, попробуйте позже.", 0x046D63)
				win_state['update'].v = not win_state['update'].v
				return
			end)
		end

		if imgui.Button(u8'Закрыть', btn_size) then
			win_state['update'].v = not win_state['update'].v
		end

		imgui.End()
	end
	if win_state['chat_settings'].v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(600, 900), imgui.Cond.FirstUseEver)
		imgui.Begin('chat settings', win_state['chat_settings'])
		imgui.End()
	end
	if win_state['chat'].v then
		local musiclist = getMusicList()
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(810, 310), imgui.Cond.FirstUseEver)

		imgui.Begin(fa(0xf0e0)..u8' Чат', win_state['chat'], imgui.WindowFlags.NoResize)

		imgui.BeginChild('##chat', imgui.ImVec2(0, imgui.GetWindowHeight() - 55))
		for i, chat_data in pairs(test_chat_data) do
			c_username = 'nil'
			c_message = 'nil'
			c_status = 'nil'
			c_time = 'nil'
			for k, v in pairs(chat_data) do
				if     k == 'username' then c_username = v
				elseif k == 'message'  then c_message = v
				elseif k == 'status'   then c_status = v
				elseif k == 'time'     then c_time = v
				end
			end
			local t = c_username == 'user'

			local size = imgui.GetFont():CalcTextSizeA(imgui.GetFont().FontSize, 350.0, 346.0, c_username..'\n> '..c_message..'\n'..c_time:sub(3))
			local x = size.x > 350 and 350 or size.x + imgui.GetStyle().ItemSpacing.x
			if t then
				imgui.NewLine()
				imgui.SameLine(imgui.GetWindowWidth() - x - imgui.GetStyle().WindowPadding.x - (imgui.GetScrollMaxY() == 0 and 0 or imgui.GetStyle().ScrollbarSize))
			end
			
			--imgui.PushStyleColor(imgui.Col.ChildWindowBg, imgui.ImColor(48, 134, 210, t == 1 and 113 or 90):GetVec4())
			imgui.PushStyleColor(imgui.Col.ChildWindowBg, imgui.ImColor(200, 200, 200, 200):GetVec4())
			imgui.PushStyleVar(imgui.StyleVar.WindowPadding, imgui.ImVec2(4.0, 2.0))
			
			imgui.BeginChild("##msg_"..i, imgui.ImVec2(x + 8.0, (size.y/2.8 + 4.0) * 3), false, imgui.WindowFlags.AlwaysUseWindowPadding + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse)
			
			local clr = nil
			if c_status == 'user' then
				--clr = '{222222}'
				clr = imgui.ImVec4(0.2, 0.2, 0.2, 1.0)
			elseif c_status == 'vip' then
				--clr = '{111188}'
				clr = imgui.ImVec4(0.1, 0.1, 0.4, 1.0)
			elseif c_status == 'helper' then
				--clr = '{117711}'
				clr = imgui.ImVec4(0.1, 0.4, 0.1, 1.0)
			elseif c_status == 'developer' then
				--clr = '{881111}'
				clr = imgui.ImVec4(0.4, 0.1, 0.1, 1.0)
			end
			--local fullText = clr..c_username..':{000000} '..c_message..'\n'..c_time
			imgui.SetWindowFontScale(1.1)
			imgui.TextColored(clr, c_username)

			imgui.SetWindowFontScale(1.0)
			imgui.TextColored(imgui.ImVec4(0.0, 0.0, 0.0, 1.0), '> '..c_message)

			imgui.SetWindowFontScale(0.8)
			imgui.NewLine()
			imgui.SameLine(x - imgui.GetFont():CalcTextSizeA(imgui.GetFont().FontSize, 350.0, 346.0, c_time).x * 0.8)
			imgui.TextColored(imgui.ImVec4(0.2, 0.2, 0.2, 1.0), c_time)
			--imgui.TextColoredRGB(fullText)
			
			imgui.EndChild()
			
			imgui.PopStyleVar()
			imgui.PopStyleColor()
		end
		imgui.EndChild()

		imgui.PushItemWidth(imgui.GetWindowWidth() - imgui.CalcTextSize(u8('Отправить')).x - 20)
		
		imgui.InputText('##input', chat_text)
		
		imgui.PopItemWidth()
		
		imgui.SameLine()
		
		if imgui.Button(fa(0xf0da)) then
			if #chat_text.v > 2 then
				table.insert(test_chat_data, {["username"]="user", ["status"]="developer", ["time"]=os.date("%H:%M:%S"), ["message"]=chat_text.v}) chat_text.v = ''
			end
		end
		imgui.End()
	end
end

function onScriptTerminate(script, quitGame) -- действия при отключении скрипта
	if script == thisScript() then
		showCursor(false)
		bass.BASS_ChannelPlay(aerr, false) -- воспроизводим звук краша
		lockPlayerControl(false) -- снимаем блок персонажа на всякий

		if not reloadScript then -- выводим текст
			sampAddChatMessage("[GeekHelper]{FFFFFF} Произошла ошибка, скрипт завершил свою работу принудительно.", 0x046D63)
		end
	end
end

function strobes() -- стробоскопы
	if not isCharOnAnyBike(PLAYER_PED) and not isCharInAnyBoat(PLAYER_PED) and not isCharInAnyHeli(PLAYER_PED) and not isCharInAnyPlane(PLAYER_PED) then
		if not enableStrobes then
			enableStrobes = true
			lua_thread.create(function()
				vehptr = getCarPointer(storeCarCharIsInNoSave(PLAYER_PED)) + 1440
				while enableStrobes and isCharInAnyCar(PLAYER_PED) do
					callMethod(7086336, vehptr, 2, 0, 0, 0)
					callMethod(7086336, vehptr, 2, 0, 1, 1)
					wait(150)
					callMethod(7086336, vehptr, 2, 0, 0, 1)
					callMethod(7086336, vehptr, 2, 0, 1, 0)
					wait(150)
					if not isCharInAnyCar(PLAYER_PED) then
						enableStrobes = false
						break
					end
				end
				callMethod(7086336, vehptr, 2, 0, 0, 0)
				callMethod(7086336, vehptr, 2, 0, 1, 0)
			end)
		else
			enableStrobes = false
		end
	end
end
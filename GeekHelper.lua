
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

lfs = require('lfs')
encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8



local win_state = {}
win_state['update'] = imgui.ImBool(false)
win_state['main'] = imgui.ImBool(false)
win_state['settings'] = imgui.ImBool(false)
win_state['mods'] = imgui.ImBool(false)
win_state['style'] = imgui.ImBool(false)
win_state['about'] = imgui.ImBool(false)



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


ini = {}
function ini:save(data, path, name)
	lfs.mkdir(path)
	res = ''
	for sec, tbl in pairs(data) do
		res = res..'['..sec..']\n'
		for key, val in pairs(tbl) do
			res = res..key..'='..val..'\n'
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
	if not fw:read('*a') == nil then return nil end
	new = {}
	sec = ''
	fw = io.open(path, 'r')
	txt = fw:read('*a')
	for line in string.gmatch(txt, '([^'..'\n'..']+)') do
		t = {}
		line:gsub('.', function(c) table.insert(t, c) end)
		if t[1] == '[' then
			for tmp in string.gmatch(line, '(%w+)') do
				new[tmp] = {}
				sec = tmp
			end
		else
			f = false
			t1 = nil
			t2 = nil
			for tmp in string.gmatch(line, '([^'..'='..']+)') do
				if not f then
					t1 = tmp
				else
					t2 = tmp
				end
				f = not f
			end
			new[sec][t1] = t2
		end
	end
	fw:close()
	return new
end


local Config = {
	ini = {
		style = {
			name = 'Androvira'
		}
	},
	name = 'settings.ini',
	path = '\\moonloader\\config\\GeekHelper\\'
}

function Config:Save()
	ini:save(Config.ini, getGameDirectory()..Config.path, Config.name)
	--lfs.mkdir(getGameDirectory()..Config.path)
	--json:encode(Config.ini)
	--inicfg.save(Config.ini, getGameDirectory()..Config.path..Config.name)
end

function Config:Load()
	tmp = ini:load(getGameDirectory()..Config.path..Config.name)
	if tmp ~= nil then
		Config.ini = tmp
	end
	Style(Config.ini.style.name)
end

function Style(name)
	ok = true
	if name == 'Light' then
		imgui.GetStyle().Colors[imgui.Col.Text]                 = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.94, 0.94, 0.94, 0.94)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]        = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]              = imgui.ImVec4(1.00, 1.00, 1.00, 0.94)
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
		imgui.GetStyle().Colors[imgui.Col.ComboBg]              = imgui.ImVec4(0.86, 0.86, 0.86, 0.99)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(0.24, 0.52, 0.88, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button]               = imgui.ImVec4(0.26, 0.59, 0.98, 0.40)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.06, 0.53, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header]               = imgui.ImVec4(0.26, 0.59, 0.98, 0.31)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.26, 0.59, 0.98, 0.80)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
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

	elseif name == 'Androvira' then
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
		imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(0.87, 0.85, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.87, 0.85, 0.92, 0.58)
		imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.13, 0.12, 0.16, 0.71)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg] = imgui.ImVec4(0.27, 0.20, 0.39, 0.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg] = imgui.ImVec4(0.05, 0.05, 0.10, 0.90)
		imgui.GetStyle().Colors[imgui.Col.Border] = imgui.ImVec4(0.87, 0.85, 0.92, 0.30)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg] = imgui.ImVec4(0.27, 0.20, 0.39, 1.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.34, 0.19, 0.63, 0.68)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.46, 0.27, 0.80, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBg] = imgui.ImVec4(0.34, 0.19, 0.63, 0.45)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(0.34, 0.19, 0.63, 0.35)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.34, 0.19, 0.63, 0.78)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.27, 0.20, 0.39, 0.57)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.27, 0.20, 0.39, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.34, 0.19, 0.63, 0.31)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.34, 0.19, 0.63, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CheckMark] = imgui.ImVec4(0.34, 0.19, 0.63, 0.80)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.34, 0.19, 0.63, 0.24)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button] = imgui.ImVec4(0.34, 0.19, 0.63, 0.44)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.34, 0.19, 0.63, 0.86)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.34, 0.19, 0.63, 0.76)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.34, 0.19, 0.63, 0.86)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column] = imgui.ImVec4(0.87, 0.85, 0.92, 0.32)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered] = imgui.ImVec4(0.87, 0.85, 0.92, 0.78)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive] = imgui.ImVec4(0.87, 0.85, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = imgui.ImVec4(0.34, 0.19, 0.63, 0.20)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.34, 0.19, 0.63, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButton] = imgui.ImVec4(0.87, 0.85, 0.92, 0.16)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered] = imgui.ImVec4(0.87, 0.85, 0.92, 0.39)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive] = imgui.ImVec4(0.87, 0.85, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines] = imgui.ImVec4(0.87, 0.85, 0.92, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.87, 0.85, 0.92, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.34, 0.19, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.34, 0.19, 0.63, 0.43)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)
	elseif name == 'Green' then
		imgui.GetStyle().Colors[imgui.Col.Text]                  = imgui.ImVec4(0.90, 0.90, 0.90, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]          = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]              = imgui.ImVec4(0.00, 0.00, 0.00, 0.90)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]         = imgui.ImVec4(0.00, 0.00, 0.00, 0.95)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]               = imgui.ImVec4(0.05, 0.05, 0.10, 0.90)
		imgui.GetStyle().Colors[imgui.Col.Border]                = imgui.ImVec4(0.08, 0.51, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]          = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]               = imgui.ImVec4(0.08, 0.51, 0.10, 0.39)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]        = imgui.ImVec4(0.08, 0.51, 0.10, 0.63)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]         = imgui.ImVec4(0.08, 0.51, 0.10, 0.71)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]               = imgui.ImVec4(0.08, 0.51, 0.10, 0.63)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]      = imgui.ImVec4(0.08, 0.51, 0.10, 0.51)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive]         = imgui.ImVec4(0.08, 0.51, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]             = imgui.ImVec4(0.40, 0.40, 0.55, 0.80)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]           = imgui.ImVec4(0.08, 0.39, 0.10, 0.39)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]         = imgui.ImVec4(0.08, 0.27, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]  = imgui.ImVec4(0.08, 0.39, 0.10, 0.74)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]   = imgui.ImVec4(0.08, 0.39, 0.10, 0.59)
		imgui.GetStyle().Colors[imgui.Col.ComboBg]               = imgui.ImVec4(0.00, 0.00, 0.00, 0.94)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]             = imgui.ImVec4(0.08, 0.51, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]            = imgui.ImVec4(0.08, 0.51, 0.10, 0.63)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]      = imgui.ImVec4(0.08, 0.51, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button]                = imgui.ImVec4(0.08, 0.51, 0.10, 0.59)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]         = imgui.ImVec4(0.08, 0.51, 0.10, 0.75)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]          = imgui.ImVec4(0.08, 0.51, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header]                = imgui.ImVec4(0.08, 0.27, 0.10, 0.67)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]         = imgui.ImVec4(0.08, 0.35, 0.10, 0.80)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]          = imgui.ImVec4(0.08, 0.39, 0.10, 0.80)
		--imgui.GetStyle().Colors[imgui.Col.Column]                = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered]         = imgui.ImVec4(0.70, 0.60, 0.60, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive]          = imgui.ImVec4(0.90, 0.70, 0.70, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]            = imgui.ImVec4(0.08, 0.27, 0.10, 0.30)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]     = imgui.ImVec4(0.08, 0.27, 0.10, 0.60)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]      = imgui.ImVec4(0.08, 0.27, 0.10, 0.90)
		imgui.GetStyle().Colors[imgui.Col.CloseButton]           = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]    = imgui.ImVec4(0.00, 0.01, 0.00, 0.60)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]     = imgui.ImVec4(0.70, 0.70, 0.70, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines]             = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]      = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram]         = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]  = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]        = imgui.ImVec4(0.00, 0.00, 1.00, 0.35)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening]  = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)
	elseif name == 'Violet' then
		imgui.GetStyle().Colors[imgui.Col.Text]                  = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled]          = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
		imgui.GetStyle().Colors[imgui.Col.WindowBg]              = imgui.ImVec4(0.00, 0.00, 0.00, 0.88)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]         = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg]               = imgui.ImVec4(0.05, 0.05, 0.10, 0.90)
		imgui.GetStyle().Colors[imgui.Col.Border]                = imgui.ImVec4(0.31, 0.00, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow]          = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg]               = imgui.ImVec4(0.31, 0.13, 0.37, 0.55)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]        = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive]         = imgui.ImVec4(0.31, 0.00, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBg]               = imgui.ImVec4(0.31, 0.18, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]      = imgui.ImVec4(0.40, 0.40, 0.80, 0.20)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive]         = imgui.ImVec4(0.31, 0.00, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg]             = imgui.ImVec4(0.40, 0.40, 0.55, 0.80)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]           = imgui.ImVec4(0.31, 0.13, 0.37, 0.22)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]         = imgui.ImVec4(0.31, 0.13, 0.37, 0.51)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]  = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]   = imgui.ImVec4(0.31, 0.13, 0.37, 0.71)
		imgui.GetStyle().Colors[imgui.Col.ComboBg]               = imgui.ImVec4(0.00, 0.00, 0.00, 0.92)
		imgui.GetStyle().Colors[imgui.Col.CheckMark]             = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab]            = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]      = imgui.ImVec4(0.31, 0.13, 0.37, 0.67)
		imgui.GetStyle().Colors[imgui.Col.Button]                = imgui.ImVec4(0.31, 0.00, 0.37, 0.65)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered]         = imgui.ImVec4(0.31, 0.00, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive]          = imgui.ImVec4(0.31, 0.00, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header]                = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered]         = imgui.ImVec4(0.31, 0.13, 0.37, 0.55)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive]          = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column]                = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered]         = imgui.ImVec4(0.70, 0.60, 0.60, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive]          = imgui.ImVec4(0.90, 0.70, 0.70, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip]            = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]     = imgui.ImVec4(0.31, 0.13, 0.37, 0.60)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]      = imgui.ImVec4(0.31, 0.13, 0.37, 0.78)
		imgui.GetStyle().Colors[imgui.Col.CloseButton]           = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered]    = imgui.ImVec4(0.00, 0.00, 0.00, 0.60)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive]     = imgui.ImVec4(0.70, 0.70, 0.70, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines]             = imgui.ImVec4(0.31, 0.13, 0.37, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]      = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram]         = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]  = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]        = imgui.ImVec4(0.00, 0.00, 1.00, 0.35)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening]  = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)
	
	elseif name == 'Deault' then
		imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
		imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.94, 0.94, 0.94, 1.)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg] = imgui.ImVec4(1.00, 1.00, 1.00, 1.)
		imgui.GetStyle().Colors[imgui.Col.Border] = imgui.ImVec4(0.00, 0.00, 0.00, 0.39)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(1.00, 1.00, 1.00, 0.10)
		imgui.GetStyle().Colors[imgui.Col.FrameBg] = imgui.ImVec4(1.00, 1.00, 1.00, 0.94)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.40)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.26, 0.59, 0.98, 0.67)
		imgui.GetStyle().Colors[imgui.Col.TitleBg] = imgui.ImVec4(0.96, 0.96, 0.96, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(1.00, 1.00, 1.00, 0.51)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.82, 0.82, 0.82, 1.00)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.86, 0.86, 0.86, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.98, 0.98, 0.98, 0.53)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.69, 0.69, 0.69, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.59, 0.59, 0.59, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.49, 0.49, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CheckMark] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.24, 0.52, 0.88, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button] = imgui.ImVec4(0.26, 0.59, 0.98, 0.40)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.06, 0.53, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.26, 0.59, 0.98, 0.31)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.80)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column] = imgui.ImVec4(0.39, 0.39, 0.39, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.78)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = imgui.ImVec4(1.00, 1.00, 1.00, 0.50)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.67)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.26, 0.59, 0.98, 0.95)
		imgui.GetStyle().Colors[imgui.Col.CloseButton] = imgui.ImVec4(0.59, 0.59, 0.59, 0.50)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered] = imgui.ImVec4(0.98, 0.39, 0.36, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive] = imgui.ImVec4(0.98, 0.39, 0.36, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines] = imgui.ImVec4(0.39, 0.39, 0.39, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(1.00, 0.43, 0.35, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.26, 0.59, 0.98, 0.35)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)

	elseif name == 'Indigo' then
		imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(0.86, 0.93, 0.89, 0.78)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.92, 0.18, 0.29, 0.78)
		imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.13, 0.14, 0.17, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg] = imgui.ImVec4(0.20, 0.22, 0.27, 0.58)
		imgui.GetStyle().Colors[imgui.Col.PopupBg] = imgui.ImVec4(0.20, 0.22, 0.27, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Border] = imgui.ImVec4(0.00, 0.00, 0.00, 0.35)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg] = imgui.ImVec4(0.20, 0.22, 0.27, 1.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.92, 0.18, 0.29, 0.78)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBg] = imgui.ImVec4(0.20, 0.22, 0.27, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(0.20, 0.22, 0.27, 0.75)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.20, 0.22, 0.27, 0.47)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.20, 0.22, 0.27, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.09, 0.15, 0.16, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.92, 0.18, 0.29, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CheckMark] = imgui.ImVec4(0.71, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.92, 0.18, 0.29, 0.37)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button] = imgui.ImVec4(0.92, 0.18, 0.29, 0.75)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.92, 0.18, 0.29, 0.86)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.92, 0.18, 0.29, 0.76)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.92, 0.18, 0.29, 0.86)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column] = imgui.ImVec4(0.15, 0.00, 0.00, 0.35)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered] = imgui.ImVec4(0.92, 0.18, 0.29, 0.59)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive] = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = imgui.ImVec4(0.92, 0.18, 0.29, 0.63)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.92, 0.18, 0.29, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButton] = imgui.ImVec4(1.00, 1.00, 1.00, 0.51)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered] = imgui.ImVec4(1.00, 1.00, 1.00, 0.67)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive] = imgui.ImVec4(1.00, 1.00, 1.00, 0.78)
		imgui.GetStyle().Colors[imgui.Col.PlotLines] = imgui.ImVec4(0.86, 0.93, 0.89, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.86, 0.93, 0.89, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.92, 0.18, 0.29, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.92, 0.18, 0.29, 0.43)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.22, 0.27, 0.73)
	elseif name == 'Night' then
	imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(0.85, 0.87, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.85, 0.87, 0.92, 0.58)
		imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg] = imgui.ImVec4(0.14, 0.19, 0.36, 0.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg] = imgui.ImVec4(0.05, 0.05, 0.10, 0.90)
		imgui.GetStyle().Colors[imgui.Col.Border] = imgui.ImVec4(0.85, 0.87, 0.92, 0.30)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg] = imgui.ImVec4(0.14, 0.19, 0.36, 1.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.10, 0.19, 0.49, 0.68)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBg] = imgui.ImVec4(0.10, 0.19, 0.49, 0.45)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(0.10, 0.19, 0.49, 0.35)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.10, 0.19, 0.49, 0.78)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.14, 0.19, 0.36, 0.57)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.14, 0.19, 0.36, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.10, 0.19, 0.49, 0.31)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.10, 0.19, 0.49, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CheckMark] = imgui.ImVec4(0.16, 0.86, 0.90, 0.80)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.10, 0.19, 0.49, 0.24)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.07, 0.26, 0.53, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button] = imgui.ImVec4(0.10, 0.19, 0.49, 0.44)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.10, 0.19, 0.49, 0.86)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.10, 0.19, 0.49, 0.76)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.10, 0.19, 0.49, 0.86)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column] = imgui.ImVec4(0.85, 0.87, 0.92, 0.32)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered] = imgui.ImVec4(0.85, 0.87, 0.92, 0.78)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive] = imgui.ImVec4(0.85, 0.87, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = imgui.ImVec4(0.10, 0.19, 0.49, 0.20)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.10, 0.19, 0.49, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButton] = imgui.ImVec4(0.85, 0.87, 0.92, 0.16)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered] = imgui.ImVec4(0.85, 0.87, 0.92, 0.39)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive] = imgui.ImVec4(0.85, 0.87, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines] = imgui.ImVec4(0.85, 0.87, 0.92, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.85, 0.87, 0.92, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.10, 0.19, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.10, 0.19, 0.49, 0.43)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)

	elseif name == 'Dunno' then
		imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(0.90, 0.90, 0.90, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
		imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg] = imgui.ImVec4(0.65, 0.00, 0.06, 0.03)
		imgui.GetStyle().Colors[imgui.Col.PopupBg] = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
		imgui.GetStyle().Colors[imgui.Col.Border] = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg] = imgui.ImVec4(0.00, 0.00, 0.06, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.00, 0.00, 0.06, 0.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBg] = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.00, 0.00, 0.00, 3.14)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.00, 0.00, 0.00, 3.14)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.CheckMark] = imgui.ImVec4(0.90, 0.90, 0.90, 0.50)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.00, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.65, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.Button] = imgui.ImVec4(0.00, 0.00, 0.06, 3.14)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.00, 0.42, 0.44, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.05, 0.27, 0.48, 0.59)
		imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.00, 0.24, 0.44, 1.00)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.00, 0.42, 0.44, 1.00)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.00, 0.42, 0.44, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column] = imgui.ImVec4(0.85, 0.89, 0.92, 0.32)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered] = imgui.ImVec4(0.85, 0.89, 0.92, 0.78)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive] = imgui.ImVec4(0.85, 0.89, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = imgui.ImVec4(0.19, 0.43, 0.63, 0.20)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.19, 0.43, 0.63, 0.78)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.19, 0.43, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButton] = imgui.ImVec4(0.85, 0.89, 0.92, 0.16)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered] = imgui.ImVec4(0.85, 0.89, 0.92, 0.39)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive] = imgui.ImVec4(0.85, 0.89, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines] = imgui.ImVec4(0.85, 0.89, 0.92, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(0.19, 0.43, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.85, 0.89, 0.92, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.19, 0.43, 0.63, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.19, 0.43, 0.63, 0.43)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)

	elseif name == 'Blue' then
		imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(0.86, 0.93, 0.89, 0.78) 
		imgui.GetStyle().Colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.13, 0.65, 0.92, 0.78) 
		imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.13, 0.14, 0.17, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg] = imgui.ImVec4(0.20, 0.22, 0.27, 0.58) 
		imgui.GetStyle().Colors[imgui.Col.PopupBg] = imgui.ImVec4(0.20, 0.22, 0.27, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.Border] = imgui.ImVec4(0.00, 0.00, 0.00, 0.35) 
		imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00) 
		imgui.GetStyle().Colors[imgui.Col.FrameBg] = imgui.ImVec4(0.20, 0.22, 0.27, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.13, 0.65, 0.92, 0.78) 
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.13, 0.65, 0.92, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.TitleBg] = imgui.ImVec4(0.20, 0.22, 0.27, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(0.20, 0.22, 0.27, 0.75) 
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.13, 0.65, 0.92, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.20, 0.22, 0.27, 0.47) 
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.20, 0.22, 0.27, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.09, 0.15, 0.16, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.13, 0.65, 0.92, 0.78) 
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.13, 0.65, 0.92, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.CheckMark] = imgui.ImVec4(0.13, 0.65, 0.92, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.13, 0.65, 0.92, 0.37) 
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.13, 0.65, 0.92, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.Button] = imgui.ImVec4(0.13, 0.65, 0.92, 0.75) 
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.13, 0.65, 0.92, 0.86) 
		imgui.GetStyle().Colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.13, 0.65, 0.92, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.13, 0.65, 0.92, 0.76) 
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.13, 0.65, 0.92, 0.86)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.13, 0.65, 0.92, 1.00) 
		--imgui.GetStyle().Colors[imgui.Col.Column] = imgui.ImVec4(0.15, 0.00, 0.00, 0.35) 
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered] = imgui.ImVec4(0.13, 0.65, 0.92, 0.59)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive] = imgui.ImVec4(0.13, 0.65, 0.92, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = imgui.ImVec4(0.13, 0.65, 0.92, 0.63) 
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.13, 0.65, 0.92, 0.78) 
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.13, 0.65, 0.92, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.CloseButton] = imgui.ImVec4(1.00, 1.00, 1.00, 0.51) 
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered] = imgui.ImVec4(1.00, 1.00, 1.00, 0.67) 
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive] = imgui.ImVec4(1.00, 1.00, 1.00, 0.78) 
		imgui.GetStyle().Colors[imgui.Col.PlotLines] = imgui.ImVec4(0.86, 0.93, 0.89, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(0.13, 0.65, 0.92, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.86, 0.93, 0.89, 0.63)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.13, 0.65, 0.92, 1.00) 
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.13, 0.65, 0.92, 0.43) 
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.22, 0.27, 0.73) 

	elseif name == 'Midnight' then
		imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
		imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.94, 0.94, 0.94, 1.)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg] = imgui.ImVec4(1.00, 1.00, 1.00, 1.)
		imgui.GetStyle().Colors[imgui.Col.Border] = imgui.ImVec4(0.00, 0.00, 0.00, 0.39)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(1.00, 1.00, 1.00, 0.10)
		imgui.GetStyle().Colors[imgui.Col.FrameBg] = imgui.ImVec4(1.00, 1.00, 1.00, 0.94)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.40)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.26, 0.59, 0.98, 0.67)
		imgui.GetStyle().Colors[imgui.Col.TitleBg] = imgui.ImVec4(0.96, 0.96, 0.96, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(1.00, 1.00, 1.00, 0.51)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.82, 0.82, 0.82, 1.00)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.86, 0.86, 0.86, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.98, 0.98, 0.98, 0.53)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.69, 0.69, 0.69, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.59, 0.59, 0.59, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.49, 0.49, 0.49, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CheckMark] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.24, 0.52, 0.88, 1.00)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button] = imgui.ImVec4(0.26, 0.59, 0.98, 0.40)
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.06, 0.53, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.26, 0.59, 0.98, 0.31)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.80)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.Column] = imgui.ImVec4(0.39, 0.39, 0.39, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.78)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = imgui.ImVec4(1.00, 1.00, 1.00, 0.50)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.67)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.26, 0.59, 0.98, 0.95)
		imgui.GetStyle().Colors[imgui.Col.CloseButton] = imgui.ImVec4(0.59, 0.59, 0.59, 0.50)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered] = imgui.ImVec4(0.98, 0.39, 0.36, 1.00)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive] = imgui.ImVec4(0.98, 0.39, 0.36, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines] = imgui.ImVec4(0.39, 0.39, 0.39, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(1.00, 0.43, 0.35, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.26, 0.59, 0.98, 0.35)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)
	elseif name == 'Black' then
		imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(0.80, 0.80, 0.80, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.60, 0.60, 0.60, 1.00)
		imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.00, 0.00, 1.00, 0.35)
		imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.10, 0.10, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ChildWindowBg] = imgui.ImVec4(0.10, 0.10, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PopupBg] = imgui.ImVec4(0.05, 0.05, 0.10, 0.90)
		imgui.GetStyle().Colors[imgui.Col.Border] = imgui.ImVec4(0.70, 0.70, 0.70, 0.65)
		imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBg] = imgui.ImVec4(0.10, 0.10, 0.10, 1.00)
		imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.90, 0.80, 0.80, 0.40)
		imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.90, 0.65, 0.65, 0.45)
		imgui.GetStyle().Colors[imgui.Col.TitleBg] = imgui.ImVec4(0.00, 0.25, 0.90, 0.83)
		imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(0.00, 0.25, 0.90, 0.20)
		imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.00, 0.25, 0.90, 0.87)
		imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.40, 0.40, 0.55, 0.80)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.20, 0.25, 0.30, 0.60)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.40, 0.40, 0.80, 0.30)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.40, 0.40, 0.80, 0.40)
		imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.80, 0.50, 0.50, 0.40)
		imgui.GetStyle().Colors[imgui.Col.CheckMark] = imgui.ImVec4(0.90, 0.90, 0.90, 0.50)
		imgui.GetStyle().Colors[imgui.Col.SliderGrab] = imgui.ImVec4(1.00, 1.00, 1.00, 0.30)
		imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.80, 0.50, 0.50, 1.00)
		imgui.GetStyle().Colors[imgui.Col.Button] = imgui.GetStyle().Colors[imgui.Col.WindowBg]
		imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.00, 0.46, 0.65, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.00, 0.25, 0.90, 0.83)
		imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.40, 0.40, 0.90, 0.45)
		imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.45, 0.45, 0.90, 0.80)
		imgui.GetStyle().Colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.53, 0.53, 0.87, 0.80)
		--imgui.GetStyle().Colors[imgui.Col.Column] = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnHovered] = imgui.ImVec4(0.70, 0.60, 0.60, 1.00)
		--imgui.GetStyle().Colors[imgui.Col.ColumnActive] = imgui.ImVec4(0.90, 0.70, 0.70, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = imgui.ImVec4(1.00, 1.00, 1.00, 0.30)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(1.00, 1.00, 1.00, 0.60)
		imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(1.00, 1.00, 1.00, 0.90)
		imgui.GetStyle().Colors[imgui.Col.CloseButton] = imgui.ImVec4(0.50, 0.50, 0.90, 0.50)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered] = imgui.ImVec4(0.70, 0.70, 0.90, 0.60)
		imgui.GetStyle().Colors[imgui.Col.CloseButtonActive] = imgui.ImVec4(0.70, 0.70, 0.70, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLines] = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
		imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)
	else
		ok = false
	end
	if ok then
		Config.ini.style.name = name
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
	print("Начинаем подгрузку скрипта и его составляющих")
	sampAddChatMessage("[GeekHelper] {FFFFFF}Скрипт подгружен в игру, версия: {00C2BB}"..thisScript().version.."{ffffff}, начинаем инициализацию.", 0x046D63)
	print("Начинаем проверку обновлений.")
	updateCheck()
	while not isUpdateCheck do wait(0) end
	imgui.Process = win_state['update'].v or win_state['main'].v
	sampRegisterChatCommand("gh", mainmenu)
	Config:Load()
	while true do
		imgui.Process = win_state['main'].v
		wait(0)
	end
end

function mainmenu()
	win_state['main'].v = not win_state['main'].v
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

		fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/GeekHelper/files/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
		menubar_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/GeekHelper/files/gtasa.ttf', 28.0)
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

function imgui.OnDrawFrame()
	local tLastKeys = {} 
	local sw, sh = getScreenResolution() 
	local btn_size = imgui.ImVec2(-0.1, 0) 
	local btn_size2 = imgui.ImVec2(160, 0)
	local btn_size3 = imgui.ImVec2(140, 0)

	imgui.ShowCursor = imgui.Process
	imgui.PushStyleVar(imgui.StyleVar.FramePadding, imgui.ImVec2(500, 20))
	imgui.PushFont(menubar_font)
	if imgui.BeginMainMenuBar() then
		if imgui.BeginMenu('Styles') then
			if imgui.MenuItem('Light')     then Style('Light')     end
			if imgui.MenuItem('Androvira') then Style('Androvira') end
			if imgui.MenuItem('Hacker')    then Style('Hacker')    end
			if imgui.MenuItem('Orange')    then Style('Orange')    end
			if imgui.MenuItem('Monsieur')  then Style('Monsieur')  end
			if imgui.MenuItem('Dark')      then Style('Dark')      end
			if imgui.MenuItem('Purple')    then Style('Purple')    end
			if imgui.MenuItem('Violet')    then Style('Violet')    end
			if imgui.MenuItem('Green')     then Style('Green')     end
			if imgui.MenuItem('Deault')    then Style('Deault')    end
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
		imgui.EndMainMenuBar()
	end
	imgui.PopFont()
	imgui.PopStyleVar()

	--imgui.ShowCursor = win_state['update'].v
	if win_state['main'].v then 
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(280, 250), imgui.Cond.FirstUseEver)

		imgui.Begin(' GeekHelper', win_state['main'], imgui.WindowFlags.NoResize)
		
		if imgui.Button(u8' Настройки', btn_size) then
			win_state['settings'].v = not win_state['settings'].v
		end

		if imgui.Button(u8' Модификации', btn_size) then
			win_state['mods'].v = not win_state['mods'].v
		end

		if imgui.Button(u8' О скрипте', btn_size) then
			win_state['about'].v = not win_state['about'].v
		end

		if imgui.Button('Style', btn_size) then
			win_state['style'].v = not win_state['style'].v
		end

		imgui.End()
	end
	if win_state['mods'].v then
		imgui.Begin(u8'Модификации', win_state['mods'])

		--imgui.AlignTextToFramePadding(); imgui.Text(u8(" Чат на клавишу Т")); imgui.SameLine(); imgui.Checkbox(u8'Чат на клавишу T', keyT)

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

		imgui.NextColumn()
		imgui.Text('button pressed: '..tostring(pres))
		imgui.ColorPicker4('colorpicker4', f4)

		imgui.End()
	end
	if win_state['settings'].v then 
		imgui.Begin(u8'Настройки', win_state['settings'])

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
		
		imgui.NextColumn()
		imgui.Text('button pressed: '..tostring(pres))
		imgui.ColorPicker4('colorpicker4', f4)

		imgui.End()
	end
	if win_state['style'].v then
		imgui.Begin('Style', win_state['style'])
		imgui.ShowStyleEditor()
		imgui.End()
	end
	if win_state['about'].v then -- окно "о скрипте"
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(360, 225), imgui.Cond.FirstUseEver)
		imgui.Begin(u8('О скрипте'), win_state['about'], imgui.WindowFlags.NoResize)

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

		imgui.Begin(u8('Обновление'), nil, imgui.WindowFlags.NoResize)

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
end

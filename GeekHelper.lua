
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


encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8



local win_state = {}
win_state['update'] = imgui.ImBool(false)
win_state['main'] = imgui.ImBool(false)
win_state['settings'] = imgui.ImBool(false)
win_state['style'] = imgui.ImBool(false)


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


local Config = {
	ini = {
		style = {
			name = 'Androvira'
		}
	},
	path = '\\moonloader\\config\\GeekHelper\\setting.ini'
}

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
		imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(0.80, 0.80, 0.83, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.24, 0.23, 0.29, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ChildWindowBg] = imgui.ImVec4(0.07, 0.07, 0.09, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PopupBg] = imgui.ImVec4(0.07, 0.07, 0.09, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.Border] = imgui.ImVec4(0.80, 0.80, 0.83, 0.88)
	    imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(0.92, 0.91, 0.88, 0.00)
	    imgui.GetStyle().Colors[imgui.Col.FrameBg] = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.24, 0.23, 0.29, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.TitleBg] = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(1.00, 0.98, 0.95, 0.75)
	    imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.07, 0.07, 0.09, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.80, 0.80, 0.83, 0.31)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ComboBg] = imgui.ImVec4(0.19, 0.18, 0.21, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.CheckMark] = imgui.ImVec4(0.80, 0.80, 0.83, 0.31)
	    imgui.GetStyle().Colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.80, 0.80, 0.83, 0.31)
	    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.Button] = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.24, 0.23, 0.29, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.10, 0.09, 0.12, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
	    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.56, 0.56, 0.58, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.06, 0.05, 0.07, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.CloseButton] = imgui.ImVec4(0.40, 0.39, 0.38, 0.16)
	    imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered] = imgui.ImVec4(0.40, 0.39, 0.38, 0.39)
	    imgui.GetStyle().Colors[imgui.Col.CloseButtonActive] = imgui.ImVec4(0.40, 0.39, 0.38, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PlotLines] = imgui.ImVec4(0.40, 0.39, 0.38, 0.63)
	    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(0.25, 1.00, 0.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.40, 0.39, 0.38, 0.63)
	    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.25, 1.00, 0.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.25, 1.00, 0.00, 0.43)
	    imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(1.00, 0.98, 0.95, 0.73)

	elseif name == 'Hacker' then
	    imgui.GetStyle().Colors[imgui.Col.Text] = imgui.ImVec4(1.000, 1.000, 1.000, 1.000)
	    imgui.GetStyle().Colors[imgui.Col.TextDisabled] = imgui.ImVec4(0.000, 0.543, 0.983, 1.000)
	    imgui.GetStyle().Colors[imgui.Col.WindowBg] = imgui.ImVec4(0.000, 0.000, 0.000, 0.895)
	    imgui.GetStyle().Colors[imgui.Col.ChildWindowBg] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
	    imgui.GetStyle().Colors[imgui.Col.PopupBg] = imgui.ImVec4(0.07, 0.07, 0.09, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.Border] = imgui.ImVec4(0.184, 0.878, 0.000, 0.500)
	    imgui.GetStyle().Colors[imgui.Col.BorderShadow] = imgui.ImVec4(1.00, 1.00, 1.00, 0.10)
	    imgui.GetStyle().Colors[imgui.Col.FrameBg] = imgui.ImVec4(0.160, 0.160, 0.160, 0.315)
	    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = imgui.ImVec4(0.160, 0.160, 0.160, 0.315)
	    imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = imgui.ImVec4(0.210, 0.210, 0.210, 0.670)
	    imgui.GetStyle().Colors[imgui.Col.TitleBg] = imgui.ImVec4(0.026, 0.597, 0.000, 1.000)
	    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = imgui.ImVec4(0.099, 0.315, 0.000, 0.000)
	    imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = imgui.ImVec4(0.026, 0.597, 0.000, 1.000)
	    imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = imgui.ImVec4(0.86, 0.86, 0.86, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = imgui.ImVec4(0.000, 0.000, 0.000, 0.801)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = imgui.ImVec4(0.238, 0.238, 0.238, 1.000)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.238, 0.238, 0.238, 1.000)
	    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = imgui.ImVec4(0.004, 0.381, 0.000, 1.000)
	    --imgui.GetStyle().Colors[imgui.Col.ComboBg] = imgui.ImVec4(0.86, 0.86, 0.86, 0.99)
	    imgui.GetStyle().Colors[imgui.Col.CheckMark] = imgui.ImVec4(0.009, 0.845, 0.000, 1.000)
	    imgui.GetStyle().Colors[imgui.Col.SliderGrab] = imgui.ImVec4(0.139, 0.508, 0.000, 1.000)
	    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = imgui.ImVec4(0.139, 0.508, 0.000, 1.000)
	    imgui.GetStyle().Colors[imgui.Col.Button] = imgui.ImVec4(0.000, 0.000, 0.000, 0.400)
	    imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = imgui.ImVec4(0.000, 0.619, 0.014, 1.000)
	    imgui.GetStyle().Colors[imgui.Col.ButtonActive] = imgui.ImVec4(0.06, 0.53, 0.98, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.Header] = imgui.ImVec4(0.26, 0.59, 0.98, 0.31)
	    imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.80)
	    imgui.GetStyle().Colors[imgui.Col.HeaderActive] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
	    --imgui.GetStyle().Colors[imgui.Col.Column] = imgui.ImVec4(0.39, 0.39, 0.39, 1.00)
	    --imgui.GetStyle().Colors[imgui.Col.ColumnHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.78)
	    ---imgui.GetStyle().Colors[imgui.Col.ColumnActive] = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.ResizeGrip] = imgui.ImVec4(0.000, 1.000, 0.221, 0.597)
	    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered] = imgui.ImVec4(0.26, 0.59, 0.98, 0.67)
	    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive] = imgui.ImVec4(0.26, 0.59, 0.98, 0.95)
	    --imgui.GetStyle().Colors[imgui.Col.CloseButton] = imgui.ImVec4(0.59, 0.59, 0.59, 0.50)
	    --imgui.GetStyle().Colors[imgui.Col.CloseButtonHovered] = imgui.ImVec4(0.98, 0.39, 0.36, 1.00)
	    --imgui.GetStyle().Colors[imgui.Col.CloseButtonActive] = imgui.ImVec4(0.98, 0.39, 0.36, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PlotLines] = imgui.ImVec4(0.39, 0.39, 0.39, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered] = imgui.ImVec4(1.00, 0.43, 0.35, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PlotHistogram] = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
	    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg] = imgui.ImVec4(0.26, 0.59, 0.98, 0.35)
	    imgui.GetStyle().Colors[imgui.Col.ModalWindowDarkening] = imgui.ImVec4(0.20, 0.20, 0.20, 0.35)
	else
		ok = false
	end
	if ok then
		Config.ini.style.name = name
	end
end

function Config:Save()
	inicfg.save(Config.ini, getGameDirectory()..Config.path)
end

function Config:Load()
	temp = inicfg.load(nil, getGameDirectory()..Config.path)
	if temp ~= nil then
		Config.ini = temp
	else
		print('Error loading cfg.')
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


	imgui.PushStyleVar(imgui.StyleVar.FramePadding, imgui.ImVec2(500, 20))
	imgui.PushFont(menubar_font)
	if imgui.BeginMainMenuBar() then
		if imgui.BeginMenu('Styles') then
			if imgui.MenuItem('Light') then Style('Light') end
			if imgui.MenuItem('Androvira') then Style('Androvira') end
			if imgui.MenuItem('Hacker (Nado dodelat)') then Style('Hacker') end
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
			--print("каракули")
			win_state['settings'].v = not win_state['settings'].v
		end

		if imgui.Button('Style', btn_size) then
			win_state['style'].v = not win_state['style'].v
		end
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

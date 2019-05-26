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

---------[ МЕСТО ДЛЯ ЛОКАЛЬНЫХ ПЕРЕМЕННЫХ ]--------------------------------



function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
end

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
-----------------------------------------------------------------------------------
------------------------------- ФИКСЫ ---------------------------------------------
-----------------------------------------------------------------------------------

-- Фикс зеркального бага alt+tab(черный экран после разворота в инте)
writeMemory(0x555854, 4, -1869574000, true)
writeMemory(0x555858, 1, 144, true)

-- функция быстрого прогруза игры. BY KEP4Ik
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
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
end

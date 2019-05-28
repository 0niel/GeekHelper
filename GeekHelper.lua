---------[ Script Meta ]--------------------------------
script_name('GeekHelper')
script_authors('Oniel', 'CzarAlex')
script_version('0.1')

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

---------[ МЕСТО ДЛЯ ЛОКАЛЬНЫХ ПЕРЕМЕННЫХ ]---------------------------------------




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
-----------------------------------------------------------------------------------
------------------------------- MAIN ----------------------------------------------
-----------------------------------------------------------------------------------
function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then -- Если SF или SA:MP не загружены
    return -- Завершаем работу скрипта
end
while not isSampAvailable() do -- Ждём пока функция isSampAvailable() вернет true
    wait(0) -- Устанавливаем минимальное ожидание, что бы наша игра не зависла
    -- значение 0 говорит что мы ждём следующий кадр (Frame)
end
print("Начинаем подгрузку скрипта и его составляющих")
sampAddChatMessage("[GeekHelper] {FFFFFF}Скрипт подгружен в игру, версия: {00C2BB}"..thisScript().version.."{ffffff}, начинаем инициализацию.", 0x046D63)
update()
end


-----------------------------------------------------------------------------------
function update() -- проверка обновлений
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
			end
		else
			sampAddChatMessage("[GeekHelper]{FFFFFF} Ошибка при получении информации об обновлении.", 0x046D63)
			print("[GeekHelper] JSON file read error")
		end
	else
		sampAddChatMessage("[GeekHelper]{FFFFFF} Не удалось проверить наличие обновлений, попробуйте позже.", 0x046D63)
	end
end

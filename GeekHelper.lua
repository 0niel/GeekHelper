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
-- массив для окон
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
print("Начинаем проверку обновлений.")
updateCheck()
imgui.Process = win_state['update'].v or win_state['main'].v
while not isUpdateCheck do wait(0) end -- пока не проверит обновления тормозим работу
sampRegisterChatCommand("gh", mainmenu)
end

function mainmenu() -- функция открытия основного меню скрипта
	win_state['main'].v = not win_state['main'].v
end

function load_settings() -- загрузка настроек
	-- CONFIG CREATE/LOAD
	ini = inicfg.load(SET, getGameDirectory()..'\\moonloader\\config\\GeekHelper\\settings.ini')

	-- LOAD CONFIG INFO
	test = imgui.ImBool(ini.settings.test)
end
function saveSettings(args, key) -- функция сохранения настроек, args 1 = при отключении скрипта, 2 = при выходе из игры, 3 = сохранение клавиш + текст key, 4 = обычное сохранение.

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
		print("Настройки и клавиши сохранены в связи.")
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
function updateCheck() -- проверка обновлений
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
-------------------------------------------------IMGUI ZONE---------------------------------------

-- подключение шрифта для работы иконок
local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
	if fa_font == nil then
		local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
		font_config.MergeMode = true

		fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/GeekHelper/files/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
	end
end


function async_http_request(method, url, args, resolve, reject) -- асинхронные запросы, опасная штука местами, ибо при определенном использовании игра может улететь в аут ;D
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
	local tLastKeys = {} -- это у нас для клавиш
	local sw, sh = getScreenResolution() -- получаем разрешение экрана
	local btn_size = imgui.ImVec2(-0.1, 0) -- а это "шаблоны" размеров кнопок
	local btn_size2 = imgui.ImVec2(160, 0)
	local btn_size3 = imgui.ImVec2(140, 0)

	-- тут мы подстраиваем курсор под адекватность
	imgui.ShowCursor = win_state['update'].v
	if win_state['main'].v then -- основное окошко

		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(280, 250), imgui.Cond.FirstUseEver)
		imgui.Begin(u8' GeekHelper', win_state['main'], imgui.WindowFlags.NoResize)
		-- кнопка настроек, готово
		if imgui.Button(fa.ICON_COGS..u8' Настройки', btn_size) then print("Переход в раздел настроек") win_state['settings'].v = not win_state['settings'].v end
		imgui.End()
	end
	if win_state['settings'].v then -- окно настроек
	end
	if win_state['update'].v then -- окно обновления скрипта
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(450, 200), imgui.Cond.FirstUseEver)
        imgui.Begin(u8('Обновление'), nil, imgui.WindowFlags.NoResize)
		imgui.Text(u8'Обнаружено обновление до версии: '..updatever)
		imgui.Separator()
		imgui.TextWrapped(u8("Для установки обновления необходимо подтверждение пользователя, разработчик настоятельно рекомендует принимать обновления ввиду того, что прошлые версии через определенное время отключаются и более не работают."))
		if imgui.Button(u8'Скачать и установить обновление', btn_size) then
			async_http_request('GET', 'https://geekhub.pro/samp/geekhelper/GeekHelper.lua', nil,
				function(response) -- вызовется при успешном выполнении и получении ответа
				local f = assert(io.open(getWorkingDirectory() .. '/GeekHelper.lua', 'wb'))
				f:write(response.text)
				f:close()
				sampAddChatMessage("[GeekHelper]{FFFFFF} Обновление успешно, перезагружаем скрипт.", 0x046D63)
				thisScript():reload()
			end,
			function(err) -- вызовется при ошибке, err - текст ошибки. эту функцию можно не указывать
				print(err)
				sampAddChatMessage("[GeekHelper]{FFFFFF} Произошла ошибка при обновлении, попробуйте позже.", 0x046D63)
				win_state['update'].v = not win_state['update'].v
				return
			end)
		end
		if imgui.Button(u8'Закрыть', btn_size) then win_state['update'].v = not win_state['update'].v end
		imgui.End()
	end
end

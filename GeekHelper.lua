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
-----------------------------------------------------------------------------------

encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

---------[ 
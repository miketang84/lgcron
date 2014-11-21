
-- arg[1] is script file
-- arg[2] is first executed time
-- arg[3] is repeated executed time
assert(arg[1], 'missing script to executed.')

print('script is: ', arg[1])
--print(arg[2])
--print(arg[3])


local CHECKTIMER = 5

APPNAME = 'mycron'
LOGDIR = '/root/TOOLS/logs' 
DAEMON = true
require 'bamboo-log'

local ev = require'ev'
local loop = ev.Loop.default
--require('lglib')
local post_logfile = " >> ".. LOGDIR..'/script_start_info.log 2>&1' 

local script = arg[1]
print('script to executed: ', script)
local start_time = tonumber(arg[2]) or 0
local DEFAULT_REPEAT = 86400
local repeated_time = tonumber(arg[3]) or DEFAULT_REPEAT

local getToday0 = function ()
  local time = os.time()
  local rest = time % 86400
  time = time - rest - 8*3600
  if rest >= 57600 then time = time + 86400 end
  return time 
end


function executer ()
	local time_prompt = '"-----> ' .. os.date('%x %X', os.time()) .. ' <-----"' 
	print('executed '.. script ..' @ '.. time_prompt)
	os.execute("echo " .. time_prompt .. post_logfile )
	os.execute(arg[1] .. post_logfile)
end

function timer_handler ()
	local now = os.time()
	local zero = getToday0()
	local start_tick = zero + start_time * 3600
	local delta_time = now - start_tick
	if delta_time < 0 then return end

	local rest = delta_time % repeated_time

	print(now, zero, start_tick, delta_time, rest)
	if rest >= 0 and rest < CHECKTIMER then
		executer()
	end


end

print('Timer start.')
local timer = ev.Timer.new(timer_handler, 1, CHECKTIMER)
timer:start(loop)
loop:loop()

print('== Aborted! ==')

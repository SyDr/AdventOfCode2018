local lpeg = require'lpeg'

local number = lpeg.R'09' ^ 1
local space = lpeg.P(" ") ^ 0

local date = lpeg.P('[') * number * '-' * number * '-' * number * space * number * ':' * lpeg.C(number) * ']'

local guard = lpeg.P('Guard') * space * '#' * (number / tonumber) * space * 'begins shift'
local asleep = lpeg.P('falls asleep') / function() return 'a' end
local wakes = lpeg.P('wakes up') / function() return 'w' end

local pattern = date * space * (guard + asleep + wakes)

local data = {}

for line in io.lines('4.txt') do
  data[#data + 1] = line
end

table.sort(data)

local guard = nil
local asleep = nil
local guards = {}

for i, v in ipairs(data) do
  local min, item = lpeg.match(pattern, v)
  if type(item) == 'number' then
    guard = item
    asleep = nil
    if not guards[guard] then
      local def = { sum = 0, id = guard }
      for i = 0, 59 do def[i] = 0 end
      guards[guard] = def
    end
  elseif item == 'a' then
    asleep = min
  else
    for i = asleep, min do
      local t = guards[guard]
      t.sum = t.sum + 1
      t[i] = t[i] + 1
    end
  end
end

local max = next(guards)
for k, v in pairs(guards) do
  if v.sum > guards[max].sum then max = k end
end

local max_min = 0
for i = 0, 59 do
  if guards[max][i] > guards[max][max_min] then max_min = i end
end

local max2 = next(guards)
local max_min2 = 0

for k, v in pairs(guards) do
  for i = 0, 59 do
    if v[i] > guards[max2][max_min2] then max2 = k max_min2 = i end
  end
end



print('1: ' .. max * max_min)
print('2: ' .. max2 * max_min2)

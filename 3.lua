local lpeg = require'lpeg'

local number = lpeg.R'09' ^ 1 / tonumber
local space = lpeg.P(" ") ^ 0
local pattern = lpeg.P('#') * number * space * '@' * space * number * ',' * number * ':' *space * number * 'x' * number

local fabric = {}
local intact = {}
for line in io.lines("3.txt") do
  local id, left, top, width, height = lpeg.match(pattern, line)
  intact[id] = true
  
  for i = left, left + width - 1 do
    for j = top, top + height - 1 do
      local cell = i .. 'x' .. j
      if fabric[cell] then
        intact[fabric[cell]] = nil
        intact[id] = nil
        fabric[cell] = 'X'
      else
        fabric[cell] = id
      end
    end
  end
end

local sum = 0
for k, v in pairs(fabric) do
  if v == 'X' then
    sum = sum + 1
  end
end


print('1: ' .. sum)
print('2: ' .. next(intact))

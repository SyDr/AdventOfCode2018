local lpeg = require'lpeg'
local pp = require'pp'

local number = lpeg.R'09' ^ 1 / tonumber
local space = lpeg.P(" ") ^ 0
local pattern = number * ',' * space * number

local minx, miny, maxx, maxy
local input = {}
for line in io.lines("6.txt") do
  local x, y = lpeg.match(pattern, line)
  input[#input + 1] = { x, y }
  
  if not minx or minx > x then minx = x end
  if not maxx or maxx < x then maxx = x end
  if not miny or miny > y then miny = y end
  if not maxy or maxy < y then maxy = y end
end

local data = {}

for i = minx, maxx do
  for j = miny, maxy do
    local min = 1
    local nil_min = false
    for k = 2, #input do
      local cur_min = math.abs(input[min][1] - i) + math.abs(input[min][2] - j)
      local nex_min = math.abs(input[k][1] - i) + math.abs(input[k][2] - j)

      if cur_min > nex_min then
        min = k
        nil_min = false
      elseif cur_min == nex_min then
        nil_min = true
      end
    end
    
    if nil_min then min = nil end
    
    data[i .. 'x' .. j] = min
  end
end

local candidates = {}
for i = 1, #input do candidates[i] = true end
for i = minx, maxx do
  if data[i .. 'x' .. miny] then candidates[data[i .. 'x' .. miny]] = nil end
  if data[i .. 'x' .. maxy] then candidates[data[i .. 'x' .. maxy]] = nil end
end

for i = miny, maxy do
  if data[minx .. 'x' .. i] then candidates[data[minx .. 'x' .. i]] = nil end
  if data[maxx .. 'x' .. i] then candidates[data[maxx .. 'x' .. i]] = nil end
end

local sum = {}
for k, v in pairs(data) do
  if candidates[v] then
    sum[v] = sum[v] and sum[v] + 1 or 1
  end
end

local max = next(sum)
for i, v in pairs(sum) do if v > sum[max] then max = i end end

local total = 0
for i = minx, maxx do
  for j = miny, maxy do
    local distance = 0
    for k = 1, #input do
      distance = distance + math.abs(i - input[k][1]) + math.abs(j - input[k][2])
    end
    if distance < 10000 then
      total = total + 1
    end
  end
end

print('1: ' .. sum[max])
print('2: ' .. total)

local sum = 0

for line in io.lines('1.txt') do
  sum = sum + tonumber(line)
end

local frequency = 0
local seen = {}
local found = false

while not found do
  for line in io.lines('1.txt') do
    frequency = frequency + tonumber(line)
    if seen[frequency] then
      found = true
      break
    else
      seen[frequency] = true
    end
  end  
end

print('1: ' .. sum)
print('2: ' .. frequency)

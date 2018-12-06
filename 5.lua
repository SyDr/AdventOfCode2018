local data = io.open('5.txt'):read('*all')

local function solve(s)
  local chars = {}
  s:gsub(".", function(c) table.insert(chars, c) end)
  local i = 1
  while i < #chars do
    if chars[i]:upper() == chars[i + 1]:upper() and chars[i] ~= chars[i + 1] then
      table.remove(chars, i)
      table.remove(chars, i)
      if i > 1 then i = i - 1 end
    else
      i = i + 1
    end
  end
  
  return #chars
end

local min = math.huge
for i = string.byte('a'), string.byte('z') do
  local test = data:gsub(string.char(i), ''):gsub(string.char(i):upper(), '')
  local x = solve(test)
  if x < min then min = x end
end

print('1: ' .. solve(data))
print('2: ' .. min)

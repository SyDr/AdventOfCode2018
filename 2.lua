local sum2 = 0
local sum3 = 0

local input = {}
for line in io.lines('2.txt') do
  input[#input + 1] = line
  local sum = {}
  for i = 1, #line do
    sum[line:sub(i, i)] = sum[line:sub(i, i)] and sum[line:sub(i, i)] + 1 or 1
  end
  
  local h2 = false
  local h3 = false

  for k, v in pairs(sum) do
    if v == 2 then h2 = true end
    if v == 3 then h3 = true end
  end
  
  if h2 then sum2 = sum2 + 1 end
  if h3 then sum3 = sum3 + 1 end
end

local part2

for i = 1, #input do
  for j = i + 1, #input do
    local line1 = input[i]
    local line2 = input[j]
    for k = 1, #line1 do
      if line1:sub(1, k-1) .. line1:sub(k+1) == line2:sub(1, k-1) .. line2:sub(k+1) then
        part2 = line1:sub(1, k-1) .. line1:sub(k+1)
      end
    end
  end
end

print('1: ' .. sum2 * sum3)
print('2: ' .. part2)

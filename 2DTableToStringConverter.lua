--save to string v2
function save(array)
local string = ""
for i = 1, #array do
string = string .. table.concat(array[i], ",") .. "n"
end
return string
end
------------------------------------------

--decode V4
function decode(string)
local array = {}
local C = 1
local C2 = 1
for v in string.gmatch(string, "[^n]+") do
  array[C] = {}
for vs in string.gmatch(v, "[^,]+") do
  array[C][C2] = vs
  C2 = C2 + 1
end
C = C + 1
C2 = 1
end
C = 1
return array
end
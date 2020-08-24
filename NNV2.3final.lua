--cls() 
math.randomseed(os.time())

function sigmaSum(array) 
local sum = 0 
for i = 1, #array do 
sum = sum + array[i]
end 
return sum 
end 

function matrixSum(a, b) 
local sum = {} 
for i = 1, #a do 
sum[i] = a[i] + b[i] 
end 
return sum 
end 

function dot(a, b) 
local dot = 0 
for i = 1, #a do 
dot = dot + a[i] * b[i] 
end 
return dot 
end 

function Transpose(array)
  local arrayT = {}
  for i = 1, #array[1] do
    arrayT[i] = {}
    for j = 1, #array do
      arrayT[i][j] = array[j][i]
    end
  end
  return arrayT
end

--Activation
function f(x) 
return 1 / (1 + math.exp(-x)) 
end 


------------------------------------------------------------------
-------------------------------------------------------------------

Lr = 0.1
x = {0, 0}
h = {}
y = {}


HiddenNeurons = 10
OutputNeurons = 1
w1 = {}
w2 = {}
b1 = 1
b2 = 1

n_weights = #x * HiddenNeurons + HiddenNeurons * OutputNeurons
n_biases = HiddenNeurons + OutputNeurons

function InitRndWeights()
  for i = 1, #x * HiddenNeurons do
    w1[i] = {}
    for m = 1, #x do
     w1[i][m] = math.random()
      end
  end

  for i = 1, HiddenNeurons * OutputNeurons do
   w2[i] = {}
    for m = 1, HiddenNeurons do
     w2[i][m] = math.random()
      end
  end

  end



function ForewardProp(x)
--Calc hidden layer
for i = 1, HiddenNeurons do
h[i] = f(dot(x, w1[i]) + b1)
--h[i] = f(dot(x, w1[i]))
end


--Calc output layer
for i = 1, OutputNeurons do
y[i] = f(dot(h, w2[i]) + b2)
--y[i] = f(dot(h, w2[i]))
end

return y
end
--------------------------------------------------------
InitRndWeights()
print("First result = ", ForewardProp(x)[1])

--XOR cycle
Counter = 0
function XORc()
local XORInput = {}
if Counter == 0 then
  XORInput = {0, 0}
elseif Counter == 1 then
  XORInput = {0, 1}
elseif Counter == 2 then
  XORInput = {1, 0}
elseif Counter == 3 then
  XORInput = {1, 1}
end
Counter = Counter + 1
if Counter == 4 then
  Counter = 0
end
return XORInput
end
----------------------------
function sigmoid_derivative(x)
    return x * (1 - x)
    end

for i = 1, 100000 do
  --print(XORc()[1])
  x = XORc()
  result = ForewardProp(x)[1]
  --print(result)
  
  --Expected answer
  if (x[1] == 0 and x[2] == 0 ) or  (x[1] == 1 and x[2] == 1 ) then
       expected = 0
     else
       expected = 1
    end
  
  Error = 0.5 * (result - expected) * (result - expected)
  dE = result - expected
  deltaOut = dE * sigmoid_derivative(result)
  
    Lr = 10 * dE * dE
    print("Lr/Error", Lr)
  --backward prop
  --w2
  for i = 1, #w2[1] do
    local Dw2 = deltaOut * h[i]
    w2[1][i] = w2[1][i] - Lr * Dw2
  end
  
  --b2
  local Db2 = deltaOut * 1
  b2 = b2 - Lr * Db2
  
  --w1
  for i = 1, #h do
  for j = 1, #x do
  local Dw1 = (deltaOut * w2[1][i]) * sigmoid_derivative(h[i]) * x[j]
  w1[i][j] = w1[i][j] - Lr * Dw1
end
end

  --b1
  local Db1 = deltaOut * w2[1][1] * sigmoid_derivative(h[1]) * 1
  b1 = b1 - Lr * Db1
  end


-------TEST
a = {0, 0}
  result = ForewardProp(a)[1]
  print("input", a[1], a[2], "out", result)
  
a = {0, 1}
  result = ForewardProp(a)[1]
  print("input", a[1], a[2], "out", result)
  
a = {1, 0}
  result = ForewardProp(a)[1]
  print("input", a[1], a[2], "out", result)
  
a = {1, 1}
  result = ForewardProp(a)[1]
  print("input", a[1], a[2], "out", result)
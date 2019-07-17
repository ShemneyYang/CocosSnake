local CommonUtility = require("CommonUtility")
local Frog = require("Frog")

local FrogFactory = class("FrogFactory")

function FrogFactory:ctor(node, maxNumber)
    self.node = node
    self.fragMaxNumber = maxNumber
    self.fragArray = {}

    math.randomseed(os.time())

    for i = 1, maxNumber do
        local x, y = CommonUtility:getRandomCoordinates()
        print("new Frog x=", x, ",y=", y)
        local frog = Frog.new(node, x, y)
        table.insert(self.fragArray, frog)
    end
end

return FrogFactory

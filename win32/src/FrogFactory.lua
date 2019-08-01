--«‡Õ‹π§≥ß

local CommonUtility = require("CommonUtility")
local Frog = require("Frog")

local FrogFactory = class("FrogFactory")

function FrogFactory:ctor(node, maxNumber)
    self.node = node
    self.fragMaxNumber = maxNumber
    self.fragArray = {}
    self:createFrogs()
end

function FrogFactory:createFrogs()
    for i = 1, #self.fragArray do
        self.fragArray[i]:destroy()
    end
    self.fragArray = {}
    for i = 1, self.fragMaxNumber do
        local x, y = CommonUtility:getRandomCoordinates()
        print("new Frog x=", x, ",y=", y)
        local frog = Frog.new(self.node, x, y)
        table.insert(self.fragArray, frog)
    end
end

function FrogFactory:removeFrog(frog)
    for i = 1, #self.fragArray do
        if(frog == self.fragArray[i]) then
            table.remove(self.fragArray, i)
            frog:destroy()
            if(#self.fragArray == 0) then
                self:createFrogs()
            end
            return true
        end
    end
    return false
end

function FrogFactory:checkOnFrogs(x, y)
    --print("checkOnFrogs x=", x , ",y=", y)
    for i = 1, #self.fragArray do
        local frog = self.fragArray[i]
        if(x == frog.x and y == frog.y) then
            return frog
        end
    end
    return nil
end

return FrogFactory

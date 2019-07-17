
local CommonUtility = require("CommonUtility")

local Frog = class("Frog")

function Frog:ctor(node, x, y)
    self.x = x
    self.y = y
    self.node = node
    self.sprite = cc.Sprite:create("Frog2.png")
    self.sprite:setScale(0.5)
    local posX, posY = CommonUtility:getPos(x, y)
    self.sprite:setPosition(posX, posY)
    self.node:addChild(self.sprite)
end

function Frog:delete()
    print("Frog:delete")
    self.node:removeChild(self.sprite)
    self.sprite = nil
end

return Frog
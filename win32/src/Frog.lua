
local CommonUtility = require("CommonUtility")

local Frog = class("Frog")

function Frog:ctor(node, x, y)
    self.x = x
    self.y = y
    self.node = node
    self.sprite = cc.Sprite:createWithSpriteFrameName("frog2.png")
    self.sprite:setScale(0.5)
    local posX, posY = CommonUtility:getPos(x, y)
    self.sprite:setPosition(posX, posY)
    self.node:addChild(self.sprite)
    self:startAnimation()
end

function Frog:startAnimation()
    --出现青蛙时的动画
    local frameList = {}
    for i = 1, 3, 1 do
        local str = string.format("frog%d.png", i)
        local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(str)
        table.insert(frameList, frame)
    end
    local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame("frog2.png")
    table.insert(frameList, frame)
    local animation = cc.Animation:createWithSpriteFrames(frameList, 0.5, 2)
    local animate = cc.Animate:create(animation)
    self.sprite:runAction(animate);
end

function Frog:delete()
    print("Frog:delete")
    self.node:removeChild(self.sprite)
    self.sprite = nil
end

return Frog
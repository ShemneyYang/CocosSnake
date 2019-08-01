
local CommonUtility = require("CommonUtility")
local Object = require("Object")

local Frog = class("Frog", Object)

function Frog:ctor(node, x, y)
    Frog.super.ctor(self, node)
    self.name = "Frog"
    Frog.super.createWithSpriteFrameName(self, "frog2.png")
    Frog.super.setPos(self, x, y);
    Frog.super.show(self);
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

return Frog
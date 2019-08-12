--ÉßÉí½Úµã
local CommonUtility = require("CommonUtility")
local Object = require("Object")

local SnakeBody = class("SnakeBody", Object)

function SnakeBody:ctor(snake, node, index)
    SnakeBody.super.ctor(self, node)
    self.name = "SnakeBody"
    self.snake = snake
    self.index = index

    local n = index % 5
    if(n == 0) then
        n = 5
    end
    local bodyImage = ""
    if self.index <= 5 then
        bodyImage = string.format("Head1_%d.png", n)
    else
        bodyImage = string.format("body1_%d.png", n)
    end
    --print("bodyImage=", bodyImage)
    SnakeBody.super.createWithSpriteFrameName(self, bodyImage)
end

function SnakeBody:startAnimation()
    if(self.index == 1) then
        return
    end

    local frameList = {}
    for i = 1, 2, 1 do
        local str = string.format("body%d.png", i)
        local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(str)
        table.insert(frameList, frame)
    end
    local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame("body1.png")
    table.insert(frameList, frame)
    local animation = cc.Animation:createWithSpriteFrames(frameList, 0.1, 6)
    local animate = cc.Animate:create(animation)
    self.sprite:runAction(animate);
end

return SnakeBody

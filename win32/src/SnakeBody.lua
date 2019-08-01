--ÉßÉí½Úµã
local CommonUtility = require("CommonUtility")
local Object = require("Object")

local DirectionRotation = {["left"] = 0, ["right"] = 180, ["up"] = 90, ["down"] = 270}

local SnakeBody = class("SnakeBody", Object)

function SnakeBody:ctor(snake, node, isHead, direction)
    SnakeBody.super.ctor(self, node)
    self.name = "SnakeBody"
    self.snake = snake
    self.isHead = isHead

    local bodyImage = "body1.png"
    if self.isHead then
        bodyImage = "Head1.png"
    end
    SnakeBody.super.createWithSpriteFrameName(self, bodyImage)
end

function SnakeBody:startAnimation()
    if(self.isHead) then
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

function SnakeBody:setDirection(dir)
    --[[
    self.direction = dir
    self.sprite:setRotation(DirectionRotation[dir])]]
end

return SnakeBody

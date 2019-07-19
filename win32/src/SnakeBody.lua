local CommonUtility = require("CommonUtility")
local SnakeBody = class("SnakeBody")

local DirectionRotation = {["left"] = 0, ["right"] = 180, ["up"] = 90, ["down"] = 270}

function SnakeBody:ctor(snake,x,y,node,isHead,direction)
    self.snake = snake
    self.x = x
    self.y = y
    self.isHead = isHead

    local bodyImage = "body1.png"
    if self.isHead then
        bodyImage = "Head1.png"
    end
    self.sprite = cc.Sprite:createWithSpriteFrameName(bodyImage)
    self:setDirection(direction)
    self:update()
    self.sprite:addTo(node)
    self:startAnimation()
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
    self.direction = dir
    self.sprite:setRotation(DirectionRotation[dir])
end

function SnakeBody:getCoordinate()
    return self.x, self.y
end

function SnakeBody:update()
    local posX, posY = CommonUtility:getPos(self.x, self.y)
    --print("posX=", posX, ",posY=", posY)
    self.sprite:setPosition(posX, posY)
end

return SnakeBody

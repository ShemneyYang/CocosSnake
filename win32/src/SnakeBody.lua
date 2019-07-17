local CommonUtility = require("CommonUtility")
local SnakeBody = class("SnakeBody")

local DirectionRotation = {["left"] = 0, ["right"] = 180, ["up"] = 90, ["down"] = 270}

function SnakeBody:ctor(snake,x,y,node,isHead)
    self.snake = snake
    self.x = x
    self.y = y
    self.direction = "left"

    local bodyImage = "body.png"
    if isHead then
        bodyImage = "Head.png"
    end
    self.sprite = cc.Sprite:create(bodyImage)
    self.sprite:addTo(node)
    self:update()
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

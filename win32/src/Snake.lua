local Snake = class("Snake")

local SnakeBody = require("SnakeBody")

function Snake:ctor(node)
    self.bodyArray = {}
    self.node = node
    self.moveDirection = "left"

    --初始化三节身体.
    self:grow(true)
    self:grow(false)
    self:grow(false)
end

function Snake:grow(isHead)
    local x, y = self:getTailCoordinate()

     if self.moveDirection == "left" then
        x = x + 1
    elseif self.moveDirection == "right" then
        x = x - 1
    elseif self.moveDirection == "up" then
        y = y - 1
    elseif self.moveDirection == "down" then
        y = y + 1
    end

    local body = SnakeBody.new(self, x, y, self.node, isHead)
    body:update()
    table.insert(self.bodyArray, body)
end

function Snake:getTailCoordinate()
    if #self.bodyArray == 0 then
        return 0, 0
    else
        local body =  self.bodyArray[#self.bodyArray]
        return body.x, body.y
    end
end

function Snake:move()
    for i=#self.bodyArray, 1, -1 do
        if i == 1 then
            local body = self.bodyArray[i]
            moveHead(body)
            body:update()
        else
            local frontBody = self.bodyArray[i - 1]
            local body = self.bodyArray[i]
            body.x, body.y = frontBody.x, frontBody.y
            body:update()
        end
    end
end

function Snake:moveHead(body)
    if self.moveDirection == "left" then
        return body.x-1, body.y
    elseif self.moveDirection == "right" then
        return body.x+1, body.y
    elseif self.moveDirection == "up" then
        return body.x, body.y+1
    elseif self.moveDirection == "down" then
        return body.x, body.y-1
    end
end

return Snake

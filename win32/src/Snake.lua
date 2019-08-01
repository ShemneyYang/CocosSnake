local Snake = class("Snake")

local CommonUtility = require("CommonUtility")
local SnakeBody = require("SnakeBody")
local DirectionClass = {["left"] = 0, ["right"] = 0, ["up"] = 1, ["down"] = 1}

function Snake:ctor(node)
    self.bodyArray = {}
    self.node = node
    self.moveDirection = "left"
    self.step = 2  --每一步多少像素
    self.speed = 1 --速度正常是1，实际每一步移动的距离为self.step * self.speed

    --初始化三节身体.
    self:grow(true)
    --self:grow(false)
end

function Snake:setMoveDirection(dir)
--[[
    if(DirectionClass[self.moveDirection] == DirectionClass[dir]) then
        return
    end

    self.moveDirection = dir
    ]]
    if(#self.bodyArray == 0) then
        return
    end

    local head = self.bodyArray[1]
    head:turnRotation(dir)
end

--长长一节身体
function Snake:grow(isHead)
    local x, y, tailWidth, tailHeight = self:getTailPos()
    local direction = self:getTailDirection()
    local body = SnakeBody.new(self, self.node, isHead, direction)
    table.insert(self.bodyArray, body)
    local width, height = body:getSize()

    --精灵默认锚点是中心, 要特殊处理一下.
    if direction == "left" then
        x = x + (width/2) + (tailWidth/2)
    elseif direction == "right" then
        x = x - (width/2) - (tailWidth/2)
    elseif direction == "up" then
        y = y - (height/2) - (tailHeight/2)
    elseif direction == "down" then
        y = y + (height/2) + (tailHeight/2)
    end

    print("pos x=", x, ",y=", y)
    body:setPos(x, y)
    body:setDirection(direction)
    body:show()
    body:startAnimation()
end

--获取头部坐标
function Snake:getHeadCoordinate()
    if #self.bodyArray == 0 then
        return 0, 0
    else
        local body = self.bodyArray[1]
        return body.x, body.y
    end
end

--获取尾部坐标
function Snake:getTailPos()
    if #self.bodyArray == 0 then
        local x, y = CommonUtility:getCenterPos()
        return x, y, 0, 0
    else
        local body = self.bodyArray[#self.bodyArray]
        local width, height = body:getSize()
        return body.x, body.y, width, height
    end
end

--获取尾部方向
function Snake:getTailDirection()
    if #self.bodyArray == 0 then
        return "left"
    else
        local body = self.bodyArray[#self.bodyArray]
        return body.direction
    end
end

--向前移动一步
function Snake:move()
    --从队尾开始循环
    for i=#self.bodyArray, 1, -1 do
        if i == 1 then
            local body = self.bodyArray[i]
            body:move(self.step * self.speed)
        else
            local frontBody = self.bodyArray[i - 1]
            local body = self.bodyArray[i]
            body:followPos(frontBody)
        end
    end
end

--根据方向移动头部
function Snake:moveHead(body)
    if self.moveDirection == "left" then
        return body.x-self.step, body.y
    elseif self.moveDirection == "right" then
        return body.x+self.step, body.y
    elseif self.moveDirection == "up" then
        return body.x, body.y+self.step
    elseif self.moveDirection == "down" then
        return body.x, body.y-self.step
    end
end

return Snake

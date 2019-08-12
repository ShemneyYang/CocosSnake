local Snake = class("Snake")

local CommonUtility = require("CommonUtility")
local SnakeBody = require("SnakeBody")

function Snake:ctor(node)
    self.bodyArray = {}
    self.node = node
    self.moveDirection = "left"
    self.step = 4  --每一步多少像素
    self.speed = 1 --速度正常是1，实际每一步移动的距离为self.step * self.speed
    self.maxSpeed = 5 --最大速度
    self.acceleratedEnergy = 100 --加速能量条.
    self.acceleratedTimerID = 0
    self.restoreTimerID = 0
    self.consumeTimerID = 0
    self.moveTimerID = 0
    self.moveTimerInterval = 0.05

    --初始化三节身体.
    for i = 1, 10 do
        self:grow()
    end
end

function Snake:turnRotation(dir)
    if(#self.bodyArray == 0) then
        return
    end

    local head = self.bodyArray[1]
    head:turnRotation(dir)
end

function Snake:createHead()
    for i = 1, 5 do
        self:grow()
    end
end

--长长一节身体
function Snake:grow()
    local x, y, tailWidth, tailHeight, rotation = self:getTailNodeInfo()
    --print("tailPos x=", x, ",y=", y, ",w=", tailWidth, ",h=", tailHeight)
    local body = SnakeBody.new(self, self.node, #self.bodyArray + 1)
    table.insert(self.bodyArray, body)
    local width, height = body:getSize()

    local len = (width/2) + (tailWidth/2)
    print("x=", x, ",y=", y, ",rotation=", rotation, ",step=", -len)
    local newX, newY = CommonUtility:calculateCoordinatesByStep(x, y, rotation, -len)
    print("newX=", newX, ",newY=", newY)
    body:setRotation(rotation)
    body:setPos(newX, newY)
    body:show()
    --body:startAnimation()
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
function Snake:getTailNodeInfo()
    if #self.bodyArray == 0 then
        local x, y = CommonUtility:getCenterPos()
        return x, y, 0, 0, 0
    else
        local body = self.bodyArray[#self.bodyArray]
        local width, height = body:getSize()
        return body.x, body.y, width, height, body.rotation
    end
end

--开始移动定时器
function Snake:startMove()
    local scheduler=cc.Director:getInstance():getScheduler()
    self.moveTimerID = scheduler:scheduleScriptFunc(handler(self, self.onMoveTimerout), self.moveTimerInterval, false)
end

--结束移动定时器
function Snake:stopMove()
    local scheduler=cc.Director:getInstance():getScheduler()
    scheduler:unscheduleScriptEntry(self.moveTimerID)
    self.moveTimerID = 0
end

function Snake:onMoveTimerout()
    self:move()
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

--开始加速
function Snake:startAccelerate()
    if(self.acceleratedTimerID ~= 0) then
        return
    end

    print("start accelerate!!!!")
    local scheduler=cc.Director:getInstance():getScheduler()
    self.acceleratedTimerID = scheduler:scheduleScriptFunc(handler(self, self.onAcceleratedTimeout), 0.2, false)

    --加速同时开始消耗能量,并且停止恢复能量.
    self:startConsumeEnergy()
    self:stopRestoreAcceleratedEnergy()
end

--结束加速
function Snake:stopAccelerate()
    if(self.acceleratedTimerID == 0) then
        return
    end

    print("stop accelerate!!!!")
    local scheduler=cc.Director:getInstance():getScheduler()
    scheduler:unscheduleScriptEntry(self.acceleratedTimerID)
    self.acceleratedTimerID = 0
    
    self.moveTimerInterval = 0.05
    self:stopMove()
    self:startMove()

    --结束加速时，开始恢复.
    self:startRestoreAcceleratedEnergy()
    self:stopConsumeEnergy()
end

function Snake:onAcceleratedTimeout()
    if(self.acceleratedEnergy <= 0) then
        --没有能量了，结束加速.
        self:stopAccelerate()
    end
    if(self.moveTimerInterval <= 0.001) then
        return
    end

    self.moveTimerInterval = self.moveTimerInterval - 0.01
    self:stopMove()
    self:startMove()
end

--开始恢复加速能量
function Snake:startRestoreAcceleratedEnergy()
    if(self.restoreTimerID ~= 0) then
        return
    end

    print("start restore energy!!!!")
    local scheduler=cc.Director:getInstance():getScheduler()
    self.restoreTimerID = scheduler:scheduleScriptFunc(handler(self, self.onRestoreAcceleratedEnergyTimeout), 0.5, false)
end

--结束恢复加速能量
function Snake:stopRestoreAcceleratedEnergy()
    if(self.restoreTimerID == 0) then
        return
    end

    print("stop restore energy!!!!")
    local scheduler=cc.Director:getInstance():getScheduler()
    scheduler:unscheduleScriptEntry(self.restoreTimerID)
    self.restoreTimerID = 0
end

function Snake:onRestoreAcceleratedEnergyTimeout()
    if(self.acceleratedEnergy >= 100) then
        self:stopRestoreAcceleratedEnergy()
        return
    end

    self.acceleratedEnergy = self.acceleratedEnergy + 5
    if(self.acceleratedEnergy > 100) then
        self.acceleratedEnergy = 100
    end
end

--开始消耗能量
function Snake:startConsumeEnergy()
    if(self.consumeTimerID ~= 0) then
        return
    end

    print("start consume energy!!!!")
    local scheduler = cc.Director:getInstance():getScheduler()
    self.consumeTimerID = scheduler:scheduleScriptFunc(handler(self, self.onConsumeEnergyTimeout), 0.5, false)
end

--结束消耗能量
function Snake:stopConsumeEnergy()
    if(self.consumeTimerID == 0) then
        return
    end

    print("stop consume energy!!!!")
    local scheduler=cc.Director:getInstance():getScheduler()
    scheduler:unscheduleScriptEntry(self.consumeTimerID)
    self.consumeTimerID = 0
end

function Snake:onConsumeEnergyTimeout()
    if(self.acceleratedEnergy <= 0) then
        self:stopConsumeEnergy()
        return
    end

    self.acceleratedEnergy = self.acceleratedEnergy - 5
    if(self.acceleratedEnergy < 0) then
        self.acceleratedEnergy = 0
    end
end

return Snake

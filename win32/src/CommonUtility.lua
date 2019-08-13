local GridSize = 1 --每一格多少像素
local ScaleRate = 1/display.contentScaleFactor

local CommonUtility = class("CommonUtility")

function CommonUtility:ctor()
end

function CommonUtility:getCenterPos()
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()
    local posX = origin.x + visibleSize.width / 2
    local posY = origin.y + visibleSize.height / 2
    return posX, posY
end

function CommonUtility:getPos(x, y)
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()
    local posX = origin.x + visibleSize.width / 2 + x * GridSize * ScaleRate
    local posY = origin.y + visibleSize.height / 2 + y * GridSize * ScaleRate

    return posX, posY
end

cc.exports.randomSeed = os.time()
function CommonUtility:getRandomCoordinates()
    math.randomseed(cc.exports.randomSeed)
    cc.exports.randomSeed = cc.exports.randomSeed + 1
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local nBoundX = visibleSize.width - 1
    local nBoundY = visibleSize.height - 1
    return math.random(1, nBoundX), math.random(1, nBoundY)
end

--根据坐标点（x,y）和前进方向的角度rotation, 向前走step的距离得到的坐标点
function CommonUtility:calculateCoordinatesByStep(x, y, rotation, step)
    if(step <= 1 and step >= 1) then
        return x, y
    end
    local posX = 0
    local posY = 0
    local temp = math.rad(rotation) --计算弧度
    if(rotation < 90) then
        posX = x - (math.cos(temp) * step)
        posY = y + (math.sin(temp) * step)
    elseif(rotation < 180) then
        temp = math.rad(180 - rotation)
        posX = x + (math.cos(temp) * step)
        posY = y + (math.sin(temp) * step)
    elseif(rotation < 270) then
        temp = math.rad(rotation - 180)
        posX = x + (math.cos(temp) * step)
        posY = y - (math.sin(temp) * step)
    elseif(rotation < 360) then
        temp = math.rad(360 - rotation)
        posX = x - (math.cos(temp) * step)
        posY = y - (math.sin(temp) * step)
    else
        posX = x - step
        posY = y
    end
    return posX, posY
end

return CommonUtility

--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local GridSize = 22 --每一格多少像素
local ScaleRate = 1/display.contentScaleFactor

local CommonUtility = class("CommonUtility")

function CommonUtility:ctor()
end

function CommonUtility:getPos(x, y)
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()

    local posX = origin.x + visibleSize.width / 2 + x * GridSize * ScaleRate
    local posY = origin.y + visibleSize.height / 2 + x * GridSize * ScaleRate

    return posX, posY
end

return CommonUtility
--endregion


local CommonUtility = require("CommonUtility")

local Object = class("Object")

function Object:ctor(node)
    self.node = node
    self.name = "Object"
    self.x = 0
    self.y = 0
    self.sprite = nil
    self.rotation = 0
end

function Object:createWithSpriteFrameName(name)
    self.sprite = cc.Sprite:createWithSpriteFrameName(name)
    self.sprite:setRotation(self.rotation)
end

function Object:setPos(x, y)
    --print("setPos x=", x, ",y=", y)
    self.x = x
    self.y = y
     if(self.sprite == nil) then
        return false
    end
    self.sprite:setPosition(self.x, self.y)
    return true
end

function Object:setRotation(value)
    self.rotation = value
    if(self.sprite == nil) then
        return
    end
    self.sprite:setRotation(self.rotation)
end

function Object:turnRotation(value)
    local r = self.rotation + value;
    if(r < 0) then
        r = 360 + r
    end

    if(r > 360) then
        r = r - 360
    end
    self:setRotation(r)
end

function Object:move(step)
    local posX, posY = CommonUtility:calculateCoordinatesByStep(self.x, self.y, self.rotation, step)
    self:setPos(posX, posY)
end

--复制object的坐标和角度
function Object:followPos(object)
    self:setPos(object.x, object.y)
    self:setRotation(object.rotation)
end

function Object:getCoordinate()
    return self.x, self.y
end

function Object:getSize()
    if(self.sprite == nil) then
        return 0, 0
    end
    local rect = self.sprite:getCenterRect()
    return rect["width"], rect["height"]
end

function Object:show()
    if(self.sprite == nil or self.node == nil) then
        print("self.sprite == nil or self.node == nil")
        return false
    end
    self.node:addChild(self.sprite)
    return true
end

function Object:hide()
    if(self.sprite == nil or self.node == nil) then
        print("self.sprite == nil or self.node == nil")
        return false
    end
    self.node:removeChild(self.sprite)
    return true
end

function Object:destroy()
    if(self.sprite == nil) then
        return
    end
    self.node:removeChild(self.sprite)
    self.sprite = nil
end

return Object
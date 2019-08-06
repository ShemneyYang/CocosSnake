local Snake = require("Snake")
local FrogFactory = require("FrogFactory")

local GamePlayingScene = class("GamePlayingScene", cc.load("mvc").ViewBase)

function GamePlayingScene:onCreate()
    self.leftTimerID = 0
    self.rightTimerID = 0
    cc.SpriteFrameCache:getInstance():addSpriteFrames("common.plist")
end

function GamePlayingScene:onEnter()
    print("GamePlayingScene:onEnter")
    self.snake = Snake.new(self)
    self.snake:startMove()
    --self.frogFactory = FrogFactory.new(self, 5)

    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(handler(self, self.onKeyPressed), cc.Handler.EVENT_KEYBOARD_PRESSED)
    listener:registerScriptHandler(handler(self, self.onKeyReleased), cc.Handler.EVENT_KEYBOARD_RELEASED)
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)

    local scheduler=cc.Director:getInstance():getScheduler()
    scheduler:scheduleScriptFunc(handler(self, self.timeout), 0.05, false)


end

function GamePlayingScene:timeout()
    --self.snake:move()
    --[[
    --处理吃青蛙过程.
    local frog = self.frogFactory:checkOnFrogs(self.snake:getHeadCoordinate())
    if(frog == nil) then
        return
    end
    print("eat one frog!!!")
    self.frogFactory:removeFrog(frog)
    self.snake:grow()]]
end

function GamePlayingScene:onKeyLeftTimeout()
    self.snake:turnRotation(-3)
end

function GamePlayingScene:onKeyRightTimeout()
    self.snake:turnRotation(3)
end

function GamePlayingScene:onKeyPressed(keyCode, event)
    if(keyCode == 28) then
        print("pressed up!!!")
        --self.snake:setMoveDirection("up")
        self.snake:startAccelerate()
    elseif (keyCode == 29) then
        --self.snake:setMoveDirection("down")
    elseif (keyCode == 26) then
        --left
        --self.snake:setMoveDirection(-10)
        local scheduler=cc.Director:getInstance():getScheduler()
        self.leftTimerID = scheduler:scheduleScriptFunc(handler(self, self.onKeyLeftTimeout), 0.01, false)
    elseif (keyCode == 27) then
        --right
        local scheduler=cc.Director:getInstance():getScheduler()
        self.rightTimerID = scheduler:scheduleScriptFunc(handler(self, self.onKeyRightTimeout), 0.01, false)
    else
        print("pressed unkown!!!")
    end
end

function GamePlayingScene:onKeyReleased(keyCode, event)
    print("key released code=", keyCode)
    
    if(keyCode == 28) then
        print("pressed up to stopAccelerate!!!")
        --self.snake:setMoveDirection("up")
        self.snake:stopAccelerate()
    end

    if(self.leftTimerID ~= 0) then
          local scheduler=cc.Director:getInstance():getScheduler()
          scheduler:unscheduleScriptEntry(self.leftTimerID)
          self.leftTimerID = 0
    end

    if(self.rightTimerID ~= 0) then
          local scheduler=cc.Director:getInstance():getScheduler()
          scheduler:unscheduleScriptEntry(self.rightTimerID)
          self.rightTimerID = 0
    end
end

return GamePlayingScene

local Snake = require("Snake")

local GamePlayingScene = class("GamePlayingScene", cc.load("mvc").ViewBase)

function GamePlayingScene:onCreate()
--[[
    -- add background image
    print("GamePlayingScene:onCreate")
    display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World, GamePlayingScene", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)
]]
end

function GamePlayingScene:onEnter()
    print("GamePlayingScene:onEnter")
    self.snake = Snake.new(self)

    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(handler(self, self.onKeyPressed), cc.Handler.EVENT_KEYBOARD_PRESSED)
    listener:registerScriptHandler(handler(self, self.onKeyReleased), cc.Handler.EVENT_KEYBOARD_RELEASED)
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)

    local scheduler=cc.Director:getInstance():getScheduler()
    scheduler:scheduleScriptFunc(handler(self, self.timeout), 1, false)
    return scheduler
end

function GamePlayingScene:timeout()
    self.snake:move()
end

function GamePlayingScene:onKeyPressed(keyCode, event)
    if(keyCode == 28) then
        print("pressed up!!!")
        self.snake:setMoveDirection("up")
    elseif (keyCode == 29) then
        self.snake:setMoveDirection("down")
    elseif (keyCode == 26) then
        self.snake:setMoveDirection("left")
    elseif (keyCode == 27) then
        self.snake:setMoveDirection("right")
    else
        print("pressed unkown!!!")
    end
end

function GamePlayingScene:onKeyReleased(keyCode, event)
    print("key released code=", keyCode)
end

return GamePlayingScene

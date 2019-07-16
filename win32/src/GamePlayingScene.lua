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

    local scheduler=cc.Director:getInstance():getScheduler()
    scheduler:scheduleScriptFunc(handler(self, self.timeout), 0.1, false)
    return scheduler
end

function GamePlayingScene:timeout()
    self.snake:move()
end

return GamePlayingScene

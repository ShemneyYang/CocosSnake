
local GamePlayingScene = class("GamePlayingScene", cc.load("mvc").ViewBase)

function GamePlayingScene:onCreate()
    -- add background image
    display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World, GamePlayingScene", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)

end

return GamePlayingScene

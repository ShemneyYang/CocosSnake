
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

local function createNormalBtn(node,imageName1,imageName2,imageName3, x, callback)
	local btn = ccui.Button:create(imageName1,imageName2,imageName3)
	btn:addClickEventListener(callback)
	btn:setScale(1.5)
	btn:move(x)
	node:addChild(btn)
end

function MainScene:onStartClicked()
	print("start")
	--切换到开始游戏场景.
	local scene = require("app.views.GamePlayingScene"):create(self.app_,"GamePlayingScene")
    scene:showWithScene()
end
	
function MainScene:onCreate()
    -- 开始背景图.
    display.newSprite("startBK.jpg")
        :move(display.center)
        :addTo(self)

	-- 开始游戏按钮.
    createNormalBtn(self,"startBtn.png","startBtn_selected.png","startBtn_disable.png", display.center,
		handler(self, self.onStartClicked))
end

return MainScene

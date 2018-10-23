--------------------------------------------------------------------------------------------
----
---- main.lua
----
--------------------------------------------------------------------------------------------

local composer = require( "composer" )
 
local scene = composer.newScene()
---- creating widget
local widget = require( "widget" )
 
----sending user back to the Home Screen 
local function Home ()	
composer.gotoScene("FirstScene",{effect = "slideLeft", time = 500})
end 


----sending user back to the previous screen
local function back ()	
composer.gotoScene("Security",{effect = "slideRight", time = 500})
end 

---- ScrollView listener
local function scrollListener( event )
 
    local phase = event.phase
    local direction = event.direction
	
	-- If the scroll view has reached it's scroll limit.
	if event.limitReached then
		if "up"== direction then
			print("Reached Top Limit")
		elseif "down" == direction then
			print("Reached Bottom Limit")
		end
	end
	
	return true
end
-- -----------------------------------------------------------------------------------
--- Code outside of the scene event functions below will only be executed ONCE unless
---- the scene is removed entirely (not recycled) via "composer.removeScene()"
--- -----------------------------------------------------------------------------------
 
---- -----------------------------------------------------------------------------------
---- Scene event functions
-- -----------------------------------------------------------------------------------
 local bg
---- create scene
function scene:create( event )

---- create background 
    local sceneGroup = self.view
	bg=display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth,600, display.contentHeight)
	bg:setFillColor(1,1,1)
	sceneGroup:insert(bg)
	
	----heading background
	bg2=display.newRect(display.contentCenterX, 0,display.contentWidth,90)
	bg2:setFillColor(0.823529 ,0.411765 ,0.117647)
	sceneGroup:insert(bg)
	sceneGroup:insert(bg2)
	
	---title of the scene camera privacy
	heading = [[Camera Privacy ]]
	head = display.newText(heading, display.contentCenterX*1.00,display.contentCenterY*0.00,"Arial",23)
	sceneGroup:insert(head)
	
	----home icon to send user to the home screen
	HomeImage = display.newImage("HomeIcon.png", 280, -7 )
	sceneGroup:insert(HomeImage)
	HomeImage:addEventListener("tap", Home)
	
	----sending user back to the previous screeen icon
	BackImage = display.newImage("back.png", 30, -7 )
	sceneGroup:insert(BackImage)
	BackImage:addEventListener("tap", back)
	
	
	---- Create the widget for scroll view
	local scrollView = widget.newScrollView(
		{
			top = 70,
			left = 0,
			width = display.contentWidth,
			height = display.contentHeight,
			topPadding = 145,
			bottomPadding = 0,
			horizontalScrollDisabled = true,
			verticalScrollDisabled = false,
			listener = scrollListener,
		}
	)
	sceneGroup:insert(scrollView)
	
	local text = [[
	To know which apps are using your Camera:
	
	For iOS users,
	Settings > Privacy > Camera > Reset Disable/Enable for applications.
	
	For Android users,
	Settings > Search For App permissions > Camera > Reset Disable/Enable for applications.
	
	
]]
local text = display.newText(text,0,0,270,0,"Helvetica", 14)
text:setTextColor(0)
text.x = display.contentCenterX
scrollView:insert(text)
	---- Code here runs when the scene is first created but has not yet appeared on screen
end
 
 
---- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
	
    if ( phase == "will" ) then
        ---- Code here runs when the scene is still off screen, (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        ---- Code here runs when the scene is entirely on screen
	
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        ---- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        ---- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
---- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    ---- Code here runs prior to the removal of scene's view
 
end
 
 
---- -----------------------------------------------------------------------------------
---- Scene event function listeners
---- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---- -----------------------------------------------------------------------------------
 
return scene

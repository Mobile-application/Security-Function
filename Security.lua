local composer = require( "composer" )
 
local scene = composer.newScene()

local function Home ()	
composer.gotoScene("FirstScene",{effect = "slideLeft", time = 500})
end

local function homepage ()	
	composer.gotoScene("FirstScene",{effect = "slideLeft", time = 500})
end



local widget = require ("widget")
function scene:create( event )
 
    local sceneGroup = self.view
	
	--showing a backgroynd
	bg=display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth,display.contentHeight)
	bg:setFillColor( 1,1 , 1)
	
	bg2=display.newRect(display.contentCenterX, 0,display.contentWidth,70)
	bg2:setFillColor(0.823529 ,0.411765 ,0.117647)
	sceneGroup:insert(bg)
	sceneGroup:insert(bg2)
	
	backImage = display.newImage("back.png", 30, -7 )
	--myImage:translate(140,450)
	sceneGroup:insert(backImage)
	backImage:addEventListener("tap", homepage)
	
	-- Code here runs when the scene is first created but has not yet appeared on screen
	head = display.newText("Disable access to recordings  ", display.contentCenterX*1.1,display.contentCenterY*0.01,"Arial",18)
	head:setFillColor(1,1,1)
	sceneGroup:insert(head)

	local recordStatus -- tracks whether the microphone is on or not

	local filePath = system.pathForFile('myRecording.aif', system.DocumentsDirectory)
	r = media.newRecording(filePath)
	r:setSampleRate(8000) -- Generally the minimum samplerate though some systems may not support

	-- function to start Recorder
	function recNow ()
		if recStatus == true then
			r:stopRecording()
			recButton:setLabel("Enable Microphone Block")
			recStatus = false
		else
			r:startRecording()
			recButton:setLabel("Disable Microphone Block")
			recStatus = true
			-- if recording fails the function will change the sample rate 
			if r:isRecording() == false then
				r:setSampleRate(11025) --Sets sample rate to second lowest if 8000Hz is unsupported
				r:startRecording()
				if r:isRecording() == false then
					r:setSampleRate() --sets Sample to rate to default at 44100Hz
					r:startRecording()
				end
			end
		end
	end

	--Button for Recorder
	recButton = widget.newButton(
	{
	    label = "Enable Microphone Block",
	    x = display.contentCenterX,
	    y = display.contentCenterY,
		fontSize = 24,
	    onEvent = myEventListener,
	    shape = "roundedRect",
		width = 300,
		height = 60,
		fillColor = { default = { 1, 0.7, 0.5}, over = { 1, 0.7, 0.5} }
	}
	    )



	sceneGroup:insert(recButton) 
	recButton:addEventListener ("tap", recNow)
 
end 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene



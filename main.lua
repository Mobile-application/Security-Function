local widget = require ("widget")

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
    onEvent = myEventListener,
    shape = "roundedRect"
}
    )



--sceneGroup:insert(recButton)  REMOVE DURING INTEGRATION
recButton:addEventListener ("tap", recNow)

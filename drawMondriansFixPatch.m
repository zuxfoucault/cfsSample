function drawMondriansFixPatch(initSetting, object, xCenter, yCenter, color)
	% Draw mondrian with the same patch for allowing contrast of stimuli changing smoothly
	% within the same mondrian

	Screen('FillRect', initSetting.windowPtr, color, CenterRectOnPoint(object,xCenter, yCenter));



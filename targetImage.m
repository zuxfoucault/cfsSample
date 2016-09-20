function targetImage(initSetting, experimentPars, cfsPars)

	picScale = 0.09; % Scale the image
	experimentPars.duration = 1; %experimentPars.durationFixP;
	experimentPars.durationTarget = 3; % seconds; image presented duration


	drawFixPointCFS(initSetting, experimentPars, cfsPars);
	drawHolderFrameCfs(initSetting, experimentPars, cfsPars);
	[initSetting.tvbl initSetting.sot] = Screen('Flip', initSetting.windowPtr);


	imdata = imread('lemonY.png'); % put png file 
	tex = Screen('MakeTexture', initSetting.windowPtr, imdata);
	[row column depth] = size(imdata);
	rectImage = CenterRectOnPoint([0 0 row*picScale column*picScale], cfsPars.centerNDomin(1), cfsPars.centerNDomin(2));


	nTrials = 1;
	flashCount = 0;
	alpha = 0.1; %initSetting.contrastStiInit
	ramping = 0.01;
	i = 0;
	while i < nTrials, % iteration of trial
		drawMondrians(initSetting, experimentPars, cfsPars);
		Screen('DrawTexture', initSetting.windowPtr, tex, [], rectImage, [], [], alpha);
		drawHolderFrameCfs(initSetting, experimentPars, cfsPars);
		[initSetting.tvbl initSetting.sot] = Screen('Flip', initSetting.windowPtr, initSetting.sot + experimentPars.duration - initSetting.ifi*0.5);

		if alpha <= 1,
			alpha = alpha + ramping;
		end;

		if (experimentPars.durationTarget - cfsPars.mondFlashDur*flashCount)/cfsPars.mondFlashDur >= 1
			experimentPars.duration = cfsPars.mondFlashDur;
			flashCount = flashCount + 1;
		else,
			experimentPars.duration = mod(experimentPars.durationTarget, cfsPars.mondFlashDur);
			flashCount = 0;
			i = i + 1;
		end;
	end;

	Screen('DrawingFinished', initSetting.windowPtr);

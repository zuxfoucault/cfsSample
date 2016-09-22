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
	ramping = 0.001;
	i = 0;
	% preparation
	[object,xCenter, yCenter, color] = ...
		drawMondrians(initSetting, experimentPars, cfsPars);
	Screen('DrawTexture', initSetting.windowPtr, tex, [], rectImage, [], [], alpha);
	drawHolderFrameCfs(initSetting, experimentPars, cfsPars);
	[initSetting.tvbl initSetting.sot] = Screen('Flip', initSetting.windowPtr, initSetting.sot + experimentPars.duration - initSetting.ifi*0.5);
	tmp1 = initSetting.sot;
	tmp2 = initSetting.sot;

	while i < nTrials, % iteration of trial
		drawMondriansFixPatch(initSetting, object, xCenter, yCenter, color);
		Screen('DrawTexture', initSetting.windowPtr, tex, [], rectImage, [], [], alpha);
		drawHolderFrameCfs(initSetting, experimentPars, cfsPars);
		[initSetting.tvbl initSetting.sot] = Screen('Flip', initSetting.windowPtr);


		if (initSetting.sot - tmp1)/experimentPars.durationTarget < 1,
			if (initSetting.sot - tmp2)/cfsPars.mondFlashDur >= 1
				[object,xCenter, yCenter, color] = ...
					drawMondrians(initSetting, experimentPars, cfsPars);
				tmp2 = initSetting.sot;
			end


			if alpha <= 1, % Set contrast max
				alpha = alpha + ramping;
			end;

		else
			[object,xCenter, yCenter, color] = ...
				drawMondrians(initSetting, experimentPars, cfsPars);
			
			i = i + 1;
			alpha = 1; % reset alpha
			tmp1 = initSetting.sot;
		end;

	end;

	Screen('DrawingFinished', initSetting.windowPtr);

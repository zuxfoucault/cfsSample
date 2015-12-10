%function cfsDemo
try
	clear all; fclose all;
	sca; FlushEvents;
	PsychJavaTrouble;
	%Screen('Preference', 'SkipSyncTests', 3); % normally to 1, 2 is just for demo
	%ListenChar(2); %generate some problem with KbQueueXXX; Cause problem in Windows


	HideCursor;

	initSetting = init;
	%initSetting.mriHook = mriHook;
	experimentPars = setExperimentPars(initSetting);
	experimentPars.dominatingEye = 0; % Left eye: 0; Right eye: 1
	cfsPars = setCfsPars(initSetting, experimentPars);
	experimentFont = setExperimentFont(initSetting, experimentPars);
	maxPriorityLevel = MaxPriority(initSetting.windowPtr);
	Priority(maxPriorityLevel);


	%Mondrian demo
	Screen('TextSize', initSetting.windowPtr, 30)
	tmpCount = 0; % 0 prepare frame
	while tmpCount < 30, % 1/10 * 30 = 3 sec of Mondrian demo
		DrawFormattedText(initSetting.windowPtr, 'Put stimuli here', cfsPars.centerNDomin(1) - experimentFont.toCenter + experimentFont.toCenterX, cfsPars.centerNDomin(2) - experimentFont.toCenter + experimentFont.toCenterY, experimentFont.textColor); %[, sx][, sy][, color][, wrapat][, flipHorizontal][, flipVertical][, vSpacing][, righttoleft]
		drawMondrians(initSetting, experimentPars, cfsPars);
		drawHolderFrameCfs(initSetting, experimentPars, cfsPars);
		if tmpCount == 0,
			duration = [];
		else,
			duration = initSetting.sot + cfsPars.mondFlashDur - initSetting.ifi*0.5;
		end;
		[initSetting.tvbl initSetting.sot] = Screen('Flip', initSetting.windowPtr, duration); %duration - 0.5*initSetting.ifi
		tmpCount = tmpCount + 1;
	end;


	WaitSecs(.1);
	Screen('CloseAll');
	clear mex;
	Priority(0);
	ListenChar(0);
	ShowCursor;

catch err,
	Screen('CloseAll');
	clear mex;
	Priority(0);
	ListenChar(0);
	ShowCursor;
	err.stack
	err.message
end

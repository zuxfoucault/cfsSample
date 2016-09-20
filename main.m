%function target
try
	clear all; fclose all;
	sca; FlushEvents;
	PsychJavaTrouble;
	%Screen('Preference', 'SkipSyncTests', 3); % normally to 1, 2 is just for demo

	timeCheck(1) = GetSecs
	global debug


	debug = 1; % Set debug level for developing; set to 0 for formal experiment


	% Basic input
	if debug == 1,
		experimentTitle = 'exp_name';
		subjectID = 0;
		dominatingEye = 0;

	elseif debug == 0,
		experimentTitle = 'exp_name';
		prompt = {'dominatingEye', 'subjectID', 'contrastStiInit'};
		default = {'0', '0', '0.1'}; % input should be numbers
		dlgTitle = 'Parameters';
		numLines = 1;
		tmp = inputdlg(prompt, dlgTitle, numLines, default);
		for i = 1:length(tmp),
			eval(sprintf('%s = %d;', cell2mat(prompt(i)), str2num(cell2mat(tmp(i)))));
		end;
	end;


	HideCursor;

	initSetting = init;
	if debug == 0,
		initSetting.contrastStiInit = contrastStiInit;
	else,
		initSetting.contrastStiInit = 0.1; % Default
	end;
	experimentPars = setExperimentPars(initSetting);
	experimentPars.dominatingEye = dominatingEye;
	cfsPars = setCfsPars(initSetting, experimentPars);
	maxPriorityLevel = MaxPriority(initSetting.windowPtr);
	Priority(maxPriorityLevel);

	responsePars = setResponseKeys; % Keyboard setting


	% Main program loop
	targetImage(initSetting, experimentPars, cfsPars)


	timeCheck(2) = GetSecs
	(timeCheck(2)-timeCheck(1))/60 % Show how long the experiment takes

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

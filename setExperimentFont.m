function experimentFont = setExperimentFont(initSetting, experimentPars)
	oldLocaleNameString = Screen('Preference','TextEncodingLocale','UTF-8');
	Screen('Preference', 'TextRenderer', 1);

	% Disable font setting, because windows can't use BiauKai
	%[oldFontName,oldFontNumber]=Screen('TextFont', initSetting.windowPtr ,'BiauKai');

	%Set Font Size Here is easier to implement center latter
	% Value of PTB textSize have to be integer
	experimentFont.textSizeMinorTune = 0; % Unit: pixel; This is used to micro-adjust size
	experimentFont.textSize = round(3*experimentPars.degToPix) - experimentFont.textSizeMinorTune; %default = 5; while on goggle
	experimentFont.textSizeSti = round(3*experimentPars.degToPix) - experimentFont.textSizeMinorTune; %default
	experimentFont.textOffSet = 0; % Unit: pixel
	experimentFont.toCenter = experimentFont.textSize/2 + experimentFont.textOffSet;
	experimentFont.toCenterX = -30;
	experimentFont.toCenterY = -26; % up -; down +

	% Text color
	experimentFont.textContrast = 1; % Default setting
	experimentFont.textColor = [repmat(initSetting.black, 1, 3), 255*experimentFont.textContrast];


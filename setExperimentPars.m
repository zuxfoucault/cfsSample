function experimentPars = setExperimentPars(initSetting)
	% Collection of all main parameters


	[experimentPars.center(1) experimentPars.center(2)] = RectCenter(initSetting.screenRect);
	experimentPars.viewdist = 600; %unit: mm
	experimentPars.mmxToPix = initSetting.resx/initSetting.mmx;
	experimentPars.degToPix = ceil(tan(2*pi/360)*(experimentPars.viewdist*experimentPars.mmxToPix));

	% drawFixPoint
	experimentPars.fixSizeDeg = .9; % Fixation point
	experimentPars.fixSize = experimentPars.fixSizeDeg * experimentPars.degToPix;
	experimentPars.penWidDeg = .1; % Fixation pencil width
	experimentPars.penWid = experimentPars.penWidDeg * experimentPars.degToPix;

	% drawHolderFrame
	experimentPars.penWidFrame = 1*experimentPars.degToPix;
	experimentPars.increamentFrameSize = 4;

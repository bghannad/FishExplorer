function [M,behavior,stim] = GetTimeIndexedData(hfig,isAllCells) %#ok<INUSD>
%{
% naming convention used:
M = GetTimeIndexedData(hfig);
M_0 = GetTimeIndexedData(hfig,'isAllCells');
%}

isZscore = getappdata(hfig,'isZscore');
isTrialRes = getappdata(hfig,'isTrialRes');
isClusRes = getappdata(hfig,'isClusRes');

% main data input
if ~isZscore,
    cellResp = getappdata(hfig,'CellResp');
    cellRespAvr = getappdata(hfig,'CellRespAvr');
else
    cellResp = getappdata(hfig,'CellRespZ');
    cellRespAvr = getappdata(hfig,'CellRespAvrZ');
end

isMotorseed = getappdata(hfig,'isMotorseed');
if ~isMotorseed,
    Behavior_full = getappdata(hfig,'Behavior_full');
    BehaviorAvr = getappdata(hfig,'BehaviorAvr');
else
    Behavior_full = getappdata(hfig,'Behavior_full_motorseed');
    BehaviorAvr = getappdata(hfig,'BehaviorAvr_motorseed');
end
stim_full = getappdata(hfig,'stim_full');
stimAvr = getappdata(hfig,'stimAvr');
% other params
isStimAvr = getappdata(hfig,'isStimAvr');
cIX = getappdata(hfig,'cIX');
tIX = getappdata(hfig,'tIX');
% absIX = getappdata(hfig,'absIX');

%% set data
isFullData = getappdata(hfig,'isFullData');
if isFullData
    
    if isStimAvr,
        if exist('isAllCells','var'),
            M = cellRespAvr(:,tIX);
        else
            M = cellRespAvr(cIX,tIX);
        end
        behavior = BehaviorAvr(:,tIX);
        stim = stimAvr(:,tIX);
    else
        if exist('isAllCells','var'),
            M = cellResp(:,tIX);
        else
            M = cellResp(cIX,tIX);
        end
        behavior = Behavior_full(:,tIX);
        stim = stim_full(:,tIX);
    end
    
    
    if isTrialRes
        [~,M] = GetTrialAvrLongTrace(hfig,M);
        [~,behavior] = GetTrialAvrLongTrace(hfig,behavior);
        %     cellRespAvr = getappdata(hfig,'CellRespAvrZ');
    end
    
    if isClusRes
        gIX = getappdata(hfig,'gIX');
        [~,M] = FindClustermeans(gIX,M);
    end
else
    M = [];
    if isStimAvr,
        behavior = BehaviorAvr(:,tIX);
        stim = stimAvr(:,tIX);
    else
        behavior = Behavior_full(:,tIX);
        stim = stim_full(:,tIX);
    end
end

setappdata(hfig,'behavior',behavior);
setappdata(hfig,'stim',stim);
end
% fast analysis of ODE results, before an integration of the iPDE

dtODE15s = min(diff(T));

lastHalf = floor(size(T)/2):size(T);

BMinODE = min(X(lastHalf,1));
BMaxODE = max(X(lastHalf,1));
BBarODE = mean(X(lastHalf,1));

AMinODE = min(X(lastHalf,2));
AMaxODE = max(X(lastHalf,2));
ABarODE = mean(X(lastHalf,2));

MMinODE = min(X(lastHalf,3));
MMaxODE = max(X(lastHalf,3));
MBarODE = mean(X(lastHalf,3));

%% ---

TExcArray = [-4 -4];

for iOdeICs = 1:numel(TArray)
    
    if iOdeICs<=(numel(TArray)/2)
        BcNow = pODE.Bc0;
    else
        BcNow = pODE.Bc0*(1+pPDE.E1);
    end
    
    %lastHalf = floor(size(TArray{iOdeICs})/2):size(TArray{iOdeICs});

    [jnk iHalf] = min(( max(TArray{iOdeICs})./2 - TArray{iOdeICs}).^2);
    
    lastHalf = iHalf:size(TArray{iOdeICs});
    
    tmp = XArray{iOdeICs};
    VLastHalf = mxVFunc(tmp(lastHalf,1), BcNow, tmp(lastHalf,2), tmp(lastHalf,3));
    tmp = TArray{iOdeICs};
    tLastHalf = tmp(lastHalf);
    
    VMax = max(VLastHalf);
    VMin = min(VLastHalf);
    VAmp = VMax-VMin;
    
    vPropEstimate = 0;
    
    TStop =0;
    if (VMax > 0.8 && VMin > 0.5) % go
        TExcArray(iOdeICs) = -1;
    elseif (VMax < 0.1 && VMin < 0.1) % stop
        TExcArray(iOdeICs) = -2;
    else % ipde locally oscillatory
        
        switchList = diff(sign(VLastHalf-0.5));
        iTGo = find(switchList==2);
        iTStop = find(switchList==-2);
        
        %     plot(tLastHalf(iTGo), 0.5*ones(size((tLastHalf(iTGo)))), 'g>');
        %     plot(tLastHalf(iTStop), 0.5*ones(size((tLastHalf(iTStop)))), 'rs');
        
        % find TExc and TStop
        
        if (numel(iTGo)>0 && numel(iTStop)>0)
            if iTStop(1)<iTGo(1)
                if (numel(iTStop)>=2 && numel(iTGo)>=2)
                    TExcArray(iOdeICs) = tLastHalf(iTStop(2))-tLastHalf(iTGo(1));
                    TStopArray(iOdeICs) = tLastHalf(iTGo(2))-tLastHalf(iTStop(2));
                else
                    TExcArray(iOdeICs) = -3; % simulation too short
                end
            elseif iTGo(1)<iTStop(1)
                if numel(iTGo)>=2
                    TExcArray(iOdeICs) = tLastHalf(iTStop(1))-tLastHalf(iTGo(1));
                    TStopArray(iOdeICs) = tLastHalf(iTGo(2))-tLastHalf(iTStop(1));
                else
                    TExcArray(iOdeICs) = -3; % simulation too short
                end
            end
        end % done if through switch possibilities
        
        
    end
    
end

% catalogue
if TExcArray(1)==-2
    lowTensionState = 'stop' ;
    lowState = 1;
elseif TExcArray(1)==-1
    lowTensionState = 'go' ;
    lowState = 2;
elseif TExcArray(1)~=-3
    lowTensionState = 'osc' ;
    lowState = 3;
end

if TExcArray(2)==-2
    highTensionState = 'stop' ;
    highState = 5;
elseif TExcArray(2)==-1
    highTensionState = 'go' ;
    highState = 7;
elseif TExcArray(2)~=-3
    highTensionState = 'osc' ;
    highState = 11;
end

stateState = lowState*highState;

display( [lowTensionState ', ' highTensionState]);

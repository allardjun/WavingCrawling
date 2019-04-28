% analyzePdeMajor



%% load data

load([runDir '/binary.mat']);
load([runDir '/params.mat']) % contains 'pODE', 'pPDE', 'pNumerics'
load([runDir '/odeResults.mat']);

%% mean velocity in steady-state

lastHalf = floor(size(tArray)/2):size(tArray);
VMeanSS = mean(mean(VAllTime(:,lastHalf)));


%% vs t at a point

ix = floor(nx/2);

VHere = VAllTime(ix,:);


%% categorize, get period

VLastHalf = VHere(lastHalf);
tLastHalf = tArray(lastHalf);

VMax = max(VLastHalf);
VMin = min(VLastHalf);

vPropEstimate = 0;
TExc = -4;
TStop =0;
if (VMax > 0.8 && VMin > 0.5) % go
    TExc = -1;
elseif (VMax < 0.1 && VMin < 0.1) % stop
    TExc = -2;
else % ipde locally oscillatory

    switchList = diff(sign(VLastHalf-0.5));
    iTGo = find(switchList==2);
    iTStop = find(switchList==-2);


    % find TExc and TStop

    if (numel(iTGo)>0 && numel(iTStop)>0)
        if iTStop(1)<iTGo(1)
            if (numel(iTStop)>=2 && numel(iTGo)>=2)
                TExc = tLastHalf(iTStop(2))-tLastHalf(iTGo(1));
                TStop = tLastHalf(iTGo(2))-tLastHalf(iTStop(2));
            else
                TExc = -3; % simulation too short
            end
        elseif iTGo(1)<iTStop(1)
            if numel(iTGo)>=2
                TExc = tLastHalf(iTStop(1))-tLastHalf(iTGo(1));
                TStop = tLastHalf(iTGo(2))-tLastHalf(iTStop(1));
            else
                TExc = -3; % simulation too short
            end
        end
    end % done if through switch possibilities


    % estimate v prop
    iTGoArray = zeros(1,nx);
    iTStopArray = zeros(1,nx);
    for ix = 1:nx

        VHere = VAllTime(ix,:);

        VLastHalf = VHere(lastHalf);
        tLastHalf = tArray(lastHalf);
        
        switchList = diff(sign(VLastHalf-0.5));
        iTGo = [find(switchList==2) 1];
        iTGoArray(ix) = iTGo(1);
        iTStop = [find(switchList==-2) 1];
        iTStopArray(ix) = iTStop(1);

    end % finish loop through ix
    
    vPropEstimate = 0;
     
end

if verboseTF
    display(TExc);
    display(TStop);
end


%% other measurements

MBar = mean(mean(MAllTime(:,lastHalf)));



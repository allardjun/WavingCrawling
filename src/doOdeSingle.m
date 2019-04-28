% Do ODE run and full analysis for a single parameter set

sessionCode = {'chase8ode'};
sweepCode = 'lowAmp';
paramCode = 'oo';
icyCode = 'unif';
   
seriesName = strcat(sessionCode, sweepCode, paramCode, icyCode);
seriesName = seriesName{1};

addpath('../analyzers/');

% define parameters, ODEs

paramDefn;


pODE.epsilon = 16;10^(0.8);
pODE.delta = 0.90;

% define initial conditions

clear odeICs;
odeICs{1} = [1 1 1];
odeICs{2} = [2 1 1];
%odeICs{3} = [1 2 1];
%odeICs{4} = [1 1 2];


%% integrate ODEs

        clear TArray XArray;
        
        % turn the ode system into a ode15s-friendly form
        dxdtLowTension  =@(x) (mxOdeDefn(x(1),x(2),x(3),pODE.Bc0,pODE));
        dxdtHighTension =@(x) (mxOdeDefn(x(1),x(2),x(3),pODE.Bc0*(1+pPDE.E1),pODE));
        
        
        for iOdeICs = 1:numel(odeICs)
            
            [T X] = ode15s(@(t,y)dxdtLowTension(y), [0 pNumerics.tMax], odeICs{iOdeICs});
            
            TArray{iOdeICs} = T;
            XArray{iOdeICs} = X;
            
        end
        
        for iOdeICs = (numel(odeICs)+1):(2*numel(odeICs))
            
            [T X] = ode15s(@(t,y)dxdtHighTension(y), [0 pNumerics.tMax], odeICs{iOdeICs-numel(odeICs)});
            
            TArray{iOdeICs} = T;
            XArray{iOdeICs} = X;
            
        end
        

%% analyze results

analyzeOdeMinor;

analyzeOdeMajor;

display('dunn');
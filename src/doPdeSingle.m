% Do ODE run and quick analysis, then do an iPDE run and store variables

mex mxPdeMarch.c;
mex mxOdeDefn.c;
mex mxVFunc.c;

runName = '2019Test1c';

runDir = ['../runs/' runName];
mkdir(runDir);

sweepCode = 'wave';
paramCode = 'ss';
icyCode = 'waveInit';

addpath('../analyzers/');

% define parameters
paramDefn;

pODE.R = 0.14;
pODE.delta = 0.8;

pNumerics.dx = 0.1;
pNumerics.dumpPeriod = 500;
pNumerics.tMax = 200;

pNumerics.wTCusp = 1.6;
pNumerics.LgMin = 0.4;

pPDE.E1 = 0.0;
pPDE.XiB = 0.001;

% -- preliminary ODE solve -- %

% define initial conditions for ode

clear odeICs;
odeICs{1} = [1 1 1];
odeICs{2} = [9 1 1];
odeICs{3} = [1 9 1];
odeICs{4} = [1 1 9];


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


%% analyze ODE results

save([runDir '/params.mat'], 'pODE', 'pPDE', 'pNumerics');

analyzeOdeMinor;

analyzeOdeMajor; % for now

save([runDir '/odeResults.mat'], 'XArray', 'TArray', 'stateState');


%% numerical preparations, ICs and stuff

nx = ceil(pPDE.L/pNumerics.dx);

icy; % now there are B, A and M arrays of size (nx,1);

% select timestep
dtCourant = 0.5*pODE.epsilon*pNumerics.dx^2; % might not work for model variants!
dt = 0.5*min([dtCourant, dtODE15s, 0.1]);

if pNumerics.dumpPeriod == 0
    pNumerics.dumpPeriod = floor(pNumerics.tMax/dt/2000);
end
%% integrate PDE!

mxPdeMarch(B,A,M, nx, dt, pODE, pPDE, pNumerics, runDir);


%%
save([runDir '/params.mat'], 'pODE', 'pPDE', 'pNumerics');

if 1
    loadAscii2binary;
end

verboseTF = 1;
analyzePdeMinor;
verboseTF = 0;

% switches
showMovieTF = 0;
makeMovieTF = 0;

analyzePdeMajor;
% define parameters of all kinds

clear('pODE', 'pPDE', 'pNumerics', 'pPhysical');

% -- ODE parameters -- % 

pODE.R = 0.2;
pODE.delta = 0.9;

if strcmp(paramCode, 'oo')
    pODE.R = 0.2;
    pODE.delta = 0.9;
end

if strcmp(paramCode, 'o2')
    pODE.R = 0.14;
    pODE.delta = 0.8;
end

if strcmp(paramCode, 'ss')
    pODE.R = 0.14;
    pODE.delta = 0.725;
end

pODE.epsilon = 0.1;
pODE.etaB = 1;

pODE.etaA = 1;
if strcmp(paramCode, 'nf')
    pODE.etaA = 0;
end

pODE.etaM = 1;
pODE.theta = 0.2;
pODE.K = 1;
pODE.alpha = 0.0;

pODE.Bc0 = 4;

pODE.MConst = 1;

% -- iPDE parameters -- %

pPDE.L = 60; % was 40 for leading edge only

if (strcmp(sweepCode, 'Osc') || strcmp(sweepCode, 'Rand') || strcmp(sweepCode, 'OR') || strcmp(sweepCode, 'lowAmp'))
    pPDE.E1 = 0.0;
else
    pPDE.E1 = 0.1;
end

pPDE.E2 = 1;

pPDE.DB = 0.1; % -- HERE

pPDE.XiB = 0.001; % -- HERE
pPDE.XiA = 0;
pPDE.XiM = 0;

% -- numerics parameters -- %

pNumerics.dx = 0.2; % -- HERE
pNumerics.dtDefault = 0.01;
pNumerics.wVCusp = 0.1;

pNumerics.wTCusp = 0.2;
pNumerics.LgMin = 0.1;

pNumerics.tMax = 300;
pNumerics.ntMax = 1e8;

pNumerics.dumpPeriod = 1000;
if strcmp(sweepCode, 'lowAmp')
    pNumerics.dumpPeriod = 0;
end

pNumerics.smallDumpPeriod = 200;

pNumerics.repeatableTF = 0;

% -- physical conversion parameters -- %

pPhysical.xStar = 1;
pPhysical.tStar = 5;

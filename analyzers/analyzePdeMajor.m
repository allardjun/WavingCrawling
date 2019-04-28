% analyzePdeMajor

load([runDir '/binary.mat']);
load([runDir '/params.mat']) % contains 'pODE', 'pPDE', 'pNumerics');


%% kymograph!

xAxis = linspace(0,pPDE.L,nx);
dx = xAxis(2)-xAxis(1);

fKymographs = figure(241); clf; 

subplot(5,1,1); hold on; box on;

surf(tArray, xAxis, BAllTime, ...
    'edgecolor', 'none');

subplot(5,1,2); hold on; box on;

surf(tArray, xAxis, AAllTime, ...
    'edgecolor', 'none');

subplot(5,1,3); hold on; box on;

surf(tArray, xAxis, MAllTime, ...
    'edgecolor', 'none');

subplot(5,1,4); hold on; box on;

surf(tArray, xAxis, VAllTime, ...
    'edgecolor', 'none');

% Guide to the eye for estimating wave propagation velocity
vProp = 1;
plot3([0 10] + tArray(floor(end/2))*[1 1], [0 +1]*vProp*10+20, [2 2], '-b', 'linewidth',2);
plot3([0 10] + tArray(floor(end/2))*[1 1], [0 -1]*vProp*10+20, [2 2], '-b', 'linewidth',2);
vProp = 0.5;
plot3([0 10] + tArray(floor(end/2))*[1 1], [0 +1]*vProp*10+20, [2 2], '-g', 'linewidth',2);
plot3([0 10] + tArray(floor(end/2))*[1 1], [0 -1]*vProp*10+20, [2 2], '-g', 'linewidth',2);
vProp = 1.5;
plot3([0 10] + tArray(floor(end/2))*[1 1], [0 +1]*vProp*10+20, [2 2], '-g', 'linewidth',2);
plot3([0 10] + tArray(floor(end/2))*[1 1], [0 -1]*vProp*10+20, [2 2], '-g', 'linewidth',2);

if (exist('vPropEstimate', 'var') && vPropEstimate>0)
   plot3([0 10] + tArray(floor(end/2))*[1 1], [0 1]*vPropEstimate*10+20, [2 2], '-r', 'linewidth',3);
   set(gca, 'ylim', [0, 40]);
end

subplot(5,1,5); hold on; box on;
% membrane tension
plot(tArray, BcArray, ...
    '-b', 'linewidth', 1);

%% vs t at a point

ix = 30;

fTimeSeries = figure(211); clf;

subplot(4,1,1); hold on; box on;
plot(tArray, BAllTime(ix,:), '-b');

plot(tArray, BcArray, '-c');

subplot(4,1,2); hold on; box on;
plot(tArray, AAllTime(ix,:), '-b');

subplot(4,1,3); hold on; box on;
plot(tArray, MAllTime(ix,:), '-b');

subplot(4,1,4); hold on; box on;
plot(tArray, VAllTime(ix,:), '-b');

set(gca, 'ylim', [0 1]);

%% movie
doSnapshot;

if showMovieTF  
    doMovie;
end
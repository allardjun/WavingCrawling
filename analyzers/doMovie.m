% options
nDumpSkip = 3;

x = 0:pNumerics.dx:(nx-1)*pNumerics.dx;

% find scale
yMax = max(max([ BAllTime AAllTime MAllTime ]));

figure(431); clf;
set(gcf, 'color', 'w');
set(gcf, 'position', [400 400 640 360]);

if(makeMovieTF) MakeQTMovie('start', [runDir '/' runName '.mov']); end


nDumpMax = min(numel(dirListing),2000);
nDump = 1000;
tMaxToAnimate = 1e3; t=0;
while(nDump<nDumpMax && t<tMaxToAnimate)
    
    nDump = nDump+nDumpSkip;
    
    B  = BAllTime(:,nDump);
    A  = AAllTime(:,nDump);
    M  = MAllTime(:,nDump);
    Bc = BcArray(nDump);
    t  = tArray(nDump);
    
    %plot profile
    clf; hold on; box on;
    %title(['t = ' num2str(tstar*t, '%.1f')])
    
    %display(['t=' num2str(t) ', Bc=' num2str(Bc)']);
    
    plot(x,B, 'color', 'b', 'linewidth', 2);
    plot(x,Bc*ones(size(x)), 'color', 'c', 'linewidth', 2);
    plot(x,A, 'color', 'r', 'linewidth', 2);
    plot(x,M, 'color', 'm', 'linewidth', 2);
    
    
    %plot(x,Vfunc(B,Bc), 'k', 'linewidth', 1);
    
    set(gca, 'ylim', [0, yMax]);
    
    pause(0.1);
    drawnow;
    
    if(makeMovieTF) MakeQTMovie('addframe', [runDir '/' runName '.mov']); end
    
end % finished time loop

if(makeMovieTF) MakeQTMovie('finish', [runDir '/' runName '.mov']); end


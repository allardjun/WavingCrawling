% analyze ODE results, full analysis

defineColors; % Jun's library

% time series
figure(111); clf; 



for iOdeICs = 1:(2*numel(odeICs))
    X = XArray{iOdeICs};
    T = TArray{iOdeICs};

    if iOdeICs<=(numel(TArray)/2)
        BcNow = pODE.Bc0;
    else
        BcNow = pODE.Bc0*(1+pPDE.E1);
    end
    
    V = mxVFunc(X(:,1), BcNow, X(:,2), X(:,3));
    
    subplot(4,1,1); hold on; box on;
    plot(T, X(:,1), 'color', colors{iOdeICs});
    ylabel('B'); xlabel('T');
    
    subplot(4,1,2); hold on; box on;
    plot(T, X(:,2), 'color', colors{iOdeICs});
    ylabel('A'); xlabel('T');
    
    subplot(4,1,3); hold on; box on;
    plot(T, X(:,3), 'color', colors{iOdeICs});
    ylabel('M'); xlabel('T');
    
    subplot(4,1,4); hold on; box on;
    plot(T, V, 'color', colors{iOdeICs});
    ylabel('V'); xlabel('T');
    
end

% phase space and plane projections
figure(121); clf; hold on; box on;
for iOdeICs = 1:(2*numel(odeICs))
    X = XArray{iOdeICs};
    T = TArray{iOdeICs};
   
    plot3(X(:,1),X(:,2),X(:,3), 'color', colors{iOdeICs});
    
    xlabel('B'); ylabel('A'); zlabel('M');
end

figure(122); clf;
for iOdeICs = 1:(2*numel(odeICs))
    X = XArray{iOdeICs};
    T = TArray{iOdeICs};
   
    subplot(1,3,1); hold on; box on;
    plot(X(:,1),X(:,2), 'color', colors{iOdeICs});
    xlabel('B'); ylabel('A');
    
    subplot(1,3,2); hold on; box on;
    plot(X(:,2),X(:,3), 'color', colors{iOdeICs});
    xlabel('A'); ylabel('M');
    
    subplot(1,3,3); hold on; box on;
    plot(X(:,1),X(:,3), 'color', colors{iOdeICs});
    xlabel('B'); ylabel('M');
end



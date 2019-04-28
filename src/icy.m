% initial conditions for PDE

%B = ones(nx,1);
%A = ones(nx,1);
%M = ones(nx,1);

F = ones(nx,1);

% B = BMaxODE*rand(nx,1);
% A = AMaxODE*rand(nx,1);
% M = MMaxODE*rand(nx,1);

B = BMinODE*ones(nx,1);
%B(end-20:end) = BMaxODE;
A = AMaxODE*rand(nx,1);
M = MMaxODE*rand(nx,1);
M(1:2:end) = M(1:2:end).*((1:2:nx)'/nx).^2;
A(1:2:end) = A(1:2:end).*((1:2:nx)'/nx).^2;


if strcmp(icyCode, 'unif') % wave maker
    
    % start go
    B = BMaxODE*ones(nx,1);
    A = AMaxODE*ones(nx,1);
    M = MMinODE*ones(nx,1);
end
if strcmp(icyCode, 'waveInit') % wave 
    
    B = BMinODE*ones(nx,1);
    A = AMinODE*ones(nx,1);
    M = MMaxODE*ones(nx,1);
    
    waveWidth = 1;
    ixWave = ceil(waveWidth/pNumerics.dx);
    
    B((end-ixWave):end) = 2*pODE.Bc0;
    A((end-ixWave):end) = AMaxODE;
    M((end-ixWave):end) = MMinODE;
    
end

if strcmp(icyCode, 'waveInit2') % wave 
    
    B = BMinODE*ones(nx,1);
    A = AMaxODE*ones(nx,1);
    M = MMaxODE*ones(nx,1);
    
    waveWidth = 1;
    ixWave = ceil(waveWidth/pNumerics.dx);
    iDeadZone = ixWave;
    
    for iStart=[100 300 500]
        B((iStart-iDeadZone):iStart) = 0;
        A((iStart-iDeadZone):iStart) = 0;
        M((iStart-iDeadZone):iStart) = MMaxODE;
    
        B(iStart:(iStart+ixWave)) = 2*pODE.Bc0;
        A(iStart:(iStart+ixWave)) = AMaxODE;
        M(iStart:(iStart+ixWave)) = MMinODE;
    end
    
end
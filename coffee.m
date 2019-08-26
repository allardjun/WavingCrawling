
N = 10; % number of scoops

nMax = 2*N;

x = ones(1,nMax);

for n=2:nMax
    
    x(n) = (1-1/N)*x(n-1);
    
end % finished loop through days

figure(1); 
plot(x,'-ok');
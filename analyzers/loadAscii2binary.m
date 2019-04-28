%% load data

dirListing = dir([runDir '/visual*']);

clear('BAllTime', 'AAllTime', 'MAllTime');

for iFile=1:min(numel(dirListing),2400);
    
    filename = dirListing(iFile).name;
    nt = str2num(filename(7:end));
    
    asciiTable = load([runDir '/visual' num2str(nt,'%06d')]);

    nx = size(asciiTable,1);
    
    if (~exist('BAllTime', 'var'))
        BAllTime = zeros(nx,numel(dirListing));
        AAllTime = zeros(nx,numel(dirListing));
        MAllTime = zeros(nx,numel(dirListing));
    end
    
    BAllTime(:,iFile) = asciiTable(:,1);
    AAllTime(:,iFile) = asciiTable(:,2);
    MAllTime(:,iFile) = asciiTable(:,3);
    
    
end % finished loop through files

tmp = dlmread([runDir '/table11']);

tArray = tmp(:,2);
BcArray = tmp(:,3);

dt = tArray(2)-tArray(1);

display(nx);
display(numel(dirListing));

VAllTime = mxVFunc(BAllTime,BcArray, AAllTime, MAllTime);

tmp = dlmread([runDir '/table22']);

tArrayFine = tmp(:,2);
BcArrayFine = tmp(:,3);


save([runDir '/binary.mat'], ...
    'BAllTime', 'AAllTime', 'MAllTime', 'tArray', 'BcArray', 'VAllTime', 'nx', 'nt', 'dt', 'tArrayFine', 'BcArrayFine');


function dirPathAndName = mkdirJun(dirPathAndNamePrefix, option)

if strcmpi(option, 'time')
   suffix = datestr(now);
else % pure numbering
    
    if (strcmpi(option, 'tn'))
       tmp = dirPathAndNamePrefix;
    end
    
    listing = dir([tmp '*']);
    
    if numel(listing)
        lastNumber = str2num(substr(listing(end).name, -1, 3))+1;
    else 
        lastNumber = 1;
    end
    
    suffixNumber = num2str(lastNumber, '%03d');
    
    suffix=suffixNumber;
    
    
end
    

dirPathAndName = [dirPathAndNamePrefix suffix];
mkdir(dirPathAndName);



end
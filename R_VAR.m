clear;clc;
load mj_data

all_data(:,:,1) = dg;
all_data(:,:,2) = kd;
all_data(:,:,3) = reem;
all_data(:,:,4) = gt;

for itn = 1:4
    for icase = 1:3
       for ivar = 1:4;
          temp = corrcoef(squeeze(all_data(:,icase+1,itn)),squeeze(all_data(:,ivar+4,itn)));
          R(icase,ivar,itn) = temp(1,2);
       end
    end
end



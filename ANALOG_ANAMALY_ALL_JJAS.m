% cmp data
clear;clc;close all;
yr = 1979:2014;


load mj_data
all_data(:,:,1) = dg;
all_data(:,:,2) = kd;
all_data(:,:,3) = reem;
all_data(:,:,4) = gt;

xx =  squeeze(all_data(:,5:8,:));
MZYD = squeeze(all_data(:,2:4,:));



MEAN = squeeze(mean(xx));
MEANY = squeeze(mean(MZYD));

for in = 1:size(xx,1);
    xxa(in,:,:) = squeeze(xx(in,:,:)) - MEAN;
    yya(in,:,:) = squeeze(MZYD(in,:,:)) - MEANY;
end


for istn = 1:4
    for icase = 1:3
        y = squeeze(yya(:,icase,istn));
        X = squeeze(xxa(:,:,istn));
        b = regress(y,X);
        yp(:,icase,istn) = b'*X' + MEANY(icase,istn);
        corrcoef(b'*X',y)
    end
end

icase = 3;
isn = 2;
NUM_ANA = 10;
PR_T_JJAS = squeeze(yp(:,icase,:));

stn = {'Dangishta','Kudmi','Reem','Gaita'};


clear xx

%stop
close all


% find analogue years
YR_G = yr;

% change for each month or comment it for JJAS mean
%PR_T_JJAS = squeeze(PR_T(4,:,:));
for im = 1:4
    for m = 1:length(yr)
        x = PR_T_JJAS(m,im);
        y = PR_T_JJAS(:,im);
        D = abs(x - y);
        [c d] = sort(D);
        ANA(im,m,:) = d(2:2+NUM_ANA-1) + YR_G(1)-1;
        ANA_C(im,m,:) = c(2:2+NUM_ANA-1);
    end
end

ANA_BK = ANA;
ANA_C_BK = ANA_C;


scrsz = get(0,'ScreenSize');
% figure 1
%figure('Position',[1 scrsz(4)/2 scrsz(3) scrsz(4)*9/10])

YR_all = 1979:2014;

scrsz = get(0,'ScreenSize');
addpath('~/PACKAGE_DOF')
for im = isn:isn % 1:4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure('Position',[1 scrsz(4)/2 scrsz(3) scrsz(4)*9/10])
    
    subplot(3,1,1)
    hold on
    plot(yr,squeeze(PR_T_JJAS(:,im)),'--g','linewidth',3)
    hold on
    scatter(yr,squeeze(PR_T_JJAS(:,im)),100,'filled','b')
    %legend(stn,'fontsize',30)
    set(gca,'fontsize',30)
    set(gcf,'color','w')
    set(gca,'xtick',yr)
    rotateXLabels( gca(), 45 )
    xlim([yr(1) yr(end)])
    grid on
    ylabel(['MJJASO PYD']);
    xlabel('Years')
    legend(stn(im))
    subplot(3,1,2)
    hold on
    temp = squeeze(PR_T_JJAS(:,im))-PR_T_JJAS(1,im);
    plot(yr,squeeze(PR_T_JJAS(:,im))-PR_T_JJAS(1,im),'k','linewidth',3)
    %legend(stn,'fontsize',30)
    set(gca,'fontsize',30)
    set(gcf,'color','w')
    xlim([yr(1) yr(end)])
    grid on
    ylabel(['PYD YEAR - PYD 1979']);
    xlabel('Years')
    legend('Target Year: 1979')
    scatter(squeeze(ANA_BK(im,1,1)),temp(squeeze(ANA_BK(im,1,1))-1979+1),200,'filled','r')
    h = text(squeeze(ANA_BK(im,1,1))-0.5,temp(squeeze(ANA_BK(im,1,1))-1979+1),'ANA1')
    set(h,'color','b')
    set(h,'fontsize',30)
    scatter(squeeze(ANA_BK(im,1,2)),temp(squeeze(ANA_BK(im,1,2))-1979+1),200,'filled','r')
    h = text(squeeze(ANA_BK(im,1,2))-0.5,temp(squeeze(ANA_BK(im,1,2))-1979+1),'ANA2')
    set(h,'color','b')
    set(h,'fontsize',30)
    scatter(squeeze(ANA_BK(im,1,3)),temp(squeeze(ANA_BK(im,1,3))-1979+1),200,'filled','r')
    h = text(squeeze(ANA_BK(im,1,3))-0.5,temp(squeeze(ANA_BK(im,1,3))-1979+1),'ANA3')
    set(h,'color','b')
    set(h,'fontsize',30)
    
    set(gca,'xtick',yr)
    rotateXLabels( gca(), 45 )
    
    subplot(3,1,3)
    plot(yr,squeeze(PR_T_JJAS(:,im)),'--g','linewidth',3)
    hold on
    clear x1 x2
    for iyr = 1:length(yr)
        x1(iyr) = min(PR_T_JJAS(ANA_BK(im,iyr,:)-1979+1,im));
        x2(iyr) = max(PR_T_JJAS(ANA_BK(im,iyr,:)-1979+1,im));
        xx(:,iyr) = squeeze(PR_T_JJAS(ANA_BK(im,iyr,:)-1979+1,im));
    end
    
    X = [YR_G(:)' fliplr(YR_G(:)')];
    Y = [x1(:)' fliplr(x2(:)')];
    fill(X,Y,'r')
    plot(yr,squeeze(PR_T_JJAS(:,im)),'--g','linewidth',3)
    scatter(yr,squeeze(PR_T_JJAS(:,im)),100,'filled','b')
    set(gca,'fontsize',30)
    set(gcf,'color','w')
    set(gca,'xtick',yr)
    rotateXLabels( gca(), 45 )
    xlim([yr(1) yr(end)])
    grid on
    %ylabel(['Spread of Analog']);
    xlabel('Years')
    ylabel(['MJJASO total PYD']);
    
    figure('Position',[1 scrsz(4)/2 scrsz(3) scrsz(4)*9/10])
    MEAN = mean(xx);
    subplot(1,2,1)
    scatter(squeeze(PR_T_JJAS(:,im)),MEAN,100,'filled')
    temp = corrcoef(squeeze(PR_T_JJAS(:,im)),MEAN');
    STD = std(squeeze(PR_T_JJAS(:,im)));
    MEANc = mean(squeeze(PR_T_JJAS(:,im)));
    hold on
    plot([MEANc+STD MEANc+STD],[max(MEAN) min(MEAN)],'--r','linewidth',3)
    plot([MEANc-STD MEANc-STD],[max(MEAN) min(MEAN)],'--r','linewidth',3)
    plot([MEANc MEANc],[max(MEAN) min(MEAN)],'r','linewidth',3)
    set(gca,'fontsize',30)
    set(gcf,'color','w')
    axis('square')
    xlabel('Target PYD')
    ylabel('Analog mean PYD')
    title(sprintf('R=%2.2f',temp(1,2)),'fontsize',40)
    grid on
    subplot(1,2,2)
    
    hold on
    scatter(squeeze(PR_T_JJAS(:,im)),MEAN'-squeeze(PR_T_JJAS(:,im)),100,'filled')
    MEAN = MEAN'-squeeze(PR_T_JJAS(:,im));
    axis('equal')
    set(gca,'fontsize',30)
    xlabel('Target')
    ylabel('Analog mean - Target')
    plot([MEANc+STD MEANc+STD],[max(MEAN) min(MEAN)],'--r','linewidth',3)
    plot([MEANc-STD MEANc-STD],[max(MEAN) min(MEAN)],'--r','linewidth',3)
    plot([MEANc MEANc],[max(MEAN) min(MEAN)],'r','linewidth',3)
    set(gcf,'color','w')
    grid on
    
end



for m = im:im % 1:4
    figure('Position',[1 scrsz(4)/2 scrsz(3) scrsz(4)*9/10])
    ANA = squeeze(ANA_BK(m,:,:));
    for m = 1:NUM_ANA
        hold on
        scatter(YR_G,ANA(:,m),(NUM_ANA-m+1)*100,'filled','r')
        tmp1 = squeeze(all_data(squeeze(ANA(:,m)-1978),icase+1,im));
        tmp2 = squeeze(all_data(:,2,im));
        corrcoef(tmp1,tmp2)
    end
    
    tmp2 = squeeze(all_data(:,icase+1,im));
    for m = 1:NUM_ANA
        tmp1 = squeeze(all_data(squeeze(ANA(:,m)-1978),icase+1,im));
        temp = corrcoef(tmp1,tmp2);
        RR(m) = temp(1,2);
    end
    
    tmp1 = 0;
    for m = 1:NUM_ANA
        m
        tmp1 = tmp1+squeeze(all_data(squeeze(ANA(:,m)-1978),icase+1,im));
        temp = corrcoef(tmp1,tmp2);
        RRR(m) = temp(1,2);
    end
   
    grid on
    set(gca,'fontsize',10)
    set(gcf,'color','w')
    %legend('Gauge','NMA','CHIRPS','PECMWF','PGPCC')
    set(gca,'xtick',1979:2014)
    set(gca,'ytick',1979:2014)
    xlim([1979 2014])
    ylim([1979 2014])
    set(gcf,'color','w')
    axis('square')
    set(gca,'fontsize',30)
    rotateXLabels( gca(), 90)
    xlabel('Target years')
    ylabel('Analogue years')
    set(gcf,'paperpositionmode','auto')
    close all
    
     plot(RR,'r')
    hold on
    plot(RRR,'k')
    set(gca,'fontsize',20)
    set(gcf,'color','w')
    legend('Single member','Ensemble mean')
    xlabel('Number of analog')
    ylabel('Correlation skill')
    xlim([1 10])
    set(gca,'xtick',1:10)
    grid on
    stop
    
    
    figure('Position',[1 scrsz(4)/2 scrsz(3) scrsz(4)*9/10])
    subplot(3,1,1:2)
    ANA_C = squeeze(ANA_C_BK(m,:,:));
    x1 = ANA_C(:,1);
    x2 = ANA_C(:,end);
    X = [YR_G(:)' fliplr(YR_G(:)')];
    Y = [x1(:)' fliplr(x2(:)')];
    fill(X,Y,'r')
    set(gca,'fontsize',30)
    rotateXLabels( gca(), 90)
    xlabel('Target years')
    ylabel('Differences for analogue years (mm)')
    set(gcf,'color','w')
    set(gca,'xtick',1979:2014)
    xlim([1979 2014])
    % pause
    % close all
end


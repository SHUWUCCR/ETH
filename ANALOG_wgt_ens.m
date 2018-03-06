% cmp data
clear;clc;close all;

load mj_data
% column 1: year
% column 2-4: maize yield for no,high,low fertilizer
% column 5-8 for sr, tmax,tmin,rainfall

all_data(:,:,1) = dg;
all_data(:,:,2) = kd;
all_data(:,:,3) = reem;
all_data(:,:,4) = gt;

yr = squeeze(dg(:,1));
%----------------------------------------------------------------
%solar     ivar = 1
%TMAX      ivar = 2
%TMIN      ivar = 3
%rainfall  ivar = 4
name_var = {'sr','tmax','tmin','rainfall'}
ivar = 2;

%no fertilizer       icase = 1
%high fertilizer     icase = 2
%low fertilizer      icase = 3
ft_case = {'no FT','high FT','low FT'}
icase = 1;

% stn = {'Dangishta','Kudmi','Reem','Gaita'};
istn = 1;

% number of analogs
NUM_ANA = 10;
ith_ana = 2;

%-------------------------------------------------------------------

tgt_var = squeeze(all_data(:,ivar+4,istn));
stn = {'Dangishta','Kudmi','Reem','Gaita'};

scrsz = get(0,'ScreenSize');
figure('Position',[1 scrsz(4)/2 scrsz(3) scrsz(4)*9/10])
plot(yr,squeeze(tgt_var),'linewidth',3)
%legend(stn,'fontsize',30)
set(gca,'fontsize',30)
set(gcf,'color','w')
xlim([yr(1) yr(end)])
grid on
%ylabel(['MJJASO total rainfall(mm)']);
ylabel(['All year round' name_var(ivar)]);
xlabel('Years')
legend(stn)

%stop
close all


% find analogue years
YR_G = yr;

for m = 1:length(yr)
    x = tgt_var(m);
    y = tgt_var;
    D = abs(x - y);
    [c d] = sort(D);
    ANA(m,:) = d(2:2+NUM_ANA-1) + YR_G(1)-1;
end

ANA_BK = ANA;

scrsz = get(0,'ScreenSize');
addpath('PACKAGE_DOF')
figure('Position',[1 scrsz(4)/2 scrsz(3) scrsz(4)*9/10])
subplot(3,1,1)
hold on
plot(yr,squeeze(tgt_var),'--g','linewidth',3)
hold on
scatter(yr,squeeze(tgt_var),100,'filled','b')
%legend(stn,'fontsize',30)
set(gca,'fontsize',30)
set(gcf,'color','w')
set(gca,'xtick',yr)
rotateXLabels( gca(), 45 )
xlim([yr(1) yr(end)])
grid on
ylabel(['All year round' name_var(ivar)]);
xlabel('Years')
legend(stn(istn))
subplot(3,1,2)
hold on
temp = squeeze(tgt_var)-tgt_var(1);
plot(yr,squeeze(tgt_var)-tgt_var(1),'k','linewidth',3)
%legend(stn,'fontsize',30)
set(gca,'fontsize',30)
set(gcf,'color','w')
xlim([yr(1) yr(end)])
grid on
ylabel([name_var(ivar) 'YEARS - 1979']);
xlabel('Years')
legend('Target Year: 1979')
for iana = 1:NUM_ANA
    scatter(squeeze(ANA_BK(1,iana)),temp(squeeze(ANA_BK(1,iana))-1979+1),200,'filled','r')
    h = text(squeeze(ANA_BK(1,iana))-0.5,temp(squeeze(ANA_BK(1,iana))-1979+1),['ANA' num2str(iana)])
    set(h,'color','b')
    set(h,'fontsize',20)
end

set(gca,'xtick',yr)
rotateXLabels( gca(), 45 )

subplot(3,1,3)
plot(yr,squeeze(tgt_var),'--g','linewidth',3)
hold on
clear x1 x2
for iyr = 1:length(yr)
    x1(iyr) = min(tgt_var(ANA_BK(iyr,:)-1979+1));
    x2(iyr) = max(tgt_var(ANA_BK(iyr,:)-1979+1));
    xx(:,iyr) = squeeze(tgt_var(ANA_BK(iyr,:)-1979+1));
end

X = [YR_G(:)' fliplr(YR_G(:)')];
Y = [x1(:)' fliplr(x2(:)')];
fill(X,Y,'r')
plot(yr,squeeze(tgt_var),'--g','linewidth',3)
scatter(yr,squeeze(tgt_var),100,'filled','b')
set(gca,'fontsize',30)
set(gcf,'color','w')
set(gca,'xtick',yr)
rotateXLabels( gca(), 45 )
xlim([yr(1) yr(end)])
grid on
%ylabel(['Spread of Analog']);
xlabel('Years')
ylabel(['All year round' name_var(ivar)]);


figure('Position',[1 scrsz(4)/2 scrsz(3) scrsz(4)*9/10])
MEAN = mean(xx);
subplot(1,2,1)
scatter(tgt_var,MEAN,100,'filled')
temp = corrcoef(tgt_var,MEAN');
STD = std(tgt_var);
MEANc = mean(tgt_var);
hold on
plot([MEANc+STD MEANc+STD],[max(MEAN) min(MEAN)],'--r','linewidth',3)
plot([MEANc-STD MEANc-STD],[max(MEAN) min(MEAN)],'--r','linewidth',3)
plot([MEANc MEANc],[max(MEAN) min(MEAN)],'r','linewidth',3)
set(gca,'fontsize',30)
set(gcf,'color','w')
axis('square')
xlabel(['Target' name_var(ivar)])
ylabel(['Analog mean' name_var(ivar)])
title(sprintf('R=%2.2f',temp(1,2)),'fontsize',40)
grid on
subplot(1,2,2)

hold on
scatter(tgt_var,MEAN'-tgt_var,100,'filled')
MEAN = MEAN'-tgt_var;
axis('equal')
set(gca,'fontsize',30)
xlabel(['Target' name_var(ivar)])
ylabel(['Analog mean - Target' name_var(ivar)])
plot([MEANc+STD MEANc+STD],[max(MEAN) min(MEAN)],'--r','linewidth',3)
plot([MEANc-STD MEANc-STD],[max(MEAN) min(MEAN)],'--r','linewidth',3)
plot([MEANc MEANc],[max(MEAN) min(MEAN)],'r','linewidth',3)
set(gcf,'color','w')
grid on



figure('Position',[1 scrsz(4)/2 scrsz(3) scrsz(4)*9/10])
ANA = ANA_BK;
for m = 1:NUM_ANA
    hold on
    scatter(YR_G,ANA(:,m),(NUM_ANA-m+1)*100,'filled','r')
    tmp1 = squeeze(all_data(squeeze(ANA(:,m)-1978),icase+1,istn));
    tmp2 = squeeze(all_data(:,icase+1,istn));
    corrcoef(tmp1,tmp2)
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


tmp2 = squeeze(all_data(:,icase+1,istn));
for m = 1:NUM_ANA
    tmp1 = squeeze(all_data(squeeze(ANA(:,m)-1978),icase+1,istn));
    temp = corrcoef(tmp1,tmp2);
    RR(m) = temp(1,2);
    if m == ith_ana
        figure('Position',[1 scrsz(4)/2 scrsz(3) scrsz(4)*9/10])
        hold on
        scatter(tmp2,tmp1,100,'filled','k')
        P = polyfit(tmp2,tmp1,1);
        title(sprintf('R=%2.2f',RR(m)),'fontsize',30)
        xx = [min(tmp2) max(tmp2)]
        plot(xx,polyval(P,xx),'r','linewidth',3)
        xlabel('Target Cropyield')
        xlabel('Analog Cropyield')
        set(gca,'fontsize',30)
        set(gcf,'color','w')
        set(gcf,'paperpositionmode','auto')
        axis('equal')
    end
    
end

clear tmp1
mean_tmp2 = mean(tmp2);
tmp2a = tmp2 - mean_tmp2;
for m = 1:NUM_ANA
    m
    tmp1(:,m) = squeeze(all_data(squeeze(ANA(:,m)-1978),icase+1,istn));
    mean_tmp1 = mean(tmp1);
    tmp1a = tmp1 - repmat(mean_tmp1,size(tmp1,1),1);
    b = regress(tmp2a,tmp1a);
    tmp2ap = b'*tmp1a';
    temp = corrcoef(tmp2ap,tmp2a);
    RRR(m) = temp(1,2);
end
close all

figure('Position',[1 scrsz(4)/2 scrsz(3) scrsz(4)*9/10])
plot(RR,'r','linewidth',5)
hold on
plot(RRR,'k','linewidth',5)
set(gca,'fontsize',40)
set(gcf,'color','w')
legend('Single member','Ensemble mean')
xlabel('Number of analog')
ylabel('Correlation skill')
xlim([1 NUM_ANA])
set(gca,'xtick',1:NUM_ANA)
grid on
set(gcf,'color','w')
title([stn(istn) name_var(ivar) ft_case(icase)])
% pause
% close all


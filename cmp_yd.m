close all;clear;
load yield
figure
subplot(2,2,1)
hold on
plot(yrm2,dg(:,1),'g','linewidth',3)
plot(yrm2,dg(:,2),'b','linewidth',3)
plot(yrm2,dg(:,3),'r','linewidth',3)
scatter(yrm,ydm(:,1),100,'filled','g')
scatter(yr,yd*100,100,'<','k')
scatter(yr2,yd2*100,100,'*','r')
%legend('no','high','low','OB1','OB Koga','OB Finchaa')
set(gca,'fontsize',30)
xlim([2004 2014])
ylabel('kg/ha')
title('Dangishta')
subplot(2,2,2)
hold on
plot(yrm2,km(:,1),'g','linewidth',3)
plot(yrm2,km(:,2),'b','linewidth',3)
plot(yrm2,km(:,3),'r','linewidth',3)
scatter(yrm,ydm(:,2),100,'filled','g')
scatter(yr,yd*100,100,'<','k')
scatter(yr2,yd2*100,100,'*','r')
%legend('no','high','low','OB1','OB Koga','OB Finchaa')
set(gca,'fontsize',30)
xlim([2004 2014])
ylabel('kg/ha')
title('Kudmi')

subplot(2,2,3)
hold on
plot(yrm2,reem(:,1),'g','linewidth',3)
plot(yrm2,reem(:,2),'b','linewidth',3)
plot(yrm2,reem(:,3),'r','linewidth',3)
scatter(yrm,ydm(:,3),100,'filled','g')
scatter(yr,yd*100,100,'<','k')
scatter(yr2,yd2*100,100,'*','r')
%legend('no','high','low','OB1','OB Koga','OB Finchaa')
set(gca,'fontsize',30)
xlim([2004 2014])
ylabel('kg/ha')
title('Reem')

subplot(2,2,4)
hold on
plot(yrm2,gt(:,1),'g','linewidth',3)
plot(yrm2,gt(:,2),'b','linewidth',3)
plot(yrm2,gt(:,3),'r','linewidth',3)
scatter(yrm,ydm(:,4),100,'filled','g')
scatter(yr,yd*100,100,'<','k')
scatter(yr2,yd2*100,100,'*','r')
legend('no','high','low','OB1','OB Koga','OB Finchaa')
set(gca,'fontsize',30)
xlim([2004 2014])
ylabel('kg/ha')
title('Gaita')

set(gcf,'color','w')




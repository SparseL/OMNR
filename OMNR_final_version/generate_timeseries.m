clear all;
clc;
% 该函数用以产生时间序列
%--------------------------------------------------------------------------
% t0=1e-03;
% t=0:t0:(30-t0);N=10*3;
% initrr = 5*randn(1,2*N);
% [T,X]=ode45(@l_iden10,t,initrr);
% % figure(1);
% % plot(T,X(:,1:3:end));
% % saveas(gcf,['f_',num2str(initrr),'_1.fig'])
% % figure(2);
% % plot(T,X(:,2:3:end));
% % saveas(gcf,['f_',num2str(initrr),'_2.fig'])
% % figure(3);
% % plot(T,X(:,3:3:end));
% % saveas(gcf,['f_',num2str(initrr),'_3.fig'])
% figure(4);
% plot(T,X,'LineWidth',2);
% % save('origial_net/L-L.mat','X');
% % saveas(gcf,'origial_net/L-L.fig');
% 
% % save('origial_net/R-L.mat','X');
% % saveas(gcf,'origial_net/R-L.fig');
% 
% save('origial_net/L-R.mat','X');
% saveas(gcf,'origial_net/L-R.fig');

% 
% clc,clear;t0=1e-03;
% t=0:t0:(30-t0);N=100*3;
%--------------------------------------------------------------------------
name1 = ['WS';'NW';'BA';'ER'];%WS or NW or BA or ER
name2 = ['10';'20';'40'];%10or20or40
name3 = 'L-R';%L-L or R-L or L-R
name4 = 'NI';%CI or MI or NI
t0=1e-03;
t=0:t0:(30-t0);

initrr = 1;%不同的name3需要赋予不同的initrr
for i = 4
    for j = 3
        disp([num2str(i),' ',num2str(j)]);
        N=str2num(name2(j,:))*3;
        [T,X]=ode45(@(t,y)l_ideni(t,y,name1(i,:),name2(j,:),name3,name4),t,initrr*randn(1,2*N));
        figure(1);
        plot(T,X,'LineWidth',2);
        save(['WSNWBAER_timeseries/',name4,'/',name1(i,:), '_N_',name2(j,:),'_',name3,'.mat'],'X');
%         save([name1(i,:), '_N_',name2(j,:),'_',name3,'.mat'],'X');
%         saveas(gcf,['WSNWBAER_timeseries/',name1(i,:), '_N_',name2(j,:),'_',name3,'.fig']);
    end
end
clear all
clc
%使用Online Learning来优化
name1 = ['WS';'NW';'ER';'BA'];
name2 = ['10';'40'];
name3 = ['L-L';'L-R';'R-L'];
times = 2;
lambdaV = 10.^[0:-1:-2];%参数可调优
le = length(lambdaV);
beta = 1;
sr1 = zeros(24,times);
results1 = zeros(24,times);
reall1 = zeros(24,times);
sr2 = zeros(24,times);
results2 = zeros(24,times);
reall2 = zeros(24,times);
Mm = 0.2:0.2:1;
for Mmn = 1:length(Mm)
    count = 0;
    for n = 1
        for m = 1
            for l = 1
                count = count + 1;
                RA1 = [];RA2 = [];
                load(['WSNWBAER_A_B/',name1(n,:),'_N_',name2(m,:),'_',name3(l,:),'_Nm_',num2str(Mm(Mmn)),'_net1.mat']);
                load(['WSNWBAER_A_B/',name1(n,:),'_N_',name2(m,:),'_',name3(l,:),'_Nm_',num2str(Mm(Mmn)),'_net2.mat']);
                N = str2num(name2(m,:));r = 3;
                Nr = N*r;
                if strcmp(name3(l,:), 'L-L')
                    daota = zeros(r,r);daota(3,1) = 1;%inner coupling matrix L-L
                elseif strcmp(name3(l,:), 'R-L')
                    daota = eye(r,r);%inner coupling matrix R-L
                elseif strcmp(name3(l,:), 'L-R')
                    daota = zeros(r,r);daota(1,1) = 1;daota(2,2) = 1;%inner coupling matrix L-R
                end
                load(['WSNWBAER_net/1_',name1(n,:),'_N_',name2(m,:),'.mat']);
                C1 = diag(sum(G,2))-G;
                C1 = -kron(C1,daota);
                load(['WSNWBAER_net/2_',name1(n,:),'_N_',name2(m,:),'.mat']);
                C2 = diag(sum(G,2))-G;
                C2 = -kron(C2,daota);
                Aeq1 = net1.A;
                Aeq2 = net2.A;     
                for l1 = 1:1
                    for l2 = 1:1
                         for a1 = 1:1
                             lambda1 = lambdaV(l1);
                             lambda2 = lambdaV(l2);
                             alpha = lambdaV(a1);                  
                             parfor i = 1:Nr
                                  beq1 = net1.B(:,i);
                                  beq2 = net2.B(:,i);
                                  x1 = subOMNR(Aeq1,beq1,alpha,beta,lambda1,lambda2);
                                  x2 = subOMNR(Aeq2,beq2,alpha,beta,lambda1,lambda2);
                                  RA1(i,:)=x1';
                                  RA2(i,:)=x2';
                              end
                          end
                     end
                end         
                RA1 = RA1';
                erre1=round(abs(C1-RA1));
                erre1(erre1~=0)=1;
                cou1=sum(sum(erre1));
                sr1(count,Mmn) = 1-cou1/(Nr*Nr);
                results1(count,Mmn) = sum(sum(abs(C1-RA1)));
                reall1(count,Mmn) = sum(sum(abs(net1.A*C1'-net1.B)));
                RA2 = RA2';
                erre2=round(abs(C2-RA2));
                erre2(erre2~=0)=1;
                cou2=sum(sum(erre2));
                sr2(count,Mmn) = 1-cou2/(Nr*Nr);
                results2(count,Mmn) = sum(sum(abs(C2-RA2)));
                reall2(count,Mmn) = sum(sum(abs(net2.A*C2'-net2.B)));
            end
        end
    end
end
figure(1);
plot(Mm,sr1(1,:),['-.s','b'],'Linewidth',2,'MarkerSize',12)
set(gca,'FontSize',16); %改变图中坐标的大小 16表示坐标显示的大小
set(gca,'linewidth',2.0);
xlabel('R_m');ylabel('Success rate');
figure(2);
plot(Mm,sr2(1,:),['-.s','b'],'Linewidth',2,'MarkerSize',12)
set(gca,'FontSize',16); %改变图中坐标的大小 16表示坐标显示的大小
set(gca,'linewidth',2.0);
xlabel('R_m');ylabel('Success rate');
% save('results/sr1_r.mat','sr1');
% save('results/sr2_r.mat','sr2');
% save('results/results1_r.mat','results1');
% save('results/results2_r.mat','results2');
% save('results/reall1_r.mat','reall1');
% save('results/reall2_r.mat','reall2');
% save('results/sr1.mat','sr1');
% save('results/sr2.mat','sr2');
% save('results/results1.mat','results1');
% save('results/results2.mat','results2');
% save('results/reall1.mat','reall1');
% save('results/reall2.mat','reall2');

% save('origial_net/sr1.mat','sr1');
% save('origial_net/sr2.mat','sr2');
% save('origial_net/results1.mat','results1');
% save('origial_net/results2.mat','results2');
% save('origial_net/reall1.mat','reall1');
% save('origial_net/reall2.mat','reall2');
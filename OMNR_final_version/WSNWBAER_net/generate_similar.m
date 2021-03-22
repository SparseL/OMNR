clc,clear
%该函数用于产生网络
N = 40;%节点个数
K = 4;p=0.1;m0=2;m=2;
p2 = 0.05;%第二个网络重新连接的概率
pp = 0.1;%产生ER
%CI 产生两个完全重合的网络---------------------------------------------------
G = WS_generate(N, K, p);
sum(sum(G))/(size(G,1)*size(G,2))
G1 = G;
save(['CI/1_WS_N_',num2str(N),'.mat'],'G');
G2 = G;
save(['CI/2_WS_N_',num2str(N),'.mat'],'G');
error = round(abs(G1-G2));
error(error~=0) = 1;
cou = sum(sum(error));
sr(1,1) = 1-cou/(size(G1,1)*size(G1,1));

G = NW_generate(N, K, p);
sum(sum(G))/(size(G,1)*size(G,2))
G1 = G;
save(['CI/1_NW_N_',num2str(N),'.mat'],'G');
G2 = G;
save(['CI/2_NW_N_',num2str(N),'.mat'],'G');
error = round(abs(G1-G2));
error(error~=0) = 1;
cou = sum(sum(error));
sr(1,2) = 1-cou/(size(G1,1)*size(G1,1));

G = BA_generate(N, m0, m);
sum(sum(G))/(size(G,1)*size(G,2))
G1 = G;
save(['CI/1_BA_N_',num2str(N),'.mat'],'G');
G2 = G;
save(['CI/2_BA_N_',num2str(N),'.mat'],'G');
error = round(abs(G1-G2));
error(error~=0) = 1;
cou = sum(sum(error));
sr(1,3) = 1-cou/(size(G1,1)*size(G1,1));

G = ER_generate(N,pp);
sum(sum(G))/(size(G,1)*size(G,2))
G1 = G;
save(['CI/1_ER_N_',num2str(N),'.mat'],'G');
G2 = G;
save(['CI/2_ER_N_',num2str(N),'.mat'],'G');
error = round(abs(G1-G2));
error(error~=0) = 1;
cou = sum(sum(error));
sr(1,4) = 1-cou/(size(G1,1)*size(G1,1));

%MI 产生两个部分重合的网络---------------------------------------------------
G = WS_generate(N, K, p);
sum(sum(G))/(size(G,1)*size(G,2))
G1 = G;
save(['MI/1_WS_N_',num2str(N),'.mat'],'G');
for i=1:N
    for j=1:N
        if(G(i,j))
            if(rand() <= p2)
                k = round(rand()*N);
                while(~k)
                    k = round(rand()*N);
                end
                if(k ~= i && ~G(i,k) && ~G(k,i))
                    G(i,j) = 0;G(j,i) = 0;
                    G(i,k) = 1;G(k,i) = 1;
                end
            end
        end
    end
end
sum(sum(G))/(size(G,1)*size(G,2))
G2 = G;
save(['MI/2_WS_N_',num2str(N),'.mat'],'G');
error = round(abs(G1-G2));
error(error~=0) = 1;
cou = sum(sum(error));
sr(2,1) = 1-cou/(size(G1,1)*size(G1,1));


G = NW_generate(N, K, p);
sum(sum(G))/(size(G,1)*size(G,2))
G1 = G;
save(['MI/1_NW_N_',num2str(N),'.mat'],'G');
for i=1:N
    for j=1:N
        if(G(i,j))
            if(rand() <= p2)
                k = round(rand()*N);
                while(~k)
                    k = round(rand()*N);
                end
                if(k ~= i && ~G(i,k) && ~G(k,i))
                    G(i,j) = 0;G(j,i) = 0;
                    G(i,k) = 1;G(k,i) = 1;
                end
            end
        end
    end
end
sum(sum(G))/(size(G,1)*size(G,2))
G2 = G;
save(['MI/2_NW_N_',num2str(N),'.mat'],'G');
error = round(abs(G1-G2));
error(error~=0) = 1;
cou = sum(sum(error));
sr(2,2) = 1-cou/(size(G1,1)*size(G1,1));

G = BA_generate(N, m0, m);
sum(sum(G))/(size(G,1)*size(G,2))
G1 = G;
save(['MI/1_BA_N_',num2str(N),'.mat'],'G');
for i=1:N
    for j=1:N
        if(G(i,j))
            if(rand() <= p2)
                k = round(rand()*N);
                while(~k)
                    k = round(rand()*N);
                end
                if(k ~= i && ~G(i,k) && ~G(k,i))
                    G(i,j) = 0;G(j,i) = 0;
                    G(i,k) = 1;G(k,i) = 1;
                end
            end
        end
    end
end
sum(sum(G))/(size(G,1)*size(G,2))
G2 = G;
save(['MI/2_BA_N_',num2str(N),'.mat'],'G');
error = round(abs(G1-G2));
error(error~=0) = 1;
cou = sum(sum(error));
sr(2,3) = 1-cou/(size(G1,1)*size(G1,1));

G = ER_generate(N,pp);
sum(sum(G))/(size(G,1)*size(G,2))
G1 = G;
save(['MI/1_ER_N_',num2str(N),'.mat'],'G');
for i=1:N
    for j=1:N
        if(G(i,j))
            if(rand() <= p2)
                k = round(rand()*N);
                while(~k)
                    k = round(rand()*N);
                end
                if(k ~= i && ~G(i,k) && ~G(k,i))
                    G(i,j) = 0;G(j,i) = 0;
                    G(i,k) = 1;G(k,i) = 1;
                end
            end
        end
    end
end
sum(sum(G))/(size(G,1)*size(G,2))
G2 = G;
save(['MI/2_ER_N_',num2str(N),'.mat'],'G');
error = round(abs(G1-G2));
error(error~=0) = 1;
cou = sum(sum(error));
sr(2,4) = 1-cou/(size(G1,1)*size(G1,1));

%NI 随机产生两个不同的网络---------------------------------------------------
G = WS_generate(N, K, p);
sum(sum(G))/(size(G,1)*size(G,2))
G1 = G;
save(['NI/1_WS_N_',num2str(N),'.mat'],'G');
G = WS_generate(N, K, p);
sum(sum(G))/(size(G,1)*size(G,2))
G2 = G;
save(['NI/2_WS_N_',num2str(N),'.mat'],'G');
error = round(abs(G1-G2));
error(error~=0) = 1;
cou = sum(sum(error));
sr(3,1) = 1-cou/(size(G1,1)*size(G1,1));

G = NW_generate(N, K, p);
sum(sum(G))/(size(G,1)*size(G,2))
G1 = G;
save(['NI/1_NW_N_',num2str(N),'.mat'],'G');
G = NW_generate(N, K, p);
sum(sum(G))/(size(G,1)*size(G,2))
G2 = G;
save(['NI/2_NW_N_',num2str(N),'.mat'],'G');
error = round(abs(G1-G2));
error(error~=0) = 1;
cou = sum(sum(error));
sr(3,2) = 1-cou/(size(G1,1)*size(G1,1));

G = BA_generate(N, m0, m);
sum(sum(G))/(size(G,1)*size(G,2))
G1 = G;
save(['NI/1_BA_N_',num2str(N),'.mat'],'G');
G = BA_generate(N, m0, m);
sum(sum(G))/(size(G,1)*size(G,2))
G2 = G;
save(['NI/2_BA_N_',num2str(N),'.mat'],'G');
error = round(abs(G1-G2));
error(error~=0) = 1;
cou = sum(sum(error));
sr(3,3) = 1-cou/(size(G1,1)*size(G1,1));

G = ER_generate(N,pp);
sum(sum(G))/(size(G,1)*size(G,2))
G1 = G;
save(['NI/1_ER_N_',num2str(N),'.mat'],'G');
G = ER_generate(N,pp);
sum(sum(G))/(size(G,1)*size(G,2))
G2 = G;
save(['NI/2_ER_N_',num2str(N),'.mat'],'G');
error = round(abs(G1-G2));
error(error~=0) = 1;
cou = sum(sum(error));
sr(3,4) = 1-cou/(size(G1,1)*size(G1,1));

save(['sr_',num2str(N),'.mat'],'sr');
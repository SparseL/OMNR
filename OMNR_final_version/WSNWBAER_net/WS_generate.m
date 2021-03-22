%先构造一个规则网络
%每个节点与它左右相邻各K/2个节点相连（K为偶数）,边重新连接的概率为p
function [G] = WS_generate(N, K, p)
% K = 4;
% N = 100;
% p = 0.1;
G = zeros(N,N);
for i=1:N-1
    G(i,i+1) = 1;
    G(i+1,i) = 1;
end
G(1,N) = 1;G(N,1) = 1;
%构造内层网络环，即K/2个节点中的第一个
%构造之后的边
for edge=2:K/2
    for i=1:N-edge
        G(i,i+edge) = 1;%顺时针的一条边
        G(i+edge,i) = 1;
        if i > edge%逆时针的一条边
            G(i-edge,i) = 1;
            G(i,i-edge) = 1;
        else
            G(N+i-edge,i) = 1;
            G(i,N+i-edge) = 1;
        end
    end
end
%规则网络构造完成
%接下来以概率p进行网络中每条边的重新连接，条件是不产生重边和自环
for i=1:N
    for j=1:N
        if(G(i,j))
            if(rand() <= p)
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
%G中保存的是产生的无向WS网络
%写文件,利用邻接矩阵表示
% str1 = 'WS_N=';
% str2 = num2str(N);
% str3 = '_k=';
% str4 = num2str(K);
% str1 = strcat(str1,str2,str3,str4);
% fp = fopen(str1,'w');
% for i=1:N
%     for j=1:N
%         fprintf(fp,'%d',G(i,j));
%     end
%     fprintf(fp,'\n');
% end
% fclose(fp);
% fprintf('Finish of generating WS!\n');
    
                  
                    

        
    
        
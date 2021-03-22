%�ȹ���һ����������
%ÿ���ڵ������������ڸ�K/2���ڵ�������KΪż����,���������ӵĸ���Ϊp
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
%�����ڲ����绷����K/2���ڵ��еĵ�һ��
%����֮��ı�
for edge=2:K/2
    for i=1:N-edge
        G(i,i+edge) = 1;%˳ʱ���һ����
        G(i+edge,i) = 1;
        if i > edge%��ʱ���һ����
            G(i-edge,i) = 1;
            G(i,i-edge) = 1;
        else
            G(N+i-edge,i) = 1;
            G(i,N+i-edge) = 1;
        end
    end
end
%�������繹�����
%�������Ը���p����������ÿ���ߵ��������ӣ������ǲ������رߺ��Ի�
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
%G�б�����ǲ���������WS����
%д�ļ�,�����ڽӾ����ʾ
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
    
                  
                    

        
    
        
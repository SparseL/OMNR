function dy = l_iden10( t,y )
% Ë«²ãÍøÂç
    if length(y)~=60
        disp('error!');
        return;
    end
    r = 3; N=10;% the number of node
    D1 = 1;D2 = D1;%intralayer coupling strength
    D12 = 1;D21 = 1;
%     daota = zeros(r,r);daota(3,1) = 1;%inner coupling matrix L-L
%     daota = eye(r,r);%inner coupling matrix R-L
    daota = zeros(r,r);daota(1,1) = 1;daota(2,2) = 1;%inner coupling matrix L-R
    A = [0,0,1,0,0,0,1,0,0,1
         0,0,0,0,0,0,0,0,0,1
         1,0,0,0,0,0,0,0,1,0
         0,0,0,0,0,0,0,0,0,1
         0,0,0,0,0,0,0,1,0,0
         0,0,0,0,0,0,1,0,0,0
         1,0,0,0,0,1,0,0,0,1
         0,0,0,0,1,0,0,0,1,0
         0,0,1,0,0,0,0,1,0,0
         1,1,0,1,0,0,1,0,0,0];% the first net
%     load('WS_N_10_K_6_p_0.1.mat');
%     A = G1;
%     load('NW_N_10_K_6_p_0.1.mat');
%     A = G2;
%     load('EA_N_10_m0_4_m_2.mat');
%     A = G3;
    B = [0,1,1,0,1,0,1,1,1,1
         1,0,1,1,0,1,0,1,0,1
         1,1,0,1,0,0,0,0,0,0
         0,1,1,0,0,1,0,0,1,0
         1,0,0,0,0,0,1,1,0,0
         0,1,0,1,0,0,1,1,0,0
         1,0,0,0,1,1,0,1,0,0
         1,1,0,0,1,1,1,0,0,0
         1,0,0,1,0,0,0,0,0,0
         1,1,0,0,0,0,0,0,0,0];% the second net
     L1 = diag(sum(A,2))-A;% the Laplacian matrix of A
     L2 = diag(sum(B,2))-B;% the Laplacian matrix of B
     X = y;
     F = X;
     X1 = X(1:r*N);F1 = F(1:r*N);
     for i = 1:N
         F1((r*(i-1)+1):(i*r)) = lorenz(X1((r*(i-1)+1):(i*r)));
%          F1((r*(i-1)+1):(i*r)) = rossler(X1((r*(i-1)+1):(i*r)));
     end
     X2 = X(r*N+1:2*r*N);F2 = F(r*N+1:2*r*N);
     for i = 1:N
%          F2((r*(i-1)+1):(i*r)) = lorenz(X2((r*(i-1)+1):(i*r)));
         F2((r*(i-1)+1):(i*r)) = rossler(X2((r*(i-1)+1):(i*r)));
     end
     F = [F1;F2];
     L = [D1*L1+D12*eye(N),-D12*eye(N);-D21*eye(N),D2*L2+D21*eye(N)];
     X = F - kron(L,daota)*X;
     dy = X;
%      X11 = F1 - kron((D1*L1+D12*eye(N)),daota)*X1 + kron(D12*eye(N),daota)*X2;
%      X22 = F2 - kron((D2*L2+D21*eye(N)),daota)*X2 + kron(D21*eye(N),daota)*X1;
%      dy = [X11;X22];
    
end


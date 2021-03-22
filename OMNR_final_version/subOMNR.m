function w = subOMNR(A,y,alpha,beta,lambda1,lambda2)
[T,d] = size(A);z = zeros(d,1);
n = zeros(d,1);w = zeros(d,1);epochs = 1;

while (epochs < 200)
    for i = 1:T
        xt = A(i,:);yt = y(i);
        I = find(xt~=0);
        for j = 1:length(I)
            a = I(j);
            if abs(z(a)) <= lambda1
                w(a,1) = 0;
            else
                w(a,1) = -1/((beta + sqrt(n(a)))/alpha + lambda2)*(z(a) - sign(z(a))*lambda1);
            end   
        end
        % update g, n, z
        for j = 1:length(I)
            a = I(j);
            g = (xt*w-yt)*xt(a);
            sigma = (sqrt(n(a) + g*g) -sqrt(n(a)))/alpha;
            z(a) = z(a)+g-sigma*w(a);
            n(a) = n(a)+g*g;
        end
    end
    epochs = epochs+1; 
end
end

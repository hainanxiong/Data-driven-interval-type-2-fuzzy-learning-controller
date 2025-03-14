function [tao] = compute_tao(vl,vr,data,G)
    v2=(vl+vr)/2;
    %U为隶属度矩阵，10*414
    [U,~]=Utility.cal_single_U(data,v2,2,size(v2,1));
    %rho为10*414
    rho=U./sum(U);
    rho=rho';
    
    %LL为10，即规则数
    LL=size(v2,1);
    %N为414，即样本数
    N=size(data,1);
    x = [data ones(size(data,1), 1)];
    M=size(x,2);
    %X为系数矩阵，维度为414*70
    X=zeros(N,LL*M);
    for loop1 = 1:LL
        for loop2 =1:N
            X(loop2,((loop1-1)*M+1):loop1*M)=rho(loop2,loop1)*x(loop2,:);
        end
    end
    tao=X*G; % 预测最终的结果
end
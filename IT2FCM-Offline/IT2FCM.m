classdef IT2FCM
    methods(Static)
function [ result,vl,vr,G ] = Method( x,vs,yt,dis,r,r1,r2)
    import IT2FCM.*;
    v1=vs; 
    e=0.01;
    l=1;L=100; 
    G=zeros((size(vs,2)+1)*size(vs,1),1);
    while(l<=L) 
        u1=Utility.MembershipMatrix(v1,x,dis,r1); 
        u2=Utility.MembershipMatrix(v1,x,dis,r2);
      
        ulower=min(u1,u2);  
        uupper=max(u1,u2);  
        vl=KMCL(x,ulower,uupper,dis,r); % 36
        vr=KMCR(x,ulower,uupper,dis,r); % 37
        v2=(vl+vr)/2; % 38
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [U,~]=Utility.cal_U(x,v2,r,size(vs,1));
        rho=U./sum(U);
        rho=rho';
        d=sum(sum(abs(v1-v2)));
        if (d>e)
            v1=v2;
            l=l+1;
        else
            break;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    LL=size(v2,1);
    N=size(x,1);
    x = [x ones(size(x,1), 1)];
    M=size(x,2);
    X=zeros(N,LL*M);
    for loop1 = 1:LL
        for loop2 =1:N
            X(loop2,((loop1-1)*M+1):loop1*M)=rho(loop2,loop1)*x(loop2,:);
        end
    end
    G=inv(X'*X)*X'*yt;
    result=X*G; 
end    
end
end


classdef Utility
    methods(Static)
            
        function distanceMatrix = DistanceMatrix(center,x,distance) 
            distanceMatrix = pdist2(x,center,distance)'; 
        end
        
        function membershipMatrix = MembershipMatrix1(distanceMatrix,r)
            [c,n]=size(distanceMatrix);  
            membershipMatrix=zeros(c,n);
            p=2/(r-1); 
            
            [row2,col2]=find(isnan(distanceMatrix));
            zs2 = size(row2);
            for j=1:zs2
                distanceMatrix(row2(j),col2(j))=1;
            end
            [row,col]=find(distanceMatrix==0);            
            dp=1./(distanceMatrix.^p); 
            dsum=sum(dp);  
            for j=1:n  
                membershipMatrix(:,j)=dp(:,j)./dsum(j);
            end
            zs = size(row);            
            for j=1:zs
                membershipMatrix(:,col(j)) = zeros(c,1);
                membershipMatrix(row(j),col(j))=1;
            end
        end
        
        function center = GetCenter(x,u,r)
            [n,m]=size(x);
            ur=u.^r;
            center = (ur*x)./(ur*ones(n,m));   
        end
      
        function membershipMatrix = MembershipMatrix(center,x,distance,r)
           distanceMatrix=Utility.DistanceMatrix(center,x,distance);
           membershipMatrix=Utility.MembershipMatrix1(distanceMatrix,r);
        end
        
        function [U,dist] = cal_U(X,V,m,c)
            dist = zeros(length(X),c);
            U = zeros(c,length(X));
            % Calculating distance of jth point from ith center
            for i=1:c
                for j=1:length(X)
                    dist(j,i) = norm( X(j,:) - V(i,:) ); 
                end
            end
            for i=1:c
                for j=1:length(X)
                    if( dist(j,i) == 0 ) 
                        U(i,j) = 1;      
                        continue;
                    end

                    temp = 0;
                    done = 0;
                    for k=1:c
                        if( dist(j,k) == 0 )
                            U(i,j) = 0;
                            done = 1;
                            break;
                        end

                        temp = temp + ( dist( j,i) / dist(j,k) )^ (2 /(m-1));
                    end

                    if ( ~done == 1 )
                        U(i,j) = 1/temp;
                    end
                end
            end
        end
        
        function [U,dist] = cal_single_U(X,V,m,c)
            dist = zeros(size(X,1),c);
            U = zeros(c,size(X,1));
            % Calculating distance of jth point from ith center
            for i=1:c
                for j=1:size(X,1)
                    dist(j,i) = norm( X(j,:) - V(i,:) ); 
                end
            end
            for i=1:c
                for j=1:size(X,1)
                    if( dist(j,i) == 0 )
                        U(i,j) = 1;    
                        continue;
                    end

                    temp = 0;
                    done = 0;
                    for k=1:c
                        if( dist(j,k) == 0 )
                            U(i,j) = 0;
                            done = 1;
                            break;
                        end

                        temp = temp + ( dist( j,i) / dist(j,k) )^ (2 /(m-1));
                    end

                    if ( ~done == 1 )
                        U(i,j) = 1/temp;
                    end
                end
            end
        end
        
    end    
end


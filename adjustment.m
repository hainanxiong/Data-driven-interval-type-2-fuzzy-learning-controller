function [delta_u,e,edt] = adjustment(yd,y)
   alpha = 0.05;
   dt = 0.001;
   e = sum(yd - y); 
   edt = sum(yd * dt - y * dt); 
   delta_u = alpha * output(e,edt);
end


function [muu] = mu(x,k) 
    a0 = -inf; a1 = -1; a2 = 0; a3 = 1; a4 = inf;
    if k == 1  
        if x < a0
            muu = 0;
        elseif x >= a0 && x <= a1
            muu = (x - a0)/(a1 - a0);
        elseif x > a1 && x <= a2
            muu = (a2 - x)/(a2 - a1);
        elseif x > a2
            muu = 0;
        end
    elseif k == 2 
        if x < a1
            muu = 0;
        elseif x >= a1 && x <= a2
            muu = (x - a1)/(a2 - a1);
        elseif x > a2 && x <= a3
            muu = (a3 - x)/(a3 - a2);
        elseif x > a3
            muu = 0;
        end
    else  
        if x < a2
            muu = 0;
        elseif x >= a2 && x <= a3
            muu = (x - a2)/(a3 - a2);
        elseif x > a3 && x <= a4
            muu = (a4 - x)/(a4 - a3);
        elseif x > a4
            muu = 0;
        end
    end
end

function [y] = output(x1,x2)
    muu1 = mu(x1,1);
    muu2 = mu(x2,2);
    muu3 = - muu1;
    mu_a11 = muu1; mu_a12 = mu_a11; mu_a13 = mu_a12;
    mu_a14 = muu2; mu_a15 = mu_a14; mu_a16 = mu_a15; 
    mu_a17 = muu3; mu_a18 = mu_a17; mu_a19 = mu_a18;
    
    mu_a21 = muu1; mu_a24 = mu_a21; mu_a27 = mu_a24;
    mu_a22 = muu2; mu_a25 = mu_a22; mu_a28 = mu_a25; 
    mu_a23 = muu3; mu_a26 = mu_a23; mu_a29 = mu_a26;
    
    C1 = -1;   C9 = C1;
    C2 = 1;    C8 = C2;
    C3 = 0.5;  C7 = C3;
    C4 = -0.5; C6 = C4;
    C5 = 0;
    p = mu_a11 * mu_a21 * C1 + mu_a12 * mu_a22 * C2 + mu_a13 * mu_a23 * C3 + mu_a14 * mu_a24 * C4 ...
        + mu_a15 * mu_a25 * C5 + mu_a16 * mu_a26 * C6 + mu_a17 * mu_a27 *C7 ...
        + mu_a18 * mu_a28 * C8  + mu_a19 * mu_a29 * C9;  % 分子部分
    q = mu_a11 * mu_a21 + mu_a12 * mu_a22 + mu_a13 * mu_a23  + mu_a14 * mu_a24 + mu_a15 * mu_a25 ...
        + mu_a16 * mu_a26 + mu_a17 * mu_a27 + mu_a18 * mu_a28  + mu_a19 * mu_a29;  % 分母部分
    y = p/q;
end
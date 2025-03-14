function [u_c] = compensation(yd,y)
   pii = 0.01;
   dt = 0.001;
   kappa = 0.1;
   vartheta = 0.1;
   e = sum(yd - y); 
   edt = sum(yd * dt - y * dt);  
   varphi = edt + kappa * e;
   u_c = pii * sat(varphi,vartheta);
end

function [temp] = sat(varphi,vartheta)
   if abs(varphi) > vartheta
      temp = sgn(varphi);
   else
      temp = varphi/vartheta;
   end
end

function [temp] = sgn(varphi)
   if varphi > 0
      temp = 1;
   elseif varphi == 0
       temp = 1;
   else
       temp = -1;
   end
end
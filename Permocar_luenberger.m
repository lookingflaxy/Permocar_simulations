% Permocar luenberger

A1 = (-mc*d)/(m + 2*Iw/(R^2));
A2 = (1/(R*(m + 2*Iw/(R^2))));
A3 = (1/(R*(m + 2*Iw/(R^2))));
A4 = (mc*d)/(I + (2*Iw*L^2)/(R^2));
A5 = L/(R*((I + (2*Iw*L^2)/(R^2))));
A6 = -L/(R*((I + (2*Iw*L^2)/(R^2))));

%Linearizing around v=0 and w=0     
% f = [A2*tauR + A3*tauL;
%         A5*tauR + A6*tauL;
%             K1*tauR + K2*(L*w + v);
%                  K3*tauL + K4*(v - L*w)];

% g = [0 0;
%         0 0;
%           B1 0;
%             0 B2];

   
Ac =[0 A1 A2 A3;
        0 A4 A5 A6;
            K2 K2*L K1 0;
                K4 -K4*L 0 K3];
 Bc = [0 0;
        0 0;
          B1 0;
            0 B2];
 
 Cc = [1 0 0 0;
        0 1 0 0];
 Dc = [0 0;
        0 0];
    
 SYSc = ss(Ac, Bc, Cc, Dc);  
 
 SYSd = c2d(SYSc,Ts);
 Ad = SYSd.A;
 Bd = SYSd.B;
 Cd = SYSd.C;
 Dd = SYSd.D;
 obs = rank(obsv(SYSc));
 
ksi = 1/sqrt(2);
Trsv = 1/6;
wnv = 3.8/(ksi*Trsv);

 tfv = tf([1],[1 2*ksi*wnv wnv^2]);
 [Zv Pv Kv] = tf2zpk([1],[1 2*ksi*wnv wnv^2]); 
 
 
ksi = 1/sqrt(2);
Trsw = 1/6;
wnw = 3.8/(ksi*Trsw);

 tfw = tf([1],[1 2*ksi*wnw wnw^2]);
 [Zw Pw Kw] = tf2zpk([1],[1 2*ksi*wnw wnw^2]); 
 
 Pvd = exp(Pv*Ts);
 
 Pwd = exp(Pw*Ts);
 
 Lk = place(SYSd.A',SYSd.C',[Pvd;Pwd])';
 
 
 
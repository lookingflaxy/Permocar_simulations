%Permocar with torque

syms I Iw m mc d L R v w vdot wdot tauR tauL uR uL K Kr vr wr zbar K1 K2 K3 K4 B1 B2 K11 K12 K13 K14 K21 K22 K23 K24 K31 K32 K33 K34 K41 K42 K43 K44 ....
        Kr11 Kr12 Kr13 Kr14 Kr21 Kr22 Kr23 Kr24 Kr31 Kr32 Kr33 Kr34 Kr41 Kr42 Kr43 Kr44;

x = [v;
        w;
            tauR;
                tauL];
u = [uR;   
        uL];    

r = [vr;
        wr];    

K = [K11 K12 K13 K14;
        K21 K22 K23 K24];

            
Kr = [Kr11 Kr12;
        Kr21 Kr22];

          
A1 = (-mc*d)/(m + 2*Iw/(R^2));
A2 = (1/(R*(m + 2*Iw/(R^2))));
A3 = (1/(R*(m + 2*Iw/(R^2))));
A4 = (-mc*d)/(I + (2*Iw*L^2)/(R^2));
A5 = L/(R*((I + (2*Iw*L^2)/(R^2))));
A6 = -L/(R*((I + (2*Iw*L^2)/(R^2))));

%     
f = [A1*w^2 + A2*tauR + A3*tauL;       
         A4*w*v + A5*tauR + A6*tauL;
            K1*tauR + K2*(L*w + v);
                 K3*tauL + K4*(v - L*w)];

g = [0 0;
         0 0;
            B1 0;
               0 B2];
            

    
xdot = f + g*u;  

%C = eye(4);
C = [1 0 0 0; 0 1 0 0];
z1 = C*x;



Lfh = jacobian(z1,x)*f; 
Lgh =  jacobian(z1,x)*g;
z2 = Lfh;

Lffh = jacobian(Lfh,x)*f; 
Lfgh = jacobian(Lfh,x)*g;

alpha = Lffh;
beta = Lfgh;

zbar = [z1(1);
            z2(1);
                z1(2);
                    z2(2)];
                

uK = simplify(inv(beta)*(-K*zbar + Kr*r - alpha));

%%
AA = [0 1 0 0;
        0 0 0 0;
            0 0 0 1;
                0 0 0 0];
BB = [0 0;
        1 0;
            0 0;
                0 1];
CC = [1 0 0 0;
        0 0 1 0];



syms s ;

ksi = 1;
Trsv = 4;
wnv = 3.8/(ksi*Trsv);

ksi = 1;
Trsw = 4;
wnw = 3.8/(ksi*Trsw);


LL = [wnv^2 2*ksi*wnv 0 0;
        0 0 wnw^2 2*ksi*wnw];
    
LLr = [wnv^2 0;
        0 wnw^2];    

SYSFL = CC*inv(eye(4)*s -(AA-BB*LL))*BB*LLr;
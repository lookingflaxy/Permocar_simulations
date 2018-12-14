% System setup


Ts = 0.05;
Ts_kf = 0.01;

mc = 100;
mw = 7.5;
m = mc + 2*mw;

R = 0.165;
L = 0.285;
d = 0.25;

Ic = (1/2)*mc*d^2;
Im = mw*(R^2);
Iw = mw*L^2;

I = Ic + mc*d^2 + 2*mw*L^2 + 2*Im;

V1 = 1/(m+(2*Iw/R^2));
V2 = -mc*d;
VT = 1/R;

W1 = 1/(I + ((2*Iw*L^2)/R^2));
W2 = V2;
WT = L/R;


k1 = 0.18;
k2 = -5.9;
b1 = 6.7;
k3 = 0.22;
k4 = -4.2;
b2 = 5.5;
run('d2c_motors.m')
run('Permocar_luenberger.m')

%% Feedback linearization

K13 = 0;
K14 = 0;
K21 = 0;
K22 = 0;

Kr12 = 0;
Kr21 = 0;

ksi = 1;
Trsv = 4;
wnv = 3.8/(ksi*Trsv);

ksi = 1;
Trsw = 4;
wnw = 3.8/(ksi*Trsw);
% 
% LL = [wnv^2 2*ksi*wnv 0 0;
%         0 0 wnw^2 2*ksi*wnw]

K11 = wnv^2;
K12 = 2*ksi*wnv;
K23 = wnw^2;
K24 = 2*ksi*wnw;

Kr11 = wnv^2;
Kr22 = wnw^2;

syms  v w tauR tauL vr wr

uK = [- ((m*R^2 + 2*Iw)*(K11*v - Kr11*vr + K13*w - Kr12*wr + (R*(K1*tauR + K2*v + K2*L*w))/(m*R^2 + 2*Iw) + (R*(K3*tauL + K4*v - K4*L*w))/(m*R^2 + 2*Iw) + (K14*R*(L*tauR - L*tauL + R*d*mc*v*w))/(2*Iw*L^2 + I*R^2) + (K12*R*(- R*d*mc*w^2 + tauL + tauR))/(m*R^2 + 2*Iw) - (2*R^3*d*mc*w*(L*tauR - L*tauL + R*d*mc*v*w))/((2*Iw*L^2 + I*R^2)*(m*R^2 + 2*Iw))))/(2*B1*R) - ((2*Iw*L^2 + I*R^2)*(K21*v - Kr21*vr + K23*w - Kr22*wr + (L*R*(K1*tauR + K2*v + K2*L*w))/(2*Iw*L^2 + I*R^2) - (L*R*(K3*tauL + K4*v - K4*L*w))/(2*Iw*L^2 + I*R^2) + (K24*R*(L*tauR - L*tauL + R*d*mc*v*w))/(2*Iw*L^2 + I*R^2) + (K22*R*(- R*d*mc*w^2 + tauL + tauR))/(m*R^2 + 2*Iw) + (R^3*d*mc*v*(L*tauR - L*tauL + R*d*mc*v*w))/(2*Iw*L^2 + I*R^2)^2 + (R^3*d*mc*w*(- R*d*mc*w^2 + tauL + tauR))/((2*Iw*L^2 + I*R^2)*(m*R^2 + 2*Iw))))/(2*B1*L*R);
   ((2*Iw*L^2 + I*R^2)*(K21*v - Kr21*vr + K23*w - Kr22*wr + (L*R*(K1*tauR + K2*v + K2*L*w))/(2*Iw*L^2 + I*R^2) - (L*R*(K3*tauL + K4*v - K4*L*w))/(2*Iw*L^2 + I*R^2) + (K24*R*(L*tauR - L*tauL + R*d*mc*v*w))/(2*Iw*L^2 + I*R^2) + (K22*R*(- R*d*mc*w^2 + tauL + tauR))/(m*R^2 + 2*Iw) + (R^3*d*mc*v*(L*tauR - L*tauL + R*d*mc*v*w))/(2*Iw*L^2 + I*R^2)^2 + (R^3*d*mc*w*(- R*d*mc*w^2 + tauL + tauR))/((2*Iw*L^2 + I*R^2)*(m*R^2 + 2*Iw))))/(2*B2*L*R) - ((m*R^2 + 2*Iw)*(K11*v - Kr11*vr + K13*w - Kr12*wr + (R*(K1*tauR + K2*v + K2*L*w))/(m*R^2 + 2*Iw) + (R*(K3*tauL + K4*v - K4*L*w))/(m*R^2 + 2*Iw) + (K14*R*(L*tauR - L*tauL + R*d*mc*v*w))/(2*Iw*L^2 + I*R^2) + (K12*R*(- R*d*mc*w^2 + tauL + tauR))/(m*R^2 + 2*Iw) - (2*R^3*d*mc*w*(L*tauR - L*tauL + R*d*mc*v*w))/((2*Iw*L^2 + I*R^2)*(m*R^2 + 2*Iw))))/(2*B2*R)];

vpa(simplify(uK),3)


% syms Kr11 K11 Kr22 K22 vr wr v w 
% 
% uK = [((m*R^2 + 2*Iw)*(Kr11*vr - K11*v - K12*w + Kr12*wr + (R^2*d*mc*w^2)/(m*R^2 + 2*Iw)))/(2*R) - ((2*Iw*L^2 + I*R^2)*(K21*v - Kr21*vr + K22*w - Kr22*wr + (R^2*d*mc*v*w)/(2*Iw*L^2 + I*R^2)))/(2*L*R)
%  ((m*R^2 + 2*Iw)*(Kr11*vr - K11*v - K12*w + Kr12*wr + (R^2*d*mc*w^2)/(m*R^2 + 2*Iw)))/(2*R) + ((2*Iw*L^2 + I*R^2)*(K21*v - Kr21*vr + K22*w - Kr22*wr + (R^2*d*mc*v*w)/(2*Iw*L^2 + I*R^2)))/(2*L*R)];
% 
% vpa(uK/(R*m),4);


%/Rm m = 100
%0.6946*Kr11*vr - 0.6946*K11*v - 0.2233*K22*w + 0.2233*Kr22*wr + 0.3814*v*w - 0.1087*w^2
%0.6946*Kr11*vr - 0.6946*K11*v + 0.2233*K22*w - 0.2233*Kr22*wr - 0.3814*v*w - 0.1087*w^2

%/Rmc
 %0.7988*Kr11*vr - 0.7988*K11*v - 0.2568*K22*w + 0.2568*Kr22*wr + 0.4386*v*w - 0.125*w^2
 %0.7988*Kr11*vr - 0.7988*K11*v + 0.2568*K22*w - 0.2568*Kr22*wr - 0.4386*v*w - 0.125*w^2
 
 % /Rmc m = 95
 %0.9193*Kr11*vr - 0.9193*K11*v - 0.294*K22*w + 0.294*Kr22*wr + 0.4386*v*w - 0.125*w^2
 %0.9193*Kr11*vr - 0.9193*K11*v + 0.294*K22*w - 0.294*Kr22*wr - 0.4386*v*w - 0.125*w^2
 
 
 % /Rmc m = 85 bäst
 %1.203*Kr11*vr - 1.203*K11*v - 0.3817*K22*w + 0.3817*Kr22*wr + 0.4386*v*w - 0.125*w^2
 %1.203*Kr11*vr - 1.203*K11*v + 0.3817*K22*w - 0.3817*Kr22*wr - 0.4386*v*w - 0.125*w^2
 
 %/Rm m = 85
  %0.8891*Kr11*vr - 0.8891*K11*v - 0.2821*K22*w + 0.2821*Kr22*wr + 0.3242*v*w - 0.09239*w^2
 %0.8891*Kr11*vr - 0.8891*K11*v + 0.2821*K22*w - 0.2821*Kr22*wr - 0.3242*v*w - 0.09239*w^2

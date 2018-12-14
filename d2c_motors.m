% d2c motors


Ar = [k1];
Br = [k2,b1];
Cr = [1];
Dr = [0,0];    
    
SYSdr = ss(Ar, Br, Cr, Dr,Ts);
SYScr = d2c(SYSdr)


Al = [k3];
Bl = [k4,b2];
Cl = [1];
Dl = [0,0];    
    
SYSdl = ss(Al, Bl, Cl, Dl,Ts);
SYScl = d2c(SYSdl)

K1 = SYScr.A(1,1);
K2 = SYScr.B(1,1);
B1 = SYScr.B(1,2);
K3 = SYScl.A(1,1);
K4 = SYScl.B(1,1);
B2 = SYScl.B(1,2);



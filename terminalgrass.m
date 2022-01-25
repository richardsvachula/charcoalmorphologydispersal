function [vta]=terminalgrass(l,w,d)
%density should range from 0.4 to 0.6 g/cc
%diameter is input in microns
%d=0:10:500;

density=0.45 + 0.1.*rand(1,1);
%density=0.55 + 0.1.*rand(1,1);

%dcm=d/10000.;
rho=0.00127;
mu=0.00018;
gravity=981.;

D1=l/2;
D2=w/2;
D3=d/2;
p1=D1/(D1+D2+D3);
p2=D2/(D1+D2+D3);
p3=D3/(D1+D2+D3);
Hr=-(p1*log(p1)+p2*log(p2)+p3*log(p3))/1.0986;
V=(4/3)*pi*D1*D2*D3

nomdiam=(6*V/pi)^(1/3);

v=(((density-rho)*gravity*nomdiam*nomdiam)/(18*mu))/100;
vta=v*(Hr-0.5833)/0.4167;

end

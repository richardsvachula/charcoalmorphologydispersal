function [l, w, d]=shaper(diameter)

dcm=diameter/10000.;

D1=dcm/2;
D2=0+D1*rand(1,1);
D3=0+D2*rand(1,1);

%grass not falling fix -- start
while (-((D1/(D1+D2+D3))*log(D1/(D1+D2+D3))+(D2/(D1+D2+D3))*log(D2/(D1+D2+D3))+(D3/(D1+D2+D3))*log(D3/(D1+D2+D3)))/1.0986)<0.5833
    D2=0+D1*rand(1,1);
    D3=0+D2*rand(1,1);
end
%grass not falling fix --end

l=2*D1
w=2*D2
d=2*D3



end

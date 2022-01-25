count=10000;
sieve=sqrt(((125/10000)^2)+((125/10000)^2));
%sieve=125/10000

diam=[];
grassxdistance=[];
grassydistance=[];
woodxdistance=[];
woodydistance=[];
grass=[];
wood=[];
vtermsgrass=[];
Hwood=[];
Hgrass=[];

while length(grass)<count;
    diameter=50+1000*rand(1,1);
    [l,w,d]=shaper(diameter);
    if l>sieve
        if 3.5<(l/w)
            grass=[grass;[l w d] ];
        end
    end
end

while length(wood)<count;
    diameter=50+1000*rand(1,1);
    [l,w,d]=shaper(diameter);
    if l>sieve
        if (l/w)<2.5
            wood=[wood; [l w d]];
        end
    end
end

for k=1:length(wood);
    %q=30*10^6;
    q=randi([0 100*10^6]);   
    u=0+5.*rand(1,1);
    v=0+5.*rand(1,1);
    tot=sqrt(u*u+v*v);
    %v=(rand(1,1)-1)
    %u=5.
    if q<(1.4*10^6)
        H=(0.01*(q.^(0.75)))/tot;
    elseif q>1.4*10^6
        H=(0.085*(q.^(0.6)))/tot;
    end
    
    Hwood=[Hwood H];
    
    vnegator=randi([0 1]);
    if vnegator==1
        v=-v;
    end
    
    l=wood(k,1);w=wood(k,2);d=wood(k,3);

    vterm=terminalwood(l,w,d);
    
    falltime=H/vterm;
    xdist=u*falltime;
    ydist=v*falltime;
    woodxdistance=[woodxdistance xdist];
    woodydistance=[woodydistance ydist];
end

for c=1:length(grass);
    %q=30*10^6;
    q=randi([0 100*10^6]);
    %q=randi([0 20*10^6]); 
    u=0+5.*rand(1,1);
    v=0+5.*rand(1,1);
    tot=sqrt(u*u+v*v);
    %v=(rand(1,1)-1)
    %u=5.
    if q<(1.4*10^6)
        H=(0.01*(q.^(0.75)))/tot;
    elseif q>1.4*10^6
        H=(0.085*(q.^(0.6)))/tot;
    end
    
    Hgrass=[Hgrass H];
    
    vnegator=randi([0 1]);
    if vnegator==1
        v=-v;
    end
    
    l=grass(c,1);w=grass(c,2);d=grass(c,3);
    vterm=terminalgrass(l,w,d);
    
    falltime=H/vterm;
    xdist=u*falltime;
    ydist=v*falltime;
    grassxdistance=[grassxdistance xdist];
    grassydistance=[grassydistance ydist];
end

woodxy=[(woodxdistance/1000)' (woodydistance/1000)'];
edges={(linspace(0,12.2,61)),(linspace(-15.2,15,151))};
[woodvalues, woodcenters]=hist3(woodxy, edges);

grassxy=[(grassxdistance/1000)' (grassydistance/1000)'];
edges={(linspace(0,12.2,61)),(linspace(-15.2,15,151))};
[grassvalues, grasscenters]=hist3(grassxy, edges);

woodxy2=[(woodxdistance/1000)' (woodydistance/1000)'];
edges2={(linspace(0,50,51)),(linspace(-50,50,101))};
[woodvalues2, woodcenters2]=hist3(woodxy2, edges2);

grassxy2=[(grassxdistance/1000)' (grassydistance/1000)'];
edges2={(linspace(0,51,52)),(linspace(-51,51,103))};
[grassvalues2, grasscenters2]=hist3(grassxy2, edges2);

figure
subplot(1,2,1)
imagesc(woodcenters2{:}, woodvalues2');
cb1=colorbar;
caxis([0.1, 1000]); 
axis xy;
cb1.Label.String = 'Wood Particle Deposition Density (#/km^{2})';
set(gca,'ColorScale','log')
xlabel('Distance traveled (km)');
ylabel('Distance traveled (km)');
xlim([0 50]);
ylim([-50 50])

subplot(1,2,2)
imagesc(grasscenters2{:}, grassvalues2');
cb2=colorbar;
caxis([0.1, 1000]); 
axis xy;
cb2.Label.String = 'Grass Particle Deposition Density (#/km^{2})';
set(gca,'ColorScale','log')
xlabel('Distance traveled (km)');
ylabel('Distance traveled (km)');
xlim([0 50]);
ylim([-50 50]);

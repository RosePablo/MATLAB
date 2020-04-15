G=6.7*10e-11
M=5.97*10e24
R=6.37*10e6
global gravity; gravity=((G*M)/(R^2));
global mass;
mass=1.0;
posvel0 = [0;450]
tfinal1=186.8/gravity
inenergy=0.5*mass*posvel0(2)^2 + mass*gravity*posvel0(1)
options=odeset('RelTol',1e-8);
[t,posvel]=ode45('projectilewe2',[0, tfinal1], posvel0, options);
top=length(t);
x=t
y=posvel(:,1)
figure
plot(x,y)
title('Altitude-time plot for a vertically-fired flare with new scaleheight value.')
xlabel('Time S')
ylabel('Altitude M');
finenergy=0.5*mass*posvel(top,2).^2 + mass*gravity*posvel(top,1)
accuracy=((finenergy-inenergy)/inenergy)
posvel(top,1)

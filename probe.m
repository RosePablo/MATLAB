G=6.67e-11;
au=1.496e11
massrad=planetparameters;
tfinal=600000000;
options=odeset('RelTol',1e-8);
figure
apo = 2.8*au;
per = au;
a = (apo + per) /2;
r = apo;
v =(sqrt(G*massrad(1)*(2/r - 1/a)))
hold on
posvel0 = [au;0;0;36.15e3];
[t,posvel]=ode45('probeeqns',[0, tfinal], posvel0, options);
plot(posvel(:,1),posvel(:,2))
axis equal
q=(0:0.01:2)*pi;
p2=sqrt(((4*pi^2)/(G*massrad(1))*a^3))/2
x2=au*cos(q);
y2=au*sin(q);
x3=apo*cos(q);
y3=apo*sin(q);
x_Sun=6.9463410^9*cos(q);
y_Sun=6.9463410^9*sin(q);
plot(x2,y2,x3,y3)
plot(x_Sun,y_Sun)
title('Atlas of Trajectories')
xlabel('x(m)')
ylabel('y(m)')
hold off
top=length(t);
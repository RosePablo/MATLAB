tfinal=6000;
options=odeset('RelTol',1e-8);
posvel0 = [10;20;30;100];
[t,posvel]=ode45('probeeqns',[0, tfinal], posvel0, options);
plot(t,posvel(4))
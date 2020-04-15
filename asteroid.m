I = [111.1282,688.6392,761.3437]
angvel0 = [0.01,0.01,1];
tfinal=1000
inenergy=0.5*(I(1)*angvel0(1)^2+I(2)*angvel0(2)^2+I(3)*angvel0(3)^2);
tspan=[0 tfinal];
options=odeset('AbsTol',1e-12,'RelTol',1e-8)
[t,angvel]=ode15s(@eulereqns,tspan,angvel0,options);
figure
plot(angvel(:,3),angvel(:,2));
title('Y angular against Z angular [0.01,0.01,1]')
figure
plot(angvel(:,1),angvel(:,3));
title('Z angular against X angular [0.01,0.01,1]')
figure
plot(angvel(:,3),angvel(:,1));
title('X angular against Z angular [0.01,0.01,1]')
finenergy=0.5*(I(1)*angvel(tfinal,1)^2+I(2)*angvel(tfinal,2)^2+I(3)*angvel(tfinal,3)^2);
accuracy=abs((finenergy-inenergy)/inenergy);
disp(accuracy)
figure
plot3(angvel(:,3),angvel(:,2),angvel(:,1));
title('3dPlot of angular velocity [0.01,0.01,1]')
grid on

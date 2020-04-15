x=[0:12000]
y=(atmosphere(x)/1.2)*100
figure
plot(x,y)
title('Density of air as a function of Altitude.')
xlabel('Altitude M')
ylabel('Density of Air (%sea-level)')
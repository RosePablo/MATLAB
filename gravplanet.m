function f=gravplanet(positveloc)
mr=planetparameters;
G=6.67e-11;
rad=sqrt(positveloc(1).^2+positveloc(2).^2);
f=[-G*mr(1)*positveloc(1)/rad^3, -G*mr(1)*positveloc(2)/rad^3];
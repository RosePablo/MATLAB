function posveldot=projectilewe3(t,posvel2)
cd=1.0;
A=0.01;
mass=1.0;
Density=atmosphere2(posvel2(1));
gravity=gravfield(posvel2(1));
posveldot=[posvel2(2);-gravity-0.5*cd*A*Density*(posvel2(2).^2)^0.5*posvel2(2)/mass];
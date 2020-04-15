function posveldot=projectilewe2(t,posvel)
cd=1.0;
A=0.01;
mass=1.0;
Density=atmosphere(posvel(1));
gravity=gravfield(posvel(1));
posveldot=[posvel(2);-gravity-0.5*cd*A*Density*(posvel(2).^2)^0.5*posvel(2)/mass];
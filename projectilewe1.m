function posveldot=projectile(t,posvel)
gravity=gravfield(posvel(1));
% posveldot is the array that gives you the rate of change 
% of position and velocity coordinates. Think of ‘dot’ as like the dot you sometimes use for differentiation with respect to time.
posveldot=[posvel(2);-gravity];

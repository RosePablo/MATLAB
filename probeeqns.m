function posveldot=probeeqns(t,posvel)
mass = 1;
h=10000;
r = 6371e3+h;
G=6.67e-11;
M=5.972e24;
omega = (sqrt(G*M)/r);

posveldot=[posvel(3);posvel(4);...
    2*omega*posvel(3)+3*(omega^2)*posvel(2);...
    -2*omega*posvel(4)];
end

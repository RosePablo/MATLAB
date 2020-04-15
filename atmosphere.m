function dens=atmosphere(h)
surfacedens=0.02;
scaleheight=11100;
dens=surfacedens*exp(-h/scaleheight);
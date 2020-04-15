function dens=atmosphere2(h)
surfacedens=1.2
scaleheight=800000
dens=surfacedens*exp(-h/scaleheight)
function f=gravfield(h)
G=6.67e-11
M=6e+24
R=6.4e6
f=G*M/(R+h)^2
function [x1 x2] = quadratic(a,b,c)
% QUADRATIC
%
% [x1 x2] = quadratic(a,b,c)
%
% Return the roots of the quadratic equation
%
% ax^2 + bx + c
%
%
x1 = (-b + (b^2-(4*a*c))^(1/2))/(2*a);
x2 = (-b - (b^2-(4*a*c))^(1/2))/(2*a); 
%A routine for working out the coordinates of the centre of mass of the
%space station modules.clear allsyms totalmass
%This makes sure that all our variables are reset and defines a total mass%
%scalar variable
modules=[4,4,-13,1;7,-3,-1,3;10,2,0,3;8,-1,7,-5;3,1,5,-1;3,-5,-6,-6];
m=modules(:,1);
x=modules(:,2);
y=modules(:,3);
z=modules(:,4);

%This line defines a 6 x 4 array. Each row of the array represents one of the 
%space station modules. The first column is mass, the second the x location, the 
%third the y location and the fourth the z location

ixx=zeros(1,6);
ixy=zeros(1,6);
ixz=zeros(1,6);
iyx=zeros(1,6);
iyy=zeros(1,6);
iyz=zeros(1,6);
izx=zeros(1,6);
izy=zeros(1,6);
izz=zeros(1,6);
cofmcoords=zeros(1,3);
totalmass=0;
%This defines a 1 x 3 row vector called cofmcoords which is initialised
%with all its entries equal to zero. In Matlab, when you introduce an array
%you must initially set the values of its entries in this or a similar way.
for n=1:6
   ixx(n)=m(n)*(y(n)^2+z(n)^2);
   ixy(n)=-m(n)*x(n)*y(n);
   ixz(n)=-m(n)*x(n)*z(n);
   iyx(n)=-m(n)*x(n)*y(n);
   iyy(n)=m(n)*(x(n)^2+z(n)^2);
   iyz(n)=-m(n)*y(n)*z(n);
   izx(n)=-m(n)*x(n)*z(n);
   izy(n)=-m(n)*y(n)*z(n);
   izz(n)=m(n)*(x(n)^2+y(n)^2);
end

ixx=sum(ixx);
ixy=sum(ixy);
ixz=sum(ixz);
iyx=sum(iyx);
iyy=sum(iyy);
iyz=sum(iyz);
izx=sum(izx);
izy=sum(izy);
izz=sum(izz);
I=[ixx,ixy,ixz;iyx,iyy,iyz;izx,izy,izz]

%This line prints out the final value of cofmcoords. Note when you run this
%m-file that the intermediate calculation of the centre of mass is
%presented. To suppress this you add a semi-colon at the end of the line
%e.g. cofmcoords(i)=cofmcoords(i)+modules(n,1).*modules(n,i+1);

for n=1:6
    totalmass=totalmass+modules(n,1);
    for i=1:3
        cofmcoords(i)=cofmcoords(i)+modules(n,1).*modules(n,i+1);
    end
end

[V,D]=eig(i)

cofmcoords=cofmcoords/totalmass
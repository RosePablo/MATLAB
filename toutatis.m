clear all
syms totalmassmass
lumps=zeros(54,3);
masslumps=[-1,4,1;0,3,1;0,-5,1;1,4,1;1,-2,1;...
    -3,3,0;-3,1,0;-2,4,0;-2,2,0;-2,0,0;-2,-4,0;...
    -1,5,0;-1,3,0;-1,1,0;-1,-1,0;-1,-3,0;-1,-5,0;-1,-7,0;...
    0,6,0;0,4,0;0,2,0;0,0,0;0,-2,0;0,-4,0;0,-6,0;...
    1,5,0;1,3,0;1,1,0;1,-1,0;1,-3,0;1,-5,0;...
    2,4,0;2,2,0;2,0,0;;2,-2,0;...
    3,1,0;...
    -2,2,-1;-1,5,-1;-1,3,-1;-1,1,-1;-1,-5,-1;...
    0,6,-1;0,4,-1;0,2,-1;0,0,-1;0,2,-1;0,4,-1;0,6,-1;...
    1,5,-1;1,3,-1;1,1,-1;1,-3,-1;1,-5,-1;2,4,-1]
cofmcoords=zeros(1,3);
totalmass=54;
mass=5*10^13
mass/totalmass
for n=1:54
    for i=1:3
        cofmcoords(i)=cofmcoords(i)+masslumps(n,i);
    end
end
cofmcoords=cofmcoords/totalmass
new=cofmcoords*sqrt(300)
diagmat=eye(3,3);
inertia=zeros(3,3);
newrow=zeros(1,3);
newrow=[cofmcoords];
map=ones(54,3);
for n=1:54
    map(n,:)=newrow;
end
map;
masslumps=masslumps-map;
cofmcoords=zeros(1,3);
for n=1:54
    for i=1:3
        cofmcoords(i)=cofmcoords(i)+masslumps(n,i);
    end
end
cofmcoords;
for n=1:54
    rad2(n)=(masslumps(n,1).*masslumps(n,1)+masslumps(n,2).*masslumps(n,2)+masslumps(n,3).*masslumps(n,3));
    inertia=inertia+rad2(n)*diagmat;
end
inertia;
for n=1:54
    for i=1:3
        for j=1:3
            inertia(i,j)=inertia(i,j)-masslumps(n,i).*masslumps(n,j);
        end
    end
end
[v,d]=eig(inertia)  

inertia_tensor=v*d
function [L2,B2,x2,y2]=equation_of_perpendicular_line(L,x,y)
%x,y: are the start and the end of a segment (L,B)
%if L2=inf==>x=x2
%if L2=0==>y=y2
L2=-1/L;...
x2=(x(1)+x(2))/2;...
y2=(y(1)+y(2))/2;...
B2=y2-L2*x2;...

return
function [flag,r_lim,vor]=interior_or_exterior_concave_decentralised(x,y,x1,y1,r,subgraph,t,hops,neigh_NxN)
%o komvos j upologizei tous ekswterikous kai eswterikous komvous me vash
%ton upografo tou(decentralised)
%epistrefei kai tis suntetagmenes twn r_lim voronoi kai twn voronoi (twn komvwn pou apoteloun ton upografo tou j)tou
%opws upologizontai me vash thn plhroforia poulamvanei apo ton  upografo
%tou

for k=1:1:t
    x_sub(k)=x(subgraph(k));...
    y_sub(k)=y(subgraph(k));...
end
x_sub(t+1)=-100000;...
x_sub(t+2)=-100000;...
x_sub(t+3)=100000;...
x_sub(t+4)=100000;...
y_sub(t+1)=-100000;...
y_sub(t+2)=100000;...
y_sub(t+3)=-100000;...
y_sub(t+4)=100000;...

%[r_lim,vor]=r_limited_voronoi(x_sub,y_sub,x1,y1,t,r);
%[r_lim,vor]=concave_area_partitioning(x_sub,y_sub,x1,y1,t,r);...
[r_lim,vor]=visible_r_limited_voronoi(x_sub,y_sub,x1,y1,r,t,neigh_NxN,hops);...
flag=characterize_node_to_move_int_or_ext(1,r_lim,vor);


return
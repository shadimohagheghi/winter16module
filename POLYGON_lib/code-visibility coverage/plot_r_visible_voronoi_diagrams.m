function plot_r_visible_voronoi_diagrams(r_lim,N,x,y)

for e1=1:N
        tx=cell2mat(r_lim{e1,1});...
        ty=cell2mat(r_lim{e1,2});... 
        plot(tx,ty,'red')
        tx=[];...
        ty=[];...    
end
for gi=1:1:N
        plot(x(gi),y(gi),'ko','markersize',2,'markerfacecolor','k');
end   
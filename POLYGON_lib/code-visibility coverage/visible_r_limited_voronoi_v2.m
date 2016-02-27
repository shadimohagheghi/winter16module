function [r_lim2,vor2]=visible_r_limited_voronoi_v2(x,y,x1,y1,r,N,neigh_NxN,hops)
[r_lim1,vor1]=visible_vor_step1(N,hops,neigh_NxN,x1,y1,r,x,y);...
 %---------------------------------------
%find r-del based on the above partitioning      
%[subgraph,t]=subgraph_per_node_v2(e,N,hops,neigh_NxN);... %j-subgraph in n hops 
[r_lim2,vor2]=visible_vor_step2(N,hops,neigh_NxN,x1,y1,r,x,y,r_lim1);...
    
for j=1:N
    [subgraph,t]=subgraph_per_node_v2(j,N,hops,neigh_NxN);...
    r_del=find_r_limited_delaunay_v2(subgraph,N,j,r_lim2);...
    xr=cell2mat(r_lim2{j,1});...%x-coordinate of r-lim voronoi cell of node j
    yr=cell2mat(r_lim2{j,2});...%y-coordinate of r-lim voronoi cell of node j
    xrn=xr;yrn=yr;...
    %prepei na afairesw ta shmeia pou anhkoun se toksa mono kai mono gia na
    %kanw ton kwdika ligo pio grhgoro:
    xrr=floor(xr*2^15)/2^15;...
    yrr=floor(yr*2^15)/2^15;...    
    k=360:-1:1;...
    c2=r(j)*cosd(k)+x(j);...
    d2=r(j)*sind(k)+y(j);...
    [fx1,fy1]=polyxpoly(xr,yr,c2,d2);%suntetagmenes twn shmeiwn kuklou 
    x_circle=floor(fx1*2^15)/2^15;...
    y_circle=floor(fy1*2^15)/2^15;...%"stroggulopoihmenes"suntetagmenes twn shmeiwn kuklou 
    [fx3,fy3]=polybool('-',xrr,yrr,x_circle,y_circle);...%suntetagmenes r lim vor cell xwris ta shmeia kuklou
    [fx5,fy5]=polybool('-',xr,yr,fx1,fy1);...%suntetagmenes r lim vor cell xwris ta shmeia kuklou
% % %     fx4=fx3(1:end-1);...
% % %     fy4=fy3(1:end-1);...    
    
    if length(r_del)>0
        for m=1:length(r_del)
           p=1;... %deiktis pou metra arithmo upopsifiwn simiwn
           pointer=[];...
           xp=[];yp=[];in2=[];on2=[];in3=[];on3=[];...
           xrdel=cell2mat(r_lim2{r_del(m),1});... 
           yrdel=cell2mat(r_lim2{r_del(m),2});... 
           xrdelr=floor(xrdel*2^15)/2^15;...
           yrdelr=floor(yrdel*2^15)/2^15;...    
           k=360:-1:1;...
           c2=r(r_del(m))*cosd(k)+x(r_del(m));...
           d2=r(r_del(m))*sind(k)+y(r_del(m));...
           [fx2,fy2]=polyxpoly(xrdel,yrdel,c2,d2);
           x_circle1=floor(fx2*2^15)/2^15;...
           y_circle1=floor(fy2*2^15)/2^15;...
           [fx4,fy4]=polybool('-',xrdelr,yrdelr,x_circle1,y_circle1);...%suntetagmenes r lim vor cell xwris ta shmeia kuklou
           [fx6,fy6]=polybool('-',xrdel,yrdel,fx2,fy2);...%suntetagmenes r lim vor cell xwris ta shmeia kuklou
           for t=1:length(fx6)
                k1=[];...
                k2=[];...
                %k1=find(fx5==fx6(t));...
                %k2=find(fx3==fx4(t));...
                %find
                for t1=1:length(fx5) %elegxw an to vertex fx6(t) einai kai kapoio apo ta vertices toy rlim tou j...mporei na anhkei sto rlim alla aegw thelw na dw an einai vertex toy rlim tou j
                    if abs(fx6(t)-fx5(t1))<=eps
                        k1=1;
                        k2=1;%vrethike...to petame (einai vertex tou r lim you j)
                    end
                end
                if length(k1)<=0 && length(k2)<=0 %ean den vrethike (auto "kinigaw") elekse an anikei panw sto boundary toy r lim tou j
%                    plot(fx6(t),fy6(t),'blue*')
                   [in1 on1]=inpolygon(fx6(t),fy6(t),fx5,fy5);... %ean on=1 tote vrika mia korufh pou anhke sto r lim enow del pou den anhkei omws ston j alla auth h korufh einai panw sto boundary toy r lim tou j (sxhma new_tes.fig)
                   [inr onr]=inpolygon(fx4(t),fy4(t),fx3,fy3);...
                   if (on1>=1 || in1>=1) || (inr>=1 || onr>=1)
                        plot(fx6(t),fy6(t),'k*')
                        xp(p)=fx6(t);... %vertex "k" (shmeiwseis)
                        yp(p)=fy6(t);...
                        pointer(p)=t;...
                        p=p+1;...
                        %============
                        %diorthwsh tou r_lim tou komvou j
                        %to upopsifio shmeio (xp,yp) sxhmatzei grammh me to
                        %epomeno kai prohgoumeno shmeio sto fx6
%                         if t>=length(fx6)
%                             k3=1;...
%                        % elseif 
%                         end


%to xr2 periexei thn nea pleura (edge) pou tha valw sto r-lim tou j 
                        xr2=[];...
                        if t>1 && t<length(fx6) 
                            [in2 on2]=inpolygon(fx6(t-1),fy6(t-1),fx5,fy5);...
                            [inr2 onr2]=inpolygon(fx4(t-1),fy4(t-1),fx3,fy3);...
                            if (in2<=0 && on2<=0) && (inr2<=0 && onr2<=0)  %to kratame auto to simeio
                                xr2=[fx6(t-1) fx6(t)];...
                                yr2=[fy6(t-1) fy6(t)];...    
                            
                            else
                                %ean anikei tote pame sto epomeno shmeio
                                [in3 on3]=inpolygon(fx6(t+1),fy6(t+1),fx5,fy5);...
                                [inr3 onr3]=inpolygon(fx4(t+1),fy4(t+1),fx3,fy3);...
                                if in3<=0 && on3<=0 
                                    xr2=[fx6(t+1) fx6(t)];...
                                    yr2=[fy6(t+1) fy6(t)];...   
                                end
                            end
                        end
                        if t<=1 || t>=length(fx6)
                            [in2 on2]=inpolygon(fx6(2),fy6(2),fx5,fy5);...
                            [inr2 onr2]=inpolygon(fx4(2),fy4(2),fx3,fy3);...
                            if (in2<=0 && on2<=0) && (inr2<=0 && onr2<=0)  %to kratame auto to simeio
                                xr2=[fx6(2) fx6(t)];...
                                yr2=[fy6(2) fy6(t)];...    
                            else
                                %ean anikei tote pame sto epomeno shmeio
                                [in3 on3]=inpolygon(fx6(end-1),fy6(end-1),fx5,fy5);...
                                [inr3 onr3]=inpolygon(fx4(end-1),fy4(end-1),fx3,fy3);...
                                if in3<=0 && on3<=0 
                                    xr2=[fx6(end-1) fx6(t)];...
                                    yr2=[fy6(end-1) fy6(t)];...   
                                end
                            end 
                        end
                         %find in which line of r-lim of j the vertex k belongs
                         if length(xr2)>0
                            xg=[];yg=[];...
                            [L,B,xa,ya]=findline(fx5,fy5,fx6(t),fy6(t));...
                            [in4 on4]=inpolygon(xa(1),ya(1),fx6,fy6);...    
                            [in5 on5]=inpolygon(xa(2),ya(2),fx6,fy6);... 
                            if in4<=0 && on4<=0
                                    xg=xa(1);...
                                    yg=ya(1);...    
                            elseif in5<=0 && on5<=0
                                    xg=xa(2);...
                                    yg=ya(2);... 
                            end
                        
                            %prepei na vrw thn thesh tou shmeiou (xg,yg) sto
                            %xr,yr wste na ginei h katallhlh paremvolh tou
                            %xr2,yr2
                            %index=find(xr==xg); %%<--kanonika tha eprepe na doulevei panta....
                            if length(xg)>0
                                for t2=1:length(xr)
                                    if  abs(xr(t2)-xg)<=10^(-10) && abs(yr(t2)-yg)<=10^(-10)
                                        index=t2;...
                                    end
                                end
                                if index>=length(xr)
                                    index=1;...
                                end
                                xr1=xr(1:index);...
                                yr1=yr(1:index);...
                                xr3=xr(index+1:end);....
                                yr3=yr(index+1:end);...
                                xrn=[xr1 xr2 xr3];...
                                yrn=[yr1 yr2 yr3];...
                            end
%                             xrn(end+1)=xrn(1);...
%                             yrn(end+1)=yrn(1);...
%                          else
%                             xrn=xr;...
%                             yrn=yr;...       
                         end
                        %============
                   end
                end
           end
           %[xr1,yr1]=poly2cw(xr,yr);...
           %plot(xrn,yrn,'green')
           r_lim3{j,1}={xrn};...
           r_lim3{j,2}={yrn};...
        end
    end


end
%----------------------------------------
plot(x1,y1,'k','linewidth',1.4)
for e1=1:N
    tx=cell2mat(r_lim3{e1,1});...
    ty=cell2mat(r_lim3{e1,2});... 
    plot(tx,ty,'blue')
    tx=[];...
    ty=[];...    
end
for gi=1:1:N
    plot(x(gi),y(gi),'ko','markersize',2,'markerfacecolor','k');
end



return

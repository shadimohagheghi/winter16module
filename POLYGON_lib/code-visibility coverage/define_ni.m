function th1=define_ni(points_x,points_y,xr,yr)

    xmid=(points_x(1)+points_x(2))/2 ;...
    ymid=(points_y(1)+points_y(2))/2;...
    z1=(points_x(1)-points_x(2))+(points_y(1)-points_y(2))*1i;...
    th=angle(z1);...
    th1=th+pi/2;...
    xmid=xmid+0.05*cos(th1);ymid=ymid+0.05*sin(th1);...
    in=inpolygon(xmid,ymid,xr,yr);...
    if in<0 %ektos tou xr,yr
        th1=th-pi/2;...
    end

return
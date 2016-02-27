function  [choose_box,not_box]=choose_halfplane_v2(a,b,c,p1,p2,box1,box2,r1,r2)

%in_box: einai to "kouti/voronoi_cell" pou tha anetethei sto j1 (sugkrinontas mono tous komvous j1 kai j2)
if b~=0
    %x_random=3;y_random=-(a*x_random+c)/b;
    [d,x_random,y_random] = p_poly_dist(p1(1), p1(2), box1(:,1), box1(:,2));
    th1=atan(-a/b);...
    th2=th1+pi/2;...
    xp=x_random+0.1*cos(th2); %ena shmeio pou anhkei eite sto box1 eite sto box2
    yp=y_random+0.1*sin(th2);
    inp=inpolygon(xp,yp,box1(:,1),box1(:,2));
    if inp==1
        %----box1-----;
        %tha eleksw an gia to xp,yp ikanopoieitai o orismos=>an ikanopoietai to
        %tote epilegw to box alliws to allo
        dj1=sqrt( (xp-p1(1))^2  +   (yp-p1(2) )^2 );...
        dj2=sqrt( (xp-p2(1))^2  +   (yp-p2(2) )^2 );...
        if ((dj1^2)-(r1^2))<((dj2^2)-(r2^2))
                choose_box=box1;...
                not_box=box2;...
        else
                 choose_box=box2;...
                 not_box=box1;...                     
        end
        %---------------
    else
       %------box2-------
        dj1=sqrt( (xp-p1(1))^2  +   (yp-p1(2) )^2 );...
        dj2=sqrt( (xp-p2(1))^2  +   (yp-p2(2) )^2 );...
        if ((dj1^2)-(r1^2))<((dj2^2)-(r2^2))
                 choose_box=box2;...
                 not_box=box1;...
        else
                 choose_box=box1;...
                 not_box=box2;...                     
        end       
       %-----------------
    end
else %b=0(a=1)=>x=-c
     yp=3;xp=-c+0.1;
%     [d,x_random,y_random] = p_poly_dist(p1(1), p1(2), box1(:,1), box1(:,2));
    inp=inpolygon(xp,yp,box1(:,1),box1(:,2));
    if inp==1
        %----box1-----;
        %tha eleksw an gia to xp,yp ikanopoieitai o orismos=>an ikanopoietai to
        %tote epilegw to box1 alliws to allo
        dj1=sqrt( (xp-p1(1))^2  +   (yp-p1(2) )^2 );...
        dj2=sqrt( (xp-p2(1))^2  +   (yp-p2(2) )^2 );...
        if ((dj1^2)-(r1^2))<((dj2^2)-(r2^2))
                 choose_box=box1;...
                not_box=box2;...                     
        else
                 choose_box=box2;...
                 not_box=box1;...                     
        end
        %---------------
    else
       %------box2-------
        dj1=sqrt( (xp-p1(1))^2  +   (yp-p1(2) )^2 );...
        dj2=sqrt( (xp-p2(1))^2  +   (yp-p2(2) )^2 );...
        if ((dj1^2)-(r1^2))<((dj2^2)-(r2^2))
                 choose_box=box2;...
                 not_box=box1;...     
        else
                 choose_box=box1;...
                 not_box=box2;...     
        end       
       %-----------------
    end
    
end

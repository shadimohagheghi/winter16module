function sensed_area= percentage_of_sensed_area_non_compact(r_lim,total_area,N)
%Evaluate percentage of sensed area in centralized way in a arbitrary time-step

sensed_area=0;...
for j=1:N
    xr=r_lim{j,1};...
    yr=r_lim{j,2};...
    index=find(isnan(xr)==1);
    if ~isempty(index)
            xr1=xr(1:index-1);yr1=yr(1:index-1);
            area=polyarea(xr1,yr1);...

            sensed_area=sensed_area+area;...
            xr2=xr(index+1:end);yr2=yr(index+1:end);
            area=polyarea(xr2,yr2);...
            sensed_area=sensed_area+area;...
            %xr=[xr1';xr2'];yr=[yr1';yr2'];
    else
            
             area=polyarea(xr,yr);...
             sensed_area=sensed_area+area;...
    end
    
end
sensed_area=(sensed_area/total_area)*100;...
return           

function [error]=data_analysis(data_name)
    datafilename = strcat(data_name,'.dat');
    DATA = dlmread(datafilename,' ');
    
    
    count = zeros(12,1);
    error =[0 0 0 0];
    
    for j = 2:4
        category_rows = find(DATA(:,1)==j);
        
        for i =1:12
            count(i) = length(find(DATA(category_rows(1):category_rows(66),4) == i));
        end
        
        [Y,rank] = sort(count,1,'descend');
        
        for k = category_rows(1):category_rows(66)
            left_rank = find(rank==DATA(k,2));
            right_rank = find(rank==DATA(k,3));

            if max(left_rank,right_rank) == find(rank == DATA(k,4))
                error(j) = error(j) + 1;
            end
            
        end
        x=1;
    end
%     sem = std([error(1) error(2) error(3)])/sqrt(3);
  h= bar([mean([error(1) error(2) error(4)]) error(3)],'b','EdgeColor','b','BarLayout','grouped');
  saveas(h,data_name,'png');
%   hold on;
%   bar([0 ],'r','EdgeColor','r',);
    axis([0 5 0 7]);
end
    
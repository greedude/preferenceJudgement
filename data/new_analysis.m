function [error]=new_analysis(data_name)
    datafilename = strcat(data_name,'.dat');
    DATA = dlmread(datafilename,' ');
    
        count = zeros(12,1);
    error =[0 0 0 0];
    
       for j = 2:4
        category_rows = find(DATA(:,1)==j);
        
        for i =1:12
            count(i) = length(find(DATA(category_rows(1):category_rows(66),4) == i));
            rt{i} = [];
        end
        
        [Y,rank] = sort(count,1,'descend');
        
            for k = category_rows(1):category_rows(66)
                left_rank = find(rank==DATA(k,2));
                right_rank = find(rank==DATA(k,3));

                switch abs(left_rank - right_rank)
                    case 1
                        rt{1}(end+1)= DATA(k,5);
                    case 2
                        rt{2}(end+1)= DATA(k,5);
                    case 3
                        rt{3}(end+1)= DATA(k,5);
                    case 4
                        rt{4}(end+1)= DATA(k,5);
                    case 5
                        rt{5}(end+1)= DATA(k,5);
                    case 6
                        rt{6}(end+1)= DATA(k,5);
                    case 7
                        rt{7}(end+1)= DATA(k,5);
                    case 8
                        rt{8}(end+1)= DATA(k,5);
                    case 9
                        rt{9}(end+1)= DATA(k,5);
                    case 10
                        rt{10}(end+1)= DATA(k,5);
                    case 11
                        rt{11}(end+1)= DATA(k,5);
                end

            end
            for l = 1:11
                mean_rt(l) = mean(rt{l});
            end
            figure(j);
            h1 = plot(mean_rt);
            set(h1,'Marker','O');
       end
    
    
%       h= bar([mean([error(1) error(2) error(4)]) error(3)],'b','EdgeColor','b','BarLayout','grouped');
%   saveas(h,data_name,'png');
%   hold on;
%   bar([0 ],'r','EdgeColor','r',);
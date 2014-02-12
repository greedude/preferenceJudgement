error1 = data_analysis('kongwei');
error2 = data_analysis('xiaoshujun');
error3 = data_analysis('xuchan');

mean_error_pt1 = mean([error1(1) error1(2) error1(4)]);
mean_error_pt2 = mean([error2(1) error2(2) error2(4)]);
mean_error_pt3 = mean([error3(1) error3(2) error3(4)]);

total_error =mean([mean_error_pt1 mean_error_pt2 mean_error_pt3]);
mean_error_perceptual = mean([error1(3) error2(3) error3(3)]);

sem1 = std([mean_error_pt1 mean_error_pt2 mean_error_pt3])/sqrt(3);
sem2 = std([error1(3) error2(3) error3(3)])/sqrt(3);

error_total = [mean_error_pt1 error1(3);mean_error_pt2 error2(3);mean_error_pt3 error3(3);total_error mean_error_perceptual];

handle = bar(error_total,'grouped');

axis([0 5 0 7]);
legend('preference','perceptual');


set(gca,'XTickLabel',{'Kong','Shu','Xu','total'});
ylabel('errors per category','FontSize',12,'FontWeight','bold');

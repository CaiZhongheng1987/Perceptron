%{
name   :  perceptron demo
author :  CaiZhongheng

date           version          record
2018.06.03     v1.0             init
%}

clear;
clc;
close all;

%% setting
base_coe_w    = [3,8];
base_coe_b    = -5;
est_coe_w     = [0,0];
est_coe_b     = 0;
upd_mu        = 1e-3;

plot_en       = 1;
uni_scale     = 100;
line_vec      = (-uni_scale:0.01:uni_scale).';
data_len      = 90;
lost_func     = zeros(data_len,1);
sum_lost_func = 1;

%% creating test data
test_data_x1 = unifrnd(-uni_scale,uni_scale,[data_len,1]);
test_data_x2 = unifrnd(-uni_scale,uni_scale,[data_len,1]);

%{
if(plot_en==1)
    figure(1);
    plot(complex(test_data_x1,test_data_x2),'*');
    xlim([-uni_scale uni_scale]);
    ylim([-uni_scale uni_scale]);
    axis square;
    title('original data');
else
end
%}

%% using a baseline to divide the data into two parts.
test_data_y = base_coe_w(1)*test_data_x1+base_coe_w(2)*test_data_x2+base_coe_b;
test_data_y = 2*(double(test_data_y>0)-1/2);

%{
if(plot_en==1)
    sign_p1_idx = find(test_data_y==1);
    figure(2);
    plot(complex(test_data_x1(sign_p1_idx),test_data_x2(sign_p1_idx)),'r*');
    xlim([-uni_scale uni_scale]);
    ylim([-uni_scale uni_scale]);
    axis square;
    title('using base\_line to divide into two parts');
    hold on;
    
    sign_n1_idx = find(test_data_y==-1);
    plot(complex(test_data_x1(sign_n1_idx),test_data_x2(sign_n1_idx)),'b*');
    hold on;
    
    base_line_plot = plot(line_vec,-1/base_coe_w(2)*(base_coe_w(1)*line_vec+base_coe_b),'g');
    set(base_line_plot,'LineWidth',2.5);
    hold off;
    legend('y=1','y=-1','base\_line','Location','EastOutside');
else
end
%}

%% using perceptron method to find the estimation line
while(sum_lost_func>0)
    for idx=1:data_len
        lost_func(idx) = test_data_y(idx)*(est_coe_w(1)*test_data_x1(idx)+est_coe_w(2)*test_data_x2(idx)+est_coe_b);
        if(lost_func(idx)<=0)
            est_coe_w = est_coe_w + upd_mu*test_data_y(idx)*[test_data_x1(idx),test_data_x2(idx)];
            est_coe_b = est_coe_b + upd_mu*test_data_y(idx);
            break;
        else
        end
    end
    sum_lost_func = sum(double(lost_func<=0));
end

if(plot_en==1)
    figure(3);
    xlim([-uni_scale uni_scale]);
    ylim([-uni_scale uni_scale]);
    axis square;
    
    sign_p1_idx = find(test_data_y==1);
    plot(complex(test_data_x1(sign_p1_idx),test_data_x2(sign_p1_idx)),'r*');
    hold on;
    
    sign_n1_idx = find(test_data_y==-1);
    plot(complex(test_data_x1(sign_n1_idx),test_data_x2(sign_n1_idx)),'b*');
    hold on;
    
    base_line_plot = plot(line_vec,-1/base_coe_w(2)*(base_coe_w(1)*line_vec+base_coe_b),'g');
    set(base_line_plot,'LineWidth',2.5);
    hold on;
    
    est_line_plot = plot(line_vec,-1/est_coe_w(2)*(est_coe_w(1)*line_vec+est_coe_b),'k');
    set(est_line_plot,'LineWidth',2.5);
    hold off;
    
    legend('y=1','y=-1','base\_line','est\_line','Location','EastOutside');
    title('perceptron demo');
else
end




%% 输入数据
clc, clear all, close all
x = [1.5, 4.5, 7.5,10.5,13.5,16.5,19.5,22.5,25.5];
y = [7.0,4.8,3.6,3.1,2.7,2.5,2.4,2.3,2.2];
plot(x, y, '*', 'linewidth', 1) % 这里的linewidth指的是散点大小
set(gca,'linewidth',2) % 设置坐标轴的线宽为2
xlabel('销售额x/万元','fontsize',12)
ylabel('流通率y/%','fontsize',12)

%% 对数形式非线性回归
m1 = @(b,x) b(1) + b(2)*log(x);
nonlinfit1 = fitnlm(x,y,m1,[0.01;0.01])
b = nonlinfit1.Coefficients.Estimate;
Y1 = b(1,1) + b(2,1)*log(x);
hold on 
plot(x, Y1, '--k', 'linewidth',2)

%% 指数形式非线性回归
m2 = 'y ~ b1*x^b2';
nonlinfit2 = fitnlm(x,y,m2, [1;1])
b1 = nonlinfit2.Coefficients.Estimate(1,1);
b2 = nonlinfit2.Coefficients.Estimate(2,1)
Y2 = b1*x.^b2;
hold on;
plot(x,Y2,'r','linewidth',2)
legend('原始数据','a+b*lnx','a*x^b') % 图例




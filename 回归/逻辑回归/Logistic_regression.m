% logistic回归

%% 导入数据
clc,clear,close all
X0 = xlsread('logistic_ex1.xlsx','A2:C21'); % 前20家企业的三项评价指标值,即回归模型的输入
Y0 = xlsread('logistic_ex1.xlsx','D2:D21'); % 前20家企业的评估结果，即回归模型的输出
X1 = xlsread('logistic_ex1.xlsx','A2:C26'); % 预测数据输入

%% 逻辑函数
GM = fitglm(X0,Y0,'Distribution','binomial');
Y1 = predict(GM,X1);

%% 模型的评估
N0 = 1:size(Y0,1); % N0 = [1,2,3,4,……，20]
N1 = 1:size(Y1,1); % N1 = [1,2,3,4,……，25]
plot(N0',Y0,'-kd'); % N0'指的是对N0'进行转置，N0'和Y0的形式相同，该行代码绘制的是前20家企业的评估结果
% plot()中的参数'-kd'的解析：-代表直线，k代表黑色，d代表菱形符号
hold on;
scatter(N1',Y1,'b'); % N1'指的是对N1'进行转置，N1'和Y1的形式相同
xlabel('企业编号');
ylabel('输出值');



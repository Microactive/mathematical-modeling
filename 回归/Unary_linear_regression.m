%% 输入数据
clc, clear, close all
% 职工工资总额
x = [23.8,27.6,31.6,32.4,33.7,34.90,43.2,52.8,63.8,73.4];
% 商品零售总额
y = [41.4,51.8,61.7,67.9,68.7,77.5,95.9,137.4,155.0,175.0];

%% 采用最小二乘法回归
% 作散点图
figure
plot(x,y,'r*') % 散点图，散点为红色
xlabel('x(职工工资总额)','fontsize',12)
ylabel('y(商品零售总额)','fontsize',12)
set(gca, 'linewidth',2) % 坐标轴线宽为2

% 采用最小二乘法拟合
Lxx = sum((x-mean(x)).^2); %在列表运算中，^与.^不同
Lxy = sum((x-mean(x)).*(y-mean(y)));
b1 = Lxy/Lxx;
b0 = mean(y) - b1 * mean(x);
y1 = b1 * x + b0;

hold on % hold on是当前轴及图像保持而不被刷新，准备接受此后将绘制的图形，多图共存
plot(x,y1, 'linewidth',2);

%% 采用 LinearModel.fit 函数进行线性回归
m2 = LinearModel.fit(x, y)

%% 采用 regress 函数进行回归
Y = y'
X = [ones(size(x,2),1),x']
[b,bint,r,rint,s] = regress(Y,X)



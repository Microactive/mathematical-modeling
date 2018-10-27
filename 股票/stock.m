%% 预测股票的价值与风险

%% 导入数据
clc, clear, close all
% clc：清除命令窗口的内容，对工作环境中的全部变量无任何影响 
% clear：清除工作空间的所有变量 
% close all:关闭所有的Figure窗口

% 导入数据
[~, ~, raw] = xlsread('sz000004.xlsx', 'Sheet1', 'A2:H7');
% [num,txt,raw],~表示省略该部分的返回值
% xlsread('filename'，'sheet'， 'range')，第二个参数指数据在sheet1还是其他sheet部分，range表示单元格范围

% 创建输出变量
data = reshape([raw{:}],size(raw));
% [raw{:}]指raw里的所有数据，size(raw)：6 x 8 ，该语句把6x8的cell类型数据转换为6x8 double类型数据

% 将导入的数组分配列变量名称
Date = data(:, 1); % 第一个参数表示从第一行到最后一行，第二个参数表示第一列
DateNum = data(:, 2);
Popen = data(:, 3);
Phigh = data(:, 4);
Plow = data(:, 5);
Pclose = data(:, 6);  
Volum = data(:, 7); % Volume 表示股票成交量的意思，成交量=成交股数*成交价格 再加权求和
Turn = data(:, 8); % turn表示股票周转率，股票周转率越高，意味着该股股性越活泼，也就是投资人所谓的热门股

% 清除临时变量data和raw
clearvars data raw;

%% 数据探索

figure % 创建一个新的图像窗口
plot(DateNum, Pclose, 'k'); % 'k',曲线是黑色的，打印后不失真
datetick('x','mm-dd'); % 更改日期显示类型
xlabel('日期') % x轴
ylabel('收盘价') % y轴
figure
bar(Pclose) % 作为对照图形

%% 股票价值的评估

p = polyfit(DateNum, Pclose, 1); % 多项式拟合
% 分号作用为不在命令窗口显示执行结果
P1 = polyval(p,DateNum); % 得到多项式模型的结果
figure
plot(DateNum,P1,DateNum,Pclose,'*g'); % 模型与原始数据的对照
value = p(1) % 将斜率赋值给value，作为股票的价值。

 

%% 股票风险的评估

MaxDD = maxdrawdown(Pclose); % 计算最大回撤

risk = MaxDD  % 将最大回撤赋值给risk，作为股票的风险
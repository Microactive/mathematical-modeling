%% 支持向量机模型
clc,clear,close all
load fisheriris % 导入数据集，fisheriris是Matlab自带的数据集
%fisheriris数据类别分为3类，setosa，versicolor，virginica.每类植物有50个样本，共150个。

% 读取数据集中的两个分类‘versicolor' 和 'virginica'
inds = ~strcmp(species,'setosa'); % 产生样本标签，属于setosa类的样本类别为0，其他类别(versicolor，virginica)样本类别为1
% 使用两个维度，即第三列和第四列数据。
X = meas(inds,3:4); % 在meas数据矩阵中，前50行数据移除，后100行数据移除；保留第三、四列的数据
y = species(inds); % 移除前50行的种类，保留后50行的种类。
tabulate(y) % tabulate()用于统计数值的个数和频率

%% 使用线性核函数训练SVM模型，并将结果可视化
SVMModel = fitcsvm(X,y,'KernelFunction','linear'); % KernelFunction即核函数
% 查看进行数据划分的支持向量
sv = SVMModel.SupportVectors;
figure
gscatter(X(:,1),X(:,2),y) % gscatter函数可以按分类或分组来画离散点，适用于画多个类别的离散样本分布图。
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10) % 空心圆圈大小
legend('versicolor','virginica','Support Vector') % 图例
hold off


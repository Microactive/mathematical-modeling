%% 导入fisheriris数据集
clc,clear,close all
load fisheriris
X = meas;
Y = species;
tabulate(Y);

%% 创建SVM模板（二分类模型），并对分类变量进行标准化处理
% predictors
t = templateSVM( 'Standardize' , 1); % 对分类变量进行标准化处理

%% 基于SVM二分类模型进行训练并生成多分类模型
Mdl = fitcecoc(X,Y,'Learners',t,...
    'ClassNames',{'setosa','versicolor','virginica'})

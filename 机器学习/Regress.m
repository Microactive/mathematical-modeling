%% 判断不同体重、年龄、性别的人的吸烟概率
clc,clear,close all
load hospital % 导入hospital数据集

dsa = hospital;

% 指定模型使用的计算公式
% 公式的书写方式符合 Wilkinson Notation, 详情请查看：
% http://cn.mathworks.com/help/stats/wilkinson-notation.html
modelspec = 'Smoker ~ 1+ Age + Weight + Sex + Age:Weight + Age:Sex + Weight:Sex';
% 通过参数'Disribution'指定'binomial'构建逻辑回归模型
mdl = fitglm(dsa, modelspec, 'Distribution', 'binomial')

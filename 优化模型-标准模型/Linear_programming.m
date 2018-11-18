clc,clear,close all
%% 选择优化求解器，线性规划求解可由linprog实现

%% 将所有变量合并为一个向量，共16个变量
variables = {'I1','I2','HE1','HE2','LE1','LE2','C','BF1','BF2','HPS','MPS','LPS','P1','P2','PP','EP'}
N = length(variables)
for v = 1:N
    eval([variables{v},'=',num2str(v),';'])
end

%% 设置上下限约束(lb<=x<=ub)
% 设置下限约束，即lb<=x
lb = zeros(size(variables)); % 1x16的矩阵，每个数都是0
lb([P1,P2,MPS,LPS]) = [2500,3000,271536,100623];
% 设置上限约束，即x<=ub
ub = Inf(size(variables)); % 1想6的矩阵，每个数都是无穷大
ub([P1,P2,I1,I2,C,LE2])= [6250,9000,192000,244000,62000,142000];

%% 创建线性不等式约束(A*x<=b)
A = zeros(3,16); % 3x16的矩阵，每个数均为0,为什么是3x16，因为约束条件有3个不等式
% 由不等式I1-HE1<=132000得到下面一行代码
A(1,I1)=1; A(1,HE1)=-1; b(1) = 132000;
% 由不等式-EP-PP<=12000得到下面一行代码
A(2,EP)=-1; A(2,PP)=-1; b(2) = -12000;
% 由不等式-P1-P2-PP<=-24550得到下面一行代码
A(3,[P1,P2,PP])=[-1,-1,-1];b(3)=-24550;

%% 创建线性等式约束(Aeq*x=beg)
Aeq=zeros(8,16);beq=zeros(8,1) % 约束条件中共有8个等式
% 把等式I2=LE2+HE2转化为LE2+HE2-I2=0后，得到下面一行代码
Aeq(1,[LE2,HE2,I2])=[1,1,-1];
Aeq(2,[LE1,LE2,BF2,LPS])=[1,1,1,-1];
Aeq(3,[I1,I2,BF1,HPS])=[1,1,1,-1];
Aeq(4,[C,MPS,LPS,HPS])=[1,1,1,-1];
Aeq(5,[LE1,HE1,C,I1])=[1,1,1,-1];
Aeq(6,[HE1,HE2,BF1,BF2,MPS])=[1,1,1,-1,-1];
Aeq(7,[HE1,LE1,C,P1,I1])=[1267.8,1251.4,192,3413,-1359.8];
Aeq(8,[HE1,LE2,P2,I2])=[1267.8,1251.4,3413,-1359.8];

%% 创建目标函数
f = zeros(size(variables));
% 由目标函数0.002614HPS+0.0239PP+0.009825EP
f([HPS,PP,EP]) = [0.002614,0.0239,0.009825];

%% 由linprog实现线性规划问题求解
options = optimoptions('linprog','Algorithm','dual-simplex');
% 将前面已经确定的各个参数传入linprog()中
[x, fval] = linprog(f,A,b,Aeq,beq,lb,ub,options);
for d=1:N
    fprintf('%12.2f\t%s\n',x(d),variables{d})
end
% 求z=3*x1 - 2*x2 + 5*x3的最大值转化为求-z=-3*x1 + 2*x2 - 5*x3
f = [-3;2;-5];
intcon=[1,2,3];
A=[1 2 -1; 1 4 1; 1 1 0; 0 4 1];
b=[2;4;3;6];
lb=[0,0,0];
ub=[1,1,1];
Aeq=[0,0,0]
beq=0;
x=intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);
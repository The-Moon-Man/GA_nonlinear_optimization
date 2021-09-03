%% 智能算法第二例遗传算法+非线性寻优（简化修改）
clc
clear
close all
%% 遗传算法参数
MAXGEN=100;                         %进化代数
NIND=30;                       %种群规模
px=0.6;                      %交叉概率
pm=0.01;                  %变异概率
lenchrom=[1 1 1];                    %变量字串长度
bound=[0 3;0 3;0 3];                 %变量范围

%% 个体初始化
Chrom=struct('fitness',zeros(1,NIND), 'chrom',[]);  %种群结构体
% % avgfitness=[];                                               %种群平均适应度
% bestfitness=[];                                              %种群最佳适应度
% bestchrom=[];                                                %适应度最好染色体
% 初始化种群
for i=1:NIND
    Chrom.chrom(i,:)=Code(lenchrom,bound);       %随机产生个体
    x=Chrom.chrom(i,:);
    Chrom.fitness(i)=Fit_fun_nonliner(x);                     %个体适应度
end

%找最好的染色体
[bestfitness,bestindex]=min(Chrom.fitness);
bestchrom=Chrom.chrom(bestindex,:);  %最好的染色体
avgfitness=sum(Chrom.fitness)/NIND; %染色体的平均适应度
% 记录每一代进化中最好的适应度和平均适应度
trace=zeros(MAXGEN,2);
%% 进化开始
for i=1:MAXGEN
    
    % 选择操作
    Chrom=Select(Chrom,NIND);
%     avgfitness=sum(individuals.fitness)/sizepop;
    % 交叉操作           
    Chrom.chrom=Cross(px,lenchrom,Chrom.chrom,NIND,bound);
    % 变异操作
    Chrom.chrom=Mutation(pm,lenchrom,Chrom.chrom,NIND,[i MAXGEN],bound);
    
    if mod(i,10)==0
        warning off
        Chrom.chrom=nonlinear(Chrom.chrom,NIND);
    end
    
    % 计算适应度
    for j=1:NIND
        x=Chrom.chrom(j,:);
        Chrom.fitness(j)=Fit_fun_nonliner(x);
    end
    
    %找到最小和最大适应度的染色体及它们在种群中的位置
    [newbestfitness,newbestindex]=min(Chrom.fitness);
    [worestfitness,worestindex]=max(Chrom.fitness);
    % 代替上一次进化中最好的染色体
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=Chrom.chrom(newbestindex,:);
    end
    Chrom.chrom(worestindex,:)=bestchrom;
    Chrom.fitness(worestindex)=bestfitness;
    
    avgfitness=sum(Chrom.fitness)/NIND;
    
    trace(i,:)=[avgfitness,bestfitness]; %记录每一代进化中最好的适应度和平均适应度
end
%进化结束
%% 结果显示
figure
plotx=1:MAXGEN;
plot(plotx',trace(:,1),'r-',plotx',trace(:,2),'b--');
title(['函数值曲线  ' '终止代数＝' num2str(MAXGEN)],'fontsize',12);
xlabel('进化代数','fontsize',12);ylabel('函数值','fontsize',12);
legend('各代平均值','各代最佳值','fontsize',12);
ylim([-3.5 4.5])
disp('    函数值    变量');
% 窗口显示
disp([-bestfitness x]);

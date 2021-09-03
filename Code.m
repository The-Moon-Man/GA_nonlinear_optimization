function ret=Code(lenchrom,bound)
flag=0;
%检验不通过则重新进行插值
while flag==0	
    pick=rand(1,length(lenchrom));						%生成随机序列
    ret=bound(:,1)'+(bound(:,2)-bound(:,1))'.*pick; 	%线性插值
    flag=test(lenchrom,bound,ret);             			%检验染色体的可行性
end

function ret = nonlinear(chrom,sizepop)
for i=1:sizepop
    x=fmincon(@Fit_fun_nonliner,chrom(i,:)',[],[],[],[],[0 0 0],[3 3 3]);
    ret(i,:)=x';
end

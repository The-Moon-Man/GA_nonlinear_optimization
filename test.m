function flag=test(lenchrom,bound,code)
%lenchrom虽然在这里多余，但根据具体情况可能会有所变化，因此并未删去
flag=1;
[n,m]=size(code);

for i=1:n
    if code(i)<bound(i,1) || code(i)>bound(i,2)
        flag=0;
    end 
end

x=[ones(10000,1),pg1,pg2,pg3,pg4,pg5,dir];
y=rating;
[b,bint,r,rint,stats]=regress(y,x);
ind=[x1,x2,x3,x4,x5,x6]
ans=[0,0,0];
for i = 1:3
    ans(i)=b(1)+b(2)*ind(i,1)+b(3)*ind(i,2)+b(4)*ind(i,3)+b(5)*ind(i,4)+b(6)*ind(i,5)+b(7)*ind(i,6);
end
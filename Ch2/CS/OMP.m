function x=OMP(A,y,k)
r=y;
O=[];
x=zeros(size(A,2),1);
for i=1:k
    c=A'*r;
    [~,ind]=max(abs(c));
    O=[O ind];
    Ao=A(:,O');
    x1=Ao\y;
    r=y-Ao*x1;
end
x(O')=x1;
end

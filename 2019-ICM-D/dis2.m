function [dd]=dis2(A,B,pic,up_stair,down_stair,stair)  %���ŵ��������̾��루��ͬ�㣩��A��BΪn��2�ľ���
%����A��B���ڲ���
f1=6-ceil(A(1,1)/684);%����¥��
f2=6-ceil(B(1,1)/684);%Ŀ��¥��
dd=0;
while f1~=f2
    if f1<f2 %��¥
        [d,~,X]=dis1(A,pos_n([up_stair;stair],f1)); %A��X���ӳ������ƶ���ͬ�����
        dd=dd+d; 
        f1=f1+1;
        A=ele_match(X,pic,up_stair,down_stair,stair);
        dd=dd+dis1([X(:,1)-684,X(:,2)],pos_n(A,f1));    %X��R,���ϵ��ݣ��������ϲ���ݿ�
    end
    if f1>f2 %��¥
        [d,~,X]=dis1(A,pos_n([down_stair;stair],f1)); %A��X���ӳ������ƶ���ͬ�����
        dd=dd+d; 
        f1=f1-1;
        A=ele_match(X,pic,up_stair,down_stair,stair);
        dd=dd+dis1([X(:,1)+684,X(:,2)],pos_n(A,f1));    %X��R,���ϵ��ݣ��������²���ݿ�
    end
end
dd=dd+dis1(A,B);
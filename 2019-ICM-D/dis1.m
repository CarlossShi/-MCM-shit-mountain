function [d,AA,BB]=dis1(A,B)  %ͬһ�����ŵ��������̾��룬A��BΪn��2�ľ���
d=nan;                         %����ȡ��ֵʱ������
for i=1:size(A,1)
    for j=1:size(B,1)
        dd=d;
        d=min(d,dis0(A(i,:),B(j,:)));
        if dd~=d
            AA=[A(i,1),A(i,2)];BB=[B(j,1),B(j,2)];
        end
    end
end
end
function [pic_n]=pic_n(pic,f)  %�Ӵ�ͼ�г�ȡ��f¥��ͼ
pic_n=pic((1:684)+684*(5-f),:,:);
end
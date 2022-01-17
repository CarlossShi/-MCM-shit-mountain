n=1000; %number of people
tmax=50000;
ak=1/150; %the degree of familiarity with the exit k(s2[0,1452])
bk=2;
lambda=2;
beta=-2;%repulsive force between people and people or between people and obstacles
delta=2;
ks=0.4;
kr=0.1;%�ų���
kd=0.0;%����
maxad=max(max(all_d));
bottleneck=zeros(3420,1395);

test=imread('all.png');%ԭͼ
pic=test;%������ͼ
%man=walk(randperm(size(walk,1),n),:); %����n����
%man_o=man;
man=man_o;
for i =1:size(man,1)
    man(i,3)=0;  %����û�н����ж�����
    %man(i,4)=man(i,1);  %������һ��ǰ���ķ���
    %man(i,5)=man(i,2);
    man(i,4)=0; %��ʾ���ڲ�ͬ��ɫ�����ϵ�״̬
    man(i,5)=i;
end
%imh=image(pic)

result=zeros(tmax,10);
for t=1:tmax
    man(man(:,3)~=0,3)=0;  %����û�н����ж�����
    for i =1:size(man,1) %��ÿ����ѭ����һ��ѭ��n��
        sig_p=my_sig(man(i,1),man(i,2));
        if sig_p~=0
            man(i,3)=sig_p;       %sign������Ŀ�����
            continue
        end
        color=[test(man(i,1),man(i,2),1),test(man(i,1),man(i,2),2),test(man(i,1),man(i,2),3)];
        if color(1,1)==185 && color(1,2)==122 && color(1,3)==87  %��ɫ
            ele=ele_match([man(i,1),man(i,2)],test,up_stair,down_stair,stair);
            d111=min([dis2([ele(1,1),ele(1,2)],gate1,test,up_stair,down_stair,stair), ...
                      dis2([ele(1,1),ele(1,2)],gate2,test,up_stair,down_stair,stair), ...
                      dis2([ele(1,1),ele(1,2)],gate3,test,up_stair,down_stair,stair), ...
                      dis2([ele(size(ele,1),1),ele(size(ele,1),2)],gate1,test,up_stair,down_stair,stair), ...
                      dis2([ele(size(ele,1),1),ele(size(ele,1),2)],gate2,test,up_stair,down_stair,stair), ...
                      dis2([ele(size(ele,1),1),ele(size(ele,1),2)],gate3,test,up_stair,down_stair,stair)]); %�˵������º������ڵ���̾���
            d112=min([dis2([man(i,1),man(i,2)],gate1,test,up_stair,down_stair,stair), ...
                      dis2([man(i,1),man(i,2)],gate2,test,up_stair,down_stair,stair), ...
                      dis2([man(i,1),man(i,2)],gate3,test,up_stair,down_stair,stair)]);  %λ����ɫ����ʱ������ڵ���̾���
        end
        if ~(color(1,1)==255 && color(1,2)==242 && color(1,3)==0)  ... %�ǻ�ɫ
        && ~(color(1,1)==255 && color(1,2)==127 && color(1,3)==39) ... %�ǳ�ɫ
        && ~(color(1,1)==185 && color(1,2)==122 && color(1,3)==87) ....%����ɫ
        || color(1,1)==185 && color(1,2)==122 && color(1,3)==87 && d111<=d112
            man(i,4)=0;  %���ڵ��ݿڣ���mani4Ϊ0,����ɫ��˵��ݺ������ڸ�������mani4Ϊ0
        end
        if color(1,1)==34 && color(1,2)==177 && color(1,3)==76 ... %��ɫ
        || color(1,1)==255 && color(1,2)==242 && color(1,3)==0 && man(i,4)==0 ...  %��ɫ
        || color(1,1)==255 && color(1,2)==127 && color(1,3)==39 && man(i,4)==0 ... %��ɫ
        || color(1,1)==185 && color(1,2)==122 && color(1,3)==87 && man(i,4)==0     %��ɫ
            man(i,3)=5;
            continue
        end 
        R=around([man(i,1),man(i,2)],0); 
        m_s1=zeros(9,1);
        m_s2=zeros(9,1);
        m_s3=zeros(9,1);
        m_r=zeros(9,1);
        m_p=zeros(9,1);
        m_d=zeros(9,1);   %����
        direction=zeros(9,1);
        for j =1:size(R,1)   %һ��ѭ��9��
            if ~(pic(R(j,1),R(j,2),1)==0 && pic(R(j,1),R(j,2),2)==0 && pic(R(j,1),R(j,2),3)==0) %������ڸ�
%             m_s1(j,1)=ak*(1500-min([dis2([R(j,1),R(j,2)],gate1,pic,up_stair,down_stair,stair) ...
%                             ,dis2([R(j,1),R(j,2)],gate2,pic,up_stair,down_stair,stair)...
%                             ,dis2([R(j,1),R(j,2)],gate3,pic,up_stair,down_stair,stair)]));
              %m_s1(j,1)=ak*(maxad-all_d(R(j,1),R(j,2)));
              m_s3(j,1)=bk*(all_d(man(i,1),man(i,2))-all_d(R(j,1),R(j,2)));
%             if pic(R(j,1),R(j,2),1)==255 && pic(R(j,1),R(j,2),2)==255 && pic(R(j,1),R(j,2),3)==255
%                 m_s2(j,1)=lambda;
%             else
%                 m_s2(j,1)=0;
%             end
              m_s2(j,1)=lambda*all_s2(R(j,1),R(j,2));
            end
            if pic(R(j,1),R(j,2),1)==0 && pic(R(j,1),R(j,2),2)==0 && pic(R(j,1),R(j,2),3)==0 || ...
               pic(R(j,1),R(j,2),1)==237 && pic(R(j,1),R(j,2),2)==28 && pic(R(j,1),R(j,2),3)==36
                m_r(j,1)=beta;
            else
                m_r(j,1)=0;
            end
            if j==5
                continue
            else
                if pic(R(j,1),R(j,2),1)==237 && pic(R(j,1),R(j,2),2)==28 && pic(R(j,1),R(j,2),3)==36
                    XX=man(man(:,2)==R(j,2) & man(:,1)==R(j,1),3);%��ΧһȦ�˵ķ���
                    XX(all(XX == 0, 2),:)=[];
                    if size(XX,1)==0
                        continue
                    else
                        direction(j,1)=XX(randperm(size(XX,1),1),1); %�����зǶ����ռ��һ�����ӵ�����
                    end
                end
            end
        end
        direction(5,:)=[]; %����������ľ��߷���
        table=tabulate(direction);
        [maxCount,idx] = max(table(:,2));
        res=table(idx); %���س�����������Ԫ��
        if res~=0
            m_d(idx,1)=delta;
        end
        N=exp(ks*(m_s1+m_s2+m_s3)+kr*m_r+kd*m_d);
        sum_N=sum(N);
        for j =1:size(R,1)   %һ��ѭ��9��
             if pic(R(j,1),R(j,2),1)==0 && pic(R(j,1),R(j,2),2)==0 && pic(R(j,1),R(j,2),3)==0
                 w=0;
             else
                 w=1;
             end
             if pic(R(j,1),R(j,2),1)==237 && pic(R(j,1),R(j,2),2)==28 && pic(R(j,1),R(j,2),3)==36
                 m=1;
             else
                 m=0;
             end
             m_p(j,1)=N(j,1)*w*(1-m)/sum_N;
        end
         c_sum=cumsum(m_p);
         if c_sum==0
             man(i,3)=5; %�������ˣ���·����
             continue
         end
         rand_p=unifrnd(0,max(c_sum));
         if rand_p>=0 && rand_p <c_sum(1)
             man(i,3)=1;
         elseif rand_p>=c_sum(1) && rand_p<c_sum(2)
             man(i,3)=2;
         elseif rand_p>=c_sum(2) && rand_p<c_sum(3)
             man(i,3)=3;
         elseif rand_p>=c_sum(3) && rand_p<c_sum(4)
             man(i,3)=4;
         elseif rand_p>=c_sum(4) && rand_p<c_sum(5)
             man(i,3)=5;
         elseif rand_p>=c_sum(5) && rand_p<c_sum(6)
             man(i,3)=6;
         elseif rand_p>=c_sum(6) && rand_p<c_sum(7)
             man(i,3)=7;
         elseif rand_p>=c_sum(7) && rand_p<c_sum(8)
             man(i,3)=8;
         elseif rand_p>=c_sum(8) && rand_p<c_sum(9)
             man(i,3)=9;
         else
             fprintf('108 error')
         end
    end %man��3�и������
    occupy=zeros(3420,1395);
    for i =1:size(man,1) %��ʼ����man��1��2��
        color=[test(man(i,1),man(i,2),1),test(man(i,1),man(i,2),2),test(man(i,1),man(i,2),3)];
        if color(1,1)==34 && color(1,2)==177 && color(1,3)==76 %��ɫ
            man(i,4)=1; %1��ʾ���˳��ڣ�������ɾ��
            if man(i,1)<1800
                result(t,8)=result(t,8)+1;   %��gate1��ȥ
            elseif man(i,1)>1800 && man(i,1)<2500
                result(t,9)=result(t,9)+1;   %��gate2��ȥ
            else
                result(t,10)=result(t,10)+1; %��gate3��ȥ
            end
            continue
        end  
        if color(1,1)==255 && color(1,2)==242 && color(1,3)==0 && man(i,4)==0 %��ɫ����Ϊ�����ƶ�״̬
            ele=ele_match([man(i,1),man(i,2)],test,up_stair,down_stair,stair);
            nele=randperm(size(ele,1),1);
            tar=ele(nele,:);
            if occupy(tar(1,1),tar(1,2))==0    %���λ��û����
                 man(i,1)=tar(1,1);
                 man(i,2)=tar(1,2);
                 occupy(tar(1,1),tar(1,2))=1; 
                 man(i,4)=2;  %����״̬���뿪���ݺ�ȵ��ǵ��ݸ�״̬�ָ�����ֹ�ظ�ʹ�õ���
            else
                man(i,3)=5; %�ȴ�
            end
            continue
        end
        
        if color(1,1)==255 && color(1,2)==127 && color(1,3)==39 && man(i,4)==0 %��ɫ����Ϊ�����ƶ�״̬
            ele=ele_match([man(i,1),man(i,2)],test,up_stair,down_stair,stair);
            nele=randperm(size(ele,1),1);
            tar=ele(nele,:);
            if occupy(tar(1,1),tar(1,2))==0    %���λ��û����
                 man(i,1)=tar(1,1);
                 man(i,2)=tar(1,2);
                 occupy(tar(1,1),tar(1,2))=1; 
                 man(i,4)=2;  %����״̬���뿪���ݺ�ȵ��ǵ��ݸ�״̬�ָ�����ֹ�ظ�ʹ�õ���
            else
                man(i,3)=5; %�ȴ�
            end
            continue
        end
        
        if color(1,1)==185 && color(1,2)==122 && color(1,3)==87 && man(i,4)==0 %��ɫ����Ϊ�����ƶ�״̬
            ele=ele_match([man(i,1),man(i,2)],test,up_stair,down_stair,stair);
            d11=min([dis2([ele(1,1),ele(1,2)],gate1,test,up_stair,down_stair,stair), ...
                     dis2([ele(1,1),ele(1,2)],gate2,test,up_stair,down_stair,stair), ...
                     dis2([ele(1,1),ele(1,2)],gate3,test,up_stair,down_stair,stair)]);
            d12=min([dis2([ele(size(ele,1),1),ele(size(ele,1),2)],gate1,test,up_stair,down_stair,stair), ...
                     dis2([ele(size(ele,1),1),ele(size(ele,1),2)],gate2,test,up_stair,down_stair,stair), ...
                     dis2([ele(size(ele,1),1),ele(size(ele,1),2)],gate3,test,up_stair,down_stair,stair)]);
            if d11<d12
                ele=ball_search([ele(1,1),ele(1,2)],test);
            else
                ele=ball_search([ele(size(ele,1),1),ele(size(ele,1),2)],test);
            end
            nele=randperm(size(ele,1),1);
            tar=ele(nele,:);
            if occupy(tar(1,1),tar(1,2))==0    %���λ��û����
                 man(i,1)=tar(1,1);
                 man(i,2)=tar(1,2);
                 occupy(tar(1,1),tar(1,2))=1; 
                 man(i,4)=2;  %����״̬���뿪���ݺ�ȵ��ǵ��ݸ�״̬�ָ�����ֹ�ظ�ʹ�õ���
            else
                man(i,3)=5; %�ȴ�
            end
            continue
        end
            

        tar=around([man(i,1),man(i,2)],man(i,3));
        if occupy(tar(1,1),tar(1,2))==0    %���λ��û����
             man(i,1)=tar(1,1);
             man(i,2)=tar(1,2);
             occupy(tar(1,1),tar(1,2))=1;  
        else                               %���λ������
            if rand(1)>0.5  %һ������ǰ����ʹ��ԭ��ռ�д˸��ӵ���ֹͣ
                man_t=find(man(:,2)==tar(1,2) & man(:,1)==tar(1,1));%�ҵ��õڼ�����ͣ
                if man(man_t,3)~=5 %�������˶���
                    tar_t=around([tar(1,1),tar(1,2)],-1*man(man_t,3));%������һ��
                    man(man_t,1)=tar_t(1,1);
                    man(man_t,2)=tar_t(1,2);
                    man(man_t,3)=5; %��ʾ�ȴ�״̬
                    man(i,1)=tar(1,1);
                    man(i,2)=tar(1,2); 
                else
                    man(i,3)=5; %�˵��ݵ���û�����ˣ��������߶��ȴ�
                end
            else  %һ������ֹͣǰ��������man��λ��״̬����
                man(i,3)=5;
            end
        end
    end
    bottleneck=bottleneck+occupy;
    man(man(:,4)==1,:)=[] ;%ɾ���ڳ��ڵ���
    result(t,6)=t;
    result(t,7)=size(man,1);
    [t,size(man,1)]
    pic=test;%test��ԭͼ����ԭͼ�ϻ����%��ʼ�ı���ɫ
    for i=1:size(man,1)
        f=6-ceil(man(i,1)/684);
        result(t,f)=result(t,f)+1;
        pic(man(i,1),man(i,2),1)=237;
        pic(man(i,1),man(i,2),2)=28;
        pic(man(i,1),man(i,2),3)=36;
    end
     %set(imh,'cdata',pic);
     %drawnow;
     if result(t,7)<=n/2
         break
     end
end
result(all(result == 0, 2),:)=[];
%image(pic);
%imwrite(pic,'test_main.png')
%plot(result1(:,1),result1(:,2))

function [newCenter,class,classCounterDistance]=calculateClassDistance(x,center,datarow,centerNum,sum1,kindNum)

if(nargin==4)
  for i=1:datarow
    for j=1:centerNum
      distancedata(j,i)=pdist2(x(:,i)',center(:,j)','Euclidean');%920,��ȷ���õ���ŷ�Ͼ������������֮��ľ���
        % distancedata(j,i)=pdist([x(:,i),center(:,j)]');
  %   distancedata(j,i)=(x(:,i)-center(:,j))'*(x(:,i)-center(:,j));%�������i�㵽�͸������ĵľ���
    end
  temp=find(distancedata(:,i)==min(distancedata(:,i)));%9.17 ֮������ôд����Ϊ�³�����x=[1,1,3],find(x==min(x))�᷵������ֵ��������ʵ�������
  %�����ֽ�����������ʽ�洢���������������t=temp(1,1)ȡ��һ���Ϳ�����
    t=temp(1,1);%i����t�����Ľ�
    %**************9.17**************
    %t��������㵽���о��������о�����̵��Ǹ����ĵ�������ĵ��࣬�������������ĵ㣬���t==2����ʾi����㵽�ڶ������ĵ�ľ�����̣��������
    %��ҲӦ�ù������ڶ����У���t==2
    class(i)=t;
    classCounterDistance(i,:)=[min(distancedata(:,i)),t];%��������i���Ӧ�������ĸ����Լ��������ľ���洢������
    %�����Ϊ���Ժ����׼�����õģ����ǰ�ͬ��ľ��붼������
    %**************9.17**************
  end
  newCenter=center;
end

if(nargin==6)
  for i=1:datarow
    for j=1:centerNum
      distancedata(j,i)=pdist2(x(:,i)',center(:,j)','Euclidean');%920,��ȷ���õ���ŷ�Ͼ������������֮��ľ���
        % distancedata(j,i)=pdist([x(:,i),center(:,j)]');
  %   distancedata(j,i)=(x(:,i)-center(:,j))'*(x(:,i)-center(:,j));%�������i�㵽�͸������ĵľ���
    end
  temp=find(distancedata(:,i)==min(distancedata(:,i)));%9.17 ֮������ôд����Ϊ�³�����x=[1,1,3],find(x==min(x))�᷵������ֵ��������ʵ�������
  %�����ֽ�����������ʽ�洢���������������t=temp(1,1)ȡ��һ���Ϳ�����
    t=temp(1,1);%i����t�����Ľ�
    %**************9.17**************
    %t��������㵽���о��������о�����̵��Ǹ����ĵ�������ĵ��࣬�������������ĵ㣬���t==2����ʾi����㵽�ڶ������ĵ�ľ�����̣��������
    %��ҲӦ�ù������ڶ����У���t==2
    class(i)=t;
    classCounterDistance(i,:)=[min(distancedata(:,i)),t];%��������i���Ӧ�������ĸ����Լ��������ľ���洢������
    %�����Ϊ���Ժ����׼�����õģ����ǰ�ͬ��ľ��붼������
    %**************9.17**************
    
%     for j=1:length(x)/2
%         if t==j
%             sum1(:,j)=sum1(:,j)+x(:,i);
%             kindNum(j)=kindNum(j)+1;
%         end
%     end
sum1(:,t)=sum1(:,t)+x(:,i);
kindNum(t)=kindNum(t)+1;
%����д����ʡȥ����Ҫ��ѭ������Ȼt��j����һһ��Ӧ��ֱ����t�滻j

  end
   
  for t=1:centerNum%924��jȫ���滻��t
    newCenter(:,t)=sum1(:,t)./kindNum(t);%�����µ�����
 end
%920
end
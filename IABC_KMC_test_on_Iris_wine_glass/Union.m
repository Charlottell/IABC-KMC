clear all
close all
clc
%%%%%%%%%%***********��926��926�����ϼ�����ȫ�֣������������ȶ�********%%%%%%%%%%%%%
%%%%%%%%***********929��ԭ�л����Ͻ�length��Ϊsize(**,1)������Ϊ�˼��ݸ�ά����*********%%%%%
tic

%Colony=load('D:\����\��һƪ��ϲ���\k-means   matlab\rand919.txt');
%Colony=load('D:\����\��һƪ��ϲ���\matlabwork\Iris913.txt');
iteration=1;
for r=1:3
    if(iteration==1)
          Colony=load('D:\����\��һƪ��ϲ���\matlabwork\Iris913.txt');
          ABCOpts = struct( 'ColonySize',  10, ...  
    'MaxCycles', 100,...  
    'Limit',   10, ... %925ԭ����100�����ڸ�Ϊ50�������仯����
     'lb',  0, ... 
    'ub',  8, ... 
    'ObjFun' , 'Sphere', ... 
    'RunTime',1); 
ColonyNumber=6;%�����ڲ���data.txt���ݼ�ʱȺ���ģҪ��㣬�����ڲ���rand922��rand919ʱֻҪ������Դ����Ҫ��Ľ����������
      end
    
    
      if(iteration==2)
          Colony=load('D:\����\��һƪ��ϲ���\matlabwork\balancescale929.txt');
          ABCOpts = struct( 'ColonySize',  10, ...  
    'MaxCycles', 100,...  
    'Limit',   10, ... %925ԭ����100�����ڸ�Ϊ50�������仯����
     'lb',  0, ... 
    'ub',  5, ... 
    'ObjFun' , 'Sphere', ... 
    'RunTime',1); 
ColonyNumber=6;%�����ڲ���data.txt���ݼ�ʱȺ���ģҪ��㣬�����ڲ���rand922��rand919ʱֻҪ������Դ����Ҫ��Ľ����������
      end
      
       if(iteration==3)
          Colony=load('D:\����\��һƪ��ϲ���\matlabwork\glass929.txt');
          ABCOpts = struct( 'ColonySize',  10, ...  
    'MaxCycles', 100,...  
    'Limit',   10, ... %925ԭ����100�����ڸ�Ϊ50�������仯����
     'lb',  0, ... 
    'ub',  76, ... 
    'ObjFun' , 'Sphere', ... 
    'RunTime',1); 
ColonyNumber=12;%�����ڲ���data.txt���ݼ�ʱȺ���ģҪ��㣬�����ڲ���rand922��rand919ʱֻҪ������Դ����Ҫ��Ľ����������
      end


%**************��ʼ���׶�******************      ������ʼ����Ⱥ�������͸����

ColonyTotal=testmaxmindistance915(Colony,ColonyNumber);%�����+����� �ܸ���
%%
%***********928������ʼ��**********
FitEmpArray=zeros(1,ABCOpts.MaxCycles);%928Ϊ�������ʾÿ�εõ���FitEmp�ı仯���ƣ�������Ҫ�洢����
[datarow,datacolumn]=size(Colony);
centerNum=size(ColonyTotal,1);%929�����ݼ�ά����lengthСʱ��length�ǿ��Եģ����ǵ�ά���ܴ�ʱ��Ҫ��size(ColonyTotal,1)
Bas=zeros(1,(size(ColonyTotal,1)/2));
kindNum=linspace(0,0,size(ColonyTotal,1)/2);
sum1=zeros(datacolumn,size(ColonyTotal,1)/2);
%%
%926*************start������������Ӧ��***************
center=ColonyTotal;
[newCenter,class,classCounterDistance]=calculateClassDistance(Colony',center',datarow,centerNum);

total=0;
sumDistance=zeros(1,size(ColonyTotal,1)/2);
FitEmp=zeros(1,size(ColonyTotal,1)/2);
for i=1:(size(ColonyTotal,1)/2)
    total=length(find(classCounterDistance(:,2)==i));
    sumDistance(i)=sum(classCounterDistance(classCounterDistance(:,2)==i,1));
  if(sumDistance(i)==0)
     FitEmp(i)=0;
  else
   FitEmp(i)=total/sumDistance(i);
  end
end
%%
%*********928������Ӧ��ֵ��Сɸѡ�������͸����
FitEmpClass=sortrows([FitEmp;1:ColonyNumber/2]');
% Onlooker=ColonyTotal(FitEmpClass(1:size(ColonyTotal,1)/2,2),:);
% Employed=setdiff(ColonyTotal,Onlooker,'rows');
%****************Ϊ����FitEmp�ܺͺ����FitEmp2����һ�£������ﰴ��Employedȡ��FitEmpֵ����
% FitEmp=FitEmpClass(size(FitEmpClass)/2+1:size(FitEmpClass,1),1)';
Employed=ColonyTotal(FitEmpClass(1:size(ColonyTotal,1)/2,2),:);

 %%
 %*************927���ϴ˶Σ���Ҫ�ǶԷ���õ�Employed���¼���FitEmp������֤���Ӿ�ȷ����Ϊǰ���FitEmp������Colony
 %Total�����ĵ����������ģ����Ǽ���֮���������ԵĲ��Ǻ��ȶ�************
%     center=Employed;
%        centerNum=size(ColonyTotal,1)/2;
%        centerNum=size(ColonyTotal,1)/2;%������4������Ϊ����Ҫ������������������ϵ��ǰ���ǱȽ��ǱȽ�ColonyTotal����Ӧ�ȴ�С
%        [newCenter,class,classCounterDistance]=calculateClassDistance(Colony',center',datarow,centerNum);
%        total=0;
%        sumDistance=zeros(1,size(ColonyTotal,1)/2);
%        FitEmp=zeros(1,size(ColonyTotal,1)/2);
%        for k=1:(size(ColonyTotal,1)/2)
%            total=length(find(classCounterDistance(:,2)==k));
%            sumDistance(k)=sum(classCounterDistance(classCounterDistance(:,2)==k,1));
%           if(sumDistance(k)==0)
%              FitEmp(k)=0;
%           else
%              FitEmp(k)=total/sumDistance(k);
%           end
%        end
    %%  103��֤�ڽ��ͼ�е������ԣ���һ��ʼ��FitEmpҲ����ʾ�ڽ��ͼ��
    %Ϊ�˱���һ���ԣ�������������Cycle=1�������Cycle=1��ΪCycle=2
        Cycle=1;
        FitEmpArray(Cycle)=sum(FitEmp); 
%%
%*****************ȫ��**************
%   FitArrayCounterNumber=[FitEmp;1:length(ColonyTotal)/2]';%923�Ƚ�Employed�е�Ԫ�ؼ��������а������
%   maxFitArray=sortrows(FitArrayCounterNumber);%��FitArrayCounterNumber���鰴���м���Ӧ��ֵ��С�Ӵ�С���У����Ҳ����仯���γ�������maxFitArray
  Employed_Best=Employed(size(Employed,1),:);%�ҳ�maxFitArray�����һ��Ԫ�ؼ���Ӧ��ֵ���������Ӧ�ĵĽǱ���Employed���ҵ���Ӧ���λ������
  Employed_SecondBest=Employed(size(Employed,1)-1,:);

%*************end������Ӧ�ȣ�������͸�ֵ**************

%%

    Cycle=2;
    y=1;
    while (Cycle <= ABCOpts.MaxCycles&&((length(find((Employed(:,1))==999))<5)))
      %% Employed Bee
        Employed2=Employed;
       for i=1:size(ColonyTotal,1)/2
        Param2Change=fix(rand*datacolumn)+1;%��Ӧ��j
        neighbour=fix(rand*(size(ColonyTotal,1)/2))+1;%��Ӧ��k
        neighbour1=fix(rand*(size(ColonyTotal,1)/2))+1;%��Ӧ��p
            while(neighbour==i||neighbour1==i||neighbour==neighbour1)
                neighbour=fix(rand*(size(ColonyTotal,1)/2))+1;
                neighbour1=fix(rand*(size(ColonyTotal,1)/2))+1;
            end;
        Employed2(i,Param2Change)=Employed(i,Param2Change)+(Employed(neighbour,Param2Change)-Employed(neighbour1,Param2Change))*(rand-0.5)*2+(Employed_Best(1,Param2Change)-Employed(i,Param2Change))*(rand-0.5)*2;
           if (Employed2(i,Param2Change)<ABCOpts.lb)
              Employed2(i,Param2Change)=Employed(i,Param2Change);
           end;
           if (Employed2(i,Param2Change)>ABCOpts.ub)
              Employed2(i,Param2Change)=Employed(i,Param2Change);
           end;
     
       %926*******************start�����������ĵ�������·��࣬��������Ӧ��*****************
       center=Employed2;
       centerNum=size(ColonyTotal,1)/2;
       centerNum=size(ColonyTotal,1)/2;%������4������Ϊ����Ҫ������������������ϵ��ǰ���ǱȽ��ǱȽ�ColonyTotal����Ӧ�ȴ�С
       [newCenter,class,classCounterDistance]=calculateClassDistance(Colony',center',datarow,centerNum);
       total2=0;
       sumDistance2=zeros(1,size(ColonyTotal,1)/2);
       FitEmp2=zeros(1,size(ColonyTotal,1)/2);
       for k=1:(size(ColonyTotal,1)/2)
           total2=length(find(classCounterDistance(:,2)==k));
           sumDistance2(k)=sum(classCounterDistance(classCounterDistance(:,2)==k,1));
          if(sumDistance2(k)==0)
             FitEmp2(k)=0;
          else
             FitEmp2(k)=total2/sumDistance2(k);
          end
       end
     %******************̰���㷨���Ƚϵ�ǰ�͸��º�λ�õ���Ӧ�ȣ�˭����****************************
     [Employed FitEmp Bas]=GreedySelection(Employed,Employed2,FitEmp,FitEmp2,Bas,i);
      end;
      NormFit=FitEmp/sum(FitEmp);
      %926*******************end�����������ĵ�������·��࣬��������Ӧ��*****************
      
      
      %*******************ȫ��*********************
        FitArrayCounterNumber=[FitEmp;1:size(ColonyTotal,1)/2]';
        maxFitArray=sortrows(FitArrayCounterNumber);
        Employed_Best=Employed(maxFitArray(size(maxFitArray,1),2),:);
        Employed_SecondBest=Employed(maxFitArray(size(maxFitArray,1)-1,2),:);

      
      %% Onlooker Bee
      Employed2=Employed;
      i=1;
      t=0;
      while(t<size(ColonyTotal,1)/2) 
        if(rand<NormFit(i))
         t=t+1;
         Param2Change=fix(rand*datacolumn)+1;
         neighbour=fix(rand*(size(ColonyTotal,1)/2))+1;%��Ӧ��k
         neighbour1=fix(rand*(size(ColonyTotal,1)/2))+1;%��Ӧ��p
            while(neighbour==i||neighbour1==i||neighbour==neighbour1)
                neighbour=fix(rand*(size(ColonyTotal,1)/2))+1;
                neighbour1=fix(rand*(size(ColonyTotal,1)/2))+1;
            end;
        %Employed2(i,Param2Change)=Employed(i,Param2Change)+(Employed(i,Param2Change)-Employed(neighbour,Param2Change))*(rand-0.5)*2;
        Employed2(i,Param2Change)=Employed(i,Param2Change)+(Employed(neighbour,Param2Change)-Employed(neighbour1,Param2Change))*(rand-0.5)*2+(Employed_Best(1,Param2Change)-Employed(i,Param2Change))*(rand-0.5)*2;
        % Employed2(i,Param2Change)=Employed(i,Param2Change)+(Employed(i,Param2Change)-Employed(neighbour,Param2Change))*(rand-0.5)*2;
           if (Employed2(i,Param2Change)<ABCOpts.lb)
              Employed2(i,Param2Change)=Employed(i,Param2Change);
           end;
           if (Employed2(i,Param2Change)>ABCOpts.ub)
              Employed2(i,Param2Change)=Employed(i,Param2Change);
           end;  
     %***************�ó�����������λ�ã������ݼ�������Ԫ�ؽ���һ���µ�������ķ���
       center=Employed2;
       [newCenter,class,classCounterDistance]=calculateClassDistance(Colony',center',datarow,centerNum);
     %*****************������Ӧ��*******************
       total2=0;
       sumDistance2=zeros(1,size(ColonyTotal,1)/2);
       FitEmp2=zeros(1,size(ColonyTotal,1)/2);
       for k=1:(size(ColonyTotal,1)/2)
           total2=length(find(classCounterDistance(:,2)==k));
           sumDistance2(k)=sum(classCounterDistance(classCounterDistance(:,2)==k,1));
          if(sumDistance2(k)==0)
             FitEmp2(k)=0;
          else
             FitEmp2(k)=total2/sumDistance2(k);
          end
       end;
     %******************̰���㷨���Ƚϵ�ǰ�͸��º�λ�õ���Ӧ�ȣ�˭����****************************
     [Employed FitEmp Bas]=GreedySelection(Employed,Employed2,FitEmp,FitEmp2,Bas,i);%924֮ǰһֱд����i,�����Ǵ���ģ���Ϊ�����i�Ѿ������汻for i=1:length(Colony)/2ʹ���ˣ�
        end;
        i=i+1;
        if (i==(size(ColonyTotal,1)/2)+1)  %���������Χ����i��1
         i=1;
        end;   
      end;
      
      %*******************ȫ��*********************
        FitArrayCounterNumber=[FitEmp;1:size(ColonyTotal,1)/2]';
        maxFitArray=sortrows(FitArrayCounterNumber);
        Employed_Best=Employed(maxFitArray(size(maxFitArray,1),2),:);
        Employed_SecondBest=Employed(maxFitArray(size(maxFitArray,1)-1,2),:);
      
      
      %% Scout phase
        ind=find(Bas==max(Bas));%�ҵ�û�б����´��������Ǹ�ʳ��ԴXi�����Ѵ�����limit�Ƚ�
        ind=ind(end);
        if (Bas(ind)>ABCOpts.Limit)
         Bas(ind)=0;
         neighbour=fix(rand*(size(ColonyTotal,1)/2))+1;%��Ӧ��k
         neighbour1=fix(rand*(size(ColonyTotal,1)/2))+1;%��Ӧ��p
            while(neighbour==i||neighbour1==i||neighbour==neighbour1)
                neighbour=fix(rand*(size(ColonyTotal,1)/2))+1;
                neighbour1=fix(rand*(size(ColonyTotal,1)/2))+1;
            end;
        %Employed2(i,Param2Change)=Employed(i,Param2Change)+(Employed(i,Param2Change)-Employed(neighbour,Param2Change))*(rand-0.5)*2;
        Employed2(i,Param2Change)=Employed(i,Param2Change)+(Employed(neighbour,Param2Change)-Employed(neighbour1,Param2Change))*(rand-0.5)*2+(Employed_Best(1,Param2Change)-Employed(i,Param2Change))*(rand-0.5)*2;
           % Employed2(ind,Param2Change)=Employed(ind,Param2Change)+(Employed(ind,Param2Change)-Employed(neighbour,Param2Change))*(rand-0.5)*2;

           if (Employed2(i,Param2Change)<ABCOpts.lb)
              Employed2(i,Param2Change)=Employed(i,Param2Change);
           end;
           if (Employed2(i,Param2Change)>ABCOpts.ub)
              Employed2(i,Param2Change)=Employed(i,Param2Change);
           end;
      
       %926*******************start�����������ĵ�������·��࣬��������Ӧ��*****************
       center=Employed2;
       centerNum=size(ColonyTotal,1)/2;%������4������Ϊ����Ҫ������������������ϵ��ǰ���ǱȽ��ǱȽ�ColonyTotal����Ӧ�ȴ�С
       [newCenter,class,classCounterDistance]=calculateClassDistance(Colony',center',datarow,centerNum,sum1,kindNum);
       total2=0;
       sumDistance2=zeros(1,size(ColonyTotal,1)/2);
       FitEmp2=zeros(1,size(ColonyTotal,1)/2);
       for i=1:(size(ColonyTotal,1)/2)
           total2=length(find(classCounterDistance(:,2)==i));
           sumDistance2(i)=sum(classCounterDistance(classCounterDistance(:,2)==i,1));
          if(sumDistance2(i)==0)
             FitEmp2(i)=0;
          else
             FitEmp2(i)=total2/sumDistance2(i);
          end
       end
     %******************̰���㷨���Ƚϵ�ǰ�͸��º�λ�õ���Ӧ�ȣ�˭����****************************
     [Employed FitEmp Bas]=GreedySelection(Employed,Employed2,FitEmp,FitEmp2,Bas);
      %926*******************end�����������ĵ�������·��࣬��������Ӧ��*****************
        end
      %%  k-means���̶������������ĵ����һ�ξ��࣬�ó���������
       %*********************ʹ��k-means���о��࣬�ҳ����ʵ��µľ������ĸ���Employed*************
       kindNum=linspace(0,0,size(ColonyTotal,1)/2);
       [newCenter,class,classCounterDistance]=calculateClassDistance(Colony',Employed',datarow,centerNum,sum1,kindNum);
       %********928֮ǰû�м�����һ�䣬�������newCenter��������Employed��Ӧ�����ĵ㣬������Ҫ��ɸѡ���Emplo
       %yed����һ�����ĵ�������㣬�����õ������ݸ���ȷ************
       step=10;
      while (sum(sum(newCenter'~=Employed)))&&step
        Employed=newCenter'; 
        times=10-step+1;
        sum1=zeros(datacolumn,centerNum);
        [newCenter,class,classCounterDistance]=calculateClassDistance(Colony',Employed',datarow,centerNum,sum1,kindNum);
        step=step-1;
      end
        Employed=newCenter';
        %Employed(isnan(Employed)==1)=999; 
       %% ����FitEmp���̣�û����δ��룬������������Ҳ�ܺ�
        %********************928������������׼ȷ����Ϊ����һ��ѭ�����õ���FitEmp���������ʽ����õ�FitEmp
        %���������׼ȷ����Ϊ����µ�λ��Ҫ���¼�������Ӧ�ȣ�����Ϊ��һ�ε�FitEmp*********
        total=0;
       sumDistance=zeros(1,size(ColonyTotal,1)/2);
       FitEmp=zeros(1,size(ColonyTotal,1)/2);
       for k=1:(size(ColonyTotal,1)/2)
           total=length(find(classCounterDistance(:,2)==k));
           sumDistance(k)=sum(classCounterDistance(classCounterDistance(:,2)==k,1));
          if(sumDistance(k)==0)
             FitEmp(k)=0;
          else
             FitEmp(k)=total/sumDistance(k);
          end
       end
        
    
      fprintf('��%d����������Employed�����飺\n',Cycle);
      disp(Employed);    
      disp('FitEmp��ֵΪ��');
      disp(FitEmp);
      FitEmpArray(Cycle)=sum(FitEmp);  
      Cycle=Cycle+1;  

      
    end;
    
    
    hold on;
    title('Iris��Balance-scale��Glass���ݼ���Ӧ��ֵ�仯����');
    xlabel('����������cycles��');
    ylabel('��Ӧ�ȣ�fitness��');%103
    if(iteration==1)
            semilogy(FitEmpArray,'k-');%928���ڻ���FitEmpֵ��ѭ��MaxCycles֮��ı仯����
    end;
    if(iteration==2)
        semilogy(FitEmpArray,'k:');
    end;
    if(iteration==3)
        semilogy(FitEmpArray,'k-.');
    end;
    legend('Iris','Balance-scale','Glass');
    
    
    %plot(FitEmpArray);
    
    
    
    %% ���ƽ��ͼ
% uniqueNumber=unique(class)';
%  m=1;
%  figure;
% for iuniquelength=1:4
%    
%     hold on;
%     if(mod(m,4)==1)
%     plot(Colony(classCounterDistance(:,2)==uniqueNumber(iuniquelength),1),Colony(classCounterDistance(:,2)==uniqueNumber(iuniquelength),2),'r*');
%     m=m+1;
%     continue;
%     end
%      if(mod(m,4)==2)
%     plot(Colony(classCounterDistance(:,2)==uniqueNumber(iuniquelength),1),Colony(classCounterDistance(:,2)==uniqueNumber(iuniquelength),2),'b+');
%     m=m+1;
%     continue;
%      end
%      if(mod(m,4)==3)
%     plot(Colony(classCounterDistance(:,2)==uniqueNumber(iuniquelength),1),Colony(classCounterDistance(:,2)==uniqueNumber(iuniquelength),2),'g>');
%     m=m+1;
%     continue;
%      end
%      if(mod(m,4)==0)
%     plot(Colony(classCounterDistance(:,2)==uniqueNumber(iuniquelength),1),Colony(classCounterDistance(:,2)==uniqueNumber(iuniquelength),2),'kp');
%     m=m+1;
%     continue;
%      end
%      hold on;
%      grid;
%      break;
% end
   
iteration=iteration+1;


end;
toc

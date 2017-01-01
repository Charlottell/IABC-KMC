%%%%%ARTIFICIAL BEE COLONY ALGORITHM%%%%

%Artificial Bee Colony Algorithm was developed by Dervis Karaboga in 2005 
%by simulating the foraging behaviour of bees.

%Copyright ?2008 Erciyes University, Intelligent Systems Research Group, The Dept. of Computer Engineering

%Contact:
%Dervis Karaboga (karaboga@erciyes.edu.tr )
%Bahriye Basturk Akay (bahriye@erciyes.edu.tr)

function GlobalMins=runABCimprove(b)

%******************928������Employed_Best��Employed_SecondBest************
% clear all
% close all
% clc



% Set ABC Control Parameters
ABCOpts = struct( 'ColonySize',  20, ...   % Number of Employed Bees+ Number of Onlooker Bees 
    'MaxCycles', 2000,...   % Maximum cycle number in order to terminate the algorithm
    'ErrGoal',     1e-20, ...  % Error goal in order to terminate the algorithm (not used in the code in current version)
    'Dim',       2 , ... % Number of parameters of the objective function   
    'Limit',   100, ... % Control paramter in order to abandone the food source 
    'lb',  -3, ... % Lower bound of the parameters to be optimized
    'ub',  3, ... %Upper bound of the parameters to be optimized
    'ObjFun' , 'griewank', ... %Write the name of the objective function you want to minimize
    'RunTime',1); % Number of the runs 



GlobalMins=zeros(ABCOpts.RunTime,ABCOpts.MaxCycles);

for r=1:ABCOpts.RunTime
    
% Initialise population
Range = repmat((ABCOpts.ub-ABCOpts.lb),[ABCOpts.ColonySize ABCOpts.Dim]);
Lower = repmat(ABCOpts.lb, [ABCOpts.ColonySize ABCOpts.Dim]);
Colony = rand(ABCOpts.ColonySize,ABCOpts.Dim) .* Range + Lower;%���ɳ�ʼColony������ColonySize�У�Dim�У�10*5
%zj�ȳ�ʼ����Ⱥ��ģ��������������㷨��ʽ�ӣ�x(j)i=x(j)min+rand(0,1)(x(j)max-x(j)min)


ObjEmp=feval(ABCOpts.ObjFun,Colony);
FitEmp=calculateFitness(ObjEmp);
FitEmpArray=[FitEmp';1:length(Colony)]';%928����Sphere���������Ժ�����FitEmp��Ҫת�ü�FitEmp'
FitEmpSort=sortrows(FitEmpArray);
Employed=Colony(FitEmpSort(length(Colony)/2+1:length(Colony),2),:);
FitEmp=FitEmpSort(length(Colony)/2+1:length(Colony),1)';


%Employed=Colony(1:(ABCOpts.ColonySize/2),:);%ǰһ��Ϊ������ʳ��Դ��5*5
%zj�ٽ���Ⱥ��ǰһ����Ϊ������ģ

         %***********ȫ��***********
        FitArrayCounterNumber=[FitEmp;1:length(Colony)/2]';%928����Sphere���������Ժ�����FitEmp��Ҫת�ü�FitEmp'
        maxFitArray=sortrows(FitArrayCounterNumber);
        Employed_Best=Employed(maxFitArray(length(maxFitArray),2),:);
        Employed_SecondBest=Employed(maxFitArray(length(maxFitArray)-1,2),:);

%evaluate and calculate fitness
ObjEmp=feval(ABCOpts.ObjFun,Employed);%�����������Employed��ÿһ�У�ÿһ��ʳ��ԴXi����Ŀ�꺯��ֵ��1*5
FitEmp=calculateFitness(ObjEmp);%����ʳ��Դ����Ӧ��ֵ��1*5

%set initial values of Bas
Bas=zeros(1,(ABCOpts.ColonySize/2));%1*5��ÿһ�ж�Ӧÿһ��Xiû�б����µĴ���


GlobalMin=ObjEmp(find(ObjEmp==min(ObjEmp),end));%����end���һ������ΪObjEmpΪһ�����������ҳ�Ŀ�꺯��ObjEmp����С��ֵ����GlobalMin��1*1
GlobalParams=Employed(find(ObjEmp==min(ObjEmp),end),:);%GlobalParams���Ŀ�꺯��ObjEmp��Сʱ��Ӧ�Ľ�,1*5

Cycle=1;
while ((Cycle <= ABCOpts.MaxCycles)),%��ʼѭ��
    
    %%%%% Employed phase
    Employed2=Employed;%Employed2��ÿһ�ж�Ӧ��Employedÿһ�е���������ֵ����Employedÿһ�д���Xij��Employed2ÿһ�д���Vij
    for i=1:ABCOpts.ColonySize/2%��Xij��ÿһ��i��ֻ��һ��j�ı䡣
        Param2Change=fix(rand*ABCOpts.Dim)+1;%��Ӧ��j
        %zj������㷨��Ҫ�ҵ�xij�е�j������Dim�е�һ�������
        neighbour=fix(rand*(ABCOpts.ColonySize/2))+1;%��Ӧ��k
        neighbour1=fix(rand*(ABCOpts.ColonySize/2))+1;%��Ӧ��k
           
            while(neighbour==i||neighbour1==i||neighbour==neighbour1)
                neighbour=fix(rand*(length(Colony)/2))+1;
                neighbour1=fix(rand*(length(Colony)/2))+1;
            end;
        Employed2(i,Param2Change)=Employed_Best(1,Param2Change)+(Employed(neighbour,Param2Change)-Employed(neighbour1,Param2Change))*(rand-0.5)*2+(Employed_SecondBest(1,Param2Change)-Employed(i,Param2Change))*(rand-0.5)*2;
        %Employed2(i,Param2Change)=Employed(i,Param2Change)+(Employed(neighbour,Param2Change)-Employed(neighbour1,Param2Change))*(rand-0.5)*2+(Employed_Best(1,Param2Change)-Employed(i,Param2Change))*(rand-0.5)*2;
        %����������λ�ø��¹�ʽ�������Է����ƺ�����Ĵ���Employed_Best��Employed_SecondBestҪ�������λ�ø���
        %��ʽ������ʱ�ٶȸ��졣
        
        
        
        %Employed2(i,Param2Change)=Employed(i,Param2Change)+(Employed(i,Param2Change)-Employed(neighbour,Param2Change))*(rand-0.5)*2;
        %���ܳ������½�
       %zj��������㷨��ʽ�ӣ�vij=xij+suijishu(xij-xkj),��ʽ��(rand-0.5)*2����Ϊ������suijishu�ķ�
       %Χ�����ڣ�-1,1��֮���
        if (Employed2(i,Param2Change)<ABCOpts.lb)
             Employed2(i,Param2Change)=ABCOpts.lb;
         end;
        if (Employed2(i,Param2Change)>ABCOpts.ub)
            Employed2(i,Param2Change)=ABCOpts.ub;
        end;
         %zj���ܳ��ڹ淶�Ŀ��ǣ�ǰ�������˲���lb��ub���������޶��µ�λ�ò�Ӧ��Խ�磬���������С�������޸���������������޴�
        %�����߸�����
end;   

    ObjEmp2=feval(ABCOpts.ObjFun,Employed2);%����ÿһ��Vi��Ŀ�꺯��ֵ��5*1
    FitEmp2=calculateFitness(ObjEmp2);%����ÿһ��Vi����Ӧ��ֵ��5*1
    [Employed ObjEmp FitEmp Bas]=GreedySelection(Employed,Employed2,ObjEmp,ObjEmp2,FitEmp,FitEmp2,Bas,ABCOpts);
     %zj  Employed��֮ǰ��λ�����飻   Employed2:����λ�ú�����飻   
    %ObjEmp��֮ǰ��Ŀ�꺯��ֵ��ÿֻ�۷䣩��    ObjEmp2������λ�ú��Ŀ�꺯��ֵ����ÿֻ�۷�ĺ���ֵ��
    %Bas����ʾ�����ɵĴ�����   ABCOpts�������ṹ��zj
    
    %̰��ԭ��ѡ��Employed ObjEmp FitEmp�ֱ��Ӧѡ����ʳ��Դ������ֵ����Ӧ��
    %Normalize
    NormFit=FitEmp/sum(FitEmp);%50*1��ÿһ�ж�Ӧ��Xi��Vi���Ž��Pi
    
     %***********ȫ��***********
        FitArrayCounterNumber=[FitEmp';1:length(Colony)/2]';%928����Sphere���������Ժ�����FitEmp��Ҫת�ü�FitEmp'
        maxFitArray=sortrows(FitArrayCounterNumber);
        Employed_Best=Employed(maxFitArray(length(maxFitArray),2),:);
        Employed_SecondBest=Employed(maxFitArray(length(maxFitArray)-1,2),:);
    
    %%% Onlooker phase  
Employed2=Employed;
%zj���������Employed2=Employed������ͨ�������Ķ�����������һ���������������=���������+��������������������=�������������
%�ң��������ǰ50%��������Ǻ�50%zj
i=1;
t=0;
while(t<ABCOpts.ColonySize/2) 
    %���̶�
    if(rand<NormFit(i))%NormFit(i)Խ�󣬱�ѡ�еĴ���Խ��
        t=t+1;%���и���䶼����ѡ���������и���
        Param2Change=fix(rand*ABCOpts.Dim)+1;
        neighbour=fix(rand*(ABCOpts.ColonySize/2))+1;
        
            while(neighbour==i||neighbour1==i||neighbour==neighbour1)
                neighbour=fix(rand*(length(Colony)/2))+1;
                neighbour1=fix(rand*(length(Colony)/2))+1;
            end;
        Employed2(i,Param2Change)=Employed_Best(1,Param2Change)+(Employed(neighbour,Param2Change)-Employed(neighbour1,Param2Change))*(rand-0.5)*2+(Employed_SecondBest(1,Param2Change)-Employed(i,Param2Change))*(rand-0.5)*2;
       % Employed2(i,Param2Change)=Employed(i,Param2Change)+(Employed(neighbour,Param2Change)-Employed(neighbour1,Param2Change))*(rand-0.5)*2+(Employed_Best(1,Param2Change)-Employed(i,Param2Change))*(rand-0.5)*2; 
        %����������λ�ø��¹�ʽ�������Է����ƺ�����Ĵ���Employed_Best��Employed_SecondBestҪ�������λ�ø���
        %��ʽ������ʱ�ٶȸ��졣
        
        
        %Employed2(i,Param2Change)=Employed(i,Param2Change)+(Employed(i,Param2Change)-Employed(neighbour,Param2Change))*(rand-0.5)*2;
         if (Employed2(i,Param2Change)<ABCOpts.lb)
             Employed2(i,Param2Change)=ABCOpts.lb;
         end;
        if (Employed2(i,Param2Change)>ABCOpts.ub)
            Employed2(i,Param2Change)=ABCOpts.ub;
         end;
    ObjEmp2=feval(ABCOpts.ObjFun,Employed2);%�������������������Ŀ�꺯��
    FitEmp2=calculateFitness(ObjEmp2);%���������������������Ӧ��
    [Employed ObjEmp FitEmp Bas]=GreedySelection(Employed,Employed2,ObjEmp,ObjEmp2,FitEmp,FitEmp2,Bas,ABCOpts,i);
   
   end;
    
    i=i+1;
    if (i==(ABCOpts.ColonySize/2)+1)  %���������Χ����i��1
        i=1;
    end;   
end;
    
    
    %%%Memorize Best
 CycleBestIndex=find(FitEmp==max(FitEmp));
 CycleBestIndex=CycleBestIndex(end);%����Ϊ���Բ�Ҫ
 CycleBestParams=Employed(CycleBestIndex,:);%ԭ��ע���ǡ���ÿ��ѭ�����ʶ�ֵ��С����Ӧ��ʳ��Դ���⣩������Ϊ�ǡ���ÿ��ѭ�����ʶ�ֵ�������Ӧ��ʳ��Դ���⣩��
 CycleMin=ObjEmp(CycleBestIndex);%ԭ�����ע���ǡ���ÿ��ѭ�����ʶ�ֵ��С����Ӧ�ĺ���ֵ��������Ϊ�ǡ���ÿ��ѭ�����ʶ�ֵ�������Ӧ�ĺ���ֵ��
 
 if CycleMin<GlobalMin %��ȫ����С���бȽ�
       GlobalMin=CycleMin;
       GlobalParams=CycleBestParams;
 end
 
 GlobalMins(r,Cycle)=GlobalMin;%��¼ÿ��ѭ������Ӧ��ȫ����Сֵ��1*2000
 
 %% Scout phase
 ind=find(Bas==max(Bas));%�ҵ�û�б����´��������Ǹ�ʳ��ԴXi�����Ѵ�����limit�Ƚ�
ind=ind(end);
if (Bas(ind)>ABCOpts.Limit)
Bas(ind)=0;
%Employed(ind,:)=(ABCOpts.ub-ABCOpts.lb)*(0.5-rand(1,ABCOpts.Dim))*2+ABCOpt
%s.lb;
Employed(ind,:)=(ABCOpts.ub-ABCOpts.lb)*(0.5-rand(1,ABCOpts.Dim))*2;%+ABCOpts.lb;
%        Employed2(i,Param2Change)=Employed(i,Param2Change)+(Employed(i,Par
%        am2Change)-Employed(neighbour,Param2Change))*(rand-0.5)*2;
%message=strcat('burada',num2str(ind))
end;
ObjEmp=feval(ABCOpts.ObjFun,Employed);
FitEmp=calculateFitness(ObjEmp);
    


    fprintf('Cycle=%d ObjVal=%g\n',Cycle,GlobalMin);
    
    Cycle=Cycle+1;

end % End of ABC

end; %end of runs
% if ABCOpts.RunTime==1
%     semilogy(GlobalMins,'b');
% else
%     semilogy(mean(GlobalMins),'b');%�����ִ�У����ֵ
% end
% %semilogy(mean(GlobalMins))
% title('Mean of Best function values');
% xlabel('cycles');
% ylabel('error');
fprintf('Mean =%g Std=%g\n',mean(GlobalMins(:,end)),std(GlobalMins(:,end)));%���GlobalMins�ľ�ֵ�ͷ���
  
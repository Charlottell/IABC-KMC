
function [Colony Fit oBas]=GreedySelection(Colony1,Colony2,FitEmp,FitEmp2,fbas,i)

oBas=fbas;
Fit=FitEmp;
Colony=Colony1;
if (nargin==5)%Inside the body of a user-defined function, NARGIN returns the number of input arguments that were used to call the function. 
for ind=1:size(Colony1,1)%ind=1��5��������ʳ��Դ����̰��ѡ��
    if (FitEmp2(ind)>FitEmp(ind))%���Vi����Ӧ��ֵ����Xi�ģ��滻��
        oBas(ind)=0;
         %zj��Ϊ�����Ѿ����µ�λ�ø����ˣ������俪�ɶ�Ӧ����Ϊ�㣬��ʾ���ǵ�һ�Σ�û�б����ɹ�
        Fit(ind)=FitEmp2(ind);
        Colony(ind,:)=Colony2(ind,:);
    else%���򲻱䣬���Ҽ�����bas+1
        oBas(ind)=fbas(ind)+1;
         %zj��Ϊ�µ�λ�õ���Ӧ��û�е�ǰ�ĺã��󣩣������ڵ�ǰλ�����Ա�����ǰ�⣬��ʾ��ǰ�ֱ�������һ��
        Fit(ind)=FitEmp(ind);
        Colony(ind,:)=Colony1(ind,:);
    end;
end; %for
end; %if
if(nargin==6)%��i������䱻���棬ֻ�Ե�i��ʳ��Դ����̰��ѡ��
    ind=i;
    if (FitEmp2(ind)>FitEmp(ind))
        oBas(ind)=0;
        Fit(ind)=FitEmp2(ind);
        Colony(ind,:)=Colony2(ind,:);
    else
        oBas(ind)=fbas(ind)+1;
        Fit(ind)=FitEmp(ind);
        Colony(ind,:)=Colony1(ind,:);
    end;
end; 
    
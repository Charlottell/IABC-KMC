a=3;
figure;
GlobalMins=runABC(a);
semilogy(GlobalMins,'k:');
%semilogy(mean(GlobalMins))
title('griewank��������Ӧ��ֵ��������');
xlabel('����������cycles��');
ylabel('��Ӧ�ȣ�fitness��');
b=3;
GlobalMins=runABCimprove(b);
GlobalMins1=GlobalMins;
hold on;
semilogy(GlobalMins1,'k-');
legend('ԭʼ��Ⱥ�㷨','�����㷨');

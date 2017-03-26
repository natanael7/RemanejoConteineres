close all
clear all
clc

%Arquivos no formato: gera��o mediamelhor desvmelhor
load errosAGCa.txt
load errosAGCo.txt
load errosAGEp.txt



% errosAGCa=errosAGCa';
% errosAGCo=errosAGCo';
% errosAGEp=errosAGEp';

size(errosAGCa);
x=errosAGCa(:,1);

figure(1)
plot(x,errosAGCo(:,2),'r-')
hold on
plot(x,errosAGEp(:,2),'b-')
plot(x,errosAGCa(:,2),'m-')
title('Valores M�dios')
xlabel('Gera��es')
ylabel('Qtd. de movimenta��es')
legend('AG Completo','AG c/ Epidemia','AG c/ Muta��o')





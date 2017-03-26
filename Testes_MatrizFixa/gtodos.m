close all
clear all
clc

%Arquivos no formato: geração mediamelhor desvmelhor
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
title('Valores Médios')
xlabel('Gerações')
ylabel('Qtd. de movimentações')
legend('AG Completo','AG c/ Epidemia','AG c/ Mutação')





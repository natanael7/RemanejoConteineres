clear all
close all
clc


%Carregamento dos arquivos
load giro1.txt;
load giro2.txt;
load giro3.txt;
load giro4.txt;
load giro5.txt;
load giro6.txt;
load giro7.txt;
load giro8.txt;
load giro9.txt;
load giro10.txt;
load giro11.txt;
load giro12.txt;
load giro13.txt;
load giro14.txt;
load giro15.txt;
load giro16.txt;
load giro17.txt;
load giro18.txt;
load giro19.txt;
load giro20.txt;
load giro21.txt;
load giro22.txt;
load giro23.txt;
load giro24.txt;
load giro25.txt;
load giro26.txt;
load giro27.txt;
load giro28.txt;
load giro29.txt;
load giro30.txt;

%Número de linhas do arquivo (nr. de gerações)
gera=size(giro1,1);
col=size(giro1,2);
x=1:gera;
step=30;


todos=cat(2,giro1(:,2:col), giro2(:,2:col), giro3(:,2:col), giro4(:,2:col), giro5(:,2:col), giro6(:,2:col), giro7(:,2:col),...
            giro8(:,2:col), giro9(:,2:col), giro10(:,2:col),...
            giro11(:,2:col), giro12(:,2:col), giro13(:,2:col), giro14(:,2:col), giro15(:,2:col), giro16(:,2:col), giro17(:,2:col),...
            giro18(:,2:col), giro19(:,2:col), giro20(:,2:col),...
            giro21(:,2:col), giro22(:,2:col), giro23(:,2:col), giro24(:,2:col), giro25(:,2:col), giro26(:,2:col), giro27(:,2:col),...
            giro28(:,2:col), giro29(:,2:col), giro30(:,2:col));

col=size(todos,2);

pior=0;
for i=1:gera %laço das gerações
    coluna=0;
    for j=1:3:col  %col %laço dos arquivos
        coluna=coluna+1;
        pior(i,coluna)=todos(i,j);
    end
end
finalpior=pior(gera,:);

medio=0;
for i=1:gera %laço das gerações
    coluna=0;
    for j=2:3:col  %col %laço dos arquivos
        coluna=coluna+1;
        medio(i,coluna)=todos(i,j);
    end
end
finalmedio=medio(gera,:);

melhor=0;
for i=1:gera %laço das gerações
    coluna=0;
    for j=3:3:col  %col %laço dos arquivos
        coluna=coluna+1;
        melhor(i,coluna)=todos(i,j);
    end
end
finalmelhor=melhor(gera,:);

%Cálculo dos valores médios e desvio padrão
medpior=mean(pior,2);
mediapior=mean(finalpior)
desvpior=std(pior,0,2);
stdpior=std(finalpior)
melhorpior=min(finalpior)

medmedio=mean(medio,2);
mediamedio=mean(finalmedio)
desvmedio=std(medio,0,2);
stdmedio=std(finalmedio)
melhormedio=min(finalmedio)

medmelhor=mean(melhor,2);
mediamelhor=mean(finalmelhor)
desvmelhor=std(melhor,0,2);
stdmelhor=std(finalmelhor)
melhormelhor=min(finalmelhor)



figure(1)
plot(x,medpior,'k-')
hold on
plot(x,desvpior,'k-')
plot(x,medmedio,'r-')
plot(x,desvmedio,'r-')
plot(x,medmelhor,'m-')
plot(x,desvmelhor,'m-')
title('AG c/ Mutação - Valores Médios')
xlabel('Gerações')
ylabel('Qtd. de movimentações')
legend('Pior','Média','Melhor')

%Piores
linha=0;
for i=1:step:gera-10
    linha=linha+1;
    novox(linha)=i;
    novopior(linha,:)=pior(i,:);
    novomedpior(linha)=medpior(i);
    novodesvpior(linha)=desvpior(i);
end
novox(linha+1)=gera;
novopior(linha+1,:)=pior(gera,:);
novomedpior(linha+1)=medpior(gera);
novodesvpior(linha+1)=desvpior(gera);


%Médios
linha=0;
for i=1:step:gera-10
    linha=linha+1;
    novox(linha)=i;
    novomedio(linha,:)=medio(i,:);
    novomedmedio(linha)=medmedio(i);
    novodesvmedio(linha)=desvmedio(i);
end
novox(linha+1)=gera;
novomedio(linha+1,:)=medio(gera,:);
novomedmedio(linha+1)=medmedio(gera);
novodesvmedio(linha+1)=desvmedio(gera);

%Melhores
linha=0;
for i=1:step:gera-10
    linha=linha+1;
    novox(linha)=i;
    novomelhor(linha,:)=melhor(i,:);
    novomedmelhor(linha)=medmelhor(i);
    novodesvmelhor(linha)=desvmelhor(i);
end
novox(linha+1)=gera;
novomelhor(linha+1,:)=melhor(gera,:);
novomedmelhor(linha+1)=medmelhor(gera);
novodesvmelhor(linha+1)=desvmelhor(gera);



figure(2)
plot(novox,novomedpior,'k-')
hold on
%plot(novox,novodesvpior,'k-')
plot(novox,novomedmedio,'r-')
%plot(novox,novodesvmedio,'r-')
plot(novox,novomedmelhor,'m-')
%plot(novox,novodesvmelhor,'m-')
title('AG c/ Mutação - Valores Médios')
xlabel('Gerações')
ylabel('Qtd. de movimentações')
legend('Pior','Média','Melhor')

figure(3)
errorbar(novox,novomedpior,novodesvpior,'k-')
hold on
errorbar(novox,novomedmedio,novodesvmedio,'r-')
errorbar(novox,novomedmelhor,novodesvmelhor,'m-')
axis([-1 3001 0 200])
title('AG c/ Mutação - \mu e \sigma')
xlabel('Gerações')
ylabel('Qtd. de movimentações')
legend('Pior','Média','Melhor')


lin=max(size(novomedmelhor));

fid = fopen('errosAGCa.txt','w');
for i=1:lin
    fprintf(fid,'%4d %12.8f %12.8f\n',novox(i),novomedmelhor(i),novodesvmelhor(i));
end
fclose(fid);


% figure(4)
% errorbar(novox,novomedmelhor,novodesvmelhor,'k-')
% axis([-1 3001 0 200])
% title('AG c/ Mutação - \mu e \sigma')
% xlabel('Gerações')
% ylabel('Qtd. de movimentações')
% legend('Pior','Média','Melhor')





















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

%N�mero de linhas do arquivo (nr. de gera��es)
gera=size(giro1,1);
gera=3000;
col=size(giro1,2);
x=1:gera;

todos=cat(2,giro1(:,2:col), giro2(:,2:col), giro3(:,2:col), giro4(:,2:col), giro5(:,2:col), giro6(:,2:col), giro7(:,2:col),...
            giro8(:,2:col), giro9(:,2:col), giro10(:,2:col),...
            giro11(:,2:col), giro12(:,2:col), giro13(:,2:col), giro14(:,2:col), giro15(:,2:col), giro16(:,2:col), giro17(:,2:col),...
            giro18(:,2:col), giro19(:,2:col), giro20(:,2:col),...
            giro21(:,2:col), giro22(:,2:col), giro23(:,2:col), giro24(:,2:col), giro25(:,2:col), giro26(:,2:col), giro27(:,2:col),...
            giro28(:,2:col), giro29(:,2:col), giro30(:,2:col));

col=size(todos,2);

melhor=0;
for i=1:gera %la�o das gera��es
    coluna=0;
    for j=3:3:col  %col %la�o dos arquivos
        coluna=coluna+1;
        melhor(i,coluna)=todos(i,j);
    end
end
finalmelhor=melhor(gera,:)

media_tudo=mean(finalmelhor)
std_tudo=std(finalmelhor)
melhor=min(finalmelhor)
media_12=mean(finalmelhor(1:12))
std_12=std(finalmelhor(1:12))
melhor12=min(finalmelhor(1:12))













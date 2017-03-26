%--------------------------------------------------------%
% Algoritmo Genetico de Varredura de Parametros.         %
%--------------------------------------------------------%
% Esta funcao emprega varios algoritmos geneticos para   %
% resolver o problema de alocacao de containeres         %
% em navios.                                             %
%--------------------------------------------------------%
function gamaster(file,path,filename,pathname,dt,nr,nc,np,D,lbound,ubound)

     % Vetor de opcoes de valores de mutacao.
     %vm = [0.15 0.30 0.60];
     vm = [0.15]; 
     % Vetor de opcoes de valores de crossover.
     %vc = [0.20 0.40 0.80];
     vc = [0.80];
     % Numero de rodadas.
     rodadas = 10;
     % Definicao do tamanho da populacao.
     %vpop = [50 100];
     vpop = [50];
     % Definicao do numero maximo de geracoes.
     % vmax = [1000 500];
     vmax = [1000];
     methodtype = 'GA';                        
     
     % Laco para testar opcao de vpop e vmax.
     for i=1:length(vpop)
       % Laco para testar opcao de vc.  
       for j=1:length(vc)
         % Laco para testar opcao de vm.
           for k=1:length(vm)
             % Laco para rodar 10 vezes com os parametros fixados.
             for t=1:rodadas
               % Definicao dos parametros.
               % Pop. Size.
               param.popsize = vpop(i);
               % Max number of generations.
               param.maxgens = vmax(i);       
               % Probability of crossover.
               param.pxover = vc(j);        
               % Probability of mutation.    
               param.pmutation = vm(k);         
               % Chamada ao algoritmo genetico customizavel.
               tic;
               [X,fit]=gavar(nr,nc,np,D,lbound,ubound,param);
               totaltime = toc;
               % Definindo o nome do diretorio onde serao salvos os
               % resultados.
               sfile = sprintf('pop%03dpc%2.0fpm%2.0fexe%02d',vpop(i),vc(j)*100,vm(k)*100,t);
               filenew = strcat(file,num2str(sfile));
               [qq1,qq2,qq3]=mkdir(path);
               % Chamada a funcao que grava os resultados obtidos.
               saveSol(filenew,path,filename,pathname,nr,nc,np,dt,D,X(end,:),fit(end),totaltime,methodtype);
             end
           end
       end
     end  
     
        
     

 
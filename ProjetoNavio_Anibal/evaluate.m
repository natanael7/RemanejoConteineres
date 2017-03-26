% Funcao responsavel por realizar a avaliacao das solucoes 
% propostas pelo algoritmo genetico.
function [population] = evaluate(POPSIZE,population,D,nr,nc)
         
   %--------------------------------------------//   
   % Calculation of costs by the rules for      //
   % each member in the population !!!          // 
   %--------------------------------------------//
   for mem=1:POPSIZE     
     [fitness] = sol2fo(population(mem).gene,D,nr,nc); 
     % Considerando a medida de infactibilidade no fitness, pois 
     % como o problema é de minimização quanto maior o fitness
     % e a infactibilidade, pior é a solução.
     population(mem).fitness = 1/(1 + fitness);
   end 
      
       
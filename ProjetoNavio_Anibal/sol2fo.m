% Funcao que calcula o valor de uma dada solucao
% de carregamento e descarregamento para um navio
% que passa em n portos (observe que o numero de 
% regras eh sempre n-1, pois no ultimo porto so 
% resta realizar o descarregamento !). 
function [fo] = sol2fo(v,D,m,n)
  
  total = 0;
  % Tamanho do navio, representado por uma 
  % matriz m x n.
  M = zeros(m,n);
  
  % Laço para transformar os índices k do vetor
  % em regras de entrada e saida para o porto k
  % e depois testar estas regras de entrada e saida.
  for k=1:length(v)
      
    % Obter regras para a i-esima componente da 
    % solucao contida no vetor v.
    [fre,frs] = num2Rules(v(k));
    
    % Empregar as regras para uma dada linha i da 
    % matriz de demandas (corresponde as demandas
    % de containeres para um dado porto i).
    [M,value] = simulaRegras(D(k,:),fre,frs,M,k);
    % Contabilizando o numero total de movimentos.
    total = total + value;
  end
  
  % Qualquer que seja a regra do ultimo para o 
  % ultimo porto, sempre sera contabilizado
  % o mesmo numero de movimentos que corresponde
  % ao numero de containeres cujo destino eh o
  % ultimo porto. Este numero eh a soma dos 
  % valores da ultima coluna da matriz D.
  total = total + sum(D(:,end));
    
  fo = total;
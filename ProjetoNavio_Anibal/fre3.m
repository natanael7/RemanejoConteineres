%----------------------------------------------------%
%----------------------------------------------------%
% Elaboração da Regra R3 de Entrada.                 %
%----------------------------------------------------%
%----------------------------------------------------%
% Procedimento de preenchimento:                     %
%----------------------------------------------------%
%  (1) Considera-se que a ordem de preenchimento
%      das cargas no navios ->, ou seja, da 
%      direita para a esquerda de baixo para cima.  
%      m ^
%        |
%        |
%      1 -----> 
%        1    n
%
%  (2) Recebe uma matriz M vazia ou parcialmente 
%      preenchida, bem como um vetor D com cargas
%      do i-esimo porto.
%
%  (3) Retorna a matriz M com as cargas contidas no
%      vetor D preenchidas de acordo com a regra RE1.
%----------------------------------------------------%
function [M] = fre3(M,D)

  % Transformando o vetor de demanda de valores totais 
  % por caixa de cada porto k para um vetor onde sao 
  % representadas as unidades das caixas !
  [D] = total2unit(D);

  % Ordenando os elementos de D em ordem decrescente 
  % de porto.
  [qq, ind] = sort(D,'descend');
  
  % Laco para preencher a matriz usando ->.  
  [m,n]=size(M);
  tam = length(D);
  k=1;
  % Laço para buscar espaços vazios para "passar"
  % containeres do vetor D para a matriz D. A busca
  % de espaços vazios começa nas linhas inferiores 
  % percorrendo as colunas de cada linha vai preenchendo
  % a matriz M.
  i=1;  
  while ((i <= m)&&(k <= tam))
    j=n;  
    while ((j >=1)&&(k <= tam))
      % Se houver um espaço vazio, então, ponha um container
      % que esta em v.
      if (M(i,j) == 0)  
        M(i,j) = D(ind(k));   
        k = k + 1;            
      end    
      j = j - 1;
    end    
    i = i + 1;
  end 
  
  % Mensagem de aviso de infactibilidade do problema !!
  if (k < tam) 
    fprintf(1,'Problema na função fre1 !! \n');
    fprintf(1,'Não foi possível carregar todos os containeres!! \n');
    fprintf(1,'Espaco insufiente !! \n');
  end   
  

%----------------------------------------------------%
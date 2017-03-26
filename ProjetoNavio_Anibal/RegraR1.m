%----------------------------------------------------%
%----------------------------------------------------%
% Elaboração da Regra R1 de Entrada.                 %
%----------------------------------------------------%
%----------------------------------------------------%
% Procedimento de preenchimento:                     %
%----------------------------------------------------%
%  (1) Considera-se que a ordem de preenchimento
%      das cargas no navios ->, ou seja, da 
%      esquerda para a direita de baixo para cima.  
%      m ^
%        |
%        |
%      1 -----> 
%        1    n
%
%  (2) Recebe uma matriz A vazia ou parcialmente 
%      preenchida, bem como um vetor v com cargas
%      do i-esimo porto.
%
%  (3) Retorna a matriz A com as cargas contidas no
%      vetor v preenchidas de acordo com a regra R1.
%----------------------------------------------------%
function [B] = RegraR1(A,v)

  % Ordenando os elementos de v em ordem decrescente 
  % de porto.
  [qq, ind] = sort(v,'descend');
  
  % Laco para preencher a matriz usando ->.  
  [m,n]=size(A)
  k = 1;
  x = m;
  y = 1;
  tam = length(v);
  for i=1:m
    for j=1:n
      if (k <= tam)  
        if (A(i,j) == 0)
          B(x,y) = v(k);  
          k = k + 1;            
        end    
      else
        break;  
      end    
    end    
  end    

%----------------------------------------------------%
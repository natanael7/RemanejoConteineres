%------------------------------------------------%
% Funcao responsavel por gerar aleatoriamente as %
% matrizes MIXED de Demanda.                     %
%------------------------------------------------%
%--------------------------------%
% Parametros de entrada:         %
%--------------------------------%
% nr - numero de linhas.
% nc - numero de colunas.
% np - numero de portos. 
%--------------------------------%
%--------------------------------%
% Parametros de saida:           %
%--------------------------------%
% D - matriz de demandas. 
%--------------------------------%
function [D]=geraD1(nr,nc,np)
  
  % Matriz D inicial, supoem que nenhum elemento ainda 
  % foi gerado, indicando para isto que todos os elementos
  % recebem o valor -1.
  D=-ones(np,np);
  
  % Numero de elementos percorridos para a matriz D.
  nelem = 0;
  ntotal = nr*nc;
  i=0;
  j=0;
  
  % Controle do laço para percorrer os elementos de D.
  control = 1;
  
  % Laço para preencher aleatoriamente todos os elementos 
  % da matriz D ate que a probabilidade de ser sorteado 
  % apenas o numero zero seja igual a 100%.
  while (control)
    ir = round(rand*(np-2))+1;
    jr = round(rand*(np-(i+1)))+(i+1);    
    
    % Busca indice em ordem lexicografica crescente.
    [i,j,ok] = buscac(ir,jr,D,np);
    
    % Busca indice em ordem lexicografica decrescente.
    [i,j,ok] = buscad(ir,jr,D,np);
    
    % Se encontrou indices i e j adequados, pode inserir
    % novo elemento na matriz. Senao, nao existe mais 
    % espaco e o while deve terminar !
    if (ok)
      [cargamax] = verifCargaT(i,j,D,np);  
      
      % Verificar se existe espaco para colocar container.
      if (cargamax < 0)
        cargamax = ntotal;    
      else
        cargamax = max(ntotal - cargamax,0);
      end
      cap = 0.2*ntotal;
      kmin = min(cargamax,cap);
      % Gerar numero aleatorio dentro do intervalo possivel !
      D(i,j) = round(rand*kmin);  
      
    else
      control = 0;  
    end % Fim do if do ok.   
      
  end % fim do while control.  
  
  
  % Modificar os elementos que não foram alterados de -1 para 0.
  for i=1:np
    for j=1:np
      if (D(i,j) == -1)
        D(i,j) = 0;
      end
    end
  end 
      
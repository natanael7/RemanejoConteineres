%------------------------------------------------%
% Funcao responsavel por gerar aleatoriamente as %
% matrizes de Demanda.                           %
%------------------------------------------------%
% GERAR MATRIZES EMPREGANDO O CRITERIO PARA GERAR%
% MATRIZES DE LONGA DISTANCIA.                   %
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
function [D]=geraDL(nr,nc,np)

  % Matriz D inicial, supoem que nenhum elemento ainda 
  % foi gerado, indicando para isto que todos os elementos
  % recebem o valor -1.
  D=-ones(nr,nc);
  
  % Numero de elementos percorridos para a matriz D.
  nelem = 0;
  ntotal = nr*nc;
  
  % Controle do laço para percorrer os elementos de D.
  control = 1;
  nelem = 0;
  
  % Laço para preencher aleatoriamente todos os elementos 
  % da matriz D ate que a probabilidade de ser sorteado 
  % apenas o numero zero seja igual a 100%.
  while (control)
    
    % Selecionar aleatoriamente um indice candidato 
    % a preenchimento. Selecionando uma linha (ate o porto np-1).
    x = round(rand*(nr-1))+1;
    % Selecionando uma coluna.
    y = round(rand*(nc-x-2))+(x+1);
    
    % Laço para ordem lexicografica crescente.
    % Percorrendo as linhas.
    %for i=x:nr
    i=x;
    while ((i<=nr)&&(control))
        
      % Primeira linha.
      if (i == x)
        % O laço das colunas começa em y.  
        for j=y:nc
          % Tentando localizar elemento
          % ainda nao preenchido.           
          if (D(i,j) == -1)
            indi = i;
            indj = j;
            nelem = nelem + 1;
            break;
          end    
        end
      % Demais linhas.  
      else  
        % O laço das colunas começa em (i+1).
        for j=(i+1):nc
          % Tentando localizar elemento
          % ainda nao preenchido.
          if (D(i,j) == -1)
            indi = i;
            indj = j;
            nelem = nelem + 1;
            break;
          end                
        end           
      end   % Fim if das linhas.     
      
      % Preenchendo aleatoriamente o elemento D(indi,indj),
      % mas respeitando as restricoes de factibilidade.
      % Respeitar capacidade maxima do navio no porto i.
      [carga] = verifCarga(i,D,np);
      % Calculando espaco vazio do navio no porto i.
      if (carga <= 0)
        carga = ntotal;
      else
        carga = max(ntotal-carga,0);
      end
      % Respeitar caracteristica de "long distance matrices".
      cap = ceil(((indj-indi)/(nr-1))^2);
      % Respeitar as duas restricoes ao mesmo tempo.
      kmin = min(carga,cap);
      % Se nao existir mais cargas a serem alocadas,
      % entao, terminar a varredura que completa D. 
      if (nelem == (ntotal - ((nr+1)*(nr/2))))          
        control = 0;
      end       
      % Gerar numero aleatorio dentro do intervalo !
      D(indi,indj) = round(rand*kmin);
      % Atualizacao de i.
      i=i+1;
    end  % Fim laco das linhas crescente.    
         
    % Laço para ordem lexicografica decrescente.
    % Percorrendo as linhas.
    %for i=(x-1):-1:1
    i=x-1;
    while ((i>=1)&&(control))    
      % Primeira linha.
      if (i == x)
        % O laço das colunas começa em y.  
        for j=y:-1:(i+1)
          % Tentando localizar elemento
          % ainda nao preenchido.           
          if (D(i,j) == -1)
            indi = i;
            indj = j;
            nelem = nelem + 1;
            break;
          end    
        end
      % Demais linhas.  
      else  
        % O laço das colunas começa em (i+1).
        for j=nc:-1:(i+1)
          % Tentando localizar elemento
          % ainda nao preenchido.
          if (D(i,j) == -1)
            indi = i;
            indj = j;
            nelem = nelem + 1;
            break;
          end                
        end           
      end   % Fim if das linhas decrescente.     
      
      % Preenchendo aleatoriamente o elemento D(indi,indj),
      % mas respeitando as restricoes de factibilidade.
      % Respeitar capacidade maxima do navio no porto i.
      [carga] = verifCarga(i,D,np);
      % Calculando espaco vazio do navio no porto i.
      if (carga <= 0)
        carga = ntotal;
      else
        carga = max(ntotal-carga,0);  
      end  
     % Respeitar caracteristica de "long distance matrices".
      cap = ceil(((indj-indi)/(nr-1))^2);
      % Respeitar as duas restricoes ao mesmo tempo.
      kmin = min(carga,cap);
      % Se nao existir mais cargas a serem alocadas,
      % entao, terminar a varredura que completa D. 
      if (nelem == (ntotal - ((nr+1)*(nr/2))))          
        control = 0;
      end               
      % Gerar numero aleatorio dentro do intervalo !
      D(indi,indj) = round(rand*kmin);
      % Atualizacao de i.
      i=i-1;      
    end  % Fim laco das linhas.
    
  end    % Fim laco do while para percorrer em ordem crescente
         % todos os elementos de D.         
         
  
  % Modificar os elementos que não foram alterados de -1 para 0.
  for i=1:nr
    for j=1:nc
      if (D(i,j) == -1)
        D(i,j) = 0;
      end
    end
  end 
  
  % Chamando funcao para realizar a gravacao de matriz D
  % gerada em um arquivo. Caracteristicas importantes a 
  % serem gravadas:
  %-----------------------------------------------------%
  % GENERAL DESCRIPTION OF INSTANCE FILE.               %
  %-----------------------------------------------------%
  % // Number of Rows
  % [NR] 
  % 6, 8, 10  
  % // Number of Columns
  % [NC]
  % 50 to 170
  % // Number of Ports
  % [NP]
  % 10, 15, 20, 25, 30
  % // Demand Matriz Type
  % [DT]
  % 1 - Mixed, 2 - Long Distance, 3 - Short Distance 
  % // Demand Matriz Information
  % [DI]
  % 0 10 15 ... 30
  % 0  0 20 ... 13
  % |  |  \  -   |  
  % 0  0  0 ... 25
  %
  % // The name of the file is generated by a combination
  % // of the information for each instance. For example:
  % // stowage06050101 mean:
  %            |  | ||
  %            |  | ||
  %            |  | |v
  %            |  | vMixed Matrix
  %            |  v 10 ports
  %            v  50 columns 
  %            6 rows
  %-----------------------------------------------------%
  %                                                     %
  %-----------------------------------------------------%
  % Chamando funcao de gravacao de dados.
  % gravarD(nr,nc,np,2,D);
  
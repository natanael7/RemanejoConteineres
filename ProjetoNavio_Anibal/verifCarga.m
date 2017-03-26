% Funcao que contabiliza a carga do navio no porto k.
function [carga] = verifCarga(portok,D,np)

    % Carga total a carga porto i tem que
    % considerar o quanto existe de carga
    % para ser transportada para os portos
    % i+1,...,m que são carregadas no porto
    % i e considerar também as cargas i+1,...,m
    % que vieram dos portos i-1,...,1.
    carga = 0;
    % Numero de linhas a serem contabilizadas.
    for i=1:portok
      % Numero de colunas a serem contabilizadas.
      for j=(portok):np
        % Só contabilizar carga se for valor positivo !  
        if (D(i,j) > 0)  
          carga = carga + D(i,j);
        end  
      end
    end  % Fim do duplo laço para contar cargas para o porto k. 
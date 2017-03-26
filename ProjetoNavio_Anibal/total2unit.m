% Funcao para transformar a demanda que eh dada 
% em numero de caixas para cada porto k em unidades
% pertencentes a cada porto. Por exemplo:
% Inicio D: D = [0 3 2 1]
% Final D:  D = [2 2 2 3 3 4]

function [v] = total2unit(D)

  % Contabilizando o numero de caixas existentes 
  % a serem carregadas no navio no porto k!
  numcaixas = 0;
  for i=1:length(D)
    numcaixas = numcaixas + D(i);
  end  
  
  % Inicializando o vetor que indica cada caixa
  % em que porto devera ser descarregada.
  v = zeros(1,numcaixas);
  k = 0;
  % Laco para preencher o vetor v.
  for i=1:length(D)
    % Indice que indica a quantidade D(1,i) 
    % de caixas pertence a um porto i.
    j = D(1,i);  
    % Laco para preencher v com j quantidade 
    % de caixas.
    while (j >= 1)
      k = k + 1;
      j = j - 1;
      v(k) = i;  
    end
  end  
    
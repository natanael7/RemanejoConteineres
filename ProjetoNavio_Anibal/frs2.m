%----------------------------------------------------%
%----------------------------------------------------%
% Elaboração da Regra R2 de Saida.                   %
%----------------------------------------------------%
%----------------------------------------------------%
% Procedimento de retirada:                          %
%----------------------------------------------------%
%  (1) Procede-se a retirada das cargas verificando-se
%      para cada coluna quantas movimentos sao necessarios
%      para se retirar as cargas do porto k de modo que
%      toda a coluna fique ordenada !!! 
%
%      m ^
%        |
%        |
%      1 -----> 
%        1    n
%
%  (2) Ao se retirar uma carga de uma coluna imediatamente
%      a carga que se encontra "acima" eh movida para "baixo".
%      Se a carga "acima" for tambem uma carga cujo destino 
%      eh o porto k, entao, passa-se a uma carga mais acima,
%      ate se chegar a ultima carga ! Se nao existir nenhuma
%      carga "acima", indica-se que existem espacos vazios na
%      coluna.
% 
%  (3) Retorna a matriz M com as cargas contidas no
%      vetor D retiradas de acordo com a regra RS2 e o numero 
%      de movimentos que foram necessarios.
%----------------------------------------------------%
% VALIDACOES REALIZADAS PARA ESTAS REGRAS:
%----------------------------------------------------%
% T = [4 0 0 0; 2 0 0 0; 3 0 0 0; 5 0 0 0]
%
% T =
% 
%      4     0     0     0
%      2     0     0     0
%      3     0     0     0
%      5     0     0     0
% 
% [TT,nmov] = frs2(T,2)
% 
% TT =
% 
%      5     0     0     0
%      4     0     0     0
%      3     0     0     0
%      0     0     0     0
% 
% 
% nmov =
% 
%      7
%-----------------------------------------------------%
% N =
% 
%      3     2     2     3
%      5     4     4     3
%      5     4     4     3
%      0     0     0     0
% 
% [TT,nmov] = frs2(N,2)
% 
% TT =
% 
%      5     4     4     3
%      5     4     4     3
%      3     0     0     3
%      0     0     0     0
% 
% 
% nmov =
% 
%     16
%
%-----------------------------------------------------%

function [M,nmov] = frs2(M,k)

  % Zerando o numero de movimentos realizados.
  nmov = 0;
  
  % Capturando a dimensao da matriz M.  
  [m,n]=size(M);
  
  % Laços para percorrer M e retirar as cargas
  % do navio que devem ser descarregadas no 
  % porto k.
  
  % Varrendo cada coluna t e retirando todos os 
  % containeres k da mesma.
  nmov = 0;
  for t=1:n
    % Para cada coluna k da matriz M, reordenar se for
    % necessario e contabilizador o esforco necessario.
    indi = 0;
    % Para cada coluna aplicar o buble sort.
    for i=1:(m - 1) % Numero de elementos a serem "fundados".
      for j=1:(m - i) % Numero de movimentos (comparacoes)
                      % para afundar um elemento.
        if ((M(j,t) < M(j+1,t))&&(M(j,t) ~= 0)) % So afundar quando necessario.
          aux = M(j,t);
          M(j,t) = M(j+1,t);
          M(j+1,t) = aux;
          % Contabilizando numero de movimentos para coluna.
          indi = max(indi, m-j+1);
        end    
      end    
    end
    % Numero de containeres do porto k na coluna t.
    % Contabilizando o numero de containeres k na coluna.
    % Se existirem !
    numk = length(find(M(:,t) == k));
    if ((numk ~= 0)&&(indi ~= 0))
            
      % Acumulando o numero de movimentos de containeres para
      % ordenar a coluna k do navio e retirar containeres do 
      % porto k.
      nmov = nmov + 2*indi - numk;
     
    else
      % So existem containeres a serem retirados.  
      if (numk ~= 0)  
        nmov = nmov + numk;
      % So existem containeres a serem ordenados.  
      else  
        % Apenas ordenacao !  
        if (indi ~= 0)
          nmov = nmov + 2*indi;  
        % Containeres nao precisam ser ordenados, nem retirados !!!  
        else
          %nmov = 0; % Zero movimentos !!  
        end
      end  
    end  
    
  end        % Fim for de j.
  
  % Contabilizar a carga e a descarga necessarias para se 
  % movimentar os containeres.
  
  for i=1:m
    for j=1:n
      if (M(i,j) == k) 
        M(i,j) = 0;  
      end    
    end
  end  
    
 
  

%----------------------------------------------------%
%----------------------------------------------------%
%----------------------------------------------------%
% Elaboração da Regra R1 de Saida.                   %
%----------------------------------------------------%
%----------------------------------------------------%
% Procedimento de preenchimento:                     %
%----------------------------------------------------%
%  (1) Procede-se a retirada das cargas verificando-se
%      para cada coluna quantas movimentos sao necessarios
%      para se retirar as cargas do porto k. 
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
%      vetor D retiradas de acordo com a regra RS1 e o numero 
%      de movimentos que foram necessarios.
%----------------------------------------------------%
function [M,nmov] = frs1(M,k)

  % Zerando o numero de movimentos realizados.
  nmov = 0;
  
  % Capturando a dimensao da matriz M.  
  [m,n]=size(M);
  
  % Laços para percorrer M e retirar as cargas
  % do navio que devem ser descarregadas no 
  % porto k.
  
  % Varrendo cada coluna e retirando todos os 
  % containeres k da mesma.
  for j=1:n
      
    % Percorrendo todas as linhas de uma dada 
    % coluna j fixada.
    i=1;
    % Ver se o elemento em foco eh o container
    % que deve ser descarregado.
    while ((i <= m)&&(M(i,j) ~= k))
      i = i + 1;   
    end    
    
    % Se encontrou o container do tipo k na coluna.
    if (i <= m)       
      % Contabilizar movimentos de descarga.
      nmov = nmov + 1;
      % Indice do local onde foi encontrado o 
      % container a ser removido.
      t1 = i;
      % Indice do local onde foi encontrado o
      % container que pode ser realocado para
      % o espaco onde foi removido um container.
      t2 = i+1;
         
      % Laço que percorre toda a coluna até que
      % não existam mais containeres a serem 
      % descarregados e consequemente movidos.
      while ((t2 <= m)&&(M(t2,j) ~= 0))  
        % Verificar se o proximo container da 
        % coluna sera retirado ou se podera 
        % ocupar o espaco deixado por outro 
        % container a ser descarregado.
        % Não é container a ser retirado,
        % portanto deve ser deslocado.
        if (M(t2,j) ~= k) 
          % Este container devera ser retirado e depois
          % colocado novamente no navio, portanto, seu
          % movimento conta em dobro.
          nmov = nmov + 2;  
          M(t1,j) = M(t2,j);
          t1 = t1 + 1;
        % O container eh k, ou seja, deve ser retirado e
        % portanto so devemos contabilizar o movimento 
        % de retirada do mesmo.
        else
          nmov = nmov + 1;  
        end    
        t2 = t2 + 1; % Analisar containeres mais acima.
      end % Fim while.
         
      % Containeres que foram retirados devem ser apagados.
      for t=t1:m
        M(t,j) = 0;  
      end   
      
    end 
     % Fim do if. 
    
  end        % Fim for de j.
    
    
 
  

%----------------------------------------------------%
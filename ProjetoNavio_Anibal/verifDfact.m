 %--------------------------------------------------%
 % Funcao que verifica a factibilidade de           %
 % uma dada matriz D com as demandas de             %
 % carga de cada porto para um dado navio           %
 % com capacidade maxima cmax.                      %
 % Esta fun��o foi validada com o seguinte exemplo: %
 %--------------------------------------------------%
 % M =                                              %
 %      0     3     2     1     1    ->  7          %
 %      0     0     2     3     1    -> 10          %
 %      0     0     0     2     1    ->  9          %
 %      0     0     0     0     1    ->  4          %
 %      0     0     0     0     0                   % 
 %--------------------------------------------------%
 %                                                  %
 %--------------------------------------------------%
 
 function [fact]=verifDfact(D,cmax)
 
  % Sup�em inicialmente que � fact�vel.
  fact = 1;
  
  % Atrav�s das dimens�es de D � poss�vel
  % obter a informa��o de quantos portos 
  % o navio ter� que passar.
  [m,n]=size(D);
  % Numero de portos eh igual a m ou n.
  np = m;
  
  % Verificando a cada linha da matriz o 
  % quanto de cargas o navio ter� que transportar.
  for k=1:(np-1)
  
    % Obtendo a carga do navio em cada porto k.  
    [carga] = verifCarga(k,D,np);
    
    % Verificando se para o porto k ainda existe solucao 
    % factivel possivel.
    if (carga > cmax)
        k
      fact = 0;
      break;  % Fim do la�o n�o existem solu��o fact�vel poss�vel.
    end  
    
  end   % Fim do la�o para analisar a carga a ser transportada 
        % para cada porto k.
        
  %--------------------------------------------------%
  %                                                  %
  %--------------------------------------------------%
         
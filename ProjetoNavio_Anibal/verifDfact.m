 %--------------------------------------------------%
 % Funcao que verifica a factibilidade de           %
 % uma dada matriz D com as demandas de             %
 % carga de cada porto para um dado navio           %
 % com capacidade maxima cmax.                      %
 % Esta função foi validada com o seguinte exemplo: %
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
 
  % Supõem inicialmente que é factível.
  fact = 1;
  
  % Através das dimensões de D é possível
  % obter a informação de quantos portos 
  % o navio terá que passar.
  [m,n]=size(D);
  % Numero de portos eh igual a m ou n.
  np = m;
  
  % Verificando a cada linha da matriz o 
  % quanto de cargas o navio terá que transportar.
  for k=1:(np-1)
  
    % Obtendo a carga do navio em cada porto k.  
    [carga] = verifCarga(k,D,np);
    
    % Verificando se para o porto k ainda existe solucao 
    % factivel possivel.
    if (carga > cmax)
        k
      fact = 0;
      break;  % Fim do laço não existem solução factível possível.
    end  
    
  end   % Fim do laço para analisar a carga a ser transportada 
        % para cada porto k.
        
  %--------------------------------------------------%
  %                                                  %
  %--------------------------------------------------%
         
% Função que realiza a simula das regras de uma 
% entrada e saida fornecida por uma dada solucao.
function [M,value] = simulaRegras(D,fre,frs,M,k)

  % Numero de movimentos realizados para carregar 
  % e descarregar containeres de 1 navios para 1
  % porto e um conjunto de regras dado por fre 
  % (regra de entrada) e frs (regra de saida).
  value = 0;

  % Verificando se nao estamos no primeiro porto onde
  % apenas os containeres sao carregados !!
  if (k > 1)
    % Descarregar containeres contidos na matriz M 
    % e que pertencem ao porto k de acordo com a 
    % regra de saida dada no arquivo cujo nome 
    % esta contido na string frs.
    [M,nmov] = feval(frs,M,k);
    value = value + nmov;
  end   
  
  % Carregar matriz M com containeres contidos 
  % em D segundo a regra dado na string fre.
  [M] = feval(fre,M,D);
  
  % Contabilizando o numero de containeres carregados.
  % (Nao eh necessaria nenhuma movimentacao dos demais
  %  containeres para colocar outros. Isto so pode ser 
  %  realizado no momento de descarga).
  value = value + sum(D);
  
 
  
%   % Carregar matriz M com containeres contidos 
%   % em D segundo a regra dado na string fre.
%   [M] = feval(fre,M,D);
%   
%   % Contabilizando o numero de containeres carregados.
%   % (Nao eh necessaria nenhuma movimentacao dos demais
%   %  containeres para colocar outros. Isto so pode ser 
%   %  realizado no momento de descarga).
%   value = value + sum(D);
%   
%   % Verificando se nao estamos no primeiro porto onde
%   % apenas os containeres sao carregados !!
%   if (k > 1)
%     % Descarregar containeres contidos na matriz M 
%     % e que pertencem ao porto k de acordo com a 
%     % regra de saida dada no arquivo cujo nome 
%     % esta contido na string frs.
%     [M,nmov] = feval(frs,M,k);
%     value = value + nmov;
%   end    
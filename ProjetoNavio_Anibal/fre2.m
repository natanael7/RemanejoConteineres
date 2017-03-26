%----------------------------------------------------%
%----------------------------------------------------%
% Elaboração da Regra R2 de Entrada.                 %
%----------------------------------------------------%
%----------------------------------------------------%
% Procedimento de preenchimento:                     %
%----------------------------------------------------%
%  (1) Considera-se que a ordem de preenchimento
%      das cargas no navios ^|, ou seja, da 
%      de baixo para cima da esquerda para a direita.  
%      Observar que as colunas serao preenchidas ate
%      uma altura maxima pre-estabelecida de acordo 
%      com o numero de carga existentes no navio e 
%      de cargas a serem colocadas no mesmo no porto atual.
%
%      m ^
%        |
%        |
%      1 -----> 
%        1    n
%
%  (2) Recebe uma matriz M vazia ou parcialmente 
%      preenchida, bem como um vetor D com cargas
%      do i-esimo porto.
%
%  (3) Retorna a matriz M com as cargas contidas no
%      vetor D preenchidas de acordo com a regra RE1.
%----------------------------------------------------%
% Regra de Entrada RE2 testada com:                  %
%----------------------------------------------------%
% D = [0 0 3 4 2];
% M = [3 2 2 0; 0 0 0 0; 0 0 0 0; 0 0 0 0];
% Resultado final obtido:
% M =
%     3     2     2     3
%     5     4     4     3
%     5     4     4     3
%     0     0     0     0
%----------------------------------------------------%
function [M] = fre2(M,D)
D
    M
  N = M; 
  % Transformando o vetor de demanda de valores totais 
  % por caixa de cada porto k para um vetor onde sao 
  % representadas as unidades das caixas !
  [D] = total2unit(D);

  % Ordenando os elementos de D em ordem decrescente 
  % de porto.
  [qq, ind] = sort(D,'descend');
  
  % Laco para preencher a matriz usando ^|.  
  [m,n]=size(M);
  numcaixas = length(D);
  % Calculando o numero total de caixas: navio + porto.
  % Depois sera estimado a altura que cada colunas pode
  % atingir.
  numtotalcaixas = numcaixas + length(find(M ~= 0));
  altura = ceil(numtotalcaixas/n);
  k=1;  % Caixa inicial.
  j=1;  % Coluna inicial.
  i=1;  % Linha inicial.
  % Laço para buscar espaços vazios para "passar"
  % containeres do vetor D para a matriz D. A busca
  % de espaços vazios começa nas colunas iniciais 
  % percorrendo as linhas e preenchendo a matriz M.
  while ((k <= numcaixas)&&(j <= n)) % Armazenar todas as caixas no navio.
    i=1;  
    while ((mod(i,altura+1) ~= 0)&&(k <= numcaixas)&&(i <= m))
      % Se houver um espaço vazio, então, ponha um container
      % que esta em v.
      if (M(i,j) == 0)  
        M(i,j) = D(ind(k));   
        k = k + 1;            
      end    
      i = i + 1;
    end    
    j = j + 1; % apos preencher uma coluna passar para a proxima.
  end 
  M
  pause;
  % Mensagem de aviso de infactibilidade do problema !!
  if (k < numcaixas) 
    N
    D
    k
    M
    fprintf(1,'Problema na função fre2 !! \n');
    fprintf(1,'Não foi possível carregar todos os containeres!! \n');
    fprintf(1,'Espaco insufiente !! \n');
  end   
  

%----------------------------------------------------%
% Esta funcao emprega beam search para 
% resolver o problema de alocacao de containeres
% em navios.
%%function [X,fit]=BeamSearch(n,m,c,h,lambda,M)
function [X,fit]=BeamSearch(nr,nc,np,D,lbound,ubound);

   % Observar que:
   % m = numero de centrais = numero de regras = ubound - lbound + 1.
   % n = numero de antenas  = numero de portos - 1. 
   m = ubound - lbound + 1;
   n = np - 1;
   
   %------------------------------------------------------%
   %                                                      %
   % A Filosofia de implementação deste BEAM SEARCH segue %
   % o seguinte diagrama esquemático:                     % 
   %                                                      %
   %------------------------------------------------------%
   %         A (b x c)  ->  B   ((b*m) x c)               %
   %        (I)            (II)                           %
   %         /|\    (III)    |                            %   
   %          |--------------|                            %
   %                                                      %
   %   Passo (I): Matriz A que armazena b soluções para   %
   %   as c células.                                      %
   %                                                      % 
   %   Passo (II): A partir da matriz A gerar b*m soluções%  
   %   e armazenar na matriz B de dimensões (b*m) x c.    %
   %                                                      %
   %   Passo (III): Selecionar da matriz B apenas as b    %
   %   melhores soluções para armazenar em A.             %
   %                                                      %
   %   Observação: Para realizar a seleção da parte (iii) %
   %   é necessário realizar uma busca gulosa que vai até %
   %   a raiz da árvore de soluções possíveis.            %
   %------------------------------------------------------%   
   % NOTACAO UTILIZADA:
   % m - número de centrais.
   % n - número de células.
   % c - custo de cabeamento.
   % h - custo de handoff.
   % lambda - demanda por célular.
   % M - capacidade de cada central.
   % b - largura de busca.
   %------------------------------------------------------%   
   
   % Definindo a largura de busca igual a 2.
   % b = 2;
   % Número de centrais é igual a largura de busca.
   b = m;
   
   % Construção das matrizes a serem utilizadas: A e B.
   A = zeros(b,n);
   B = zeros(b*m,n);
   nA = 0;
   % Vetor auxiliar que armazena apenas uma solução candidata a entrar 
   % na matriz B se ela for factível.
   vaux = zeros(1,n);
   
   % Construção dos índices que indicam em que ordem a matriz A 
   % sera construida.      
   %%[aux,ind1]=sort(lambda,2,'descend');
   ind1 = 1:n;
   
   % Construção da primeira alocação da matriz A com no máximo 
   % b alocações (mesmo que b seja menor que m). Ou seja, se
   % tivermos um estudo de caso com m centrais e n células, se 
   % a largura de busca b for menor que n, então, a solução 
   % inicial de A considera apenas b nos sementes referentes 
   % as n possíveis árvores de busca. Por exemplo, seja um 
   % caso 4 células e 3 centrais para largura de busca igual 
   % a 2. Então, temos:
   %
   %  N1      1          2          3 -> Não é analisada, pois b = 2 !!       
   %       / | | \    / | | \    / | | \
   %  N2  1  2 3 4    1 2 3 4   1  2 3 4
   %
   for k=1:b
      A(k,ind1(1))= k;
   end
   
   % Anotando o número de soluções contidas em A.
   nA = b;

   % Barra de espera.
   hbar = waitbar(0,'Please wait...','name','Stage Analisys Progress');
   
   % Laço para realizar a alocação das demais células 
   % na ordem dada por ind1.
   for t=2:n


     %------------------------------------------------------%
     % PASSO (II): CONSTRUÇÃO DA MATRIZ B A CADA ESTÁGIO T. %
     %------------------------------------------------------%     
     % Contador de soluções factíveis para inserir em B.
     scont = 0;     
 
     % Gerando m*nA soluções factiveis (se possível) em B a partir de A.
     for i=1:nA
         
       % % Copia a informação de A para B até o estágio t-1.
       vaux(ind1(1:t-1)) = A(i,ind1(1:t-1));
       % for k=1:t-1
       %   B(i*j,ind1(k)) = A(i,ind1(k)); 
       % end        
       
       
       % Para cada solução i verificar as j possibilidades de centrais.
       for j=1:m
       
         % Alocando central j para a célula t.                   
         vaux(ind1(t)) = j;        
           
         % Testando a factibilidade da solução proposta.
         %[state] = factverif(vaux,lambda,M,ind1(t));             
         state = 1;
         
         % Inserir solução proposta em B só se for factível.
         if (state == 1)             
           % Contador de soluções para preencher a matriz B.
           scont = scont + 1;
           % Inserindo solução proposta em B.
           B(scont,ind1(1:t)) = vaux(ind1(1:t)); 
         end % Fim do if que verifica se uma solução é factível.  
             % e permite que ela não seja apagada por outras
       end % Fim do laço de verificação de m centrais.     
       
     end % Fim do laço de criação de m soluções para cada sol. t de A.
     
     % Atualização do número de soluções contidas em B (nA).
     nA = scont;
     
     %-----------------------------------------------------%
     
     
     % Matriz auxiliar C que armazena temporariamente as alocações 
     % de B em C de modo a realizar avaliações de soluções com 
     % base na heurística gulosa.
     % C = B;
     
     %-------------------------------------------------------%
     % PASSO (III): AVALIAÇÃO DAS M*NA SOLUÇÕES DE B USANDO  %
     %              UMA HEURÍSTICA GULOSA QUE VAI ATÉ A      %
     %              ÚLTIMA ALOCAÇÃO DA ÁRVORE.               %
     %-------------------------------------------------------%     
  
     
     % Contador de soluções factíveis admitidas em B.
     fcont = 1;
     
     % Decidindo se a busca local deve ser usada, observando 
     % o número de soluções atual é maior do que a largura de 
     % busca permite armazenar.
     if (nA > b)
         
       % Se não for o último estágio t, então, realizar a análise
       % abaixo. Senão, se for p último estágio, então, a matriz B 
       % já é automaticamente formada a partir da matriz A.
       if (t < n)
         
         % Laço para atribuir um valor de função objetivo para 
         % cada solução contida na matriz B realizando buscas 
         % locais (heurística gulosa), ou seja, observando apenas
         % os custos de cabeamento (c) e handoff (h).
         for k=1:nA
           
           % Para completar o custo de cada sol. alocar os estágios
           % além de t ou seja de t+1 até n.
           for s=(t+1):n
             % Avaliação da alocação da central para o estágio t+1.  
             B(fcont,ind1(s)) = 1;
           
             % Testando a factibilidade da solução proposta.
             %[state] = factverif(B(fcont,:),lambda,M,ind1(s));
             state = 1; 
             
             % Verificando se a solução proposta é factível.
             if (state == 1)
               %%vind3 = funevaluates(B(fcont,:),c,h,s,ind1);
               vind3 = sol2fo(B(fcont,1:s),D,nr,nc);
               ind3 = 1;
             else
               vind3 = inf;
               ind3 = -1;
             end 
           
           
             % Laço para testar as demais alocações de centrais em t+1.
             for v=2:m 
               B(fcont,ind1(s)) = v;
             
               % Avaliação da alocação da central v para o estágio t+1.  
               %%aux = funevaluates(B(fcont,:),c,h,s,ind1);
               aux = sol2fo(B(fcont,1:s),D,nr,nc);
               % Testando a factibilidade da solução proposta.
               %%[state] = factverif(B(fcont,:),lambda,M,ind1(s));
               state = 1;
               
               % Verificando que a possibilidade de alocação v é melhor e 
               % se é também é factível.
               if (state == 1)
                 if (aux < vind3)  
                   ind3 = v;
                   vind3 = aux;
                 end
               end    
             
             end % Laço que testa v alocações de centrais em t+1.
           
             % Se todas as m possibilidades de alocação de centrais 
             % para a solução no estágio atual t são infactíveis, então, 
             % não precisa mais analisar os demais estágios desta solução !!!
             if (vind3 < inf)
             
               % Armazenando para o estágio s apenas a solução que 
               % apresentou melhor valor após a heurística gulosa
               % para uma dada solução k e que seja factivel.
               B(fcont,ind1(s)) = ind3;               
             
            
             % Esta solução não ofereceu soluções factíveis e 
             % devemos passar para a próxima.
             else  
               break;
             end % Fim do if que verifica se a solução em um dado
                 % estágio t é infactível.
           
             % Armazenar os valores de função objetivo apenas no último
             % estágio (em cada estágio ocorre a alocação de uma célula).
             if (s == n)
               fb(k) = vind3; 
             end  
           
           end   % Laço que testa os estágios de t+1 até m.
         
           % Incrementa o número de soluções factíveis que
           % podem ser adicionadas em B desde que a solução
           % proposta em B seja factível.
           if (vind3 < inf)
             fcont = fcont + 1;
           end            
         
         end     % Laço que avalia as k = 1:nA soluções contidas em B.
         
         % Recalculando o número de soluções de B (devido a verificação 
         % de soluções factíveis que pode levar a um número menor de sol.
         % entre os sucessivos estágios t).
         nA = fcont - 1;
         
       % Estamos no último estágio e a matriz B é completamente preenchida
       % com as possíveis combinações a partir da matriz A.
       else
         
           
         % Não é necessário mais realizar a verificação de factibilidade, 
         % pois a geração de soluções de B a partir de A já realiza a 
         % verificação de factibilidade, mas é necessário calcular o 
         % valor de cada solução proposta por B.
         % Laço que fornece o valor das soluções contidas em B no estágio t  
         for v=1:nA
            % Avaliação da alocação da célula para o último estágio t.  
            
            
            % % Testando a factibilidade da solução proposta.
            % [state] = factverif(B(v,:),lambda,M,ind1(t));                      
            % Verificando se a solução proposta é factível.
            % if (state == 1)
               %%fb(v) = funevaluates(B(v,:),c,h,t,ind1);
               fb(v) = sol2fo(B(v,1:t),D,nr,nc);
            % else
            %   fb(v) = inf;
            % end            
            
         end % Fim do laço que calcula fo para as soluções do último est. 
           
       end   % Fim do teste que verifica se estamos no último estágio t
       
     % Caso em que só é necessário atribuir valores da função objetivo
     % sem se preocupar com espaço, mas é necessário se preocupar com
     % a factibilidade !!!
     else  
         
         
        % Laço para avaliar os valores das soluções contidas em B.
        for k=1:nA                               
            
          % Testando a factibilidade da solução proposta.
          %[state] = factverif(B(k,:),lambda,M,ind1(t));
          state = 1; 
          
          % Verificando se a solução proposta é factível.
          if (state == 1)
            %%fb(k) = funevaluates(B(k,:),c,h,t,ind1);
            fb(k) = sol2fo(B(k,1:t),D,nr,nc);
          else
            fb(k) = inf;
          end              
            
          % Avaliação da alocação da central v para o estágio t.  
          %%fb(k) = funevaluates(B(k,:),c,h,t,ind1);             
          fb(v) = sol2fo(B(k,1:t),D,nr,nc);
        end % Laço que fornece o valor das b soluções de B.  
       
     end       % Teste para saber se aplica heurística gulosa.

     %-------------------------------------------------------%
     
     %-------------------------------------------------------%
     % PASSO (I):   A PARTIR DA MATRIZ B GERAR A MATRIZ      %
     %              SELECIONANDO APENAS AS b MELHORES        %
     %              SOLUÇÕES DE ACORDO COM A HEURÍSTICA      %
     %              GULOSA.                                  %
     %-------------------------------------------------------%
     [aux,ind2]=sort(fb,2,'ascend');
     
     % Copiando apenas os elementos de 1 até t das b melhores 
     % soluções de B para A.
     for v=1:b
       A(v,ind1(1:t)) = B(ind2(v),ind1(1:t));   
       fit(v) = fb(ind2(v));
     end    
     
     % Limpando B e fb.
     B(:,:) = 0;
     fb(:) = inf;
     
     % Verificando se o tamanho de B é maior que o de A 
     % e se isto ocorrer, então, modificar nA para b.
     if (nA > b)
       nA = b;  
     end    
     
     % Se for o último estágio, então, copia a informação 
     % de função objetivo para ser fornecida para a gravação 
     % de dados.
     if (t == n)
       % Reordenando a matriz X de saida das soluções de modo
       % a se obter que o melhor individuo esteja ultima posicao.
       X = A(end:-1:1,:);
       fit = fit(end:-1:1);
     end  
     
     %-------------------------------------------------------%
     
     % Atualizando a barra de espera.
     waitbar(t/n,hbar);   

       
   end % Fim do laço para percorrer todas as células.    
   
   
   % Fechando a barra de espera.
   close(hbar);
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
   % A Filosofia de implementa��o deste BEAM SEARCH segue %
   % o seguinte diagrama esquem�tico:                     % 
   %                                                      %
   %------------------------------------------------------%
   %         A (b x c)  ->  B   ((b*m) x c)               %
   %        (I)            (II)                           %
   %         /|\    (III)    |                            %   
   %          |--------------|                            %
   %                                                      %
   %   Passo (I): Matriz A que armazena b solu��es para   %
   %   as c c�lulas.                                      %
   %                                                      % 
   %   Passo (II): A partir da matriz A gerar b*m solu��es%  
   %   e armazenar na matriz B de dimens�es (b*m) x c.    %
   %                                                      %
   %   Passo (III): Selecionar da matriz B apenas as b    %
   %   melhores solu��es para armazenar em A.             %
   %                                                      %
   %   Observa��o: Para realizar a sele��o da parte (iii) %
   %   � necess�rio realizar uma busca gulosa que vai at� %
   %   a raiz da �rvore de solu��es poss�veis.            %
   %------------------------------------------------------%   
   % NOTACAO UTILIZADA:
   % m - n�mero de centrais.
   % n - n�mero de c�lulas.
   % c - custo de cabeamento.
   % h - custo de handoff.
   % lambda - demanda por c�lular.
   % M - capacidade de cada central.
   % b - largura de busca.
   %------------------------------------------------------%   
   
   % Definindo a largura de busca igual a 2.
   % b = 2;
   % N�mero de centrais � igual a largura de busca.
   b = m;
   
   % Constru��o das matrizes a serem utilizadas: A e B.
   A = zeros(b,n);
   B = zeros(b*m,n);
   nA = 0;
   % Vetor auxiliar que armazena apenas uma solu��o candidata a entrar 
   % na matriz B se ela for fact�vel.
   vaux = zeros(1,n);
   
   % Constru��o dos �ndices que indicam em que ordem a matriz A 
   % sera construida.      
   %%[aux,ind1]=sort(lambda,2,'descend');
   ind1 = 1:n;
   
   % Constru��o da primeira aloca��o da matriz A com no m�ximo 
   % b aloca��es (mesmo que b seja menor que m). Ou seja, se
   % tivermos um estudo de caso com m centrais e n c�lulas, se 
   % a largura de busca b for menor que n, ent�o, a solu��o 
   % inicial de A considera apenas b nos sementes referentes 
   % as n poss�veis �rvores de busca. Por exemplo, seja um 
   % caso 4 c�lulas e 3 centrais para largura de busca igual 
   % a 2. Ent�o, temos:
   %
   %  N1      1          2          3 -> N�o � analisada, pois b = 2 !!       
   %       / | | \    / | | \    / | | \
   %  N2  1  2 3 4    1 2 3 4   1  2 3 4
   %
   for k=1:b
      A(k,ind1(1))= k;
   end
   
   % Anotando o n�mero de solu��es contidas em A.
   nA = b;

   % Barra de espera.
   hbar = waitbar(0,'Please wait...','name','Stage Analisys Progress');
   
   % La�o para realizar a aloca��o das demais c�lulas 
   % na ordem dada por ind1.
   for t=2:n


     %------------------------------------------------------%
     % PASSO (II): CONSTRU��O DA MATRIZ B A CADA EST�GIO T. %
     %------------------------------------------------------%     
     % Contador de solu��es fact�veis para inserir em B.
     scont = 0;     
 
     % Gerando m*nA solu��es factiveis (se poss�vel) em B a partir de A.
     for i=1:nA
         
       % % Copia a informa��o de A para B at� o est�gio t-1.
       vaux(ind1(1:t-1)) = A(i,ind1(1:t-1));
       % for k=1:t-1
       %   B(i*j,ind1(k)) = A(i,ind1(k)); 
       % end        
       
       
       % Para cada solu��o i verificar as j possibilidades de centrais.
       for j=1:m
       
         % Alocando central j para a c�lula t.                   
         vaux(ind1(t)) = j;        
           
         % Testando a factibilidade da solu��o proposta.
         %[state] = factverif(vaux,lambda,M,ind1(t));             
         state = 1;
         
         % Inserir solu��o proposta em B s� se for fact�vel.
         if (state == 1)             
           % Contador de solu��es para preencher a matriz B.
           scont = scont + 1;
           % Inserindo solu��o proposta em B.
           B(scont,ind1(1:t)) = vaux(ind1(1:t)); 
         end % Fim do if que verifica se uma solu��o � fact�vel.  
             % e permite que ela n�o seja apagada por outras
       end % Fim do la�o de verifica��o de m centrais.     
       
     end % Fim do la�o de cria��o de m solu��es para cada sol. t de A.
     
     % Atualiza��o do n�mero de solu��es contidas em B (nA).
     nA = scont;
     
     %-----------------------------------------------------%
     
     
     % Matriz auxiliar C que armazena temporariamente as aloca��es 
     % de B em C de modo a realizar avalia��es de solu��es com 
     % base na heur�stica gulosa.
     % C = B;
     
     %-------------------------------------------------------%
     % PASSO (III): AVALIA��O DAS M*NA SOLU��ES DE B USANDO  %
     %              UMA HEUR�STICA GULOSA QUE VAI AT� A      %
     %              �LTIMA ALOCA��O DA �RVORE.               %
     %-------------------------------------------------------%     
  
     
     % Contador de solu��es fact�veis admitidas em B.
     fcont = 1;
     
     % Decidindo se a busca local deve ser usada, observando 
     % o n�mero de solu��es atual � maior do que a largura de 
     % busca permite armazenar.
     if (nA > b)
         
       % Se n�o for o �ltimo est�gio t, ent�o, realizar a an�lise
       % abaixo. Sen�o, se for p �ltimo est�gio, ent�o, a matriz B 
       % j� � automaticamente formada a partir da matriz A.
       if (t < n)
         
         % La�o para atribuir um valor de fun��o objetivo para 
         % cada solu��o contida na matriz B realizando buscas 
         % locais (heur�stica gulosa), ou seja, observando apenas
         % os custos de cabeamento (c) e handoff (h).
         for k=1:nA
           
           % Para completar o custo de cada sol. alocar os est�gios
           % al�m de t ou seja de t+1 at� n.
           for s=(t+1):n
             % Avalia��o da aloca��o da central para o est�gio t+1.  
             B(fcont,ind1(s)) = 1;
           
             % Testando a factibilidade da solu��o proposta.
             %[state] = factverif(B(fcont,:),lambda,M,ind1(s));
             state = 1; 
             
             % Verificando se a solu��o proposta � fact�vel.
             if (state == 1)
               %%vind3 = funevaluates(B(fcont,:),c,h,s,ind1);
               vind3 = sol2fo(B(fcont,1:s),D,nr,nc);
               ind3 = 1;
             else
               vind3 = inf;
               ind3 = -1;
             end 
           
           
             % La�o para testar as demais aloca��es de centrais em t+1.
             for v=2:m 
               B(fcont,ind1(s)) = v;
             
               % Avalia��o da aloca��o da central v para o est�gio t+1.  
               %%aux = funevaluates(B(fcont,:),c,h,s,ind1);
               aux = sol2fo(B(fcont,1:s),D,nr,nc);
               % Testando a factibilidade da solu��o proposta.
               %%[state] = factverif(B(fcont,:),lambda,M,ind1(s));
               state = 1;
               
               % Verificando que a possibilidade de aloca��o v � melhor e 
               % se � tamb�m � fact�vel.
               if (state == 1)
                 if (aux < vind3)  
                   ind3 = v;
                   vind3 = aux;
                 end
               end    
             
             end % La�o que testa v aloca��es de centrais em t+1.
           
             % Se todas as m possibilidades de aloca��o de centrais 
             % para a solu��o no est�gio atual t s�o infact�veis, ent�o, 
             % n�o precisa mais analisar os demais est�gios desta solu��o !!!
             if (vind3 < inf)
             
               % Armazenando para o est�gio s apenas a solu��o que 
               % apresentou melhor valor ap�s a heur�stica gulosa
               % para uma dada solu��o k e que seja factivel.
               B(fcont,ind1(s)) = ind3;               
             
            
             % Esta solu��o n�o ofereceu solu��es fact�veis e 
             % devemos passar para a pr�xima.
             else  
               break;
             end % Fim do if que verifica se a solu��o em um dado
                 % est�gio t � infact�vel.
           
             % Armazenar os valores de fun��o objetivo apenas no �ltimo
             % est�gio (em cada est�gio ocorre a aloca��o de uma c�lula).
             if (s == n)
               fb(k) = vind3; 
             end  
           
           end   % La�o que testa os est�gios de t+1 at� m.
         
           % Incrementa o n�mero de solu��es fact�veis que
           % podem ser adicionadas em B desde que a solu��o
           % proposta em B seja fact�vel.
           if (vind3 < inf)
             fcont = fcont + 1;
           end            
         
         end     % La�o que avalia as k = 1:nA solu��es contidas em B.
         
         % Recalculando o n�mero de solu��es de B (devido a verifica��o 
         % de solu��es fact�veis que pode levar a um n�mero menor de sol.
         % entre os sucessivos est�gios t).
         nA = fcont - 1;
         
       % Estamos no �ltimo est�gio e a matriz B � completamente preenchida
       % com as poss�veis combina��es a partir da matriz A.
       else
         
           
         % N�o � necess�rio mais realizar a verifica��o de factibilidade, 
         % pois a gera��o de solu��es de B a partir de A j� realiza a 
         % verifica��o de factibilidade, mas � necess�rio calcular o 
         % valor de cada solu��o proposta por B.
         % La�o que fornece o valor das solu��es contidas em B no est�gio t  
         for v=1:nA
            % Avalia��o da aloca��o da c�lula para o �ltimo est�gio t.  
            
            
            % % Testando a factibilidade da solu��o proposta.
            % [state] = factverif(B(v,:),lambda,M,ind1(t));                      
            % Verificando se a solu��o proposta � fact�vel.
            % if (state == 1)
               %%fb(v) = funevaluates(B(v,:),c,h,t,ind1);
               fb(v) = sol2fo(B(v,1:t),D,nr,nc);
            % else
            %   fb(v) = inf;
            % end            
            
         end % Fim do la�o que calcula fo para as solu��es do �ltimo est. 
           
       end   % Fim do teste que verifica se estamos no �ltimo est�gio t
       
     % Caso em que s� � necess�rio atribuir valores da fun��o objetivo
     % sem se preocupar com espa�o, mas � necess�rio se preocupar com
     % a factibilidade !!!
     else  
         
         
        % La�o para avaliar os valores das solu��es contidas em B.
        for k=1:nA                               
            
          % Testando a factibilidade da solu��o proposta.
          %[state] = factverif(B(k,:),lambda,M,ind1(t));
          state = 1; 
          
          % Verificando se a solu��o proposta � fact�vel.
          if (state == 1)
            %%fb(k) = funevaluates(B(k,:),c,h,t,ind1);
            fb(k) = sol2fo(B(k,1:t),D,nr,nc);
          else
            fb(k) = inf;
          end              
            
          % Avalia��o da aloca��o da central v para o est�gio t.  
          %%fb(k) = funevaluates(B(k,:),c,h,t,ind1);             
          fb(v) = sol2fo(B(k,1:t),D,nr,nc);
        end % La�o que fornece o valor das b solu��es de B.  
       
     end       % Teste para saber se aplica heur�stica gulosa.

     %-------------------------------------------------------%
     
     %-------------------------------------------------------%
     % PASSO (I):   A PARTIR DA MATRIZ B GERAR A MATRIZ      %
     %              SELECIONANDO APENAS AS b MELHORES        %
     %              SOLU��ES DE ACORDO COM A HEUR�STICA      %
     %              GULOSA.                                  %
     %-------------------------------------------------------%
     [aux,ind2]=sort(fb,2,'ascend');
     
     % Copiando apenas os elementos de 1 at� t das b melhores 
     % solu��es de B para A.
     for v=1:b
       A(v,ind1(1:t)) = B(ind2(v),ind1(1:t));   
       fit(v) = fb(ind2(v));
     end    
     
     % Limpando B e fb.
     B(:,:) = 0;
     fb(:) = inf;
     
     % Verificando se o tamanho de B � maior que o de A 
     % e se isto ocorrer, ent�o, modificar nA para b.
     if (nA > b)
       nA = b;  
     end    
     
     % Se for o �ltimo est�gio, ent�o, copia a informa��o 
     % de fun��o objetivo para ser fornecida para a grava��o 
     % de dados.
     if (t == n)
       % Reordenando a matriz X de saida das solu��es de modo
       % a se obter que o melhor individuo esteja ultima posicao.
       X = A(end:-1:1,:);
       fit = fit(end:-1:1);
     end  
     
     %-------------------------------------------------------%
     
     % Atualizando a barra de espera.
     waitbar(t/n,hbar);   

       
   end % Fim do la�o para percorrer todas as c�lulas.    
   
   
   % Fechando a barra de espera.
   close(hbar);
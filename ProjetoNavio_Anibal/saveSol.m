 %----------------------------------------------------------------%
 %                                                                %     
 % FUNCAO RESPONSAVEL POR SALVAR OS DADOS DA OTIMIZAÇÃO           %
 %                                                                % 
 %----------------------------------------------------------------%   
 function saveSol(file,path,filename,pathname,nr,nc,np,dt,D,X,fit,totaltime,methodtype)
     
  
    
  % Verificando se foi atribuido um nome ao arquivo e 
  % um diretorio aonde salvar as soluções.
  if (file ~= 0)
  
    % Concatenando o nome proposto pelo usuario com 
    % o do arquivo de dados utilizado.
    file = strcat(filename(1:end-4),file);
    
    % Adicionando uma extensao ao arquivo de saida.
    file = strcat(file,'.scs')
  
    %--------------------------------------------------%
    % ARMAZENANDO EM UM ARQUIVO OS RESULTADOS          %
    % DA OTIMIZACAO !!!                                %
    %--------------------------------------------------%
    
    % Armazenando o diretorio atual.
    diratual = cd;
    
    % Mudando para o diretorio aonde os dados
    % devem ser salvos.
    cd(path);
    
    % Dependendo do tipo de metodo utilizado 
    % para obter a solucao atualmente em foco
    % (1-EE ou 2-MPI), o nome do arquivo sera 
    % diferente.  
    
    
    % Abrindo o arquivo selecionado para gravar os 
    % dados.
    fid = fopen(file,'w');
    
    
    %------------------------------------------------------%
    %                                                      %
    %------------------------------------------------------%
    %                                                      %
    %------------------------------------------------------%
    %                                                      %
    %                                                      %
    %                                                      %
    %     PARTE RELATIVA AOS DADOS DOS ARQUIVOS USADOS     %
    %                                                      %
    %                                                      %
    %                                                      %
    %------------------------------------------------------%
    %                                                      %
    %------------------------------------------------------%
    %                                                      %
    %------------------------------------------------------%
    
    

    %// ARQUIVO DE RESULTADOS
    %// CellManager 1.0 - Alocação de Antenas para Telefonia Celular
    %// Metodo de otimizacao utilizado: MS/SG/etc...
    fprintf(fid,'// ARQUIVO DE RESULTADOS \n');
    fprintf(fid,'// ShipManager 1.0 - Alocação de Containeres em Navios \n');    
     
    
    %% Diretorio de origem e nome dos arquivos de entrada 
    fprintf(fid,'\n// Diretorio do arquivo com os dados:  \n');
    fprintf(fid,'//  %s \n',pathname);
    fprintf(fid,'\n// Arquivo de entrada:  \n');
    aux = strcat(filename);
     
    
    %------------------------------------------------------%
    %                                                      %
    %------------------------------------------------------%
    %                                                      %
    %------------------------------------------------------%
    %                                                      %
    %                                                      %
    %                                                      %
    %     PARTE RELATIVA AOS DADOS DO PROBLEMA             %
    %                                                      %
    %                                                      %
    %                                                      %
    %------------------------------------------------------%
    %                                                      %
    %------------------------------------------------------%
    %                                                      %
    %------------------------------------------------------%
    
    
    
      %-------------------------------------------%
      % Cabecalho das principais informacoes.     %
      %-------------------------------------------%
      
      %-------------------------------------------%
      % Informacoes de data e tempo de geracao.   %
      %-------------------------------------------%
      fprintf(fid,'// Date \n');  
      fprintf(fid,'[DA] \n');  
      fprintf(fid,'%s \n',date);  
      fprintf(fid,'// Hour \n');  
      fprintf(fid,'[HO] \n');  
      v = clock;
      fprintf(fid,'%02d:%02d:%02.0f \n',v(4),v(5),v(6));        
      %-------------------------------------------%
      
      
      %-------------------------------------------%
      % Numero de linhas.                         %
      %-------------------------------------------%
      fprintf(fid,'// Number of Rows: 6, 8, 10 \n');  
      fprintf(fid,'[NR] \n');  
      fprintf(fid,'%02d \n',nr);  
      %-------------------------------------------%
      
      %-------------------------------------------%
      % Numero de colunas.                        %
      %-------------------------------------------%
      fprintf(fid,'// Number of Columns: 50 to 170 \n');  
      fprintf(fid,'[NC] \n');  
      fprintf(fid,'%03d \n',nc);  
      %-------------------------------------------%

      %-------------------------------------------%
      % Numero de portos.                         %
      %-------------------------------------------%
      fprintf(fid,'// Number of Ports: 10:5:30 \n');  
      fprintf(fid,'[NP] \n');  
      fprintf(fid,'%2d \n',np);  
      %-------------------------------------------%
      
      %-------------------------------------------%
      % Tipos de matriz.                          %
      %-------------------------------------------%
      fprintf(fid,'// Matrix type: 1 - Mixed, 2 - Long Distance, 3 - Short Distance \n');  
      fprintf(fid,'[DT] \n');  
      fprintf(fid,'%1d \n',dt);  
      %-------------------------------------------%
      
      %-------------------------------------------%
      % Conteudo da matriz D gerada.              %
      %-------------------------------------------%
      fprintf(fid,'// Demand Matriz Information \n');  
      fprintf(fid,'[DI] \n');  
      % Percorrendo cada elemento da matriz D e 
      % imprimindo.
      for i=1:np
        for j=1:np  
          fprintf(fid,' %5d ',D(i,j));  
        end
        fprintf(fid,'\n');
      end  
      %-------------------------------------------%
           
    
    %------------------------------------------------------%
    %                                                      %
    %------------------------------------------------------%
    %                                                      %
    %------------------------------------------------------%
    %                                                      %
    %                                                      %
    %                                                      %
    %     PARTE RELATIVA AOS DADOS DA SOLUÇÃO OBTIDA       %
    %                                                      %
    %                                                      %
    %                                                      %
    %------------------------------------------------------%
    %                                                      %
    %------------------------------------------------------%
    %                                                      %
    %------------------------------------------------------%
    
        
    %// Nome do metodo escolhido e utilizado para resolver o problema.
    %[MN]
    %    
    % Merchant e Sengupta / Simple Genetic / etc...
    fprintf(fid,' \n');
    % Construcao do Cabecalho.
    fprintf(fid,'// Method used to solve the container ship problem. \n');
    fprintf(fid,'[MN] \n');
    % Loop para construcao dos valores das atribuicoes de antena
    % realizadas para cada célula.
    fprintf(fid,' %s \n',methodtype); 
    
    %// Tempo computacional[s] do método escolhido.
    %[CT]
    %    
    % 0.03
    fprintf(fid,' \n');
    % Construcao do Cabecalho.
    fprintf(fid,'// Computacional time spent in seconds. \n');
    fprintf(fid,'[CT] \n');
    % Impressao do tempo gasto para obter a solucao otima.
    fprintf(fid,' %f  \n',totaltime);


    
    %// Valor da solucao fornecida pelo metodo escolhido.
    %[SO]
    %    
    fprintf(fid,' \n');
    % Construcao do Cabecalho.
    fprintf(fid,'// Solution objetive value. \n');
    fprintf(fid,'[SO] \n');
    % Impressao do valor da funcao objetivo para solucao fornecida.
    fprintf(fid,' %f  \n',fit);
   
    
    %// Vetor de regras: Solucao fornecida pelo metodo escolhido.
    %[RV]
    %    
    % Ordem Implícita   Regra mostrada
    % Cel. 1            Antena 3
    % Cel. 2            Antena 1
    % ...               ...  
    % Cel. n-1          Antena m-1
    % Cel. n            Antena 2
    fprintf(fid,' \n');
    % Construcao do Cabecalho.
    fprintf(fid,'// Vector of rules: indicates which rule should be used for each port. \n');
    fprintf(fid,'// Also remember that the in last port there is only one type of container. \n');
    fprintf(fid,'// So, any rule will produce the same number of moviments. \n');
    fprintf(fid,'[RV] \n');
    % Loop para construcao dos valores das atribuicoes de regras
    % realizadas para cada porto.
    for i=1:(np-1)
      fprintf(fid,' %d  \n',X(i));
    end     
    
    
    % Fechando o arquivo de gravacao de dados.
    fclose(fid);
    
    
    
    % Voltando para o diretorio inicial.
    cd(diratual);
    
    % Indicando o status dos dados no arquivo.
    file = strcat(path,file);
    file = strcat(file,' has been saved sucessfully !');
  %  msgbox(file,'Saving Process','help');
    fprintf(1,'%s has been saved sucessfully ! \n',file);
    
  else
     msgbox('The file was not saved','Saving Process','help'); 
  end    
      
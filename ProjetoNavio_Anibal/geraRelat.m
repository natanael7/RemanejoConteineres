  % Funcao responsavel por gerar relatorios dos arquivos de solucao
  % obtendo a media da solucao e do tempo de execucao para um dado
  % diretorio contendo resultados para uma mesma instancia.
  
  function geraRelat
  
  % Comando que obtem o arquivo que sera utilizado na analise
  % grafica, bem como o diretorio aonde ele esta.
  [filename, dirfile] = uigetfile('*.scs', 'Set directory');

  % Caso nao tenham sido fornecidas informacoes suficientes
  % para se obter o nome do novo arquivo e do novo diretorio
  % nao iremos modificar as mesmas.
  if ( (sum(filename > 0)) & (sum(dirfile > 0)) )
    
     %-------------------------------------------------------------------------%
     % Esta funcao deve captar e listar todos os arquivos que estao 
     % no formato pre-selecionado pelo usuario (CART*.DAT ou 20050203_PAT*.PWF)
     % no quadro de lista existente.
     %-------------------------------------------------------------------------%
     diratual = cd;
     
     % Obtendo os arquivos de acordo com o padrao escolhido pelo usuario.
     extension = strcat('*','.scs');
  
     % Aplicando a busca no diretorio apenas aos arquivos com tipos 
     % selecionados pelo usuario.
     cd(dirfile);
     aux = dir(extension);

     % Preparando os dados recebidos em um formato que possamos 
     % colocar na interface grafica.
     % Ordenacao de colunas.
     [sorted_names,sorted_index] = sortrows({aux.name}');
     
     % Construindo lista ordenada de arquivos.
     listoffiles = sorted_names;    
          
     % New number of total files.
     numberfiles = length(listoffiles);
     
     % Voltando ao diretorio atual.
     cd(diratual);

     % Obtendo as informações de arquivos e diretorios para 
     % que estas sejam utilizadas para resolver os casos 
     % de problemas selecionados.
     for i=1:(numberfiles)
          
       % Escolhendo um arquivo para ser resolvido por vez.  
       filename = listoffiles{i};

       % Recuperando as informacoes de tempo computacional 
       % e melhor valor da solucao otima obtida.
       [ct(i),so(i),error] = getSol(dirfile,filename);     
     end 
     
     % Escrever as informacoes em um arquivo de mesmo nome que
     % o diretorio onde estao contidas as informacoes.
     [file, path] = uiputfile('*.rsc', 'Save a RSC-file');
     if isequal(file,0) | isequal(path,0)
        disp('User pressed cancel');
     else
        diratual = cd;
        cd(path);
        fid = fopen(file,'w');
        
        %// ARQUIVO DE RESULTADOS
        %// CellManager 1.0 - Alocação de Antenas para Telefonia Celular
        %// Metodo de otimizacao utilizado: MS/SG/etc...
        fprintf(fid,'// ARQUIVO DE RESULTADOS \n');
        fprintf(fid,'// ShipManager 1.0 - Alocação de Containeres em Navios \n');    
         
        %% Diretorio de origem e nome dos arquivos de entrada 
        fprintf(fid,'\n// Diretorio do arquivo com os dados:  \n');
        fprintf(fid,'//  %s \n',path);
        fprintf(fid,'\n// Arquivo de entrada:  \n');
        aux = strcat(file);
        
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
        % Informacoes de tempo e fo da solucao.     %
        %-------------------------------------------%
        fprintf(fid,'// MEAN CT in seconds \n');  
        fprintf(fid,'[MC] \n');  
        fprintf(fid,'%8.2f \n',mean(ct));  
        fprintf(fid,'// Mean SO in number of moviments \n');  
        fprintf(fid,'[MF] \n');  
        fprintf(fid,'%8.2f \n',mean(so));      
        
     end
     
     % Voltando ao diretorio atual.
     cd(diratual);
       
  end  
 
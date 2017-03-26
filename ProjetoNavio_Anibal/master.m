function master %(file,path,pathname,filename,method)

%pathname='C:\Unisinos\Disserta��es\Luziana\Programas\';
%filenae='stowage06050101.sto';

  % Fun��o respons�vel por capturar 
  % os dados do problema de aloca��o 
  % de containeres em navios de acordo 
  % com as informac�es de diretorio e 
  % nome de arquivo.
  [nr,nc,np,dt,D,error] = getData('E:\Computa��o\ProjetoNavio_Anibal','stowage06050101.sto')   %(pathname,filename);
  method=1;
  
  
  % Numero de regras possiveis.
  lb = 1;
  ub = 4; % Ate 4 combinacoes de regras possiveis: 2 de entrada e 2 de saida.
  %ub = 8; % Ate 8 combinacoes de regras possiveis: 4 de entrada e 2 de saida.
 
  % Verificando se nao ocorreram erros.
  if not(error)
  
     
    %----------------------------------------------------------------%
    %                                                                % 
    % ALGORITMO GEN�TICO                                             % 
    %                                                                % 
    %----------------------------------------------------------------%
    %                                                                % 
    % Verificando se foi escolhido o ALGORITMO GEN�TICO simples.     % 
    %                                                                % 
    %----------------------------------------------------------------%
    if (method == 1)  
      tic;
      [X,fit]=ga(nr,nc,np,D,lb,ub);
      totaltime = toc;
      methodtype = 'GA';
      
    %----------------------------------------------------------------%
    %                                                                % 
    % MERCHANT & SENGUPTA.                                           % 
    %                                                                % 
    %----------------------------------------------------------------%
    %                                                                % 
    % O m�todo de Merchant & Sengupta foi escolhido.                 %
    %                                                                %     
    %----------------------------------------------------------------%
    elseif (method == 2)
      % Coordenando a execu��o do algoritmo de Merchant & Sengupta.
      % Implementa��o da heuristica de 
      % Merchant and Sengupta, Assigment 
      % of Cells to Switches in PCS
      % Networks, Vol. 3, No. 5, October,
      % 1995.
      tic;
      [X,fit]=ms(nr,nc,np,D);
      totaltime = toc;
      methodtype = 'MS';

    %----------------------------------------------------------------%
    %                                                                % 
    % ALGORITMO DO BEAM SEARCH.                                      % 
    %                                                                % 
    %----------------------------------------------------------------%
    %                                                                % 
    % O m�todo de beam search simples foi escolhido.                 %
    %                                                                %     
    %----------------------------------------------------------------%
    elseif (method == 3)
      % Coordenando a execu��o de um algoritmo gen�tico.
      tic;
      [X,fit]=BeamSearch(nr,nc,np,D,lb,ub);
      totaltime = toc;
      methodtype = 'BS';                        
      
    %----------------------------------------------------------------%
    %                                                                % 
    % ALGORITMO DO GENETICO PARA TESTAR VARIOS PARAMETROS.           % 
    %                                                                % 
    %----------------------------------------------------------------%
    %                                                                % 
    % O m�todo de genetico varredura foi escolhido.                  %
    %                                                                %     
    %----------------------------------------------------------------%
    elseif (method == 4)
      % Coordenando a execu��o de um algoritmo gen�tico de varredura.
      tic;
      gamaster(file,path,filename,pathname,dt,nr,nc,np,D,lb,ub);
      totaltime = toc;
      methodtype = 'GM';                        
  
    
    %----------------------------------------------------------------%
    %                                                                %     
    % NENHUM M�TODO DE RESOLU��O FOI SELECIONADO !!!!                %
    %                                                                % 
    %----------------------------------------------------------------%   
    else
      msgbox('Unkown method have been selected','Warning','Warn');  
    end

    %----------------------------------------------------------------%
    %                                                                %     
    % ARMAZENANDO AS SOLU��ES OBTIDAS COM OS ALGORITMOS DE RESOLU��O.%
    %                                                                % 
    %----------------------------------------------------------------%   
    if (method ~= 4) % Se nao usou o algoritmo gentico de varredura !!
%       saveSol(file,path,filename,pathname,nr,nc,np,dt,D,X(end,:),fit(end),totaltime,methodtype);
       saveSol('saida.txt','E:\Computa��o\ProjetoNavio_Anibal','stowage06050101.sto',...
               'E:\Computa��o\ProjetoNavio_Anibal',nr,nc,np,dt,D,X(end,:),fit(end),totaltime,methodtype);
       
    end   
  end  
 
%----------------------------------------------------------%
% LEITURA DOS DADOS DA INSTANCIA PARA O PROBLEMA DE        %
% NAVIOS.                                                  %
%----------------------------------------------------------%
% // Date 
% [DA] 
% 02-Jul-2009 
% // Hour 
% [HO] 
% 15:43:29 
% // Number of Rows: 6, 8, 10 
% [NR] 
% 06 
% // Number of Columns: 50 to 170 
% [NC] 
% 050 
% // Number of Ports: 10:5:30 
% [NP] 
% 10 
% // Matrix type: 1 - Mixed, 2 - Long Distance, 3 - Short Distance 
% [DT] 
% 1 
% // Demand Matriz Information 
% [DI] 
%      0     38      0     48     42     31     32     55     50      5 
%      0      0     13     41     16      8     56     28     38     53 
%      0      0      0      0     15     53     54      0      0     14 
%      0      0      0      0      0     21     54     56     15      0 
%      0      0      0      0      0     20     14     55      4     41 
%      0      0      0      0      0      0      0     59      0      0 
%      0      0      0      0      0      0      0      4     29     18 
%      0      0      0      0      0      0      0      0     36     15 
%      0      0      0      0      0      0      0      0      0     18 
%      0      0      0      0      0      0      0      0      0      0 
%----------------------------------------------------------%
function [ct,so,error] = getSol(dirfile,filename)

   % Assumindo que houve erro na leitura dos dados.
   error = 1;
   
   % Sabendo qual e o diretorio atual para depois voltar.
   diratual = cd;

   % Mudando para o diretorio aonde estao os arquivos com os resultados.
   cd(dirfile);
 
   % Abrindo o arquivo so para leitura.
   fid = fopen(filename,'r');
   
   % Abertura com sucesso do arquivo !!!
   if (fid ~= -1)
     error = 0;
   
%    %// Number of Rows: 6, 8, 10.
%    %[NR]
%    % n m  
%    qq = fscanf(fid,' %s ',1);
%    while (not(strcmp('[NR]',qq)))
%      qq = fscanf(fid,' %s ',1);     
%    end    
%    % Leitura do numero de linhas da matriz que representa o navio.
%    nr = fscanf(fid,'%d',1);
%     
%       
%    %// Number of Columns: 50 to 170 
%    %[NC]
%    qq = fscanf(fid,' %s ',1);
%    while (not(strcmp('[NC]',qq)))
%      qq = fscanf(fid,' %s ',1);  
%    end       
%    % Lendo o numero de colunas da matriz que representa o navio.
%    nc = fscanf(fid,'%d',1);
%    
%    %// Number of Ports: 10:5:30 
%    %[NP]
%    qq = fscanf(fid,' %s ',1);
%    while (not(strcmp('[NP]',qq)))
%      qq = fscanf(fid,' %s ',1);  
%    end       
%    % Lendo o numero de portos pelos quais o navio deve passar.
%    np = fscanf(fid,'%d',1);
% 
% 
%     %// Matrix type: 1 - Mixed, 2 - Long Distance, 3 - Short Distance 
%     qq = fscanf(fid,' %s ',1);
%     while (not(strcmp('[DT]',qq)))
%       qq = fscanf(fid,' %s ',1);  
%     end       
%     % Lendo o tipo de matriz de demanda.
%     dt = fscanf(fid,'%d',1);
%    
%     
%     %// Demand Matriz Information.
%     %[DI]
%     qq = fscanf(fid,' %s ',1);
%     while (not(strcmp('[DI]',qq)))
%       qq = fscanf(fid,' %s ',1);  
%     end       
%     % Lendo a matriz de demanda para cada porto.
%     D = [fscanf(fid,' %d ',[np np])]';    
%     
    
    %// Computacional time spent in seconds.
    %[CT]
    qq = fscanf(fid,' %s ',1);
    while (not(strcmp('[CT]',qq)))
      qq = fscanf(fid,' %s ',1);  
    end       
    % Lendo o tempo computacional.
    ct = fscanf(fid,'%f',1);
   
    %// Solution objetive value.
    %[SO]
    qq = fscanf(fid,' %s ',1);
    while (not(strcmp('[SO]',qq)))
      qq = fscanf(fid,' %s ',1);  
    end       
    % Lendo o valor da funcao objetivo.
    so = fscanf(fid,'%f',1);
    
    % Fechando o arquivo lido.
    fclose(fid);
    
    end % Fim do if do arquivo.
   
    % Voltando ao diretorio atual.
    cd(diratual);
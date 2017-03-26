function varargout = ShipManager(varargin)
% SHIPMANAGER M-file for ShipManager.fig
%      SHIPMANAGER, by itself, creates a new SHIPMANAGER or raises the existing
%      singleton*.
%
%      H = SHIPMANAGER returns the handle to a new SHIPMANAGER or the handle to
%      the existing singleton*.
%
%      SHIPMANAGER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHIPMANAGER.M with the given input arguments.
%
%      SHIPMANAGER('Property','Value',...) creates a new SHIPMANAGER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ShipManager_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ShipManager_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help ShipManager

% Last Modified by GUIDE v2.5 02-Jul-2009 18:59:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ShipManager_OpeningFcn, ...
                   'gui_OutputFcn',  @ShipManager_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ShipManager is made visible.
function ShipManager_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ShipManager (see VARARGIN)

% Choose default command line output for ShipManager
handles.output = hObject;


    %---------------------------------------------------------------------------------------%
    % IMPORTANT VARIABLES INITIALIZATION.
    % %   
    %---------------------------------------------------------------------------------------%  

    handles.fileext    = '.sto';  % File extension .dat.
    handles.dirfile    =    cd;   % Actual directory.
    handles.dirsaida   =    cd;   % The directory where the results will be saved is the
                                  % actual directory.  
    handles.filesaida  = 'unkownmethod.sol'; % default output file name.
    handles.filesol = ''; % empty file is the default.
    handles.dirsol = '';  % empty directory is the default.

    % Initial edit_directory must be showed in the interface.
    set(handles.edit_directory,'String',handles.dirfile); % Setting the interface.
    set(handles.edit_dirsaida,'String',handles.dirsaida); % The default results directory.
    % Only extensions from the user.
    extension = strcat('*',handles.fileext);
    % Aplicando a busca no diretorio apenas aos arquivos com tipos 
    % selecionados pelo usuario.
    aux = dir(extension);
    % Putting the information in interface list !
    % Preparing data to put in the interface.
    % Column Ordenation.
    [sorted_names,sorted_index] = sortrows({aux.name}');
    % List of files.
    handles.listoffiles = sorted_names;
    % Initial number of total files.
    handles.numberfiles = length(handles.listoffiles);
    % Putting the information in interface list !
    set(handles.listbox_files,'String',handles.listoffiles,'Value',1)
    % Initial list of seleted files for analisys.
    handles.listfilesselected = {};
    % Initial number of files selected.
    handles.numberfilesselected = 0;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ShipManager wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ShipManager_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_files.
function listbox_files_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_files


% --- Executes during object creation, after setting all properties.
function listbox_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_add.
function pushbutton_add_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  % Esta funcao ter por finalidade escolher como sera constituida
    % a nova lista de arquivos total e selecionada.
    
    % Verificando se o numero total de arquivos e maior que zero !
    if (handles.numberfiles > 0)
                
      % Obtendo o arquivo selecionado na caixa principal.  
      Numfile = get(handles.listbox_files,'Value');
        
      % Se o arquivo ja nao foi retirado da lista de todos 
      % os arquivos existentes, entao, podemos incluir o 
      % mesmo na lista de arquivos selecionados.
      if not(isempty(handles.listoffiles{Numfile}))
        
        % Atualizando o numero de arquivos do total que estao 
        % disponiveis para serem copiados.
        handles.numberfiles = handles.numberfiles - 1;
    
        % Numero de arquivos ja selecionados sera atualizado.
        handles.numberfilesselected = handles.numberfilesselected + 1;
        NumSelected = handles.numberfilesselected;
   
        % Adicionando na lista de arquivos a serem usados
        % para construir os graficos o arquivo atualmente
        %  em foco.
        handles.listfilesselected{NumSelected} = handles.listoffiles{Numfile};
        
        % Retirando o arquivo da lista de arquivos totais.
        ind = 1;
        % Variavel auxiliar. Devemos usar um for, pois o 
        % comando find nao funciona para estrutura tipo
        % cell, nem o comando {} retira o elemento dado
        % pelo indice Numfile do vetor de strings.
        aux = {};
        for i=1:(handles.numberfiles+1)
          if (i ~= Numfile)  
            aux{ind} = handles.listoffiles{i};
            ind = ind + 1;
          end  
        end  
        % Limpando totalmente o vetor para que possamos
        % fornecer uma nova lista de arquivos armazenados
        % nele.
        handles.listoffiles = {};
        % Passando a nova lista de arquivos para a lista
        % de arquivos totais existentes.
        handles.listoffiles = aux;        
      end  

    end

    % Atualizando na interface dos arquivos ja 
    % devidamente selecionados.
    % Putting the information in the selected interface list !
    set(handles.listbox_selected,'String',handles.listfilesselected,'Value',1)
    % Putting the information in the total interface list !
    set(handles.listbox_files,'String',handles.listoffiles,'Value',1)
   

    % Update handles structure
    guidata(hObject, handles);



% --- Executes on button press in pushbutton_remove.
function pushbutton_remove_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  % Verificando se o numero total de arquivos e maior que zero !
   if (handles.numberfilesselected > 0)

      % Obtendo o arquivo selecionado na caixa de arquivos selecionados.  
      Numfile = get(handles.listbox_selected,'Value');
        
      % Se o arquivo ja nao foi retirado da lista de todos 
      % os arquivos existentes, entao, podemos incluir o 
      % mesmo na lista de arquivos selecionados.
      if not(isempty(handles.listfilesselected{Numfile}))
        
        % Atualizando o numero de arquivos do total que estao 
        % disponiveis para serem copiados.
        handles.numberfilesselected = handles.numberfilesselected - 1;
    
        % Numero de arquivos ja selecionados sera atualizado.
        handles.numberfiles = handles.numberfiles + 1;
        NumSelected = handles.numberfiles;
   
        % Adicionando na lista de arquivos a serem usados
        % para construir os graficos o arquivo atualmente
        %  em foco.
        handles.listoffiles{NumSelected} = handles.listfilesselected{Numfile};
        
        % Retirando o arquivo da lista de arquivos totais.
        ind = 1;
        % Variavel auxiliar. Devemos usar um for, pois o 
        % comando find nao funciona para estrutura tipo
        % cell, nem o comando {} retira o elemento dado
        % pelo indice Numfile do vetor de strings.
        aux = {};
        for i=1:(handles.numberfilesselected+1)
          if (i ~= Numfile)  
            aux{ind} = handles.listfilesselected{i};
            ind = ind + 1;
          end  
        end  
        % Limpando totalmente o vetor para que possamos
        % fornecer uma nova lista de arquivos armazenados
        % nele.
        handles.listfilesselected = {};
        % Passando a nova lista de arquivos para a lista
        % de arquivos totais existentes.
        handles.listfilesselected = aux;

    
        % Atualizando na interface dos arquivos ja 
        % devidamente selecionados.
        % Putting the information in the selected interface list !
        set(handles.listbox_selected,'String',handles.listfilesselected,'Value',1)
        % Putting the information in the total interface list !
        set(handles.listbox_files,'String',handles.listoffiles,'Value',1)
        
      end  

   end

   % Update handles structure
   guidata(hObject, handles);


% --- Executes on selection change in listbox_selected.
function listbox_selected_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox_selected contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_selected


% --- Executes during object creation, after setting all properties.
function listbox_selected_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_selected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_addAll.
function pushbutton_addAll_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_addAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_removeall.
function pushbutton_removeall_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_removeall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  % Esta funcao ter por finalidade escolher como sera constituida
   % a nova lista de arquivos total e selecionada.
    
   % Verificando se o numero total de arquivos e maior que zero !
   while (handles.numberfilesselected > 0)

      % Obtendo o arquivo selecionado na caixa de arquivos selecionados.  
      Numfile = get(handles.listbox_selected,'Value');
        
      % Se o arquivo ja nao foi retirado da lista de todos 
      % os arquivos existentes, entao, podemos incluir o 
      % mesmo na lista de arquivos selecionados.
      if not(isempty(handles.listfilesselected{Numfile}))
        
        % Atualizando o numero de arquivos do total que estao 
        % disponiveis para serem copiados.
        handles.numberfilesselected = handles.numberfilesselected - 1;
    
        % Numero de arquivos ja selecionados sera atualizado.
        handles.numberfiles = handles.numberfiles + 1;
        NumSelected = handles.numberfiles;
   
        % Adicionando na lista de arquivos a serem usados
        % para construir os graficos o arquivo atualmente
        %  em foco.
        handles.listoffiles{NumSelected} = handles.listfilesselected{Numfile};
        
        % Retirando o arquivo da lista de arquivos totais.
        ind = 1;
        % Variavel auxiliar. Devemos usar um for, pois o 
        % comando find nao funciona para estrutura tipo
        % cell, nem o comando {} retira o elemento dado
        % pelo indice Numfile do vetor de strings.
        aux = {};
        for i=1:(handles.numberfilesselected+1)
          if (i ~= Numfile)  
            aux{ind} = handles.listfilesselected{i};
            ind = ind + 1;
          end  
        end  
        % Limpando totalmente o vetor para que possamos
        % fornecer uma nova lista de arquivos armazenados
        % nele.
        handles.listfilesselected = {};
        % Passando a nova lista de arquivos para a lista
        % de arquivos totais existentes.
        handles.listfilesselected = aux;

    
        % Atualizando na interface dos arquivos ja 
        % devidamente selecionados.
        % Putting the information in the selected interface list !
        set(handles.listbox_selected,'String',handles.listfilesselected,'Value',1)
        % Putting the information in the total interface list !
        set(handles.listbox_files,'String',handles.listoffiles,'Value',1)
        
      end  

   end

   % Update handles structure
   guidata(hObject, handles);




function edit_directory_Callback(hObject, eventdata, handles)
% hObject    handle to edit_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_directory as text
%        str2double(get(hObject,'String')) returns contents of edit_directory as a double


% --- Executes during object creation, after setting all properties.
function edit_directory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_changedir.
function pushbutton_changedir_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_changedir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


  % Comando que obtem o arquivo que sera utilizado na analise
  % grafica, bem como o diretorio aonde ele esta.
  [filename, pathname] = uigetfile('*.sto', 'Set directory');

  % Caso nao tenham sido fornecidas informacoes suficientes
  % para se obter o nome do novo arquivo e do novo diretorio
  % nao iremos modificar as mesmas.
  if ( (sum(filename > 0)) & (sum(pathname > 0)) )
    
     handles.dirfile = pathname; % The directory where is the data to be analized. 

     % Colocando na interface o nome do novo diretorio.
     set(handles.edit_directory,'String',pathname); % Setting the interface.

     %-------------------------------------------------------------------------%
     % Esta funcao deve captar e listar todos os arquivos que estao 
     % no formato pre-selecionado pelo usuario (CART*.DAT ou 20050203_PAT*.PWF)
     % no quadro de lista existente.
     %-------------------------------------------------------------------------%
     
     % Obtendo o diretorio atual.
     diratual = cd;
     
     % Mudando para o diretorio aonde estao os dados selecionados pelo 
     % usuario.
     cd(pathname);

     % Obtendo os arquivos de acordo com o padrao escolhido pelo usuario.
     extension = strcat('*',handles.fileext);
  
     % Aplicando a busca no diretorio apenas aos arquivos com tipos 
     % selecionados pelo usuario.
     aux = dir(extension);

     % Preparando os dados recebidos em um formato que possamos 
     % colocar na interface grafica.
     % Ordenacao de colunas.
     [sorted_names,sorted_index] = sortrows({aux.name}');
     % Construindo lista ordenada de arquivos.
     handles.listoffiles = sorted_names;    
     
     
      % New number of total files.
     handles.numberfiles = length(handles.listoffiles);
     
     % Putting the information in interface list !
     set(handles.listbox_files,'String',handles.listoffiles,'Value',1);  
     
     
     % Restarting the selected file list !
     % Initial list of seleted files for analisys.
     handles.listfilesselected = {};
     % Initial number of files selected.
     handles.numberfilesselected = 0;
     
     % Putting the information in interface list !
     set(handles.listbox_selected,'String',handles.listfilesselected,'Value',1)
           

     % Voltando ao diretorio original.
     cd(diratual);
       
  end  
  
  

  guidata(hObject,handles); % Save the handles structure after adding data  



% --- Executes on button press in pushbutton_solve.
function pushbutton_solve_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_solve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



 % Obtendo o valor do método que foi selecionado no menu 
   % de opções de métodos.
   method = get(handles.popupmenu_methods,'Value');
      
   % Descobrindo qual foi o metodo selecionado e os arquivos
   % que possuem os resultados correspondentes aos metodos
   % utilizados terao parte do nome do metodo.
   % Metodo GA (Algoritmo Genetico).
   if ((method == 1)||(method == 4))
     mname =  'GAMethod';
       
   % Metodo MS (Merchant & Sengupta).
   elseif (method == 2)    
     mname =  'MSMethod';           
           
   % Metodo BS (Beam Search).           
   elseif (method == 3)        
     mname =  'BSMethod';        

   % Método ainda nao definido !  
   else
     mname =  'UMethod';                        

   end
   
   handles.filesaida = strcat(handles.filesaida,mname);
   
   % Construindo o nome do arquivo de saida, empregando o nome do 
   % metodo escolhido com o nome fornecido pelo usuario no  
   % campo edit_dirsaida.
  
      
   % Obtendo as informações de arquivos e diretorios para 
   % que estas sejam utilizadas para resolver os casos 
   % de problemas selecionados.
   for i=1:(handles.numberfilesselected)
          
     % Escolhendo um arquivo para ser resolvido por vez.  
     filename = handles.listfilesselected{i};

     % Função que coordena a resolução dos vários casos 
     % utilizando informação de diretorio e nome de arquivo.
     master(handles.filesaida,handles.dirsaida,get(handles.edit_directory,'String'),filename,method);   
     
   end 

   guidata(hObject,handles); % Save the handles structure after adding data  


% --- Executes on selection change in popupmenu_methods.
function popupmenu_methods_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_methods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_methods contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_methods


% --- Executes during object creation, after setting all properties.
function popupmenu_methods_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_methods (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dirsaida_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dirsaida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dirsaida as text
%        str2double(get(hObject,'String')) returns contents of edit_dirsaida as a double


% --- Executes during object creation, after setting all properties.
function edit_dirsaida_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dirsaida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_dirsaida.
function pushbutton_dirsaida_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dirsaida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 %--------------------------------------------------%
  % CAPTURANDO O LOCAL E O NOME DO ARQUIVO ONDE O    %
  % USUARIO DESEJA SALVAR AS INFORMAÇÕES DA SOLUÇÃO! %
  %--------------------------------------------------%
  [file, path] = uiputfile('*.scs', 'Save a SCS-file');
  
  % Só devemos alterar o nome escolhido e o caminho
  % se o usuario fornecer novas informacoes.
  if (file ~= 0)
    handles.filesaida = file(1:end-4);
    handles.dirsaida = path;
    
    % Alterando o nome do diretorio que aparece na 
    % interface.
    set(handles.edit_dirsaida,'String',handles.dirsaida); % The default results directory.
  end  

guidata(hObject,handles); % Save the handles structure after adding data  


% --- Executes on button press in pushbutton_addall.
function pushbutton_addall_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_addall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

   % Esta funcao ter por finalidade escolher como sera constituida
    % a nova lista de arquivos total e selecionada.
    
    % Verificando se o numero total de arquivos e maior que zero !
    while (handles.numberfiles > 0)
                
      % Obtendo o arquivo selecionado na caixa principal.  
      Numfile = 1;
        
      % Se o arquivo ja nao foi retirado da lista de todos 
      % os arquivos existentes, entao, podemos incluir o 
      % mesmo na lista de arquivos selecionados.
      if not(isempty(handles.listoffiles{Numfile}))
        
        % Atualizando o numero de arquivos do total que estao 
        % disponiveis para serem copiados.
        handles.numberfiles = handles.numberfiles - 1;
    
        % Numero de arquivos ja selecionados sera atualizado.
        handles.numberfilesselected = handles.numberfilesselected + 1;
        NumSelected = handles.numberfilesselected;
   
        % Adicionando na lista de arquivos a serem usados
        % para construir os graficos o arquivo atualmente
        %  em foco.
        handles.listfilesselected{NumSelected} = handles.listoffiles{Numfile};
        
        % Retirando o arquivo da lista de arquivos totais.
        ind = 1;
        % Variavel auxiliar. Devemos usar um for, pois o 
        % comando find nao funciona para estrutura tipo
        % cell, nem o comando {} retira o elemento dado
        % pelo indice Numfile do vetor de strings.
        aux = {};
        for i=1:(handles.numberfiles+1)
          if (i ~= Numfile)  
            aux{ind} = handles.listoffiles{i};
            ind = ind + 1;
          end  
        end  
        % Limpando totalmente o vetor para que possamos
        % fornecer uma nova lista de arquivos armazenados
        % nele.
        handles.listoffiles = {};
        % Passando a nova lista de arquivos para a lista
        % de arquivos totais existentes.
        handles.listoffiles = aux;        
      end  

    end

    % Atualizando na interface dos arquivos ja 
    % devidamente selecionados.
    % Putting the information in the selected interface list !
    set(handles.listbox_selected,'String',handles.listfilesselected,'Value',1)
    % Putting the information in the total interface list !
    set(handles.listbox_files,'String',handles.listoffiles,'Value',1)
   

    % Update handles structure
    guidata(hObject, handles);

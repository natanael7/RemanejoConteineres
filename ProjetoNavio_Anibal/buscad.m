% Funcao responsavel por realizar a busca lexicografica crescente.
function [i,j,ok] = buscad(x,y,D,np)
  
  % Busca falhou.
  ok = 0;
  
  i=x;
  control = 1;
  % Laço para percorrer todas as linnhas, ate 
  % achar elemento adequado, em ordem crescente.
  while ((i >= 1)&&(control == 1))
    % Verificando onde começar na coluna,
    % dependendo de que linha começamos !
    if (i ~= x)
      j = np;  
    else
      j = y;  
    end    
    
    % Laço para percorrer todas as colunas, 
    % ate achar elemento adequado, em ordem crescente.
    while (((j >= 1)&&(j > i))&&(control == 1))
      % Achou elemento !  
      if (D(i,j) == -1)
        control = 0;            
        ok = 1;
      else
        j = j - 1;            
      end          
    end
    % So atualizar i, se o indice com elemento 
    % adequado ainda nao foi encontrado !
    if (control == 1)
      i = i - 1;  
    end
  end    
  
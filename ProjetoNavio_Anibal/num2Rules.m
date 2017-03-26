% Funcao responsavel por realizar o mapeamento entre
% numeros e regras de entrada e saida. Ou seja:
%
%  Numero   Regra de Entrada   Regra de Saida  
%    1             1                 1 
%    2             1                 2
%    3             1                 3  
%    4             2                 1
%    5             2                 2 
%    6             2                 3
function [fre,frs] = num2Rules(valor)

  %------------------------------------------%
  % TRANSFORMANDO NUMERO EM NOMES DE ARQUIVOS%
  % QUE CONTEM AS REGRAS DE ENTRADAS E SAIDA.%
  %------------------------------------------%
  if (1 == valor)
    fre = 'fre1';
    frs = 'frs1';
  end
  
  if (2 == valor)
    fre = 'fre1';
    frs = 'frs2';      
  end
  
  if (3 == valor)   
    fre = 'fre2';
    frs = 'frs1';      
  end    
  
  if (4 == valor)
    fre = 'fre2';
    frs = 'frs2';
  end
  
  % Novas regras de entrada e suas combinacoes.
  % Observar que as regras R3 e R4 realizam o
  % preenchimento reverso das regras R1 e R2
  % que sao regras de entrada por linha e 
  % coluna, respectivamente. R1 e R2 realizam
  % preenchimento da esquerda para direita e
  % R3 e R4 realizam o preenchimento da direita
  % para esquerda.
  
  if (5 == valor)
    fre = 'fre3';
    frs = 'frs1';
  end
  
  if (6 == valor)
    fre = 'fre3';
    frs = 'frs2';
  end
  
  if (7 == valor)
    fre = 'fre4';
    frs = 'frs1';
  end
  
  if (8 == valor)
    fre = 'fre4';
    frs = 'frs2';
  end
  
  
  %------------------------------------------%

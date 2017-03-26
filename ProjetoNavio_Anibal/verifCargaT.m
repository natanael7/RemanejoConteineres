% Função que verifica a maior carga considerando
% todos os portos ate o porto k.
function [cargamax] = verifCargaT(portoi,portoj,D,np)
  cargamax = verifCarga(portoi,D,np);
  for i=portoi:portoj
    [carga] = verifCarga(i,D,np);
    cargamax = max(carga,cargamax);
  end  

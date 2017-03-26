% Esta funcao emprega algoritmos geneticos para 
% resolver o problema de alocacao de containeres
% em navios.
function [X,fit]=gavar(nr,nc,np,D,lbound,ubound,param);

     % Declaração de valores importantes 
     % e que serão utilizados ao longo do
     % programa.
     POPSIZE = param.popsize;       % Pop. Size.
     MAXGENS = param.maxgens;       % Max number of generations.
     PXOVER  = param.pxover;        % Probability of crossover.
     PMUTATION = param.pmutation;   % Probability of mutation.    
     generation = 0;                % Initial number of generations.
     NVARS = np -1;                 % Number of variables.
     kind = 1;
          
     % Chamadas as funções auxiliares.
     population = initialize(POPSIZE,NVARS,lbound,ubound);      
     population = evaluate(POPSIZE,population,D,nr,nc);
     population = keep_the_best(POPSIZE,NVARS,population);
     while (generation < MAXGENS)
       generation = generation + 1;
       ipopulation = select(POPSIZE,population);
       ipopulation = crossover(POPSIZE, PXOVER, NVARS, population);
       ipopulation = mutate(POPSIZE, NVARS, PMUTATION, ipopulation);
       population = cbelitist(POPSIZE,NVARS,ipopulation);       
       population = evaluate(POPSIZE,population,D,nr,nc);
       xrep(generation,:) = report(POPSIZE, population);
       fprintf(1,'Geracao: %4d -> Best Fitness: %8.4f  \n',generation,1/xrep(generation,1)-1);
     end
     
     % Copiando informações das soluções da última geração
     % para uma matriz X.
     for i=1:POPSIZE+1
         X(i,:) = population(i).gene;
     end  
     
     % Copiando a informação de fitness dos individuos para
     % um vetor de fitness.
     for i=1:POPSIZE+1
       fit(i) = (1.0/(population(i).fitness)-1.0);
     end  
     
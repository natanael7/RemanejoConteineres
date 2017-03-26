% Esta funcao emprega algoritmos geneticos para 
% resolver o problema de alocacao de containeres
% em navios.
function [X,fit]=ga(nr,nc,np,D,lbound,ubound);

     % Declaração de valores importantes 
     % e que serão utilizados ao longo do
     % programa.
     POPSIZE = 10;       % Pop. Size.
     MAXGENS = 1000;     % Max number of generations.
     ITERSHOW = 10;     % Max number of iterations without graphics.
     PXOVER = 0.8;       % Probability of crossover.
     PMUTATION = 0.15;   % Probability of mutation.    %0.15.
     TCONSTRAINT = 1.0;  % Constraint violation penalization factor.
     generation = 0;     % Initial number of generations.
     NVARS = np -1;       % Number of variables.
     map = [1 0 0; 0 1 0; 0 0 1; 0.5 0 0.5];
     kind = 1;
          
     % Chamadas as funções auxiliares.
     population = initialize(POPSIZE,NVARS,lbound,ubound);      
     population = evaluate(POPSIZE,population,D,nr,nc);
     population = keep_the_best(POPSIZE,NVARS,population);
     while (generation < MAXGENS)
       generation = generation + 1;
       ipopulation = select(POPSIZE,population);
       %------------------------------------------------%
%        if (rem(generation-1,ITERSHOW) == 0)
%        A = reshape([population.gene],NVARS,POPSIZE+1)';       
%        figure(1);
%        colormap(map);
%        subplot(2,MAXGENS/ITERSHOW,kind);
%        kind = kind + 1;
%        image(A);
%        A = reshape([ipopulation.gene],NVARS,POPSIZE)';
%        subplot(2,MAXGENS/ITERSHOW,kind);
%        colormap(map);
%        image(A);
%        kind = kind + 1;
%        end
       %------------------------------------------------%
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
     
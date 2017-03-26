% This function evaluate each individual.
function [fitness] = evaluateaux(population(mem),D,np)

     for ii=1:NVARS
       % Atribution for vector of gene elements.
       x(ii) = pop.gene(ii);
     end
  
  
     % Fitness Calculation for each individual.           
     % population[mem].fitness = 0.0;     
     somaf = 0.0;
     
     % Initial values for used capacity vector.
     for ii=1:ubound
       capused(ii)=0.0;
     end  
      
     %   //////////////////////////////////////////////
     %   // Loop to evaluate the contribution of     //
     %   // each gene in the objective function      //
     %   // value.                                   //  
     %   //////////////////////////////////////////////
     for i=1:NVARS
        %  //---------------------------//
        %  // FIXED COSTS CALCULATION.
        %  //---------------------------//         
        somaf = somaf + c(i,x(i)); 
        %  //---------------------------//      
  
        %  //---------------------------//      
        %  // HANDOFF COSTS CALCULATION.
        %  //---------------------------//         
        for j=1:NVARS
          y = 1;  
          % // Verificando se existe custo de 
          % // randoff a ser computado !!
          if (x(i) ~= x(j))
            y = 0; 
          end  
            
          % Putting the handoff cost in objective function.
          somaf = somaf + (1.0-y)*h(i,j);          
        end  

        %  //---------------------------//
        
        %  //------------------------------------------//      
        %  // COSTS OF CAPACITY CONSTRAINTS VIOLATION. //
        %  //------------------------------------------//
        %  // Important Observation: x[j+1]-1 is used as 
        %  // an index of each cell is allocated in each 
        %  // switch and which capacity constraint M value
        %  // will be used.

        %  // Contabilization of used capacity for each switch
        %  // by knowing with cell is allocated for each switch.
        capused(x(i)) = capused(x(i)) + lambda(i);
        
     end           
     
     %   //////////////////////////////////////////////  
   %   // The penalization about how much the constraint 
   %   // of capacity is violated for each cromossome.
      somau = 0;
      for j=1:ubound
        aux = (capused(j)-M(j))/(M(j));
        % // Constraint violation contabilization.  
        if ( aux > 0)
          somau = somau + 1;
        end  
      end  
      
      %// Obtendo o nivel de infactibilidade de uma solução 
      %// proposta por um indivíduo !!
      unfitness = somau;      
   
              
      % Contabilizando o fitness de forma que poderemos aplicar
      % o mecanismo de selecao por rolette wheall.
      % Usando mecanismo linear para transformar MAX->MIN.
      % fitness = (1.0/(1.0+somaf)); 
      fitness = somaf;
      % Usando mecanismo sigmoide para transformar MAX->MIN. 
      %population(mem).fitness = 1.0/(1.0+exp(-somaf));   
      %MN = mean([population.fitness]);
      %STD = std([population.fitness]);
      %population(mem).fitness = (1/pi)*atan((somaf-MN)/(1+STD))+1/2;

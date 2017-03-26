void orderPop(int np, int tp, int pop[][np]){
     int i, j, cont, aux;
     for(cont=1; cont<tp; cont++){
          for(i=0; i<tp-1; i++){
                   
               if(pop[i][np-1] > pop[i+1][np-1]){
                    for(j=0; j<np; j++){
                         aux = pop[i][j];
                         pop[i][j] = pop[i+1][j];
                         pop[i+1][j] = aux;
                    }
               }
               
          }
     }
}

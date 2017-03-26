void crossPais(int np, int pai_1[], int pai_2[], int filho_1[], int filho_2[]){
     int i, j, corte;
     
     corte = (rand()%(np-2))+1;
     //printf("\n\ncorte = %i", corte);
     
     j=0;
     while(j<np){
          if(j<corte){
               filho_1[j] = pai_1[j];
          }else{
               filho_1[j] = pai_2[j];
          }
          j++;
     }
     
     j=0;
     while(j<np){
          if(j<corte){
               filho_2[j] = pai_2[j];
          }else{
               filho_2[j] = pai_1[j];
          }
          j++;
     }

}

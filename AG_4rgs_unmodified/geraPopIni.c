void geraPopIni(int np, int tp, int pop[][np]){
     int i, j;
     for(i=0; i<tp; i++){
          for(j=0; j<np-1; j++){
               pop[i][j] = (rand()%4)+1;
          }
     }
}

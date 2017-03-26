void fre1(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np){
     int i, j, k, numcaixas;
     numcaixas = 0;
          
     //determina a demanda de contairers
     for(i=0; i<tamD; i++){
          numcaixas = numcaixas + D[loop_np][i];
     }
     
     //printf("\nnumcaixas = %i", numcaixas);
     
     //inicializa o vetor de demanda
     int vet[numcaixas];
     for(i=0; i<numcaixas; i++){
          vet[i] = 0;
     }
     
     k = 0;
     for(i=0; i<tamD; i++){
          j = D[loop_np][i];
          while(j > 0){
               j = j - 1;
               vet[k] = i+2;
               k = k + 1;
          }
     }
     //------------
     
     //preenche a matriz ocupacao
     k = 0;
     i = 0;
     while((i < row)&&(k < numcaixas)){
          j=0;
          while((j < col)&&(k < numcaixas)){
               if(M[i][j] == 0){
                    M[i][j] = vet[numcaixas-k-1];
                    k = k+1;
               }
               j = j+1;
          }
          i = i+1;
     }
     
     //printf("\nVETOR");
     //printVet(numcaixas, vet);
     //printf("\n------ entrada 1 -------");
     
}

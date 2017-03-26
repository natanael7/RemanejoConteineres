void fre2(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np){
     int N[row][col], i, j, k, numcaixas, numtotalcaixas, dif_zero, altura;
     
     // copia matriz M para N
     for(i=0; i<row; i++){
          for(j=0; j<col; j++){
               N[i][j] = M[i][j];
          }
     }
     
     
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
     
     
     //numero de caixas ao total
     dif_zero=0;
         for(i=0; i<row; i++){
              for(j=0; j<col; j++){
                  if(M[i][j] != 0){
                       dif_zero++;
                  }
              }
         }
     numtotalcaixas = numcaixas + dif_zero;
     altura = ceil((float)numtotalcaixas/col);
     
     k = 0;
     j = 0;
     i = 0;
     
     while((k < numcaixas)&&(j <= col)){
          i = 0;
          while((((i+1)%(altura+1)) != 0)&&(k < numcaixas)&&(i <= row)){
               if(M[i][j] == 0){
                    M[i][j] = vet[numcaixas-k-1];
                    k++;
               }
               i++; 
          }
          j++;
     }
     
     //printf("\nVETOR");
     //printVet(numcaixas, vet);
     //printf("\n------ entrada 2 -------");
     














}

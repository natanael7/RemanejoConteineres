void fre4(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int vet_sd[]){
     int N[row][col], i, j, k, l, numcaixas, numtotalcaixas, dif_zero, altura, numcx_s2;
     
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
     numcx_s2 = numcaixas;
     for(i=0; i<row*col; i++){
          if(vet_sd[i] != 0){
               numcaixas++;
          }
     }
     numcx_s2 = numcaixas - numcx_s2;
     
     //printf("\nnumcaixas = %i", numcaixas);
     
     //inicializa o vetor de demanda
     int vet[numcaixas];
     for(i=0; i<numcaixas; i++){
          vet[i] = 0;
     }
     
     
     k = 0;
     
     for(i=0; i<tamD; i++){
     	l=numcx_s2-1;
	 	  while(l>=0){
	 	  	   if(vet_sd[l]==i+2){
		   	   		vet[k] = vet_sd[l];
			   		k++;
			   }
			   l--;
		  }
          j = D[loop_np][i];
          while(j > 0){
               j--;
               vet[k] = i+2;
               k++;
          }
     }
     /*for(i=0; i<numcx_s2; i++){
          vet[k] = vet_sd[i];
          k++;
     }*/
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
     j = col-1;
     i = 0;
     
     while((k < numcaixas)&&(j >=0)){
          i = 0;
          while((((i+1)%(altura+1)) != 0)&&(k < numcaixas)&&(i < row)){
               if(M[i][j] == 0){
                    M[i][j] = vet[numcaixas-k-1];
                    k++;
               }
               i++; 
          }
          j--;
     }
     
     //printf("\nVETOR");
     //printVet(numcaixas, vet);
     //printf("\n------ entrada 2 -------");
     














}

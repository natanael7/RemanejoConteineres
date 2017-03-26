void fre3(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int vet_sd[]){
     int i, j, k, l, numcaixas, numcx_s2;
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
	 
     //------------
     
     //preenche a matriz ocupacao
     k = 0;
     i = 0;
     while((i < row)&&(k < numcaixas)){
          j=col-1;
          while((j >=0)&&(k < numcaixas)){
               if(M[i][j] == 0){
                    M[i][j] = vet[numcaixas-k-1];
                    k = k+1;
               }
               j--;
          }
          i = i+1;
     }
     
     //printf("\nVETOR");
     //printVet(numcaixas, vet);
     //printf("\n------ entrada 1 -------");
     
}

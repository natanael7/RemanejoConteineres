int frs2(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int nmov, int vet_sd[]){
    int i, j, k, t, h, indi, aux, numK;
    
    /*printf("\nloop_np = %i", loop_np+1);
    printMat(col, row, M);*/
	k=0;
    nmov = 0;
    for(j=0; j<col; j++){
	     for(i=0; i<row; i++){
	      	   if(M[i][j] == loop_np+1){
	      	   		M[i][j] = 0;
	      	   		nmov++;
	      	   	    for(h=0; h<row; h++){
	      	   	    	if(M[h][j] != 0){
	      	   	    		if(M[h][j] != loop_np+1){
		      	   	    		vet_sd[k] = M[h][j];
								k++;
								nmov += 2;		      	   	    		
		      	   	    	}
		      	   	    	nmov++;
		      	   	    	M[h][j] = 0;
	      	   	    	}
	      	   	    }
	      	   	    i=row;
	      	   	    
	      	   }
	     }
    }
    /*printf("\n");
	printMat(col, row, M);
	printf("\n");
	printVet(k, vet_sd);
	printf("\nnmov = %i\n", nmov);
	system("PAUSE");*/



/*	k=0;
    nmov = 0;
    for(i=0; i<row; i++){
	     for(j=0; j<col; j++){
	          if(M[i][j] != 0){
	          	   if(M[i][j] != loop_np+1){
	          	   	    vet_sd[k] = M[i][j];
	          	   	    k++;
	          	   }
	               M[i][j] = 0;
	               nmov++;
	      	  }
	     }
    }*/
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //-------------------------------------------------------------------------
    /*
    nmov = 0;
    
    for(t=0; t<col; t++){
         indi = 0;
         for(i=0; i<row-1; i++){
              h=i+1;
              for(j=0; j<row-h; j++){
                   if((M[j][t] < M[j+1][t])&&(M[j][t] !=0)){
                        aux = M[j][t];
                        M[j][t] = M[j+1][t];
                        M[j+1][t] = aux;
                        indi = maxNum(indi, row-j);
                   }
              }
         }
         
         numK=0;
         for(i=0; i<row; i++){
              if(M[i][t] == loop_np+1){
                   numK++;
              }
         }
         
         if((numK != 0)&&(indi != 0)){
              nmov += 2*indi - numK;
         }else{
              if(numK != 0){
                   nmov += numK;
              }else{
                   if(indi != 0){
                        nmov += 2*indi;
                   }
              }
         }
    
    }
    
    for(i=0; i<row; i++){
         for(j=0; j<col; j++){
              if(M[i][j] == loop_np+1){
                   M[i][j] = 0;
              }
         }
    }
    */
    
    
    
    //printf("\npassou regra saida 2-------------------------");
    return nmov;
}

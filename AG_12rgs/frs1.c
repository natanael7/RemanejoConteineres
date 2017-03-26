int frs1(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int nmov, int vet_sd[]){
     int i, j, t, k, t1, t2;
     
     
     nmov = 0;
     k=0;
     /////////PROBLEMA NO VETORRRRR -----------SOLUCIONED!!!
     //printf("\nbefore");
     //printMat(row, col, M);
     //system("pause");
     for(j=0; j<col; j++){
     	  i = 0;
          while((i < row)&&(M[i][j] != loop_np+1)){
               i++;
          }
          if (i < row){
          	   t = i+1;
          	   while((M[t][j] != 0)&&(t < row)){
      	   	   	   if(M[t][j] != loop_np+1){
	          	   	   vet_sd[k] = M[t][j];
	          	   	   //printf("\nk = %d", k);
	          	   	   k++;
	          	   	   nmov =nmov+2;	          	   	   
	          	   	   //printf("\nt = %d  j = %d", t, j);
				   }else{
					   nmov++; 
				   }
				   M[t][j] = 0;
	         	   t++;
	           }
          	   M[i][j] = 0;
          	   nmov++; 	           	   
          }
 	     
     }
    
     
     
     
     
     
     
     
     
     
     
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 /*
	 
	 for(j=0; j<col; j++){
          i = 0;
          while((i < row)&&(M[i][j] != loop_np+1)){
               i++;
          }   
    
          
          if (i < row){
               nmov++;
               t1 = i;
               t2 = i+1;
               while((t2 < row)&&(M[t2][j] != 0)){
                    if(M[t2][j] != loop_np+1){
                         nmov += 2;
                         M[t1][j] = M[t2][j];
                         t1++;
                    }else{
                         nmov++;
                    }
                    t2++;
               }
               for(t=t1; t<row; t++){
                    M[t][j] = 0;
               }
          }
          
     }
     */
     //printf("\nafter");
     //printMat(row, col, M);
     //printf("\nvector");
     //printVet(15, vet_sd);
     //printf("\nnmov = %d", nmov);
     //system("pause");
     //printf("\nnumero de movimentos : %i   ------", nmov);
     return nmov;
}

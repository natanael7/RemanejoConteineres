int frs1(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int nmov){
     int i, j, t, t1, t2;
     
     nmov = 0;
     
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
     //printf("\nnumero de movimentos : %i   ------", nmov);
     return nmov;
}

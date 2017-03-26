void printMat(int col, int row, int mat[][col]){
     int i, j;
     for(i=0; i<row; i++){
          printf("\n");
          for(j=0; j<col; j++){
               printf("%i ", mat[i][j]);
          }
     }
}

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <windows.h>
#include <string.h>
#include <locale.h>
void getD(int np, int D[][np-1], char* fullfile){
     int i, nl, j;
     FILE *doc;
     
     //abre arquivo
     doc = fopen(fullfile, "r");
     //verifica erro na abertura do arquivo
     if(doc == NULL){
            printf("Erro ao abrir o arquivo de dados!");
            //sleep(2500);
            exit(0);
     }
     
     //procura D
     i = 0;
     while(i < 20){
          nl = fgetc(doc);
          if(nl == 10){
               i++;
          }
     }
     for(i=0; i<np-1; i++){
          fscanf(doc, "%d", &nl);
          for(j=0; j<np-1; j++){
               fscanf(doc, "%d", &D[i][j]);
          }
     }
     //printf("\n");
     /*for(i=0; i<np-1; i++){
          for(j=0; j<np-1; j++){
               printf(" %.3d", D[i][j]);
          }
          printf("\n");
     }*/
     
     
     fclose(doc);
     
}

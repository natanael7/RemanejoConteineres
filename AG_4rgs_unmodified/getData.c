#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <windows.h>
#include <string.h>
#include <locale.h>
void getData(int *np, int *row, int *col, char* fullfile){
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
     
     
     //procura row = nr
     i = 0;
     while(i < 8){
          nl = fgetc(doc);
          if(nl == 10){
               i++;
          }
     }
     fscanf(doc, "%d", &(*row));
     //printf("row = %d", *row);
     
     
     //procura col = nc
     i = 0;
     while(i < 3){
          nl = fgetc(doc);
          if(nl == 10){
               i++;
          }
     }
     fscanf(doc, "%d", &(*col));
     //printf("\ncol = %d", *col);
     
     //procura np
     i = 0;
     while(i < 3){
          nl = fgetc(doc);
          if(nl == 10){
               i++;
          }
     }
     fscanf(doc, "%d", &(*np));
     //printf("\nnp = %d", *np);
     
     
     
     
     fclose(doc);
     
}

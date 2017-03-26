#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <windows.h>
#include <string.h>
#include <locale.h>
void saveResults(char* infile, char* outfile, int fitness[], int gerac, int finalSol[], int np, float ftime){
	int i, j;
	FILE *doc;
	
	//localização para o Português do Brasil
	setlocale(LC_ALL, "Portuguese_Brazil");
    
  	time_t data_hora_segundos; // guarda os segundos deste 01/01/1970
  	struct tm *timeinfo; // declara uma estrutura tm
  	time(&data_hora_segundos); // preenche a variável data_hora_segundos
  	// preenche a estrutura timeinfo
  	timeinfo = localtime(&data_hora_segundos);
  	// um buffer para receber a data formatada
  	char data[80];
  	char hora[80];

  	// formata data-hora
  	strftime(data, 80, "%d de %B de %Y", timeinfo);
  	strftime(hora, 80, "%X", timeinfo);
  	
  	//------------------------/-------------
         
         
        
         
	//cria pasta e set directory
	CreateDirectoryA("results", NULL);
	SetCurrentDirectoryA("results");
	
	bestFitnessEver(infile, finalSol, np, data, hora); //grava as melhores solucoes das intancias
	
	//cria pasta e set directory
	CreateDirectoryA(infile, NULL);
	SetCurrentDirectoryA(infile);
	
	
	doc = fopen(outfile, "r");
	
	//cria arquivo
	i = 0;
	do{
		 i++;
		 //system("PAUSE");
		 if(doc != NULL)
		 fclose(doc);
		 
		 strcpy(outfile, "test_");
		  
		 itoa(i, outfile+5, 10);
		 strcat(outfile, ".dat");
	     doc = fopen(outfile, "r");
	}while(doc != NULL);
	 
	//fclose(doc);	
	strcpy(outfile, "test_");
	itoa(i, outfile+5, 10);
	strcat(outfile, ".dat");
	doc = fopen(outfile, "w");
	//------
	
	
	//Anexando dados ao arquivo
	fprintf(doc, "ARQUIVO DE RESULTADOS - %d\n", i);
	
	fprintf(doc, "---------------------\n");
	fprintf(doc, "Data: %s\n", data);
	fprintf(doc, "Hora: %s\n", hora);
	fprintf(doc, "---------------------\n");
	
	fprintf(doc, "Arquivo de entrada: \"%s\"\n", infile);
	fprintf(doc, "\nBest Fitness das Geracoes: ---------------------------------------------------\n");
	for(i = 0; i < gerac; i++){
		fprintf(doc, "\nGeracao %.3d = %d", i+1, fitness[i]);
	}
	fprintf(doc, "\n------------------------------------------------------------------------------\n");
	
	fprintf(doc, "Melhor solucao obtida: [");
	for(i=0; i<np-1; i++){
		fprintf(doc, " %d", finalSol[i]);
	}
	fprintf(doc, " ] = fitness %d\n\n", finalSol[np-1]);
	fprintf(doc, "\n--> Tempo de Processamento: %.3f sec\n", ftime);
	//---------
	
	
	
	fclose(doc);//fecha arquivo
	
	
	//fo's para media
	doc = fopen("all_fo.dat", "a+");
	fprintf(doc, "\n%i", fitness[gerac-1]);
	fclose(doc);//fecha arquivo
	
}

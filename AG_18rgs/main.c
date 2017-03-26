//includes
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <windows.h>
#include <string.h>
#include <locale.h>

//definitions
#define rand_float (float)rand()/(float)RAND_MAX

//functions
void getData(int *np, int *row, int *col, char* fullfile);
void getD(int np, int D[][np-1], char* fullfile);
void saveResults(char* infile, char* outfile, int fitness[], int gerac, int finalSol[], int np, float ftime);
void bestFitnessEver(char* infile, int finalSol[], int np, char* data, char* hora);
void geraPopIni(int np, int tp, int pop[][np]);
void avaliaPop(int np, int tp, int pop[][np], int row, int col, int D[][np-1], int loop_gerac);
void selectPais(int np, int tp, int pop[][np], int pai_1[], int pai_2[]);
void crossPais(int np, int pai_1[], int pai_2[], int filho_1[], int filho_2[]);
void mutateFilhos(int np, int indiv[], float gen);
void fre1(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int vet_sd[]);
void fre2(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int vet_sd[]);
void fre3(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int vet_sd[]);
void fre4(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int vet_sd[]);
void fre5(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int vet_sd[]);
void fre6(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int vet_sd[]);
int frs1(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int nmov, int vet_sd[]);
int frs2(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int nmov, int vet_sd[]);
int frs3(int np, int tamD, int col, int row, int pop[][np], int D[][tamD], int M[][col], int loop_np, int nmov, int vet_sd[]);
void orderPop(int np, int tp, int pop[][np]);
void printMat(int col, int row, int mat[][col]);
void printVet(int tam, int vet[]);
int maxNum(int num, int val);


//MAIN PROGRAM
int main(){
    //declara variaveis
    int np, tp, gerac, row, col, x, meta;
    float mut, cross, gen;
    np = 0;//numero de portos - (arquivo)
    tp = 50;//tamanho da populacao
    gen = 10;//por cento de genes a mutar
    mut = 15;//por cento de mutacao
    cross = 80;//por cento de cruzamento
    gerac = 1000;//numero de geracoes
    row = 0;//numero de linhas da matriz de ocupacao - (arquivo)
    col = 0;//numero de colunas da matriz de ocupacao - (arquivo)
    meta = 50;// bigger loop
    int fitness[gerac], a;


    //tratamento do arquivo de dados
    
    scanf("%i", &a);
    //char filename[30] = "stowage04004051.sto";
    char filename[30] = "stowage06050";
    //stowage06050101.sto
    //stowage04004051.sto
	itoa(a, filename+12, 10);
	strcat(filename, ".sto");
	printf(filename);
	
    char infile[30];
    char fullfile[] = "instances/";
    char outfile[] = "test_";
	strcat (fullfile, filename);
    
    //pega dados np, row, col
    getData(&np, &row, &col, fullfile);
    
    //pega D = transporte
    int D[np-1][np-1];
    getD(np, D, fullfile);
    
    //declara variaveis
    int pop[tp][np], newPop[tp][np], pai_1[np], pai_2[np], filho_1[np], filho_2[np], indiv[np], finalSol[np];
    int i, j, copy, loop_pop, loop_gerac, pos;
    pos=0;
    float rand_num, ftime;
	clock_t tempo;
    srand(time(NULL));
    
    
	for(x=0; x<meta; x++){//laco para META
	    
	    tempo = clock();
	    //gera populacao inicial
	    geraPopIni(np, tp, pop);
	    orderPop(np, tp, pop);
	    //printf("POPULACAO GERADA");
	    //printMat(np, tp, pop);
	    
	    
	    //laco de geracoes
	    for(loop_gerac=1; loop_gerac<=gerac; loop_gerac++){
	    
	    //avalia e ordena e imprime a população                  
	    avaliaPop(np, tp, pop, row, col, D, loop_gerac);
	    orderPop(np, tp, pop);
	    //printf("\n\n------POPULACAO GERACAO %i------", loop_gerac);
	    //printMat(np, tp, pop);
	    if(meta <= 1)
	    printf("\nGeracao %.3d - Best fitness: %d", loop_gerac, pop[0][np-1]);
	    fitness[loop_gerac-1] = pop[0][np-1];
	    //printf("\nSolucao: ");
	    //printMat(np-1, 1, pop);
	    //zera newPop
	    for(i=0; i<tp; i++){
	          for(j=0; j<np; j++){
	               newPop[i][j] = 0;
	          }         
	    }
	    
	    //copia o(s) primeiro(s) individuo(s)    
	    if((tp%2)==0){
	         for(i=0; i<2; i++){
	              for(j=0; j<np; j++){
	                   newPop[i][j] = pop[i][j];
	              }
	         }
	         copy=2;
	         pos=2;
	    }else{
	         for(j=0; j<np; j++){
	              newPop[0][j] = pop[0][j];
	         }
	         copy=1;
	         pos=1;
	    }
	    
	    //laco de newPop--------
	    for(loop_pop=0; loop_pop<(tp-pos)/2; loop_pop++){
	        
	        //seleciona os 2 pais
	        selectPais(np, tp, pop, pai_1, pai_2);
	        //printf("\n");
	        //printf("\nPAI 1");
	        //printVet(np-1, pai_1);
	        //printf("\nPAI 2");
	        //printVet(np-1, pai_2);
	        
	        //gera % crossover
	        rand_num = rand_float;
	        
	        //crossover dos pais
	        if(rand_num < cross/100){
	             crossPais(np, pai_1, pai_2, filho_1, filho_2);
	             //printf("\n");
	             //printf("\nFILHO 1");
	             //printVet(np-1, filho_1);
	             //printf("\nFILHO 2");
	             //printVet(np-1, filho_2);
	        }else{
	             for(j=0; j<np-1; j++){
	                  filho_1[j] = pai_1[j];
	                  filho_2[j] = pai_2[j];
	             }
	        }
	        
	        
	        //mutation dos filhos
	        for(i=1; i<3; i++){
	             rand_num = rand_float;
	             if(rand_num < mut/100){
	                  if(i==1){
	                       for(j=0; j<np-1; j++){
	                            indiv[j] = filho_1[j];
	                       }
	                       mutateFilhos(np, indiv, gen);
	                       //printf("\n");
	                       //printf("\nFILHO 1 MUTADO");
	                       //printVet(np-1, indiv);
	                       for(j=0; j<np-1; j++){
	                            filho_1[j] = indiv[j];
	                       }
	                  }else{
	                       for(j=0; j<np-1; j++){
	                            indiv[j] = filho_2[j];
	                       }
	                       mutateFilhos(np, indiv, gen);
	                       //printf("\n");
	                       //printf("\nFILHO 2 MUTADO");
	                       //printVet(np-1, indiv);
	                       for(j=0; j<np-1; j++){
	                            filho_2[j] = indiv[j];
	                       }
	                  }
	             }
	        }
	        
	        //inclui filhos na nova população
	        for(j=0; j<np-1; j++){
	             newPop[copy][j] = filho_1[j];
	             newPop[copy+1][j] = filho_2[j];
	        }
	        copy += 2;
	        
	        //printf("\n\n");
	        
	        //printf("POPULACAO NOVA");
	        //printMat(np, tp, newPop);
	        
	    }//laco de newPop----------
	    
	    //passa a newPop para POP
	    for(i=0; i<tp; i++){
	          for(j=0; j<np; j++){
	               pop[i][j] = newPop[i][j];
	          }         
	    }
	    
	    }//laco de gerecoes
	    
	    
	    //imprime população FINAL
	    avaliaPop(np, tp, pop, row, col, D, loop_gerac);
	    orderPop(np, tp, pop);
	    //printf("\n\n>>>>>>--POPULACAO FINAL--<<<<<<");
	    //printMat(np, tp, pop);
	    tempo = clock() - tempo;
	    ftime = (((float)tempo)/CLOCKS_PER_SEC);
	    
	    
	    //grava resultados em um arquivo
	    for(i=0; i<np; i++){
	    	finalSol[i] = pop[0][i];
	    }
		strcpy(infile, filename);
		saveResults(infile, outfile, fitness, gerac, finalSol, np, ftime);
		SetCurrentDirectoryA("../../");
	    
	    
	    printf("\n\n");
	    printf("-----------------------------------");
	    printf("\nALGORITIMO GENETICO - meta %i", x+1);
	    printf("\nArquivo de Entrada: %s", filename);
	    printf("\nArquivo de Saida: %s",outfile);
		printf("\nTempo de Processamento: %.3f sec", ftime);
		printf("\nMelhor Fitness: %i",fitness[gerac-1]);
	    printf("\n-----------------------------------");
	    
	    
	}
    
    //finaliza programa
    printf("\n\n");
    system("PAUSE");
        
}

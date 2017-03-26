#include <stdio.h>
void bestFitnessEver(char* infile, int finalSol[], int np, char* data, char* hora){
	int i, j, nl, k;
	FILE *doc;
	long pos, num;
	char string[50];
	
	
	//abre ou cria arquivo
	doc = fopen("Best_Fitness.dat", "r");
	if(doc == NULL){
		    doc = fopen("Best_Fitness.dat", "w+");
		    
		    //anexa dados
            fprintf(doc, "Ultima alteracao em:\n");
            fprintf(doc, "Data: %s\n", data);
            fprintf(doc, "Hora: %s\n", hora);
            fprintf(doc, "De: \"%s\"\n", infile);
            //num = ftell(doc);
			//fprintf(doc, "Nº 888\n");
            fprintf(doc, "----------------------------------\n");
            fprintf(doc, "--------------------------------\n");
            
            
            fprintf(doc, "\n\nMELHOR(ES) FITNESS ENCONTRADO(S)\n");
            fprintf(doc, "--------------------------------\n");
            
            fprintf(doc, "\n|%s --- %4d|\n", infile, finalSol[np-1]);
            //pos = ftell(doc);
            
            
            
            //fseek (doc, num, SEEK_SET );
            //fprintf(doc, "Nº = %ld\n", pos);
            
            
    }else{
    		fclose(doc);
    		doc = fopen("Best_Fitness.dat", "r+");
			i = 0;
    		while(i < 10){
    		      nl = fgetc(doc);
    		      if(nl == 10){
    		           i++;
    		      }
    		}
    		k = 0;
    		while(k == 0){
				
				/*do{
					nl = fgetc(doc);
				}while(nl != 124);*/
	    		nl = fgetc(doc);
	    		nl = fgetc(doc);
	    		pos = ftell(doc);
	    		
	    		
	    		
	    		//printf("nl = %d", nl);
	    		fgets(string, 20, doc);
				//system("PAUSE");
	    		//printf("\n%c", string[18]);
	    		//printf("\n%c = %c", string[12], infile[12]);
				//printf("\n%c = %c", string[13], infile[13]);
				//printf("\n%c = %c", string[14], infile[14]);
	    		//system("PAUSE");
				//fscanf(doc, "%d", &nl);
				//printf("\n number = %d", nl);
				if((string[12] == infile[12]) && (string[13] == infile[13]) && (string[14] == infile[14])){
					nl = fgetc(doc);
					nl = fgetc(doc);
					nl = fgetc(doc);
					nl = fgetc(doc);
					nl = fgetc(doc);
					
					//printf("\n\nYES\n\n");
					//printf("\n%c = %c", string[12], infile[12]);
					//printf("\n%c = %c", string[13], infile[13]);
					//printf("\n%c = %c", string[14], infile[14]);
					
					
					
					fscanf(doc, "%d", &nl);
					//printf("\n\n%i\n\n", nl);
					//system("PAUSE");
					if(nl > finalSol[np-1]){
						fseek(doc, pos, SEEK_SET);
						
						fprintf(doc, "%s --- %4d|", infile, finalSol[np-1]);
						
					}
					k = 1;
					
				}else{
					for(i=0; i < 11; i++){
						nl = fgetc(doc);
					}
					//printf("\n\n%i\n\n", nl);
					
					//system("PAUSE");
					if((feof(doc))!=0){
						//printf("\n\nFIM\n\n");
						fclose(doc);
						doc = fopen("Best_Fitness.dat", "a");
						fprintf(doc, "\n|%s --- %4d|\n", infile, finalSol[np-1]);
						k = 1;
						break;
					}
					
					
				}
    		}
    }

	
	
	
	fclose(doc);//fecha arquivo
	
}

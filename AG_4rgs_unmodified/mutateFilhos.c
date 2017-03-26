void mutateFilhos(int np, int indiv[]){
    int i, j, ponto, num;
     
     ponto = (rand()%(np-1));
     //printf("\n\nponto = %i", ponto+1);
     do{
          num = (rand()%4)+1;
     }
     while(num==indiv[ponto]);
     
     //printf("\nnum = %i", num);
     
     indiv[ponto] = num;
     
}



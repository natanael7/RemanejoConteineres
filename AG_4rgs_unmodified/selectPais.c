void selectPais(int np, int tp, int pop[][np], int pai_1[], int pai_2[]){
     int i, j, num_1, num_2;
     
     num_1 = (rand()%(int)(0.2*tp+1));
     for(i=0; i<np; i++){
          pai_1[i] = pop[num_1][i];
     }
     
     do{
          num_2 = rand()%tp;
     }while(num_2==num_1);
     for(i=0; i<np; i++){
          pai_2[i] = pop[num_2][i];
     }
}

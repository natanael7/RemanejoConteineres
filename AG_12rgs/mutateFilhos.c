void mutateFilhos(int np, int indiv[], float gen){
     int i, j, ponto, num, comp;
     float ngen, loop;
     
     
     ngen = round((gen/100)*np);
     //printf("\nngen = %f", ngen);
     //system("PAUSE");
     int ponto2[(int)ngen];
     for(i=0; i<ngen; i++) ponto2[i] = 0;
     loop = ngen;
     
     ponto = (rand()%(np));
     //printf("\n\nponto = %i", ponto+1);
     //system("PAUSE");
     do{
          num = (rand()%4)+1;
     }
     while(num==indiv[ponto]);
     
     //printf("\nnum = %i", num);
     
     indiv[ponto] = num;
     
     
	 
	 while(ngen > 1){
	 	 
     	 ponto2[(int)ngen] = ponto;
     	 //system("PAUSE");
     	 do{
     	 	comp = 0;
     	 	ponto = (rand()%(np));
     	 	for(i=loop; i>=ngen; i--){
     	 		if(ponto2[i] == ponto) comp = 1;
     	 	}
     	 }while(comp);
	     
	     //printf("\n\nponto = %i", ponto+1);
	     //system("PAUSE");
	     do{
	          num = (rand()%4)+1;
	     }
	     while(num==indiv[ponto]);
	     
	     //printf("\nnum = %i", num);
	     
	     indiv[ponto] = num;
	     ngen--;
     
	 }
}



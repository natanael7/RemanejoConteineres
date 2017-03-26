void avaliaPop(int np, int tp, int pop[][np], int row, int col, int D[][np-1], int loop_gerac){
     
/*------------------------------------------------------------------------------
     int i, j;
     
     if(non==0){
          for(i=0; i<tp; i++){
               pop[i][np-1] = (rand()%900)+100;
          }
     }else{
          for(i=0; i<tp; i++){
               if(((non==1)&&(i==0)) || ((non==2)&&((i==0)||(i==1)))){
               }else{
                   pop[i][np-1] = (rand()%900)+100;
               }
          }
     }
------------------------------------------------------------------------------*/

     int i, j, k, loop_np, loop_tp, soma, lastP, vet_sd[row*col];
     int tamD, total, value, nmov;
     tamD = np-1;//tamanho da matriz de transporte
     lastP = 0;
     total = 0;
     soma = 0;
     value = 0;
     nmov = 0;
     int M[row][col];
     
     //determina a matriz de transporte
     /*srand(300);
     k = 0;
     for(i=0; i<tamD; i++){
          for(j=tamD; j>=0; j--){
               if(j >= k){
                    D[i][j] = rand()%6;
               }else{
                    D[i][j] = 0;
               }
          }
          k++;
     }
     if(loop_gerac == 1){
     printf("\n\nMATRIZ DE TRANSPORTE");
     printMat(np-1, np-1, D);
     }
     //getch();  
     printf("\n");
     
     srand(time(NULL));*/
     
     /*D[0][0] = 2;
     D[0][1] = 5;
     D[0][2] = 0;
     D[0][3] = 0;
     D[1][0] = 0;
     D[1][1] = 2;
     D[1][2] = 3;
     D[1][3] = 1;
     D[2][0] = 0;
     D[2][1] = 0;
     D[2][2] = 2;
     D[2][3] = 2;
     D[3][0] = 0;
     D[3][1] = 0;
     D[3][2] = 0;
     D[3][3] = 1;*/
     
     
     
     //laco
     for(loop_tp = 0; loop_tp<tp; loop_tp++){
                 
          total = 0;
          //zera a matriz de ocupacao
          for(i=0; i<row; i++){
               for(j=0; j<col; j++){
                    M[i][j] = 0;
               }         
          }
          /*printf("\n\nMATRIZ DE OCUPACAO");
          printMat(row, col-40, M);*/
          
          for(loop_np = 0; loop_np<np-1; loop_np++){
               soma = 0;
               value = 0;
               nmov = 0;
               //zera vet_sd
               for(i=0; i<row*col; i++){
            	    vet_sd[i] = 0;
               }
               //---
               //system("PAUSE");
               switch(pop[loop_tp][loop_np]){
                                             
                    case 1://Combinação de regra ONE------------------------------------------------------------------------//
                         if(loop_np>0){
                         //funcao de saida 1
                              nmov = frs1(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 1
                         fre1(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
                         break;
                    
                    //------------------------------------------------------------------------------------------------------      
                    case 2://Combinação de regra TWO------------------------------------------------------------------------//
                         if(loop_np>0){
                         //funcao de saida 2
                              nmov = frs2(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 1
                         fre1(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
                         break;
                    
                    //------------------------------------------------------------------------------------------------------    
                    case 3://Combinação de regra THREE----------------------------------------------------------------------//
                         if(loop_np>0){
                         //funcao de saida 1
                              nmov = frs1(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 2
                         fre2(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
                         break;
                    
                    //------------------------------------------------------------------------------------------------------ 
                    case 4://Combinação de regra FOUR-----------------------------------------------------------------------//
                         if(loop_np>0){
                         //funcao de saida 2
                              nmov = frs2(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 2
                         fre2(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
                         break;
                         
                    //------------------------------------------------------------------------------------------------------ 
                    case 5://Combinação de regra FIVE-----------------------------------------------------------------------//
                    	 //funcao de saida 1
						 if(loop_np>0){
                              nmov = frs1(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 3
                         fre3(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
                    //------------------------------------------------------------------------------------------------------ 
                    case 6://Combinação de regra SIX-----------------------------------------------------------------------//
                    	 //funcao de saida 2
						 if(loop_np>0){
                              nmov = frs2(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 3
                         fre3(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
                    //------------------------------------------------------------------------------------------------------ 
                    case 7://Combinação de regra SEVEN-----------------------------------------------------------------------//
                    	 //funcao de saida 1
						 if(loop_np>0){
                              nmov = frs1(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 4
                         fre4(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
                    //------------------------------------------------------------------------------------------------------ 
                    case 8://Combinação de regra EIGHT-----------------------------------------------------------------------//
                    	 //funcao de saida 2
						 if(loop_np>0){
                              nmov = frs2(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 4
                         fre4(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
                    //------------------------------------------------------------------------------------------------------ 
                    case 9://Combinação de regra NINE-----------------------------------------------------------------------//
                    	 //funcao de saida 1
						 if(loop_np>0){
                              nmov = frs1(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 5
                         fre5(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
                    //------------------------------------------------------------------------------------------------------ 
                    case 10://Combinação de regra TEN-----------------------------------------------------------------------//
                    	 //funcao de saida 2
						 if(loop_np>0){
                              nmov = frs2(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 5
                         fre5(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
                    //------------------------------------------------------------------------------------------------------ 
                    case 11://Combinação de regra ELEVEN-----------------------------------------------------------------------//
                    	 //funcao de saida 1
						 if(loop_np>0){
                              nmov = frs1(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 6
                         fre6(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
                    //------------------------------------------------------------------------------------------------------ 
                    case 12://Combinação de regra TWELVE-----------------------------------------------------------------------//
                    	 //funcao de saida 3
						 if(loop_np>0){
                              nmov = frs2(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 6
                         fre6(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
					//------------------------------------------------------------------------------------------------------ 
					case 13://Combinação de regra THIRTEEN-----------------------------------------------------------------------//
                    	 //funcao de saida 3
						 if(loop_np>0){
                              nmov = frs3(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 1
                         fre1(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
					//------------------------------------------------------------------------------------------------------ 
					case 14://Combinação de regra FOURTEEN-----------------------------------------------------------------------//
                    	 //funcao de saida 3
						 if(loop_np>0){
                              nmov = frs3(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 2
                         fre2(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
					//------------------------------------------------------------------------------------------------------ 
					case 15://Combinação de regra FIFTEEN-----------------------------------------------------------------------//
                    	 //funcao de saida 3
						 if(loop_np>0){
                              nmov = frs3(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 3
                         fre3(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
					//------------------------------------------------------------------------------------------------------
					case 16://Combinação de regra SIXTEEN-----------------------------------------------------------------------//
                    	 //funcao de saida 3
						 if(loop_np>0){
                              nmov = frs3(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 4
                         fre4(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
					//------------------------------------------------------------------------------------------------------ 
					case 17://Combinação de regra SEVENTEEN-----------------------------------------------------------------------//
                    	 //funcao de saida 3
						 if(loop_np>0){
                              nmov = frs3(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 5
                         fre5(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
					//------------------------------------------------------------------------------------------------------ 
					case 18://Combinação de regra EIGHTEEN-----------------------------------------------------------------------//
                    	 //funcao de saida 3
						 if(loop_np>0){
                              nmov = frs3(np, tamD, col, row, pop, D, M, loop_np, nmov, vet_sd);
                              value = value + nmov;
                         }
                         //funcao de entrada 6
                         fre6(np, tamD, col, row, pop, D, M, loop_np, vet_sd);
                         for(i=0; i<tamD; i++){
                              soma = soma + D[loop_np][i];
                         }
                         value = value + soma;
						 break;
					//------------------------------------------------------------------------------------------------------  
					
               }
               total = total + value;
          }
          //contabiliza o ultimo porto
          for(i=0; i<tamD; i++){
               lastP = lastP + D[i][tamD-1];
          }
          total = total + lastP;
          pop[loop_tp][np-1] = total;
          //printf("\ntotal linha %i = %i\n", loop_tp, pop[loop_tp][np-1]);
          lastP = 0;
          
          
     }
     
     
     
}

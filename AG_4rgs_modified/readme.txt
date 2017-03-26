Para rodar, deve-se digitar o n�mero de portos seguido do tipo da matriz.
Exemplo: 
101 -> indica 10 portos e matriz do tipo 1
253 -> indica 25 portos e matriz do tipo 3

Para definir o n�mero de replica��es, deve-se alterar o par�metro "meta"
no arquivo main.c. O padr�o � definido "meta=60".

Os resultados podem ser visualizados na pasta "results".
L� encontram-se as pastas com os resultados de cada inst�ncia. Cada pasta
destas ir� conter os arquivos com o resultado de cada execu��o, apresentando:
- data da execu��o (cabe�alho)
- hist�rico da melhor FO
- melhor solu��o final e o respectivo valor de FO
- tempo de execu��o

Obs: cada nova execu��o � salva com um n�mero de identifica��o, sendo isso 
feito de forma incremental

Al�m dos resultados por inst�ncia, existe tamb�m o arquivo Best_Fitness.dat
que apresenta os melhores resultados encontrados dentre todas as execu��es
realizadas de cada uma das inst�ncias. O arquivo � modificado apenas quando
uma solu��o melhor que as ali presentes � encontrada. A �ltima modifica��o 
realizada � indicada pelo nome da inst�ncia em 'De: "stowage06050202.sto"',
por exemplo.

Obs: todas as inst�ncias encontram-se na pasta "instances". Elas est�o no
formato proposto por Azevedo.



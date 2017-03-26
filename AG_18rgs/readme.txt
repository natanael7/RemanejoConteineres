Para rodar, deve-se digitar o número de portos seguido do tipo da matriz.
Exemplo: 
101 -> indica 10 portos e matriz do tipo 1
253 -> indica 25 portos e matriz do tipo 3

Para definir o número de replicações, deve-se alterar o parâmetro "meta"
no arquivo main.c. O padrão é definido "meta=60".

Os resultados podem ser visualizados na pasta "results".
Lá encontram-se as pastas com os resultados de cada instância. Cada pasta
destas irá conter os arquivos com o resultado de cada execução, apresentando:
- data da execução (cabeçalho)
- histórico da melhor FO
- melhor solução final e o respectivo valor de FO
- tempo de execução

Obs: cada nova execução é salva com um número de identificação, sendo isso 
feito de forma incremental

Além dos resultados por instância, existe também o arquivo Best_Fitness.dat
que apresenta os melhores resultados encontrados dentre todas as execuções
realizadas de cada uma das instâncias. O arquivo é modificado apenas quando
uma solução melhor que as ali presentes é encontrada. A última modificação 
realizada é indicada pelo nome da instância em 'De: "stowage06050202.sto"',
por exemplo.

Obs: todas as instâncias encontram-se na pasta "instances". Elas estão no
formato proposto por Azevedo.



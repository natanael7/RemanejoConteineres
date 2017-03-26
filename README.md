# RemanejoConteineres
Algoritmo Genético aplicado ao problema de carregamento de navios-contêineres.

---

### Resumo 2014/1

O trabalho de pesquisa desenvolvido tem como objetivo a implementação e avaliação do método Algoritmo Genético (AG) quando empregado na solução de um problema de otimização combinatória. A implementação do AG foi realizada através do uso de duas diferentes linguagens de programação e a sua avaliação foi feita em diferentes sistemas operacionais. 

O Algoritmo Genético é aplicado na resolução do problema de carregamento e descarregamento de um navio-contêiner quando em operação em num terminal portuário. Este problema pode ser modelado como um problema de otimização onde se busca a minimização do número de movimentações de contêineres. Dependendo da capacidade de armazenamento do navio e do número de contêineres a serem carregados e/ou descarregados, o tempo para obtenção da solução ótima pode ser alto, tornando a solução do problema inviável. Com o objetivo de obter uma solução de boa qualidade em um tempo razoável, adota-se a metaheurística AG, porém sem a garantia de ser obtida a solução ótima. 

Sabidamente, técnicas metaheurísticas requerem um grande esforço computacional, exigindo um tempo de processamento alto para obter soluções ótimas ou quase-ótimas. Desta forma, mostra-se necessário o emprego de uma implementação computacional eficiente e sua execução em um ambiente da mesma forma eficiente. O código computacional do AG foi implementado nas linguagens de programação do Matlab e ANSI C, sendo avaliado nos sistemas operacionais Windows e Linux. Foram feitos experimentos assumindo três tipos de matrizes de transporte, definidas de acordo com o tempo que os contêineres permanecem a bordo. Nos problemas teste avaliados foi adotado um navio com capacidade máxima de 300 contêineres e rotas com a quantidade de portos entre 10 e 30, com variação de 5 portos. 

Os experimentos computacionais mostraram que a implementação em ANSI C exigiu um tempo computacional menor que a implementação Matlab em ambiente Windows. Os resultados para matrizes de transporte do tipo 1 apresentaram uma redução média de 97,9% no tempo de processamento, para matrizes do tipo 2 foi obtido uma redução média de 98,2% e para matrizes do tipo 3 verificou-se uma redução média de 98,1% no tempo de processamento. Assim, conclui-se que a implementação do AG com emprego da linguagem ANSI C garante uma redução no tempo de processamento, se comparada com a implementação em Matlab, possibilitando a obtenção de soluções de melhor qualidade com o mesmo esforço computacional.

---

### Resumo 2014/2

Partindo do estudo feito no período de pesquisa anterior, no qual foi implementado o código computacional do AG em linguagem ANSI C, iniciou-se o aprimoramento lógico do programa para maior eficácia na obtenção dos resultados. O primeiro aprimoramento foi a modificação de duas regras de descarga, sendo proposta a unificação dos contêineres remanejados com aqueles que a serem carregados, garantindo assim uma melhor ordenação dos contêineres de remanejamento. Os resultados obtidos mostraram uma melhora média de 18% nos resultados.

Seguindo o curso da pesquisa, foram também desenvolvidas duas novas regras de carga e uma de descarga, sendo proposto um método AG com 12 combinações de regras. Estas novas regras permitiram uma maior diversificação na realização das operações de carga e descarga dos contêineres no navio, tais como a ordenação dos contêineres da esquerda para a direita e vice-versa. Os resultados atingiram uma melhora média de 9% na solução final obtida. Seguindo esta lógica, foram implementadas mais 2 regras de carga, gerando assim uma implementação AG com 18 combinações de regras.

Por fim, a pesquisa para o aprimoramento do programa computacional mostrou um grande ganho na aproximação ao resultado ótimo desejado, tendo sido avaliadas a seguintes especificações para o número de portos: 10, 15, 20, 25, 30. Os melhores resultados obtidos com a implementação do AG utilizando 18 combinações de regras foram, respectivamente: 1340, 1621, 2070, 1706, 2378; onde os respectivos resultados ótimos conhecidos são: 1322, 1580, 1990, 1664, 2262, para uma matriz de transporte do tipo 1.

Assim, conclui-se que a implementação do AG com mais regras de carregamento e descarregamento possibilita a obtenção de soluções de melhor qualidade, sendo mais próximas às soluções ótimas conhecidas.

---

### Programação

Linguagem: C  
IDE: Dev C++  
Source: dentro das pastas AG_***/  

---

## Sobre

O projeto foi desenvolvido entre 10/2012 e 12/2014 na Universidade UNISINOS - São Leopoldo, RS. Através de uma bolsa de pesquisa CNPq - Modalidade Ensino Médio.

*Autor: Natanael Josué Rabello*  
*Orientador: Leonardo Dagnino Chiwiacowsky*


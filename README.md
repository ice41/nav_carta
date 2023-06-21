# nav_carta
**Este script foi uma melhoria de um script existente na comunidade para uso free.**
**Script Original vrp_autoescola da Zirix V3**
**Como tal pode alterar o mesmo ao seu gosto mas pfv mantenha os creditos do meu tempo investido nele**

Ao normal script para vRPEX de tirar a ablitação para conduzir foi adicionado mais categorias.
- T - Teórica
- A - [PT-BR] Moto / [PT-PT] Mota
- B - Carro
- C - Pesado
- C + E - [PT-BR] Caminhão + Traler / [PT-PT] Camião + Semi-reboque
- D - [PT-BR] Ônibus / [PT-PT] Autocarro **Ainda não implementada**

## 
- Para cada uma delas tem as velocidades ajustadas para a sua categoria segundo o codigo da estrada em Portugal.
- O teste de Teoria ainda não está terminado infelizmente mas em breve receberá a devida atenção.
- Os campos da BD que são necessários são criados automaticamente pelo script.

## Trabalho realizados

- [x] Categoria A teste prático
- [x] Categoria B teste prático
- [X] Categoria C teste prático
- [X] Categoria C + E teste prático
    - [ ] Avião
    - [ ] Barco
    - [ ] Armas
## Trabalho em falta
- [ ] Teórica
    - [ ] Avião
    - [ ] Barco
    - [ ] Armas

## Verificação de pose de ablitações apenas os policias ou a `policia.permissao` pode consultar e retirar cada tipo de carta.
Como policia pede fazer os seguinte comandos a baixo, o script verifica o id do jogador que está na sua frente.

- /carta ```mota ``` , ```carro ```, ```camiao ```,``` reboque``` em frente ao jogador


- /tirarcarta ```mota ``` , ```carro ```, ```camiao ```,``` reboque``` em frente ao jogador

## Estados da Ablitação / carta de condução
 - Estado **1** Utilizador com abilitação / carta
 - Estado **2** abilitação / carta apreendida
 - Estado **3** sem abilitação / carta

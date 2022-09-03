# language: pt

@regression
@cadastro_produto
Funcionalidade: Cadastro de anuncios
  Sendo usuario cadastrado no RockLov que possui equipamentos musicais
  Quero cadastrar meus equipamentos
  Para que eu possa disponibilizalos para locacao

  Contexto: Logando e indo para cadastro
    * que estou logado como 'gui@rozinmaill.com' e '123456'

  @cadastro_equipamento
  Cenario: Cadastrando equipamento
    Dado que acesso o formulario de cadastro de anuncios
      E que eu tenho o seguinte equipamento:
      | thumb     | kramer.jpg |
      | nome      | fender     |
      | categoria | Cordas     |
      | preco     | 150        |
    Quando submeto o cadastro desse item
    Entao devo ver esse item no meu Dashboard

  @cadastro_equipamento_invalido
  Esquema do Cenario: Cadastrando anuncio sem foto
    Dado que acesso o formulario de cadastro de anuncios
      E que eu tenho o seguinte equipamento:
      | thumb     | <foto>      |
      | nome      | <nome>      |
      | categoria | <categoria> |
      | preco     | <preco>     |
    Quando submeto o cadastro desse item
    Entao devo visualizar a mensagem de alerta: '<mensagem>'
    Exemplos:
      | foto          | nome            | categoria | preco | mensagem                             |
      |               | Violao de Nylon | Cordas    | 122   | Adicione uma foto no seu anúncio!    |
      | clarinete.jpg |                 | Outros    | 152   | Informe a descrição do anúncio!      |
      | mic.jpg       | Microfone Shure |           | 100   | Informe a categoria                  |
      | trompete.jpg  | Trompete Padrao | Outros    |       | Informe o valor da diária            |
      | trompete.jpg  | Trompete Padrao | Outros    | A     | O valor da diária deve ser numérico! |
      | trompete.jpg  | Trompete Padrao | Outros    | 2A    | O valor da diária deve ser numérico! |
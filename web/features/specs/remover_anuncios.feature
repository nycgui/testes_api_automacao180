#language: pt

@regression
@remover_anuncio
Funcionalidade: Remover Anuncio
  Sendo um anunciante que possui anuncio que deve ser removido
  Quero poder remover este anuncio
  Para que meus anuncios continuem sempre atualizados


  Contexto: Logando e indo para cadastro
    * que estou logado como 'nycnog@rozinmaill.com' e '123456'

  Cenario: Remover anuncio
    Dado que eu tenha um anuncio a ser removido:
      | thumb     | telecaster.jpg    |
      | nome      | Telecaster fender |
      | categoria | Cordas            |
      | preco     | 1500              |
    Quando solicito a remocao deste anuncio
    E confirmo a remocao
    Entao o anuncio deve ser removido do meu Dashboard


  Cenario: Desistir remover anuncio
    Dado que eu tenha um anuncio a ser removido:
      | thumb     | conga.jpg  |
      | nome      | Conga      |
      | categoria | Outros     |
      | preco     | 700        |
    Quando solicito a remocao deste anuncio
    Mas nao confirmo a remocao
    Entao o anuncio deve continuar no meu Dashboard

#language: pt

@regression
@cadastro
Funcionalidade: Cadastro
  Sendo um musico que possui equipamentos musicais
  Quero fazer o meu cadastro no RockLov
  Para que eu possa disponibiliza-los para locacao

  @cadastro_valido
  Cenario: Fazer cadastro
    Dado que acesso a pagina de cadastro
    Quando submeto o seguinte formulario de cadastro:
      | nome              | email                 | senha  |
      | Nycollas Nogueira | nyc.gui@rozinmaill.com | 123456 |
    Entao sou redirecionado para o Dashboard

  @cadastro_tentativas
  Esquema do Cenario: Tentativas de cadastro
    Dado que acesso a pagina de cadastro
    Quando submeto o seguinte formulario de cadastro:
      | nome         | email         | senha         |
      | <nome_input> | <email_input> | <senha_input> |
    Entao vejo a mensagem de alerta: '<mensagem_output>'
    Exemplos:
      | nome_input        | email_input           | senha_input | mensagem_output                  |
      |                   | nyc.gui@rozinmail.com | 123456      | Oops. Informe seu nome completo! |
      | Nycollas Nogueira |                       | 123456      | Oops. Informe um email válido!   |
      | Nycollas Nogueira | nyc.gui#rozinmail.com | 123456      | Oops. Informe um email válido!   |
      | Nycollas Nogueira | nyc.gui*rozinmail.com | 123456      | Oops. Informe um email válido!   |
      | Nycollas Nogueira | nyc.gui@rozinmail.com |             | Oops. Informe sua senha secreta! |
#language: pt

@regression
@login
Funcionalidade: login
    Sendo um usuário cadastrado
    Quero acessar o sistema da Rocklov
    Para que eu possa anunciar meus equipamentos musicais

    @login_valido
    Cenario: Login do usuário
        Dado que acesso a página principal
        Quando submeto minhas credenciais com 'nyc.gui@rozinmaill.com' e '123456'
        Então sou redirecionado para o Dashboard

    @login_tentativas
    Esquema do Cenario: Tentativa de login
        Dado que acesso a página principal
        Quando submeto minhas credenciais com '<email>' e '<senha>'
        Entao vejo a mensagem de alerta: '<mensagem>'
        Exemplos:
            | email                 | senha   | mensagem                         |
            | nyc.gui@rozinmail.com | abcd    | Usuário e/ou senha inválidos.    |
            | nyc.gui@hmail.com     | 123456  | Usuário e/ou senha inválidos.    |
            | nyc.gui#rozinmail.com | 123456  | Oops. Informe um email válido!   |
            |                       | 123456  | Oops. Informe um email válido!   |
            | nyc.gui@rozinmail.com |         | Oops. Informe sua senha secreta! |
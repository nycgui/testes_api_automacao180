#language:pt

@receber_pedido
Funcionalidade: Receber pedido de locacao
  Eu como anunciante com esquipamentos disponiveis para locacao
  Desejo receber pedidos de locacao
  Podendo aprova-los ou reijeita-los

  Cenario: Receber pedido
    Dado que meu perfil de anunciante seja 'nyc@anunciante.com' e '123456'
      E que eu tenha o seguinte equipamento cadastrado:
        | thumb     | trompete.jpg |
        | nome      | trompete     |
        | categoria | Outros       |
        | preco     | 100          |
    E acesso o dashboard
    Quando o locatario 'nog@locatario.com' e '123456' solicita a locacao desse equipo
    Entao devo ver a seguinte mensagem:
    """
    nog@locatario.com deseja alugar o equipamento: trompete em: DATA_ATUAL
    """
    E devo ver as opcoes: 'ACEITAR' e 'REJEITAR' no pedido
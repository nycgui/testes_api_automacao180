Dado('que meu perfil de anunciante seja {string} e {string}') do |email, senha|
  @emailAnunciante = email
  @passAnunciante = senha
end

Dado('que eu tenha o seguinte equipamento cadastrado:') do |table|
  userId = SessionsService.new.get_user_id(@emailAnunciante, @passAnunciante)

  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), 'rb')

  @equipo = { thumbnail: thumbnail,
             name: table.rows_hash[:nome],
            category: table.rows_hash[:categoria],
            price: table.rows_hash[:preco]
          }
  MongoDB.new.remove_equipo(@equipo[:name], @emailAnunciante)
  retorno = EquiposService.new.create(@equipo, userId)
  @equipoId = retorno.parsed_response["_id"]
end

Dado('acesso o dashboard') do
  steps %{
    Dado que acesso a página principal
    Quando submeto minhas credenciais com "#{@emailAnunciante}" e "#{@passAnunciante}"
    Então sou redirecionado para o Dashboard
  }
end

Quando('o locatario {string} e {string} solicita a locacao desse equipo') do |email, senha|
  userId = SessionsService.new.get_user_id(email, senha)
  EquiposService.new.booking(@equipoId, userId)
end

Entao('devo ver a seguinte mensagem:') do |mensagemEsperada|
  mensagemEsperada = mensagemEsperada.gsub('DATA_ATUAL', Time.now.strftime("%d/%m/%Y"))
  expect(@dashPage.order).to have_text(mensagemEsperada)
end

Entao('devo ver as opcoes: {string} e {string} no pedido') do |aceitar, rejeitar|
  expect(@dashPage.order_actions(aceitar)).to be true
  expect(@dashPage.order_actions(rejeitar)).to be true
end
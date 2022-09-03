Dado('que estou logado como {string} e {string}') do |email, senha|
  steps %{
    Dado que acesso a página principal
    Quando submeto minhas credenciais com "#{email}" e "#{senha}"
    Então sou redirecionado para o Dashboard
  }
  @email = email
end

Dado('que acesso o formulario de cadastro de anuncios') do
  @dashPage.goto_equipo_form
end

Dado('que eu tenho o seguinte equipamento:') do |tabela|
  @anuncio = tabela.rows_hash
  MongoDB.new.remove_equipo(@anuncio[:nome], @email)
end

Quando('submeto o cadastro desse item') do
  @equiposPage.create(@anuncio)
end

Entao('devo ver esse item no meu Dashboard') do
  expect(@equiposPage.equipo_list).to have_content @anuncio[:nome]
  expect(@equiposPage.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
end

Entao('devo visualizar a mensagem de alerta: {string}') do |mensagem|
  expect(@alert.dark).to have_text mensagem
end
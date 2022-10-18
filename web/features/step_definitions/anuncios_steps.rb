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

Dado('que eu tenha um anuncio a ser removido:') do |table|
  userId = page.execute_script("return localStorage.getItem('user')")
  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), 'rb')

  @equipo = { thumbnail: thumbnail,
             name: table.rows_hash[:nome],
            category: table.rows_hash[:categoria],
            price: table.rows_hash[:preco]
          }
  EquiposService.new.create(@equipo, userId)
  visit current_path
end

Quando('solicito a remocao deste anuncio') do
  @dashPage.remove_equipo(@equipo[:name])
end

Quando('confirmo a remocao') do
  @dashPage.confirm_removal('Sim')
end

Entao('o anuncio deve ser removido do meu Dashboard') do
  expect(@dashPage.has_no_equipo?(@equipo[:name])).to be true
end

Quando('nao confirmo a remocao') do
  @dashPage.confirm_removal('Não')
end

Entao('o anuncio deve continuar no meu Dashboard') do
  expect(@equiposPage.equipo_list).to have_content @equipo[:name]
end
Dado('que acesso a página principal') do
  @loginPage.open
end

Quando('submeto minhas credenciais com {string} e {string}') do |email, senha|
  # find('.email')
  @loginPage.with(email, senha)
end
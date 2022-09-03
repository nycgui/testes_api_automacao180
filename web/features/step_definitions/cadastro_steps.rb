Dado('que acesso a pagina de cadastro') do
  @signupPage.open
end

Quando('submeto o seguinte formulario de cadastro:') do |table|
  user = table.hashes.first
  MongoDB.new.remove_user(user[:email])
  @signupPage.create(user)
end

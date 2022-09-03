Entao('sou redirecionado para o Dashboard') do
  expect(@dashPage.on_dash?).to be true
end

Entao('vejo a mensagem de alerta: {string}') do |mensagem|
  expect(page).to have_css '.alert-dark'
  expect(@alert.dark).to eql mensagem
  expect(page).to have_content mensagem
end
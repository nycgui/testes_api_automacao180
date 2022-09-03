class EquiposPage
  include Capybara::DSL

  def create(equipo)
    page.has_css?("equipoForm")
    upload(equipo[:thumb]) if equipo[:thumb].length > 0
    # Seletores css
    # $ busca um placeholder que termina com a plavra
    # * busca um placeholder que contenha a palavra
    # ^ busca um placeholder que comeca com a palavra
    find("input[placeholder$=equipamento]").set equipo[:nome]
    # find('# ').select tabela[:categoria]
    select_cat(equipo[:categoria]) if equipo[:categoria].length > 0
    find("input[placeholder^=Valor]").set equipo[:preco]
    click_button "Cadastrar"
  end

  def equipo_list
    return find(".equipo-list")
  end

  def select_cat(categoria)
    find("#category").find("option", text: categoria).select_option
  end

  def upload(fileName)
    imagem = Dir.pwd + "/features/support/fixtures/images/#{fileName}"
    find("#thumbnail input[type=file]", visible: false).set imagem
  end
end

class DashPage
  include Capybara::DSL

  def on_dash?
    page.has_css?('.dashboard')
  end

  def goto_equipo_form
    click_button 'Criar anúncio'
  end

  def remove_equipo(name)
    equipo = find('.equipo-list li', text: name)
    equipo.find('.delete-icon').click
  end

  def confirm_removal(value)
    click_on value
  end

  def has_no_equipo?(name)
    page.has_no_css?('.equipo-list li', text: name)
  end

  def order
    find(".notifications p")
  end

  def order_actions(action)
      page.has_css?('.notifications button', text: action)
  end
end
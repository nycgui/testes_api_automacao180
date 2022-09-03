Before do
  @alert = Alert.new
  @loginPage = LoginPage.new
  @signupPage = SignupPage.new
  @dashPage = DashPage.new
  @equiposPage = EquiposPage.new

  page.current_window.resize_to(1440, 900)
end

After do
  temp_shot = page.save_screenshot("logs/temp_screenshot.png")

  Allure.add_attachment(
    name: "Screenshot",
    type: Allure::ContentType::PNG,
    source: File.open(temp_shot)
  )
end

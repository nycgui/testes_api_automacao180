require "allure-cucumber"
require "capybara"
require "capybara/cucumber"
require "faker"
require "pry"

CONFIG = YAML.load_file(File.join(Dir.pwd, "features/support/config/#{ENV["CONFIG"]}"))
BROWSER = ENV["BROWSER"]

Capybara.configure do |config|
  config.default_driver = :"#{BROWSER}"
  config.app_host = CONFIG["url"]
  config.default_max_wait_time = 10
end

AllureCucumber.configure do |config|
  config.results_directory = "/logs"
  config.clean_results_directory = true
end

require_relative 'routes/signup'
require_relative 'routes/equipos'
require_relative 'routes/sessions'

require_relative 'libs/mongo'
require_relative 'helpers'

require 'digest/md5'

def to_md5(pass)
  # cria senha criptografada no formato md5 que eh o formato utilizado no projeto
  return Digest::MD5.hexdigest(pass)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    users = [
      {name: 'NycGuiRobozin', email: 'nyc.gui@rozinmaill.com', password: to_md5('123456')},
      {name: 'GuiRobozin', email: 'gui@gmail.com', password: to_md5('123456')},
      {name: 'NycRobozin', email: 'nyc@rozinmaill.com', password: to_md5('123456')},
      {name: 'CarvRobozin', email: 'carv@gmail.com', password: to_md5('123456')},
      {name: 'NogRobozin', email: 'nog@gmaill.com', password: to_md5('123456')}
    ]

    MongoDB.new.drop_danger
    MongoDB.new.insert_users(users)
  end

end

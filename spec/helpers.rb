module Helpers
  def get_fixtures(item)
    YAML.load(File.read(Dir.pwd + "/spec/fixtures/#{item}.yml"), symbolize_names: true)
  end

  def get_thumb(thumb_name)
    File.open(File.join(Dir.pwd, "spec/fixtures/images/#{thumb_name}"), 'rb')
  end

  module_function :get_fixtures
  module_function :get_thumb
end
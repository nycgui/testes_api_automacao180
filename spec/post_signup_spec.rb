require_relative 'routes/signup'
require_relative 'libs/mongo'

describe 'POST /signup' do
  context('novo usuario') do
    before(:all) do
      payload = {
        name: 'Nyc',
        email: 'ngui@gmail.com',
        password: '123456'
      }
      MongoDB.new.remove_user(payload[:email])
      @result = Signup.new.create(payload)
    end

    it 'valida status code' do
      expect(@result.code).to eql 200
    end

    it 'valida id do usuario' do
      expect(@result.parsed_response['_id'].length).to eql 24
    end
  end

  context('Usuario existente') do
    before (:all) do
      payload = {
        name: 'Nyc',
        email: 'ngui@gmail.com',
        password: '123456'
      }
      MongoDB.new.remove_user(payload[:email])
      Signup.new.create(payload)
      @result = Signup.new.create(payload)
    end
    
    it 'valida status code 409' do
      expect(@result.code).to eql 409
    end

    it 'valida mensagem' do
      expect(@result.parsed_response['error']).to eql 'Email already exists :('
    end
  end
end

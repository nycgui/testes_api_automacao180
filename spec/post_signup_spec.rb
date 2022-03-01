describe 'POST /signup' do
  context('Novo usuario') do
    before(:all) do
      payload = {
        name: 'Nyc',
        email: 'ngui@gmail.com',
        password: '123456'
      }
      MongoDB.new.remove_user(payload[:email])
      @result = Signup.new.create(payload)
    end

    it 'Valida status code' do
      expect(@result.code).to eql 200
    end

    it 'Valida id do usuario' do
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
    
    it 'Valida status code 409' do
      expect(@result.code).to eql 409
    end

    it 'Valida mensagem' do
      expect(@result.parsed_response['error']).to eql 'Email already exists :('
    end
  end

  examples = Helpers::get_fixtures('signup_requireds')

  examples.each do |e|
    context e[:title] do
      before(:all) do
        @result = Signup.new.create(e[:payload])
      end
  
      it "Valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end
  
      it "Valida mensagem de erro #{e[:error]}" do
        expect(@result.parsed_response['error']).to eql e[:error]
      end
    end
  end
end

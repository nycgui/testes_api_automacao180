describe 'POST /equipos' do
  before(:all) do
    payload = { email:'nyc.gui@rozinmaill.com', password: '123456' }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response['_id']
  end

  context 'novo equipamento' do

    before(:all) do
      payload = {
        thumbnail: Helpers::get_thumb('kramer.jpg'),
        name: 'Kramer',
        category: 'Cordas',
        price: 250
      }
      MongoDB.new.remove_equipo(payload[:name], @user_id)

      @result = Equipos.new.create(payload, @user_id)
    end

    it 'deve retornar 200' do
      expect(@result.code).to eql 200
    end

  end

  context 'nao autorizado' do

    before(:all) do
      payload = {
        thumbnail: Helpers::get_thumb('amp.jpg'),
        name: 'Amp',
        category: 'Cordas',
        price: 170
      }

      @result = Equipos.new.create(payload, nil)
    end

    it 'deve retornar 401' do
      expect(@result.code).to eql 401
    end

  end

end
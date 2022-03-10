describe 'GET /equipos/{equipo_id}' do
  before(:all) do
    payload = { email:'nyc.gui@rozinmaill.com', password: '123456' }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response['_id']
  end
 
  context 'buscar um equipo' do
    before(:all) do
      @payload = {
        thumbnail: Helpers::get_thumb('clarinete.jpg'),
        name: 'Clarinete',
        category: 'Sopro',
        price: 400
      }
      MongoDB.new.remove_equipo(@payload[:name], @user_id)

      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response['_id']
      @result = Equipos.new.find_by_id(@equipo_id, @user_id)
    end

    it 'deve retornar 200' do
      expect(@result.code).to eql 200
    end

    it 'deve retornar o nome' do
      expect(@result.parsed_response).to include('name' => @payload[:name])
    end

  end

  context 'obter equipamento que nao existe' do

    before(:all) do
      @result = Equipos.new.find_by_id(MongoDB.new.get_mongo_id, @user_id)
    end

    it 'deve retornar 404' do
        expect(@result.code).to eql 404
    end
  end

end
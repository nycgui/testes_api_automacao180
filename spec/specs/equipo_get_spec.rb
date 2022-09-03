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

describe 'GET /equipos' do

  before(:all) do
    payload = {email: 'gui@gmail.com', password: '123456'}
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response['_id']
  end

  context 'obter uma lista de equipamentos' do

    before(:all) do
      #Dado que eu tenha varios equipos cadastrados
      payloads = [
        {
        thumbnail: Helpers::get_thumb('clarinete.jpg'),
        name: 'Clarinete',
        category: 'Sopro',
        price: 400
        },
        {
          thumbnail: Helpers::get_thumb('kramer.jpg'),
          name: 'Kramer',
          category: 'Cordas',
          price: 250
        },
        {
          thumbnail: Helpers::get_thumb('amp.jpg'),
          name: 'Amp',
          category: 'Cordas',
          price: 170
        }
      ]
      payloads.each do |payload|
        MongoDB.new.remove_equipo(payload[:name], @user_id)
        Equipos.new.create(payload, @user_id)
      end
      # Quando procuro todos os produto

      @result = Equipos.new.list(@user_id)
    end

    it 'deve retornar 200' do
      expect(@result.code).to eql 200
    end

    it 'nao deve ser vazio' do
      expect(@result.parsed_response).not_to be_empty
      expect(@result.parsed_response.class).to eql Array
    end

  end
end
#encoding: utf-8

describe 'DELETE /equipos/{equipo_id}' do
  before(:all) do
    # Dado que eu tenha um equipamento cadastrado
    payload = { email:'nyc.gui@rozinmaill.com', password: '123456' }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response['_id']
  end
 
  context 'buscar um equipo' do
    before(:all) do
      @payload = {
        thumbnail: Helpers::get_thumb('conga.jpg'),
        name: 'Conga',
        category: 'Outros',
        price: 1000
      }
      MongoDB.new.remove_equipo(@payload[:name], @user_id)

      # E o id do equipamento
      equipo = Equipos.new.create(@payload, @user_id)
      @equipo_id = equipo.parsed_response['_id']

      # Quando faco uma requisicao delete por Id
      @result = Equipos.new.delete_by_id(@equipo_id, @user_id)
    end

    it 'deve retornar 204' do
      expect(@result.code).to eql 204
    end
  end

  context 'obter equipamento que nao existe' do

    before(:all) do
      @result = Equipos.new.delete_by_id(MongoDB.new.get_mongo_id, @user_id)
    end

    it 'deve retornar 204' do
        expect(@result.code).to eql 204
    end
  end

end
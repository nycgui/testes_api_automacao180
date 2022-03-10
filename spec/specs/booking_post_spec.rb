describe 'POST /equipos/{equipo_id}/bookings' do

  before(:all) do
    @carv_id = Sessions.new.login({ email:'carv@gmail.com', password: '123456' }).parsed_response['_id']
  end


  context 'solicitar locacao' do

    before(:all) do
      # Dado que um usuario tenha um equipamento para locacao

      nyc_id = Sessions.new.login({ email:'nyc.gui@rozinmaill.com', password: '123456' }).parsed_response['_id']

      payload = {
        thumbnail: Helpers::get_thumb('baixo.jpg'),
        name: 'Baixo',
        category: 'Cordas',
        price: 250
      }
      MongoDB.new.remove_equipo(payload[:name], nyc_id)
      nyc_equipo_id = Equipos.new.create(payload, nyc_id).parsed_response['_id']

      # Quando logo com outro usuario e solicito a locacao do equipo criado
      @result = Equipos.new.booking(nyc_equipo_id, @carv_id)
    end

    it 'deve retornar 200' do
      expect(@result.code).to eql 200
    end
  end
end
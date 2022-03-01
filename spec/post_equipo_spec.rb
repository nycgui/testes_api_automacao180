describe 'POST /equipos' do
  before(:all) do
    payload = { email:'nyc.gui@rozinmaill.com', password: '123456' }
    result = Sessions.new.login(payload)
    @user_id = result.parsed_response['_id']
  end

  context 'novo equipamento' do

    before(:all) do
      thumbnail = File.open(File.join(Dir.pwd, 'spec/fixtures/images/kramer.jpg'))
      payload = {
        thumbnail: thumbnail, 
        name: 'Kramer',
        category: 'Cordas',
        price: 250
      }

      @result = Equipos.new.create(payload, @user_id)
    end

    it 'deve retornar 200' do
      expect(@result.code).to eql 200
    end

  end

end
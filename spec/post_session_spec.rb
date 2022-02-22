require_relative "routes/sessions"
require_relative "helpers"

describe 'Post /sessions' do

  context 'login com sucesso' do
    before(:all) do
      payload = { email: 'nyc.gui@rozinmaill.com', password: '123456' }
      @result = Sessions.new.login(payload)
    end

    it 'valida status code' do
      expect(@result.code).to eql 200
    end

    it 'valida id do usuario' do
      expect(@result.parsed_response['_id'].length).to eql 24
    end
  end

  # examples = [
  #   {
  #     title: 'senha incorreta',
  #     payload: { email: 'nyc.gui@rozinmaill.com', password: '123' },
  #     code: 401,
  #     error: 'Unauthorized'
  #   },
  #   {
  #     title: 'usuario nao existe',
  #     payload: { email: 'nyc.gui@maill.com', password: '123456' },
  #     code: 401,
  #     error: 'Unauthorized'
  #   },
  #   {
  #     title: 'email em branco',
  #     payload: { email: '', password: '123456' },
  #     code: 412,
  #     error: 'required email'
  #   },
  #   {
  #     title: 'sem o campo email',
  #     payload: { password: '123456' },
  #     code: 412,
  #     error: 'required email'
  #   },
  #   {
  #     title: 'senha em branco',
  #     payload: { email: 'nyc.gui@rozinmaill.com', password: '' },
  #     code: 412,
  #     error: 'required password'
  #   },
  #   {
  #     title: 'sem o campo senha',
  #     payload: { email: 'nyc.gui@rozinmaill.com' },
  #     code: 412,
  #     error: 'required password'
  #   }
  # ]

  examples = Helpers::get_fixtures('login')

  examples.each do |e|
    context e[:title] do
      before(:all) do
        @result = Sessions.new.login(e[:payload])
      end
  
      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end
  
      it 'valida id do usuario' do
        expect(@result.parsed_response['error']).to eql e[:error]
      end
    end
  end
end
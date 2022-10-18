require_relative 'base_service'

class SessionsService < BaseService
  include HTTParty
  base_uri 'http://rocklov-api:3333'

  def get_user_id(email, senha)
    payload = {email: email, password: senha}
    retorno = self.class.post(
      '/sessions',
      body: payload.to_json,
      headers: {
        'Content-Type': 'application/json'
      }
    )
    retorno.parsed_response["_id"]
  end
end
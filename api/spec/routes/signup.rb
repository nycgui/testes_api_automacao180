require_relative 'base_api'

class Signup < BaseApi
  def create(payload)
    self.class.post(
      '/signup',
      body: payload.to_json,
      headers: {
        'Content-Type': 'application/json'
      }
    )
  end
end
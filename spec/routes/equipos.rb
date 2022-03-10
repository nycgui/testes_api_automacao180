require_relative 'base_api'

class Equipos < BaseApi
  def create(payload, user_id)
    self.class.post(
      '/equipos',
      body: payload,
      headers: {
        'user_id': user_id
      }
    )
  end

  def find_by_id(equipo_id, user_id)
    self.class.get(
      "/equipos/#{equipo_id}",
      headers: {
        'user_id': user_id
      }
    )
  end

  def delete_by_id(equipo_id, user_id)
    self.class.delete(
      "/equipos/#{equipo_id}",
      headers: {
        'user_id': user_id
      }
    )
  end

end
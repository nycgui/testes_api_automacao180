require_relative 'base_service'

class EquiposService < BaseService
  def create(equipo, userId)
    self.class.post('/equipos', body: equipo, headers: { 'user_id': userId} )
  end

  def booking(equipo_id, user_id)
    self.class.post(
      "/equipos/#{equipo_id}/bookings",
      body: {date: Time.now.strftime('%d/%m/%Y')}.to_json,
      headers: {
        'content-type': 'application/json',
        'user_id': user_id
      }
    )
  end
end
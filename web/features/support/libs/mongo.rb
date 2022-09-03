require 'mongo'

Mongo::Logger.logger = Logger.new('./logs/mongo.log')

class MongoDB
  attr_accessor :client, :users, :equipos

  def initialize
    @client = Mongo::Client.new(CONFIG["mongo"])
    @users = client[:users]
    @equipos = client[:equipos]
  end

  def drop_danger
    @client.database.drop
  end

def insert_users(docs)
  @users.insert_many(docs)
end

  def remove_user(email)
    @users.delete_many({email: email})
  end

  def get_user(email)
    user = @users.find({email: email}).first
    user[:_id]
  end

  def remove_equipo(nome, email)
    userId = get_user(email)
    @equipos.delete_many({name: nome, user: userId})
  end

end


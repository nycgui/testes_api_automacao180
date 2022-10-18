require  'httparty'

class BaseService
  include HTTParty
  base_uri 'Http://rocklov-api:3333'
end
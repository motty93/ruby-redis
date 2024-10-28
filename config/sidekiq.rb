require 'sidekiq'
require 'dotenv/load'
require_relative '../redis_worker'

redis_url = ENV['REDIS_URL'].gsub('redis://', 'rediss://')
redis_password = ENV['REDIS_PASSWORD']

Sidekiq.configure_server do |config|
  config.redis = {
    url: redis_url,
    password: redis_password,
    ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: redis_url,
    password: redis_password,
    ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
  }
end

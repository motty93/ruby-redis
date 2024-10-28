# NOTE: no certificate verification
# Sidekiq.configure_server do |config|
#   config.redis = {
#     url: redis_url,
#     password: redis_password,
#     ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
#   }
# end
#
# Sidekiq.configure_client do |config|
#   config.redis = {
#     url: redis_url,
#     password: redis_password,
#     ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
#   }
# end

require 'tempfile'
require 'sidekiq'
require 'dotenv/load'
require_relative '../redis_worker'

cert_file = Tempfile.new('redis_cert')
cert_file.write(ENV.fetch('REDIS_CERT', nil))
cert_file.rewind
url = ENV.fetch(ENV.fetch('REDIS_PROVIDER', 'REDIS_URL'), nil)&.gsub('redis://', 'rediss://')
password = ENV.fetch('REDIS_PASSWORD', nil)

Sidekiq.configure_server do |config|
  config.redis = {
    url: url,
    ssl_params: {
      cert_store: OpenSSL::X509::Store.new.tap { |store| store.add_file(cert_file.path) },
      verify_mode: OpenSSL::SSL::VERIFY_PEER,
    },
    password: password,
    size: 20,
    connect_timeout: 5,
    reconnect_attempts: 3,
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: url,
    ssl_params: {
      cert_store: OpenSSL::X509::Store.new.tap { |store| store.add_file(cert_file.path) },
      verify_mode: OpenSSL::SSL::VERIFY_PEER,
    },
    password: password,
    size: 20,
    connect_timeout: 5,
    reconnect_attempts: 3,
  }
end

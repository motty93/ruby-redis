require 'redis'
require 'dotenv/load'
require 'sidekiq'

class RedisWorker
  include Sidekiq::Worker

  def perform(key, value)
    redis = Redis.new(url: ENV['REDIS_URL'])
    return if redis.nil?

    redis.set(key, value)
    puts "Set #{key} to #{value} in Redis."

    retrieved_value = redis.get(key)
    puts "Retrieved #{key} from Redis: #{retrieved_value}"
  end
end

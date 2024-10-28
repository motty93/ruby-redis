require 'redis'
require 'dotenv/load'

redis = Redis.new(url: ENV['REDIS_URL'])
return if redis.nil?

value = redis.get('mykey')
puts value

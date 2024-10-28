require 'redis'
require 'dotenv/load'

redis = Redis.new(url: ENV['REDIS_URL'])
return if redis.nil?

redis.set('mykey', 'hello world')
puts redis.get('mykey')

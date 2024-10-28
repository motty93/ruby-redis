require './redis_worker'

# sidekiqにジョブ追加
RedisWorker.perform_async('my_key', 'hello, Redis!')

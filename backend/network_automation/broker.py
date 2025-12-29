import dramatiq
from dramatiq.brokers.redis import RedisBroker
from dramatiq.results import Results
from dramatiq.results.backends import RedisBackend

# Create Redis broker and results backend
redis_broker = RedisBroker(url="redis://127.0.0.1:6379/0")
results_backend = RedisBackend()

# Attach Results middleware
redis_broker.add_middleware(Results(backend=results_backend))

# Register broker globally
dramatiq.set_broker(redis_broker)
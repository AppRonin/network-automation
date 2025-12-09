import re
import time
import redis
import dramatiq
from network_automation import broker

r = redis.Redis()

def get_total_onu(file):
    onu_pattern = r"interface\sgpon-onu_\d{1,2}/\d{1,2}/\d{1,2}:\d{1,2}"
    total_onu = len(re.findall(onu_pattern, file))
    return total_onu

@dramatiq.actor(store_results=True)
def gpon_conversor(task_id, file):

    # Read entire file as text
    file = file.read().decode("utf-8", errors="ignore")
    r.set(f"progress:{task_id}", 10)

    # Get total of onu interfaces
    total_onu = get_total_onu(file)
    r.set(f"progress:{task_id}", 20)

    # simulate your final data
    result_data = {"message": "Task completed!", "sum": 42}
    r.set(f"result:{task_id}", str(result_data))
    return "done"


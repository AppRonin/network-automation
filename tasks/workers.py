import os
import time
import redis
import dramatiq
from network_automation import broker
from utils.gpon_conversor import *
from django.core.files.storage import default_storage
import django

r = redis.Redis()

os.environ.setdefault("DJANGO_SETTINGS_MODULE","network_automation.settings")
django.setup()

@dramatiq.actor(store_results=True)
def gpon_conversor(task_id, file_path, port):
    try:
        # Get file content
        with default_storage.open(file_path, "r") as f:
            file = f.read()

        r.set(f"progress:{task_id}", 20)

        # Get total of onu interfaces
        total_onu = get_total_onu(file)
        r.set(f"progress:{task_id}", 40)
        time.sleep(2)

        # Build a list of new onu interfaces
        # Ex: [1/1/1:1 ... 1/1/1:10]
        onu_list = get_onu_list(total_onu, port)
        r.set(f"progress:{task_id}", 60)

        # build an dict with each onu interface and his conf
        onu_conf = get_onu_conf(file, onu_list)
        r.set(f"progress:{task_id}", 80)

        # build the template
        template = build_template(onu_conf)
        r.set(f"progress:{task_id}", 100)
    finally:
        if default_storage.exists(file_path):
            default_storage.delete(file_path)

    # simulate your final data
    result_data = {"template": template}
    r.set(f"result:{task_id}", str(result_data))
    return "done"


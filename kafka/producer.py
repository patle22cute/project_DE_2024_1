from confluent_kafka import Producer
import time
from random import uniform
import random
from datetime import datetime
import csv
import json

path = '~/final_project_2024/credit_card/credit_card_transactions.csv'

producer_config = {
    'bootstrap.servers':'localhost:9092',
    'client.id':'python-producer'
}

producer = Producer(producer_config)

topic = 'raw_data'

with open(path, 'r') as file:
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    reader = csv.reader(file)
    header = next(reader)

    for row in reader:
        data = dict(zip(header, row))
        json_data = json.dumps(data)
        producer.produce(topic, value=json_data.encode('utf-8'))
        time.sleep(uniform(1,3))

producer.flush()
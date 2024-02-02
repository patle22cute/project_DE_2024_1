from pyspark.sql import SparkSession
from pyspark.sql.functions import *
import os
from schema import *
from spark_function import *

KAFKA_ADDRESS = os.getenv("KAFKA_ADDRESS", 'localhost')
KAFKA_PORT = "9092"
GCP_GCS_BUCKET = os.getenv("GCP_GCS_BUCKET", 'final_project_2024')
GCS_STORAGE_PATH = f'gs://{GCP_GCS_BUCKET}'
LISTEN_EVENTS_TOPICS = "raw_data"
storage_path = f"{GCS_STORAGE_PATH}/{LISTEN_EVENTS_TOPICS}"
checkpoint_path = f"{GCS_STORAGE_PATH}/checkpoint/{LISTEN_EVENTS_TOPICS}"
trigger = "20 seconds"
output_mode = "append"
file_format = "csv"

spark = spark_session("datacourses")
stream = read_stream(spark, KAFKA_ADDRESS, KAFKA_PORT, LISTEN_EVENTS_TOPICS)
stream = process_stream(spark, schema[LISTEN_EVENTS_TOPICS])

# write_GCS = write_stream_to_GCS(stream, storage_path, checkpoint_path, trigger,output_mode, file_format)
# write_GCS.start()
write_console = write_stream_to_console(stream, trigger, output_mode)
write_console.start()

spark.stream.awaitAnyTermination()






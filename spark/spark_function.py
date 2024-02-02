from pyspark.sql import SparkSession
from pyspark.sql.functions import from_json, col 

def spark_session(app_name):
    # spark = SparkSession.builder.appName(app_name).master("spark://spark-master:7077").getOrCreate()
    spark = SparkSession.builder.appName(app_name).master("yarn").getOrCreate()
    return spark

def read_stream(spark, kafka_address, kafka_port, topic, starting_offset="earliest"):
    read_stream = (spark.readStream.format("kafka").option("kafka.bootstrap.server", f"{kafka_address}:{kafka_port}").option("failOnDataLoss", False).option("startingOffsets", starting_offset).option("subscribe", topic).load())
    return read_stream

def process_stream(stream, stream_schema):
    transformed_stream = (stream
                          .select(from_json(col("value").cast("string"),stream_schema).alias("data"))
                          .filter(col("data.`Is Fraud?`") == "No")
                          .filter(col("data.Errors?") == "")
                          .select(
                            col("data.User").alias("User"),
                            col("data.Card").alias("Card"),
                            col("data.Year").alias("Year"),
                            col("data.Month").alias("Month"),
                            col("data.Day").alias("Day"),
                            col("data.Time").alias("Time"),
                            col("data.Amount").alias("Amount"),
                            col("data.`Use Chip`").alias("Use_Chip"),
                            col("data.`Merchant Name`").alias("Merchant_Name"),
                            col("data.`Merchant City`").alias("Merchant_City"),
                            col("data.`Merchant State`").alias("Merchant_State"),
                            col("data.Zip").alias("Zip"),
                            col("data.MCC").alias("MCC")
                        )
                        )
    return transformed_stream

def write_stream_to_GCS(stream, storage_path, checkpoint_path, trigger, output_mode, file_format):
    write_stream = (stream
                    .writeStream
                    .format(file_format)
                    .partitionBy("Year", "Month", "Day")
                    .option("path", storage_path)
                    .option("checkpointLocation", checkpoint_path)
                    .trigger(processingTime=trigger)
                    .outputMode(output_mode))
    
    return write_stream

def write_stream_to_console(stream, trigger, output_mode):
    write_stream = (stream
                    .writeStream
                    .format("console")
                    .outputMode(output_mode)
                    .trigger(processingTime=trigger)
                    )
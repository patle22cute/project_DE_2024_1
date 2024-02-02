# Thực hiện kết nối đến VM - datacourses - spark
- ssh -i ./.ssh/gcp datacourses@External ID của VM trên GCP

# Tiến hành tải project về VM
- git clone https://github.com/patle22cute/final_project_2024.git

# Chuyển tiếp một cổng từ VM ra local machine

# Thiết lập các biến môi trường VM datacourses spark
- export KAFKA_ADDRESS=External IP của VM spark 
- export GCP_GCS_BUCKET=ID của project

# Cài đặt
- bash ~/final_project_2024/bash_setup/bash_spark.sh && exec newgrp docker

# Tiến hành chạy spark, 
- spark-submit --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2 ~/final_project_2024/spark/read_kafka.py

docker-compose exec spark-master /opt/spark/bin/spark-submit --master spark://spark-master:7077 --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2 /opt/spark-apps/py-spark/read_kafka.py

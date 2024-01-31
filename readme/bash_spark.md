# Thực hiện kết nối đến VM - datacourses - spark
- ssh -i ./.ssh/gcp datacourses@External ID của VM trên GCP

# Tiến hành tải project về VM
- git clone https://github.com/patle22cute/final_project_2024.git

# Chuyển tiếp một cổng từ VM ra local machine

# Thiết lập các biến môi trường VM datacourses spark
- export KAFKA_ADDRESS=External IP của VM spark 
- export GCP_GCS_BUCKET=ID của project

# Tiến hành chạy spark
- spark-submit --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.1.2 stream_all_events.py
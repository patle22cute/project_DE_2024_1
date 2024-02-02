# Thực hiện kết nối vào VM - datacourses - kafka
- ssh -i ./.ssh/gcp datacourses@External ID of VM in GCP

# Tiến hành clone final_project_2024
- git clone https://github.com/patle22cute/final_project_2024.git

# Tiến hành chạy cài đặt Docker, docker-compose và Anacoda
- bash ./final_project_2024/bash_setup/bash_vms.sh && exec newgrp docker

# Thiết lập các biến môi trường cho Kafka
- export KAFKA_ADDRESS=External IP of VM Kafka in GCP(If use kafka in local machine, KAFKA was 127.0.0.1)

# Chạy khởi động kafka
- cd final_project_2024/kafka
- docker-compose build 
- docker-compose up

# Chạy kafka producer
- cd ~/final_project_2024/kafka
- chmod +x scripts_run.sh
- bash ./scripts_run.sh
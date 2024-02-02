# Thực hiện kết nối vào Vm - datacourses - airflow
- ssh -i ./.ssh/gcp datacourses@

# Tiến hành clone final_project_2024
- git clone https://github.com/patle22cute/final_project_2024.git

# Tiến hành cài đặt Docker, Docker compose và Anacoda
- bash ./final_project_2024/bash_setup/bash_vms.sh && exec newgrp docker

# Tiến hành di chuyển gcp credential vào Vm
- 

# Thiết lập các biến môi trường cho Airflow 
- export GCP_PROJECT_ID=External IP of VM airflow
- export GCP_GCS_BUCKET = Name of 

# Tiếng hành cài đặt Airflow cho VM
- bash ~/final_project_2024/bash_setup/bash_airflow.sh 

# Forwarding port ở VS Code 

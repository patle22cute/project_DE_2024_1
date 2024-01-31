# Tạo khóa ssh để kết nối vào VM 
- Tạo khóa ssh trước khi tạo một máy ảo trên GCP
- ssh-keygen -t rsa -f gcp -C datacourses -b 2048 
- name: gcp
- user: datacourses
- thêm public key vào metadata trên Compute Engine

# Cách dùng private key để kết nối đến VM và tạo file config để thuận tiện cho việc kết nối 
- ssh -i ~/.ssh/name of private key Name of Vms@External IP of VMs
- ssh -i ~/.ssh/gcp datacourses@External IP of VMs
- htop: xem chi tiết VM (view VMs)
- touch ~/.ssh/config
- code ~/.ssh/config
- config to access VMs
- Host ABC
    HostName
    User
    IdentityFile
- connecting to VMs 
- ssh ABC 


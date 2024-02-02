#!/bin/bash

echo "Runing producer"
cd ~/final_project_2024/kafka

# conda activate myenv
sudo apt install python3-pip
pip3 install -r requirements.txt
python3 producer.py
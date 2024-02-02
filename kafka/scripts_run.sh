#!/bin/bash

echo "Runing producer"
cd ~/final_project_2024/kafka

# conda activate myenv
pip3 install -r requirements.txt
python3 producer.py
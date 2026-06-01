# AWS EC2 & CloudWatch Monitoring Infrastructure

This repository contains the deployment configurations for provisioning an EC2 compute instance paired with automated metric threshold monitoring using AWS CloudWatch and Simple Notification Service (SNS).

## ⚙️ Infrastructure Specifications
* **Region:** `us-east-1`
* **EC2 Instance Name:** `xfusion-ec2`
* **Operating System:** Ubuntu 22.04 LTS
* **Monitoring Alarm Name:** `xfusion-alarm`
* **Metric Target:** CPU Utilization >= 90% for 1 consecutive 5-minute period (300s)
* **Notification Target:** `xfusion-sns-topic`

## 🛠️ Deployment Steps

1. **Make the script executable:**
   ```bash
   chmod +x deploy-aws.sh

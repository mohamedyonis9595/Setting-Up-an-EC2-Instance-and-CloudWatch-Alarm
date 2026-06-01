#!/bin/bash

# 1. Get Ubuntu AMI ID
AMI_ID=$(aws ec2 describe-images --owners 099720109477 --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" "Name=state,Values=available" --query "Images[0].ImageId" --output text)

# 2. Launch EC2 Instance
INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=xfusion-ec2}]' --query "Instances[0].InstanceId" --output text)

# 3. Get pre-created SNS Topic ARN
SNS_ARN=$(aws sns list-topics --query "Topics[?contains(TopicArn, 'xfusion-sns-topic')].TopicArn" --output text)

# 4. Create CloudWatch Alarm
aws cloudwatch put-metric-alarm \
  --alarm-name xfusion-alarm \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold 90 \
  --comparison-operator GreaterThanOrEqualToThreshold \
  --evaluation-periods 1 \
  --dimensions Name=InstanceId,Value=$INSTANCE_ID \
  --alarm-actions $SNS_ARN

echo "Deployment complete! Instance ID: $INSTANCE_ID"

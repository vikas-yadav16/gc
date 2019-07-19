#!/bin/bash

gcloud compute instance-groups managed create vikas-group --size 1 --template vikas-template --zone us-central1-a

gcloud compute instance-groups managed set-autoscaling vikas-group --max-num-replicas 3 --target-load-balancing-utilization 0.5 --cool-down-period 30

gcloud compute instances create instance1 --image-family debian-9-stretch-v20190618 --image-project pe-training --zone us-central1-a --tags http-server --metadata startup-script="#!/bin/bash
	sudo apt update
	sudo apt install apache2
	sudo service apache2 start
	echo >/var/www/html/index.html
	echo '<!doctype html><html><body><h1>Hello I am $USER</h1></body></html>' | tee /var/www/html/index.html
	EOF"
gcloud compute firewall-rules create my-rule --target-tags http-server --allow tcp:80


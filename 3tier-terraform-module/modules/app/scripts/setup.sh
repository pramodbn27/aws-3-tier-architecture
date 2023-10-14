#!/bin/bash
sudo aws s3 cp s3://ed-eos-web-data/app.yaml  /tmp/app.yaml
sudo ansible-playbook /tmp/app.yaml
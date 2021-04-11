#!/bin/bash
docker system prune -f --volumes
docker pull yurchin23/imageapp_jenkins
docker-compose -f /home/ubuntu/app/docker-compose.yml up -d

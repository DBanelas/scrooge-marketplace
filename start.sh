#!/bin/bash
sudo docker compose --env-file ./eshop/.env down
sudo docker compose --env-file ./eshop/.env build
sudo docker compose --env-file ./eshop/.env up

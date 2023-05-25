# Purpose
This is meant to act as an example of how to embed a containerized CA inside of a docker network for use with an MQTT bus. The goal is to create the ability for disconnected deployments to generate and manage their own certs so that traffic on the MQTT bus can be properly TLS encrypted.

# Usage
1. fill in the `ca.env` files with the appropriate values for CA initialization
1. fill in the secrets files (by default: `.ca_password`, `.mqtt_password`, and `.mqtt_user`) with your preferred values
1. `docker compose up -d --build`
1. wait for the CA and mqtt containers to become healthy
1. use the `mosquitto_pub` and `mosquitto_sub` binaries from the client container to test functionality
```sh
mosquitto_pub -h server.mqtt.local -p 8883 -u $(cat /run/secrets/mqtt_user) -P $(cat /run/secrets/mqtt_pass) --tls-use-os-certs -t "enctest" -m "I'm Encrypted!"
``` 
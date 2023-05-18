#! /bin/sh
unset HISTFILE

touch /etc/mosquitto/passwd
touch /var/log/mosquitto.log
chown mosquitto:mosquitto /var/log/mosquitto.log
chown mosquitto:mosquitto /etc/mosquitto/passwd
./trust_ca.sh
certbot certonly --standalone --domains server.mqtt.local \
--register-unsafely-without-email \
--server https://ca.mqtt.local:8050/acme/acme/directory

# by design the path for lets encrypt certs is inaccessible
# copy certs to a location accessible by mosquitto and
# adjust config accordingly
mkdir /etc/mosquitto/certs
cp /etc/letsencrypt/live/server.mqtt.local/*.pem /etc/mosquitto/certs/
chown -R mosquitto:mosquitto /etc/mosquitto/certs/
mosquitto_passwd -b /etc/mosquitto/passwd $(cat /run/secrets/mqtt_user) $(cat /run/secrets/mqtt_pass)
/usr/sbin/mosquitto -v -c /etc/mosquitto/mosquitto.conf

# test with mosquitto_pub -h mqtt-server -u $(cat /run/secrets/mqtt_user) -P $(cat /run/secrets/mqtt_pass) -t "test" -m "Hats!"
# test with TLS mosquitto_pub -h server.mqtt.local -p 8883 -u $(cat /run/secrets/mqtt_user) -P $(cat /run/secrets/mqtt_pass) -t "enctest" -m "I'm Encrypted!"
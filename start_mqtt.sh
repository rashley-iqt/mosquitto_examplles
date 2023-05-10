#! /bin/sh
unset HISTFILE

touch /etc/mosquitto/passwd
touch /var/log/mosquitto.log
chown mosquitto:mosquitto /var/log/mosquitto.log
chown mosquitto:mosquitto /etc/mosquitto/passwd
mosquitto_passwd -b /etc/mosquitto/passwd $(cat /run/secrets/mqtt_user) $(cat /run/secrets/mqtt_pass)
/usr/sbin/mosquitto -v -c /etc/mosquitto/mosquitto.conf

# test with mosquitto_pub -h mqtt-server -u $(cat /run/secrets/mqtt_user) -P $(cat /run/secrets/mqtt_pass) -t "test" -m "Hats!"
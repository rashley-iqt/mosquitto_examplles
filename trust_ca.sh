#! /bin/sh

step ca bootstrap --ca-url https://ca:8050 --fingerprint $(curl http://ca:8051/fingerprint)
cp /root/.step/certs/root_ca.crt /usr/local/share/ca-certificates/ && \
update-ca-certificates

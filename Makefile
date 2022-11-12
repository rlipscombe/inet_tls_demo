run:
	./run.sh

CA_SUBJECT := /C=GB/L=London/O=differentpla.net/CN=differentpla.net inet_tls CA

certs: server.crt server.key

inet-tls-ca.crt inet-tls-ca.key:
	./scripts/certs self-signed \
		--out-cert inet-tls-ca.crt --out-key inet-tls-ca.key \
		--template root-ca \
		--subject "${CA_SUBJECT}"	

server.crt server.key: inet-tls-ca.crt inet-tls-ca.key
	./scripts/certs create-cert \
		--issuer-cert inet-tls-ca.crt --issuer-key inet-tls-ca.key \
		--out-cert server.crt --out-key server.key \
		--template server \
		--subject '/CN=server'

clean:
	rm -f *.crt *.key

OTHER_HOST ?= roger-nuc3

copy-certs:
	scp server.crt server.key "${OTHER_HOST}:$(shell pwd)"

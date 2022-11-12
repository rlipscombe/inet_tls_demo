run:
	./run.sh

CA_SUBJECT := /C=GB/L=London/O=differentpla.net/CN=differentpla.net inet_tls CA

certs: roger-nuc0.crt roger-nuc0.key roger-nuc3.crt roger-nuc3.key

inet-tls-ca.crt inet-tls-ca.key:
	./scripts/certs self-signed \
		--out-cert inet-tls-ca.crt --out-key inet-tls-ca.key \
		--template root-ca \
		--subject "${CA_SUBJECT}"	

roger-nuc0.crt roger-nuc0.key: inet-tls-ca.crt inet-tls-ca.key
	./scripts/certs create-cert \
		--issuer-cert inet-tls-ca.crt --issuer-key inet-tls-ca.key \
		--out-cert roger-nuc0.crt --out-key roger-nuc0.key \
		--template server \
		--subject '/CN=roger-nuc0'

roger-nuc3.crt roger-nuc3.key: inet-tls-ca.crt inet-tls-ca.key
	./scripts/certs create-cert \
		--issuer-cert inet-tls-ca.crt --issuer-key inet-tls-ca.key \
		--out-cert roger-nuc3.crt --out-key roger-nuc3.key \
		--template server \
		--subject '/CN=roger-nuc3'

clean:
	rm -f *.crt *.key

OTHER_HOST ?= roger-nuc3

copy-certs:
	scp "${OTHER_HOST}.crt" "${OTHER_HOST}.key" "${OTHER_HOST}:$(shell pwd)"

#!/bin/bash

export HOSTNAME="$(hostname -s)"

envsubst < inet_tls.conf.template > "inet_tls.$HOSTNAME.conf"

erl -sname demo -setcookie KMZWIWWTBVPEBURCLHVQ -proto_dist inet_tls -ssl_dist_optfile "$PWD/inet_tls.$HOSTNAME.conf"

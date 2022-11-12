#!/bin/bash

erl -sname demo -setcookie KMZWIWWTBVPEBURCLHVQ -proto_dist inet_tls -ssl_dist_optfile "$PWD/inet_tls.conf"

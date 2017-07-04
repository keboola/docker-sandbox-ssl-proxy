#!/bin/sh

sed -i -e 's/KEBOOLA_SANDBOX_PORT/'"$KEBOOLA_SANDBOX_PORT"'/g' /etc/nginx/conf.d/default.conf
nginx -g "daemon off;"
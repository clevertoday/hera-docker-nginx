#!/bin/bash

set -e


function setConfiguration() {
  KEY=$1
  VALUE=$2
  sed -i "s/{{$KEY}}/$VALUE/g" /etc/nginx/nginx.conf
}


if [ -n "${GRAFANA_HOST+1}" ]; then
  setConfiguration "GRAFANA_HOST" "$GRAFANA_HOST"
else
  setConfiguration "GRAFANA_HOST" "grafana"
fi

if [ -n "${GRAFANA_PORT+1}" ]; then
  setConfiguration "GRAFANA_PORT" "$GRAFANA_PORT"
else
  setConfiguration "GRAFANA_PORT" "80"
fi


if [ -n "${GRAPHITE_HOST+1}" ]; then
  setConfiguration "GRAPHITE_HOST" "$GRAPHITE_HOST"
else
  setConfiguration "GRAPHITE_HOST" "graphite"
fi

if [ -n "${GRAPHITE_PORT+1}" ]; then
  setConfiguration "GRAPHITE_PORT" "$GRAPHITE_PORT"
else
  setConfiguration "GRAPHITE_PORT" "80"
fi


if [ -n "${ES_HOST+1}" ]; then
  setConfiguration "ES_HOST" "$ES_HOST"
else 
  setConfiguration "ES_HOST" "graphite"
fi

if [ -n "${ES_PORT+1}" ]; then
  setConfiguration "ES_PORT" "$ES_PORT"
else
  setConfiguration "ES_PORT" "9200"
fi


if [[ "$1" == -* ]]; then
    set -- /usr/sbin/nginx "$@"
elif [ -z "$1" ]; then
    exec /usr/sbin/nginx
fi


exec "$@"

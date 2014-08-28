#!/bin/bash
set -ex

/usr/bin/riemann /etc/riemann/riemann.config &
riemann_pid=$!
sleep 10

pushd /etc/riemann-dash/
riemann-dash &
riemann_dash_pid=$!
popd

riemann-health
riemann_health_pid=$!

wait $riemann_pid
wait $riemann_dash_pid
# wait $riemann_health_pid


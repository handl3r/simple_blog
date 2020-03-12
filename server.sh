#!/bin/bash
set -e

rm -f /my_app/tmp/pids/server.pid

rails --version

rails server -b 0.0.0.0

#!/usr/bin/env bash
set -e

cat >> ansible.cfg <<\EOF
[defaults]
nocows = True
inventory = ./inventory.ini
interpreter_python = auto_silent
EOF

mkdir tasks
touch main.yml
touch example.inventory.ini

#!/bin/bash
# Start the SSH daemon
/usr/sbin/sshd

# Start ngrok
ngrok tcp 22 --log stdout --authtoken $NGROK_AUTHTOKEN

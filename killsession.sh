#!/bin/bash

PID=$(ps -ef |grep ucbbs-session.sh | grep "sh ucbbs-session.sh" | awk -F ' ' '{print $2}')
echo $PID
kill $PID
pkill tcpser

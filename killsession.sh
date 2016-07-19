#!/bin/bash

PID=$(ps -ef |grep bbs-session.sh | grep "sh bbs-session.sh" | awk -F ' ' '{print $2}')
echo $PID
kill $PID
pkill tcpser

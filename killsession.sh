#!/bin/bash

PID=ps -ef |grep bbs-session-new.sh | grep "?" | awk -F ' ' '{print $2}'

kill $PID

#!/bin/bash

mv filelist.txt filelist-old.txt

bash dirlist.sh > filelist.txt

diff filelist.txt filelist-old.txt



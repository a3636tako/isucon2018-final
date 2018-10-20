#!/bin/bash

log_path=/home/isucon/isucon2018-final/webapp/mysql/log/slow.log
sudo rm $log_path

echo 'Reloading daemon...'
sudo systemctl daemon-reload

echo 'Restarting isucon...'
sudo systemctl restart isucoin

echo 'Done!'


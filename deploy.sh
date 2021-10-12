#!bin/bash

cd reddit && bundle install
puma -d
ps aux | grep puma

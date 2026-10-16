#!/bin/bash
file_name=$1
cat $file_name | while read i j k; do bash zip_n_send.sh $i $j $k; done
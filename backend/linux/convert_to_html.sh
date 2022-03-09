#!/bin/bash
# /bin/bash ./convert_to_html.sh > /tmp/op.html
# cp /tmp/user.csv /tmp/output.csv
awk 'NR<3' /tmp/output.csv > /tmp/op1.csv
awk 'NR>2' /tmp/output.csv > /tmp/op2.csv
sort -t";" -nr -k3 /tmp/op2.csv > /tmp/op3.csv
cat /tmp/op1.csv /tmp/op3.csv > /tmp/op.csv
cp ./format.css /tmp/format.css
awk -f ./convert_to_html.awk /tmp/op.csv

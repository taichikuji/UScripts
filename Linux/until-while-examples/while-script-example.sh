#!/bin/bash

counter=0

while [[ "$counter" -lt "6" ]]; do
  echo "Contador: $counter"
  let counter=counter+1
done

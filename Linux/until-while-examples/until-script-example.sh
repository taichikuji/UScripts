#!/bin/bash

counter=0

until [[ "$counter" -gt "5" ]]; do
  echo "Contador: $counter"
  let counter=counter+1
done

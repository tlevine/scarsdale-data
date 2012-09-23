#!/bin/sh

for thing in downloads/*/*
  do
  echo $thing | grep '\.pdf$' > /dev/null && continue
  file $thing | grep PDF > /dev/null && mv $thing{,.pdf} && continue
  file $thing
done

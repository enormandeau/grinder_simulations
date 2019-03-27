#!/bin/bash

# Remove results
rm -r 04_outputs/* 2>/dev/null

# Remove logs
rm -r 99_logfiles/* 2>/dev/null

# Remove vim savefiles
find . | grep "~$" | parallel rm

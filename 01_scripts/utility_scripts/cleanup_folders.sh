#!/bin/bash

# Remove results
rm -r 04_outputs/*

# Remove logs
rm -r 99_logfiles/*

# Remove vim savefiles
find . | grep "~$" | parallel rm

# Display folders
tree

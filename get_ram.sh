#!/bin/bash

# Fetch the free RAM information using the 'free' command
free_ram=$(free | awk '/^Mem:/{print $4}')

# Print the free RAM value
echo "Free RAM: $free_ram kB"

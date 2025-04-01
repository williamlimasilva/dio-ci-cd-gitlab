#!/bin/bash
set -e

echo "Running tests..."
echo "Current directory:"
pwd

echo "Listing files in current directory:"
ls || { echo "Error: Unable to list files."; exit 1; }

echo "System Information:"
if cat /etc/os-release; then
  echo "OS information displayed successfully."
else
  echo "Error: Unable to read /etc/os-release"
  exit 1
fi

echo "Creating 'pipeline' directory if it doesn't exist..."
mkdir -p pipeline && echo "Directory 'pipeline' is ready."

echo "Listing files again after creating the directory:"
ls

echo "Script execution completed successfully!"

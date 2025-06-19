#!/bin/bash

parameter=$1
START_TIME=$(date +%s.%N)

if [ $# -ne 1 ]; then
echo "Error: The script is run with exactly one parameter."
exit 1
fi

if ! [ ${parameter: -1} = / ]; then 
echo "Error: Invalid syntax"
exit 1
fi

if ! [ -d $parameter ]; then
echo 'Error: No directory'
exit 1
fi

echo "Total number of folders (including all nested ones) = $(ls -lR "$parameter" | grep -E '^-' | wc | awk '{print $1}')"
echo "TOP 5 folders of maximum size arranged in descending order (path and size): "
echo "$(find "$parameter"* -type d -exec du -h {} +| sort -nr | head -n 5 | awk '{ print NR " - " $2 ", " $1 }')"
echo "etc up to 5"
echo "Total number of files = $(ls -lR "$parameter" | grep -E '^-' | wc | awk '{print $1}')"
echo "Number of:  "
echo "Configuration files (with the .conf extension) = $(ls -lR "$parameter" | grep -E '*.conf' | wc -l)"
echo "Text files = $(ls -lR "$parameter" | grep -E '*.txt' | wc -l)"
echo "Executable files = $(find "$parameter" -type f -executable | wc -l)"
echo "Log files (with the extension .log) = $(ls -lR "$parameter" | grep -E '*.log' | wc -l)"
echo "Archive files = $(ls -lR "$parameter" | grep -E '*.tar|*.zip|*.rar|*.gz' | wc -l)"
echo "Symbolic links = $(find "$parameter" -type l | wc -l)"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"  
echo "$(find "$parameter"* -type f -exec du -ah {} + | sort -rh | head | awk '{print NR " - " $1 ", " $2}' | while read -r line; do
file=$(echo "$line" | awk '{print $4}')
file_type=$(file -b "$file")
echo "$line, $file_type"
done)"  
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"  
echo "$(find "$parameter"* -type f -executable -exec du -ah {} + | sort -rh | head | awk '{print NR " - " $1 ", " $2}' | while read -r line; do
file=$(echo "$line" | awk '{print $4}')
hash=$(md5sum "$file" | awk '{print $1}')
echo "$line, $hash"
done)"
echo "etc up to 10" 
END_TIME=$(date +%s.%N)
difference=$(echo "$END_TIME - $START_TIME" | bc -l)
echo "Script execution time (in seconds) = $difference"
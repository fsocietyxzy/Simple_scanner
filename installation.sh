#!/bin/bash

# Subdomain enumeration

echo "Starting subdomain enumeration..."
sublist3r -d example.com -o domain_list.txt

echo "Subdomain enumeration done."

# Vulnerability finding

echo "Starting vulnerability finding..."

# Script will go through the list and check for the vulnerabilities
while IFS= read -r line
do
  echo "Checking for XSS vulnerability in $line"
  xssmap -u $line -t 3
  echo "Checking for SQL injection vulnerability in $line"
  sqlmap -u $line --dbs
  echo "Checking for SSTI vulnerability in $line"
  ssti-scanner -u $line
  echo "Checking for LFI vulnerability in $line"
  lfi-scanner -u $line
  echo "Checking for Nuclei & Templates in $line"
  nuclei -t templates/all -url $line
done < domain_list.txt

echo "Vulnerability finding done."

echo "Bye Dude."

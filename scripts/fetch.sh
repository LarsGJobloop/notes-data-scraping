#!/bin/bash

# Initial setup
query=$QUERY
api_base=$API_BASE
token=$TOKEN
RESPONSE_DIR="response"
mkdir -p ${RESPONSE_DIR}

# Keep track of the current page
page=0

# Fetch the first page
echo "Fetching first page"
curl -s -H "Authorization: Bearer ${token}" "${api_base}?${QUERY}&page=${page}" | jq > "${RESPONSE_DIR}/response-${page}.json"

# Read the 'last' field from the JSON
is_last=$(jq '.last' "${RESPONSE_DIR}/response-${page}.json")

echo "Total pages: $(jq '.totalPages' "${RESPONSE_DIR}/response-${page}.json")"

# Loop until 'last' field is true
while [[ $is_last != "true" ]]; do
  ((page++)) # Increment the page number
  echo "Fetching page: ${page}"
  curl -s -H "Authorization: Bearer ${token}" "${api_base}?${QUERY}&page=${page}" | jq > "${RESPONSE_DIR}/response-${page}.json"
  is_last=$(jq '.last' "${RESPONSE_DIR}/response-${page}.json") # Update the 'last' field from new response
  sleep 2 # Sleep for a second to prevent API rate limits
done

echo "All pages have been retrieved."

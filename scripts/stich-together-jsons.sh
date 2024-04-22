#!/bin/bash

RESPONSE_DIR="response"
COMBINED_DIR="combined"
mkdir -p ${COMBINED_DIR}

# Initialize an empty array to hold all the data
echo '[]' > "${COMBINED_DIR}/combined.json"

# Loop through all JSON files in the specified directory
for file in "${RESPONSE_DIR}"/*.json; do
  jq -s '.[0] + [.[1].content[]]' "${COMBINED_DIR}/combined.json" "$file" > "${COMBINED_DIR}/temp.json" && mv "${COMBINED_DIR}/temp.json" "${COMBINED_DIR}/combined.json"
done

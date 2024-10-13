#!/bin/bash

# Base directory containing JSON files
BASE_DIR="smoketester_newman/resources/tsys/uat/us"
# Output directory for CSV files
OUTPUT_DIR="skipSMTest_csv"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Function to process each JSON file
process_json_file() {
    local json_file=$1
    local csv_file=$2

    # Extract the required fields from JSON where skipTestCase is false
    jq -r '.[] | select(.skipTestCase == "false") | [.clientid, .skipTestCase, .statuscode, .url] | @csv' "$json_file" >> "$csv_file"
}

# Recursively find JSON files in the directory
find "$BASE_DIR" -type f -name "*.json" | while read json_file; do
    # Extract the name of the JSON file without the directory and extension
    base_name=$(basename "$json_file" .json)

    # Create the CSV file in the output directory based on the JSON file name (e.g., abc.json -> output_csv/abc.csv)
    csv_file="$OUTPUT_DIR/${base_name}.csv"

    # Write the CSV header if the file doesn't exist
    if [[ ! -f "$csv_file" ]]; then
        echo "clientId,skipTestCase,statuscode,url" > "$csv_file"
    fi

    # Process the JSON file and append the result to the corresponding CSV
    process_json_file "$json_file" "$csv_file"

    echo "Processed $json_file -> $csv_file"
done

echo "CSV files have been generated in the $OUTPUT_DIR directory."

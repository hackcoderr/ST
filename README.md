8```
echo -e "\033[0;34mReady node: $(kubectl get nodes | grep -c ' Ready ')\033[0m"
echo -e "\033[0;34mNot ready node: $(kubectl get nodes | grep -c ' NotReady ')\033[0m"
echo -e "\033[0;34mCordon node: $(kubectl get nodes | grep -c 'schedulingDisabled')\033[0m"

```

```

```
#!/bin/bash

workspace="/var/lib/jenkins/workspace/Invo_ST"
resources_dir="$workspace/resources/sachin/prod/us"
skip_tests_dir="$workspace/skip_tests"
count_dir="$workspace/count"
csv_dir="$workspace/csv"

# Create necessary directories
mkdir -p "$skip_tests_dir"
mkdir -p "$csv_dir"
mkdir -p "$count_dir"

for value in "$resources_dir"/*; do
  total_length=0
  count_file="$count_dir/$(basename "$value")_count"

  for file in "$value"/data/*.json; do
    len=$(jq length "$file")
    total_length=$((total_length + len))
    
    if jq -e '.skipTestCase == "true"' "$file" >/dev/null; then
      jq '[select(.skipTestCase == "true")]' "$file" >> "$skip_tests_dir/$(basename "$value")_skip.json"
    fi
  done

  echo "$total_length" > "$count_file"
done

for json_value in "$skip_tests_dir"/*; do
  csv_file="$json_value.csv"
  header="ClientID,AppID,SkipTestCase,Expected,Response,Endpoint"

  jq -r '[.clientId, .appId, .skipTestCase, .statusCode, .url] | @csv' "$json_value" > "$csv_file"
  sed -i "1s;^;$header\n;" "$csv_file"
done

```

This script will extract the lines containing "skipped" from the console output, save them to a CSV file called `st_audit_file.csv`, and print a message indicating that the data has been saved to the file.


```
```
```
// Google Apps Script code.gs

function updateSheet(validation, yesNo) {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var lastRow = sheet.getLastRow() + 1;
  sheet.getRange(lastRow, 1).setValue(validation);
  sheet.getRange(lastRow, 2).setValue(yesNo);
}

function getData() {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var data = sheet.getDataRange().getValues();
  return data;
}

```
```
<!-- index.html -->
<!DOCTYPE html>
<html>
<head>
  <title>Simple Table</title>
</head>
<body>
  <table>
    <tr>
      <th>Validation</th>
      <th>Yes/No</th>
    </tr>
    <tr>
      <td>Some Data</td>
      <td>
        <select id="yesNo">
          <option value="Yes">Yes</option>
          <option value="No">No</option>
        </select>
      </td>
    </tr>
  </table>

  <script>
    document.getElementById('yesNo').addEventListener('change', function() {
      var validation = 'Some Data'; // Get validation data
      var yesNo = this.value;
      google.script.run.updateSheet(validation, yesNo);
    });
  </script>
</body>
</html>
```

```
#!/bin/bash

# Define variables for repeated paths
RESOURCES_DIR="resources/tsys/uat/us"
SKIP_TESTS_DIR="./audit/skip_tests"
CSV_DIR="./audit/SDC_UAT"
EXCEL_DIR="./audit/excel"

# Deleting the skip tests and csv directories
rm -rf $SKIP_TESTS_DIR
rm -rf $CSV_DIR

# Create the directories
mkdir -p "$SKIP_TESTS_DIR"
mkdir -p "$CSV_DIR"

# Initialize the final report CSV file with headers
REPORT_FILE="$CSV_DIR/skip_test_report.csv"
printf "Application Name, Skipped Test Cases, Total Test Cases\n" > "$REPORT_FILE"

# Loop through each directory in the resources folder
for value in $(ls "$RESOURCES_DIR"); do
    total_tests=0
    skipped_tests=0

    # Loop through each JSON file in the data directory
    for file in $RESOURCES_DIR/$value/data/*.json; do
        # Get the length of the JSON file (total test cases)
        len=$(jq '. | length' "$file")
        total_tests=$((total_tests + len))

        # Get the application name from the filename (e.g., auth.json -> auth)
        app_name=$(basename "$file" .json)

        # Check for skipped test cases in the file and store them
        if jq '.[] | select(.skipTestCase == true)' "$file" > $SKIP_TESTS_DIR/"$value"_"$app_name"_SkipTestCase.json; then
            skipped=$(jq '. | length' $SKIP_TESTS_DIR/"$value"_"$app_name"_SkipTestCase.json)
            skipped_tests=$((skipped_tests + skipped))
        fi
    done

    # Log results in the report file (Application Name, Skipped Test Cases, Total Test Cases)
    echo "$app_name, $skipped_tests, $total_tests" >> "$REPORT_FILE"
done

# Final message
echo "Smoke Test Audit is Completed and saved in $REPORT_FILE"
```

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
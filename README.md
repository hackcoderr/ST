```
import jenkins
import sys

# Jenkins server information
jenkins_url = 'http://your-jenkins-server-url'
jenkins_username = 'your-username'
jenkins_password = 'your-password'

# Job name
job_name = 'first_pipeline'

# Connect to Jenkins
server = jenkins.Jenkins(jenkins_url, username=jenkins_username, password=jenkins_password)

# Get the latest build number of the first_pipeline job
latest_build = server.get_job_info(job_name)['lastBuild']['number']

# Get the console output of the latest build
try:
    console_output = server.get_build_console_output(job_name, latest_build)
    if "skipped=true" in console_output:
        # Print the lines containing "skipped=true"
        lines = console_output.split('\n')
        skipped_lines = [line for line in lines if "skipped=true" in line]
        for line in skipped_lines:
            print(line)
    else:
        print("No 'skipped=true' found in console output.")
except jenkins.JenkinsException as e:
    print(f"Error: {str(e)}")
   
```

```
#!/bin/bash

# Jenkins server information
jenkins_url="http://your-jenkins-server-url"
jenkins_username="your-username"
jenkins_password="your-password"

# Job name
job_name="first_pipeline"

# Jenkins API URL to get the latest build info
build_info_url="${jenkins_url}/job/${job_name}/lastBuild/api/json"

# Jenkins API URL to get the console output of the latest build
console_output_url="${jenkins_url}/job/${job_name}/lastBuild/consoleText"

# Function to fetch data from Jenkins API with authentication
fetch_data() {
    local url="$1"
    curl -s --user "${jenkins_username}:${jenkins_password}" "$url"
}

# Get the latest build info
build_info=$(fetch_data "$build_info_url")

if [ -n "$build_info" ]; then
    # Get the build number of the latest build
    latest_build_number=$(echo "$build_info" | jq -r '.number')

    # Get the console output of the latest build
    console_output=$(fetch_data "$console_output_url")

    if echo "$console_output" | grep -q "skipped=true"; then
        # Print the lines containing "skipped=true"
        skipped_lines=$(echo "$console_output" | grep "skipped=true")
        echo "Found 'skipped=true' in console output:"
        echo "$skipped_lines"
    else
        echo "No 'skipped=true' found in console output."
    fi
else
    echo "Failed to fetch build info."
    exit 1
fi

```


```

#!/bin/bash

# Jenkins server information
jenkins_url="http://your-jenkins-server-url"
jenkins_username="your-username"
jenkins_password="your-password"

# Job name
job_name="first_pipeline"

# Jenkins API URL to get the console output of the latest build
console_output_url="${jenkins_url}/job/${job_name}/lastBuild/consoleText"

# Function to fetch data from Jenkins API with authentication
fetch_data() {
    local url="$1"
    curl -s --user "${jenkins_username}:${jenkins_password}" "$url"
}

# Get the console output of the latest build
console_output=$(fetch_data "$console_output_url")

if echo "$console_output" | grep -q "skipped=true"; then
    # Print the lines containing "skipped=true"
    skipped_lines=$(echo "$console_output" | grep "skipped=true")
    echo "Found 'skipped=true' in console output:"
    echo "$skipped_lines"
else
    echo "No 'skipped=true' found in console output."
fi

grep -B1 'skipped' test.txt | sed -n '/\[[0-9]\+\]/s/.*\(\[[0-9]\+\]\).*/\1/p'
```

```
grep -C1 "skipped" test.txt | grep -oE 'GET .*\[([0-9]+)\]' | sed 's/GET //;s/\[//;s/\]//' | awk '{print $2}'
```
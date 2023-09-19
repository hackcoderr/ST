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
    sys.exit(1)
```

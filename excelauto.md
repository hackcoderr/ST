```
function sendExcelFiles() {
  // Define the folder where the Excel files are stored
  var folder = DriveApp.getFolderById('drive-folder-id'); // Use the ID of your devops/excelauto folder
  var files = folder.getFiles(); // Get all files in the folder
  
  // Define the email mappings for the teams
  var teamEmails = {
    "sachin.xlsx": "anl@gmail.com",
    "anustha.xlsx": "awsan.demo@gmail.com",
    "ginger.xlsx": "al20000@gmail.com"
    // Add more file-to-email mappings here
  };
  
  // Iterate over the files in the folder
  while (files.hasNext()) {
    var file = files.next();
    var fileName = file.getName();
    
    // Check if the file has a corresponding team email
    if (teamEmails.hasOwnProperty(fileName)) {
      var recipient = teamEmails[fileName];
      
      // Send email with the file attached
      GmailApp.sendEmail(recipient, 
                         "Excel File: " + fileName, 
                         "Hi team,\n\nPlease find attached the file: " + fileName + ".", 
                         {
                           attachments: [file.getAs(MimeType.MICROSOFT_EXCEL)]
                         });
      
      Logger.log('Sent ' + fileName + ' to ' + recipient);
    } else {
      Logger.log('No team found for file: ' + fileName);
    }
  }
}
```

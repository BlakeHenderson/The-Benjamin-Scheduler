The Benjamin Scheduler
==================
Version 1.0
=================
This version is designed to extract a text from the PDF of The Benjamin School Schedule. It then extracts the users
information from a MYSQL Database (Name, Phone Number, Carrier). It would send the
schedule to each user that signed up (Via. Website). The Schedule will arrive at a set time (6:45, 7:00, 7:15, 7:30). 

  - Extracts Text from a PDF File (Benjamin Scheduler)
  - Reterieves MYSQL Data from Database (User Info - Phone, Name, Carrier)
  - Sends a Email Via. Gmail Account
  
  **Know Bugs**
  - PDF extractor crashes when given a unknown day (Not Realtive to Algorithm) 
  - Only can send a message every 3 - 5 seconds (Caused by Google Email)

Version 2.0
=================
  - Now no longer uses a PDF File to extract information. A .txt from a CVS file is used in it's place. This CVS file is      created from an Excel file where the information is formmated. The format of the Excel file is as follows:
    1. The data is formated in two parts: The dates and their respective cycle number (From here known as [1]) and the           cycle number and the schedule for that cycle number (From here known as [2]).
    2. [1] must go in that order in the Excel file and they must also be presented
      in a higer row than [2].
    3. The cycle number is simply followed by the schedule
    4. Everything must be "tagged" such that at some point in each row there must be a symbol to represent which part of         the data it is (As of Version 2.0, the tags are "!" and "@" for [1] and [2] respectively).
    5. Here is an example of how the data is formatted in Excel. Each new line represents a new row and each "|"                 represents a new column (Anything in brackets represents a comment)

2/4/14 | 14 | !                     [This is [1]]

2/5/14 | 15 | !                     [This is [1]]

14 | A | B | C | D | @              [This is [2]]

15 | C | D | E | F | G | A | B | @  [This is [2]]


  - Restructured the entire program to work for the new formation of the data.
  - Restructured the text message system and database config
  
 Version 3.0
=================

The Original Text Message Version is now a fully developed mobile application (iOS). This application integrates the school news, lunch schedule, and announcements. This allows the users to access their schedule and future schedules for the entire week. The Application uses Swift and Objective-C. 

Written in Swift 2

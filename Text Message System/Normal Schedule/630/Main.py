#Eric Rosen and Blake Henderson
#Feburary 4, 2014

"""
This code outputs the schedule for a given day. The main method requires a number of how many
days in advance from the current day (main(1) gives the schedule for tomorrow). The output will
be either three things:
1) If the day inputted is a weekday where there is school, it will output the schedule
2) If the day inputted is a weekday where there is no school, it will output "NO SCHOOL"
3) If the day inputted is a weekend, it will return "NO SCHOOL: WEEKEND"

By default, giving no parameters to the main method will output the scheudle for today
"""

#Import Python Files
import datetime
import time
import sys
import MYSQLData
from SendEmail import sendEmail
import MySQLdb
#Main Function
def getSchedule(daysAhead=0): #Input how many
    today = datetime.date.today() + datetime.timedelta(days = daysAhead) #Get the date depending on the daysAhead
    todaysDate = str(today.month) + "/" + str(today.day) + "/" + str(today.year)[2:] #Puts the date into proper format
    myDic = {} #Creates a dictionary to hold all the cycles
    output = ""
    f = open("Scheduler.txt","rb") 
    data = f.read() 
    data = data.split("\r") 
    for line in data: 
        line = line.split(",")
        line = filter(None, line)
        if "!" in line: #These are dates and their cycle number
            line = line[:-1] #Gets rid of the tag
            if todaysDate in line:  #This is the correct date and cycle number
                output =  myDic[str(line[1])]
        if "@" in line: #These are the cycle number's periods
            line = line[:-1] #Gets rid of tag
            myDic[line[0]] = line[1:]
    if len(output) > 1:
        temp = ""
        for period in output:
            temp += period + "\n"
        return temp[:-1]
    if len(output) == 1:
        return output[0]
    else:
        return "NO SCHOOL: WEEKEND"

def Main():
    """Compiles the Final Scheduler to be sent out via. Text Message"""
    
    #Retrieves the Current Days Schedule
    daySchedule = getSchedule()
    
    #Prints Schedule
    print "Todays Schedule Is: " + "\n" + daySchedule + "\n" 
    #Sends Email
    sendEmail(daySchedule)

Main()

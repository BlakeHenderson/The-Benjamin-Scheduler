#Blake Henderson
#January 30, 2014
#Edited on Feburary 2, 2014


#Import Functions
import smtplib
import MYSQLData
from MYSQLData import retrievePhoneData
from MYSQLData import retrieveCarrierData
from MYSQLData import retrieveFirstNameData
import datetime
import time
import MySQLdb

#Send Email Function
def sendEmail(msg):
    print "Starting Send Text Function" + "\n"
    
    #Checking the Validity of the Schedule
    if "NO SCHOOL" in msg:
	return 
    
    #Define Variables
    currentDate = str(datetime.date.today().strftime("%A, %B %d, %Y"))
    userPhone = retrievePhoneData()
    userCarrier = retrieveCarrierData()
    userName = retrieveFirstNameData()
    Carrier = ""

    #Login Information for Email
    username = 'benjaminscheduler.645@gmail.com'  
    password = ''

    #Login to Google Servers
    server = smtplib.SMTP('smtp.gmail.com:587')
    server.starttls()  
    server.login(username,password)
 
    for x in range(len(userName)):
        if " ".join(userCarrier[x])  == "Verizon":
            Carrier = "@vtext.com"
        elif " ".join(userCarrier[x]) == "ATT":
            Carrier =  "@txt.att.net"
        elif " ".join(userCarrier[x]) == "T-Mobile":
            Carrier = "@tmomail.net"
        elif " ".join(userCarrier[x]) == "Sprint":
            Carrier = "@pm.sprint.com"
        elif " ".join(userCarrier[x]) == "Virgin-Mobile":
            Carrier = "@vmobl.com"
        elif " ".join(userCarrier[x]) == "MetroPCS":
            Carrier = "@mymetropcs.com"
        
        sendUserName = " ".join(userName[x])
        sendPhone = " ".join(userPhone[x])
        
        fromaddr = 'benjaminscheduler.645@gmail.com'
        toaddrs  = str(sendPhone) + str(Carrier)

        sendMsg = "Hi, " + str(sendUserName) + "\n" + "Here is the Schedule For: " + "\n" + str(currentDate) + "\n" + "==================" + "\n" + msg 
        print "Sending Schedule to: " + str(sendUserName) + "\n" + "Phone Number: " + str(sendPhone) 
    #Send Mail
        server.sendmail(fromaddr, toaddrs, sendMsg)
        time.sleep(10)
        print "Succesfully Sent to: " + str(sendUserName) + "\n"
    server.close()

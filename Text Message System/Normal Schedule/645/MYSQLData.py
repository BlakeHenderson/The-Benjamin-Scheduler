#Blake Henderson
#January 30, 2014

#MYSQLData
import MySQLdb
#Retrieve the First Name from the Database

def retrieveFirstNameData():
    """Takes Name from Database and Returns it"""
    connection = MySQLdb.connect (host = "localhost", user = "root", passwd = "", db = "")
    cursor = connection.cursor ()
    cursor.execute ("SELECT `firstName` FROM `textMemberInfo` WHERE `sendTime`=645")
    firstName = cursor.fetchall ()
    cursor.close ()
    connection.close ()

    return firstName


#Retrieve the Last Name from the Database

def retrieveLastNameData():
    """Takes Name from Database and Returns it"""
    connection = MySQLdb.connect (host = "localhost", user = "root", passwd = "", db = "")
    cursor = connection.cursor ()
    cursor.execute ("SELECT `lastName` FROM `textMemberInfo` WHERE `sendTime`=645")
    lastName = cursor.fetchall ()
    cursor.close ()
    connection.close ()

    return lastName

#Retrieve the Phone Number from the Database

def retrievePhoneData():
    """Takes Name from Database and Returns it"""
    connection = MySQLdb.connect (host = "localhost", user = "root", passwd = "", db = "")
    cursor = connection.cursor ()
    cursor.execute ("SELECT `phoneNumber` FROM `textMemberInfo` WHERE `sendTime`=645")
    phone = cursor.fetchall ()
    cursor.close ()
    connection.close ()

    return phone

#Retrieve the Carrier from the Database and parse accordingly

def retrieveCarrierData():
    """Takes Name from Database and Returns it"""
    connection = MySQLdb.connect (host = "localhost", user = "root", passwd = "", db = "")
    cursor = connection.cursor ()
    cursor.execute ("SELECT `carrier` FROM `textMemberInfo` WHERE `sendTime`=645")
    data = cursor.fetchall ()
    cursor.close ()
    connection.close ()
    
    return data

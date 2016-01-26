#Blake Henderson and Eric Rosen
#April 9th, 2014

import datetime
import time
import MySQLdb

def main():
    """Runs the Main Function"""
    #Remove All of the Information from the Database table (Previous Day)
    databaseRemove()
    
    todayLunch = "No Lunch Today" #lunchSchedule()

    #Run  the function that inserts the current days lunch schedule
    databaseInsert(todayLunch)

def lunchSchedule():
    """Gets the Current Days Lunch Schedule"""
    #Gets the Current Day 
    currentDate = str(datetime.date.today().strftime("%A"))

    if currentDate == "Monday":
	return "Todays Lunch is: Meatball Subs, Turkey Subs, Pasta, and Caesar Salad with a 1/2 Chicken Wrap from Carmine's"
    elif currentDate == "Tuesday":
        return "Todays Lunch is: Pepperoni Rolls from Sal's Express and Pasta Chicken Dish and Chicken Caesar Salad from CR Chicks"
    elif currentDate == "Wednesday":
        return "Todays Lunch is: 1/2 Subs from Publix"
    elif currentDate == "Thursday":
        return "Todays Lunch is: Chicken Sandwiches and Chicken Nuggets from Chick-Fil-A"
    elif currentDate == "Friday":
        return "Todays Lunch is: Pizza from Papa John's"
    elif currentDate == "Saturday":
        return "No Lunch Today"
    elif currentDate == "Sunday":
	return "No Lunch Today"
	
    print currentDate
def databaseInsert(schedule):
    """Inserts the Current Days Schedule to Database"""
    print "Running Connection"   
    db = MySQLdb.connect (host = "localhost", user = "root", passwd = "", db = "")
    print "Cursor Execute"
    c = db.cursor()
    print "Running SQL Command"
    c.execute(
        """INSERT INTO `todayLunch`(`lunch`) VALUES (%s)""",
        (schedule))    
    db.commit()
    db.close()

def databaseRemove():
    """Removes all of the current informaiton inside of a database"""
    print "DELETING ALL"
    db = MySQLdb.connect (host = "localhost", user = "root", passwd = "", db = "")
    c = db.cursor()
    c.execute("""DELETE FROM todayLunch""")
    db.commit()

main()

import mysql.connector 
from mysql.connector import errorcode

import dotenv
from dotenv import dotenv_values

secrets = dotenv_values(".env")

#database config object
config = {
    "user": secrets["USER"],
    "password": secrets["PASSWORD"],
    "host": secrets["HOST"],
    "database": secrets["DATABASE"],
    "raise_on_warnings": True #not in .env file
}

try:
    # try/catch block for handling potential MySQL database errors

    db = mysql.connector.connect(**config) 
    
    # output the connection status 
    print("\n  Database user {} connected to MySQL on host {} with database {}".format(config["user"], config["host"], config["database"]))

    input("\n\n  Press any key to continue...")

except mysql.connector.Error as err:
    # """ on error code """

    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("  The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("  The specified database does not exist")

    else:
        print(err)

cursor = db.cursor()


cursor.execute("SELECT studio_id, studio_name FROM studio")
query = cursor.fetchall()
print("--  DISPLAYING Studio RECORDS --")
for id in query:
    print(f"STUDIO ID: {id[0]} \nStudio Name: {id[1]}\n")



cursor.execute("SELECT genre_id, genre_name FROM genre")
query = cursor.fetchall()
print("-- DISPLAYING Genre RECORDS --")
for id in query:
    print(f"GENRE ID: {id[0]} \nGenre Name: {id[1]}\n")





cursor.execute("Select film_name, film_runtime FROM film WHERE film_runtime < 120")
query=cursor.fetchall()
print("-- DISPLAYING Short Film RECORDS --")
for id in query:
    print(f"Film Name: {id[0]} \nFilm RunTime {id[1]}\n")




cursor.execute("Select film_name, film_director FROM film")
query=cursor.fetchall()
print("-- DISPLAYING Short Film Directors --")
for id in query:
    print(f"Film Name: {id[0]} \nFilm Director {id[1]}\n")





# finally:
db.close()
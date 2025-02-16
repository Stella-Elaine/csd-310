import mysql.connector 
from mysql.connector import errorcode
import dotenv
from dotenv import dotenv_values

secrets = dotenv_values(".env")

secrets = dotenv_values(".env")

def db_connect():
#database config object
    config = {
        "user": secrets["USER"],
        "password": secrets["PASSWORD"],
        "host": secrets["HOST"],
        "database": secrets["DATABASE"],
        "raise_on_warnings": True #not in .env file
    }
    try:
        db = mysql.connector.connect(**config) 
        print("\n  Database user {} connected to MySQL on host {} with database {}".format(config["user"], config["host"], config["database"]))
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("  The supplied username or password are invalid")

        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("  The specified database does not exist")

        else:
            print(err)
    return db

def show_films(cursor, title):
    db = cursor
    cursor = db.cursor()
    cursor.execute("select film_name as Name, film_director as Director, genre_name as Genre, studio_name as 'Studio Name' FROM film INNER JOIN genre on film.genre_id=genre.genre_id INNER JOIN studio ON film.studio_id=studio.studio_id")
    films = cursor.fetchall()
    print(f"-- {title} --")
    for film in films:
        print(f"Film Name: {film[0]}\nDirector: {film[1]}\nGenre Name ID: {film[2]}\nStudio Name: {film[3]}\n")

def insert_films(cursor):
    db = cursor
    cursor = db.cursor()
    cursor.execute("INSERT INTO film (film_name, film_director, film_releaseDate, film_runtime, studio_id, genre_id) VALUES ('Oppenheimer', 'Christopher Nolan', 2023, 180, 3, 3)")
    db.commit()
    show_films(db_connect(), "DISPLAYING FILMS AFTER INSERT")

def update_films(cursor):
    db = cursor
    cursor = db.cursor()
    cursor.execute("UPDATE film SET genre_id = 1 WHERE film_name = 'Alien'")
    db.commit()
    show_films(db_connect(), "DISPLAYING FILMS AFTER UPDATE - Changed Alien to Horror")

def delete_films(cursor):
    db = cursor
    cursor = db.cursor()
    cursor.execute("DELETE FROM film WHERE film_name = 'Gladiator'")
    db.commit()
    show_films(db_connect(), "DISPLAYING FILMS AFTER DELETE")

show_films(db_connect(), "DISPLAYING FILM RECORDS")
insert_films(db_connect())
update_films(db_connect())
delete_films(db_connect())
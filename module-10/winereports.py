import mysql.connector
from mysql.connector import errorcode
import mysql.connector
from datetime import datetime, timedelta

import dotenv
from dotenv import dotenv_values

secrets = dotenv_values(".env")

config = {
    "user": secrets["USER"],
    "password": secrets["PASSWORD"],
    "host": secrets["HOST"],
    "database": secrets["DATABASE"],
    "raise_on_warnings": True
}

def generate_supplier_report(cursor):
    
    query = "SELECT * FROM suppliers;"
    cursor.execute(query)
    results = cursor.fetchall()
    for row in results:
        print(row)

       #create  wine distribution and sales data
def generate_distribution_report(cursor):
    query = """
    SELECT products.product_id, products.product_name, distributor.distributor_name, SUM(order.quantity) AS total_sold
    FROM distributor d
    JOIN products  ON orders.product_id = products.product_id
    JOIN distributor  ON distributor.distributor_id = d.distributor_id
    GROUP BY product.product_id, distributor.distributor_name
    ORDER BY total_sold DESC;
    """
    cursor.execute(query)
    results = cursor.fetchall()
    print("\n-- Wine Distribution Report --")
    for row in results:
        print(f"Wine: {row[1]}, Distributor: {row[2]}, Total Sold: {row[3]}")


    #create employee work hours over last four quarters

def generate_employee_hours_report(cursor):
    last_year = datetime.today() - timedelta(days=365)
    query = """SELECT employee.employee_id, employee.employee_name, SUM(employee.hours_worked) AS total_hours FROM employee 
    WHERE employee.work_date >= %s
    GROUP BY employee.employee_id
    ORDER BY total_hours DESC;"""

    cursor.execute(query, (last_year,))
    employee = cursor.fetchall()
    print("\n-- Employee Work Hours Report --")
    for row in employee:
        print(f"Employee: {row[1]}, Total Hours: {row[2]}")

#  Dan, this connects to the database and run reports one at time, from top to bottom,
try:
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    generate_supplier_report(cursor)
    # generate_distribution_report(cursor)
    # generate_employee_hours_report(cursor)

    cursor.close()
    db.close()

    # moving over same errors as last time, if logging in to database
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
         print("The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("The specified database does not exist")
    else:
        print(err)
 


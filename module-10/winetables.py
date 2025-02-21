import mysql.connector
from mysql.connector import errorcode

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
try:
    db = mysql.connector.connect(**config)

    print(f"Database user {config["user"]} connected to MySQL on host {config['host']} with database {config['database']}")
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("The specified database does not exist")
    else:
        print(err)

cursor = db.cursor()

#owners table
cursor.execute("SELECT owner_id, owner_name, role_id FROM owners")
query  = cursor.fetchall()
print("--  DISPLAYING Owners TABLE --")
for owner in query:
    print(f"OWNER ID: {owner[0]}\nOWNER NAME: {owner[1]}\nROLE ID: {owner[2]}")

#employee table
cursor.execute("SELECT employee_id, role_id, employee_name FROM employee")
query  = cursor.fetchall()
print("--  DISPLAYING employee TABLE --")
for employee in query:
    print(f"ROLE ID: {employee[0]}\nEMPLOYEE ID: {employee[1]}\nROLE ID: {employee[2]}\n EMPLOYEE NAME: {employee[3]}") 

#roles table 
cursor.execute("SELECT role_id, role_name FROM roles")  
query  = cursor.fetchall()          
print("--  DISPLAYING roles TABLE --")
for role in query:
  print(f"ROLE ID: {role[0]}\nROLE NAME: {role[1]}") 
  cursor.close()
  db.close()

#suppliers table 
cursor.execute("SELECT supplier_id, supplier_name, supplier_products FROM suppliers")
query  = cursor.fetchall()
print("--  DISPLAYING suppliers TABLE --")
for supplier in query:
    print(f"SUPPLIER ID: {supplier[0]}\nSUPPLIER NAME: {supplier[1]}\nSUPPLIER PRODUCTS: {supplier[2]}")

#products table 
cursor.execute("SELECT product_id, product_name, inventory FROM products")
query  = cursor.fetchall()
print("--  DISPLAYING products TABLE --")
for product in query:
    print(f"PRODUCT ID: {product[0]}\nPRODUCT NAME: {product[1]}\nINVENTORY: {product[2]}")

#orders table
cursor.execute("SELECT order_id, product_id,  tracking_id, order_date, order_quantity, FROM orders")
query  = cursor.fetchall()
print("--  DISPLAYING orders TABLE --")
for order in query:
    print(f"ORDER ID: {order[0]}\nPRODUCT ID: {order[1]}\nTRACKING ID: {order[2]}\nORDER DATE: {order[3]}\nQUANTITY: {order[4]}")
    



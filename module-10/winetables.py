#module 10 milestone 2
import mysql.connector
db = mysql.connector.connect(
    host="localhost",
    user="root",
    # password="password",
    # database=" "
)
cursor = db.cursor()
cursor.execute("DROP TABLE IF EXISTS WorkHours, Sales, Inventory, Distributor, Supplier, Wine, Employee, Owner")



cursor.execute('''
CREATE TABLE Owner (
    OwnerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Role VARCHAR(100)
)
''')
cursor.execute('''
CREATE TABLE Employee (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Role VARCHAR(100),
    Department VARCHAR(100)
)
''')
cursor.execute('''
CREATE TABLE Wine (
    WineID INT AUTO_INCREMENT PRIMARY KEY,
    WineName VARCHAR(100),
    WineType VARCHAR(50),
    YearProduced YEAR
)
''')
cursor.execute('''
CREATE TABLE Supplier (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ProductSupplied VARCHAR(100),
    ContactInfo VARCHAR(100)
)
''')
cursor.execute('''
CREATE TABLE Distributor (
    DistributorID INT AUTO_INCREMENT PRIMARY KEY,
    DistributorName VARCHAR(100),
    Region VARCHAR(100)
)
''')
cursor.execute('''
CREATE TABLE Inventory (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY,
    WineID INT,
    SupplierID INT,
    Quantity INT,
    OrderDate DATE,
    DeliveryDate DATE,
    FOREIGN KEY (WineID) REFERENCES Wine(WineID),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
)
''')
cursor.execute('''
CREATE TABLE Sales (
    SalesID INT AUTO_INCREMENT PRIMARY KEY,
    WineID INT,
    DistributorID INT,
    SaleDate DATE,
    Quantity INT,
    FOREIGN KEY (WineID) REFERENCES Wine(WineID),
    FOREIGN KEY (DistributorID) REFERENCES Distributor(DistributorID)
)
''')
cursor.execute('''
CREATE TABLE WorkHours (
    WorkID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    WorkDate DATE,
    Hours INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
)
''')

cursor.execute("INSERT INTO Owner (FirstName, LastName, Role) VALUES ('Stan', 'Bacchus', 'Co-Owner'), ('Davis', 'Bacchus', 'Co-Owner')")
cursor.execute("INSERT INTO Employee (FirstName, LastName, Role, Department) VALUES ('Janet', 'Collins', 'Finance Manager', 'Finance'), ('Roz', 'Murphy', 'Marketing Manager', 'Marketing'), ('Henry', 'Doyle', 'Production Manager', 'Production')")
cursor.execute("map_results=INSERT INTO Wine (WineName, WineType, YearProduced) VALUES ('Merlot', 'Red', 2020), ('Chardonnay', 'White', 2021), ('Cabernet', 'Red', 2019)")
cursor.execute("INSERT INTO Supplier (SupplierName, ProductSupplied, ContactInfo) VALUES ('BottleCo', 'Bottles and Corks', 'contact@bottleco.com'), ('LabelWorks', 'Labels and Boxes', 'contact@labelworks.com'), ('VatsRUs', 'Vats and Tubing', 'contact@vatsrus.com')")
cursor.execute("INSERT INTO Distributor (DistributorName, Region) VALUES ('WineWorld', 'Northeast'), ('GrapeVine', 'Midwest'), ('Vinopolis', 'West Coast')")
cursor.execute("INSERT INTO Inventory (WineID, SupplierID, Quantity, OrderDate, DeliveryDate) VALUES (1, 1, 500, '2025-01-01', '2025-01-05'), (2, 2, 300, '2025-01-10', '2025-01-15'), (3, 3, 200, '2025-01-20', '2025-01-25')")
cursor.execute("INSERT INTO Sales (WineID, DistributorID, SaleDate, Quantity) VALUES (1, 1, '2025-02-01', 50), (2, 2, '2025-02-05', 30), (3, 3, '2025-02-10', 20)")
cursor.execute("INSERT INTO WorkHours (EmployeeID, WorkDate, Hours) VALUES (1, '2025-01-15', 8), (2, '2025-01-16', 7), (3, '2025-01-17', 9)")


db.commit()


tables = ['Owner', 'Employee', 'Wine', 'Supplier', 'Distributor', 'Inventory', 'Sales', 'WorkHours']
for table in tables:
    cursor.execute(f"SELECT * FROM {table}")
    print(f"\n{table} Table:")
    for row in cursor.fetchall():
        print(row)


cursor.close()

db.close()
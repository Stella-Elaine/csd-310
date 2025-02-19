# module-11 milstone 3 

import mysql.connector
db = mysql.connector.connect(
    host="localhost",
    user="root",
    # password="password",
    # database=" "
)
cursor = db.cursor()


cursor.execute('''
SELECT s.SupplierName, i.OrderDate, i.DeliveryDate, DATEDIFF(i.DeliveryDate, i.OrderDate) AS DeliveryGap
FROM Inventory i
JOIN Supplier s ON i.SupplierID = s.SupplierID
ORDER BY DeliveryGap DESC;
''')
print("\nSupplier Delivery Timeliness Report:")
for row in cursor.fetchall():
    print(row)




cursor.execute('''
SELECT w.WineName, d.DistributorName, SUM(s.Quantity) AS TotalSold
FROM Sales s
JOIN Wine w ON s.WineID = w.WineID
JOIN Distributor d ON s.DistributorID = d.DistributorID
GROUP BY w.WineName, d.DistributorName
ORDER BY TotalSold DESC;
''')
print("\nWine Sales Performance Report:")
for row in cursor.fetchall():
    print(row)



cursor.execute('''
SELECT e.FirstName, e.LastName, SUM(w.Hours) AS TotalHours
FROM WorkHours w
JOIN Employee e ON w.EmployeeID = e.EmployeeID
GROUP BY e.EmployeeID
ORDER BY TotalHours DESC;
''')
print("\nEmployee Work Hours Report:")
for row in cursor.fetchall():
    print(row)
cursor.close()
db.close()



















/*
    Title: winetables.sql
    
*/

-- drop database user if exists 
DROP USER IF EXISTS 'wine_user'@'localhost';


CREATE USER 'wine_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'grapes';

GRANT ALL PRIVILEGES ON wine.* TO 'wines_user'@'localhost';


-- drop tables if they are present
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS products;




-- create the owners table 
CREATE TABLE owners (
    role_id     INT             NOT NULL,   
    owner_name   CHAR(50)     NOT NULL,
    order_id      INT          NOT NULL ,  
     
    PRIMARY KEY(owner_id)
    FOREIGN KEY(role_id)
); 

-- create the roles table 
CREATE TABLE roles (
    role_id     INT             NOT NULL        AUTO_INCREMENT,
    role_name   VARCHAR(75)     NOT NULL,
     
    PRIMARY KEY(role_id)
); 
-- create the employees table and set the foreign key
CREATE TABLE employee (
    employee_id   INT             NOT NULL        AUTO_INCREMENT,
    role_id     INT             NOT NULL,
    employee_name    

	
    
    PRIMARY KEY(employee_id),
    FOREIGN KEY(role_id)
    );

-- create the order table and set the foreign key
CREATE TABLE orders (
    order_id   INT             NOT NULL        AUTO_INCREMENT,
    product_id  INT     NOT NULL,
    tracking_id INT     NOT NULL        AUTO_INCREMENT,
    order_date DATE     NOT NULL,
    order_quantity INT     NOT NULL,

	
    
    PRIMARY KEY(order_id),
    FOREIGN KEY(product_id)
    FOREIGN KEY(tracking_id)
    );

    -- create the product table and set the foreign key
CREATE TABLE product (
    product_id  INT     NOT NULL,        AUTO_INCREMENT,
    product_name  VARCHAR(75)     NOT NULL,
    inventory   INT     NOT NULL,
	
    
    PRIMARY KEY(product_id)
    );

        -- create the suppliers table and set the foreign key
CREATE TABLE suppliers (
    supplier_name  VARCHAR(75)     NOT NULL,
    supplier_product  VARCHAR(75)     NOT NULL,
	
    
    PRIMARY KEY(supplier_id)
);
    

-- insert role records
INSERT INTO roles(role_name)
    VALUES('Owner');    

INSERT INTO roles(role_name)
    VALUES('Fiance and Payroll'); 

 INSERT INTO roles(role_name)
    VALUES('Marketing'); 

 INSERT INTO roles(role_name)
   VALUES('Production'); 

INSERT INTO roles(role_name)
  VALUES('Distribution'); 

 
 


-- insert owner records
INSERT INTO owners(owner_name, role_id)
    VALUES('Stan Bacchus', (SELECT role_id FROM roles WHERE role_name = 'Owner'));

INSERT INTO owners(owner_name)
    VALUES('Davis Bacchus');

-- insert employee records
INSERT INTO employee(employee_name, role_id)
    VALUES ('Janet Collins', (SELECT role_id FROM roles WHERE role_name = 'Fiance and Payroll'));

INSERT INTO employee(employee_name, role_id)
    VALUES ('Roz Murphy', (SELECT role_id FROM roles WHERE role_name = 'Marketing'));

INSERT INTO employee(employee_name, role_id)
    VALUES ('Bob Ulrich', (SELECT role_id FROM roles WHERE role_name = 'Marketing'));

INSERT INTO employee(employee_name, role_id)
    VALUES ('Henry Doyle', (SELECT role_id FROM roles WHERE role_name = 'Production'));

INSERT INTO employee(employee_name, role_id)
    VALUES ('Maria Costanza', (SELECT role_id FROM roles WHERE role_name = 'Distribution'));


-- insert into suppliers
INSERT INTO suppliers(supplier_name, supplier_product)
    VALUES('Supplier_1', 'bottles, corks')

INSERT INTO suppliers(supplier_name, supplier_product)
    VALUES('Supplier_2', 'lables, boxes')

INSERT INTO suppliers(supplier_id, supplier_product)
    VALUES('Supplier_3', 'vats, tubing')

-- insert into products
INSERT INTO products(product_name, inventory, supplier_id)
    VALUES('Merlot', 100, (SELECT supplier_id FROM suppliers WHERE supplier_name = 'Supplier_1'));

INSERT INTO products(product_name, inventory, supplier_id)
    VALUES('Carbernet', 100, (SELECT supplier_id FROM supplier_id WHERE supplier_name = 'Supplier_2'));

INSERT INTO products(product_name, inventory, supplier_id)
    VALUES('Chablis', 100, (SELECT supplier_id FROM supplier_id WHERE supplier_name = 'Supplier_3')));

INSERT INTO products(product_name, inventory, supplier_id)
    VALUES('Chardonnay', 100, (SELECT supplier_id FROM suppliers WHERE supplier_name = 'Supplier_1'));

-- insert into orders
INSERT INTO orders(order_date, order_quantity, product_id)
    VALUES('JAN 1, 2024', 20, (SELECT product_id FROM products WHERE product_name = 'Merlot'));

INSERT INTO orders(order_date, order_quantity, product_id)
    VALUES('JAN 2, 2024', 32, (SELECT product_id FROM products WHERE product_name = 'Cabernet'));

INSERT INTO orders(order_date, order_quantity, product_id)
    VALUES('JAN 3, 2024', 102, (SELECT product_id FROM products WHERE product_name = 'Chanblis'));






















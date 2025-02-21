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
    film_name  VARCHAR(75)     NOT NULL,
    employee_name    

	
    
    PRIMARY KEY(employee_id),
    FOREIGN KEY(role_id)
    );

-- create the order table and set the foreign key
CREATE TABLE orders (
    order_id   INT             NOT NULL        AUTO_INCREMENT,
    product_id  INT     NOT NULL,        AUTO_INCREMENT,
   tracking_id INT     NOT NULL,        AUTO_INCREMENT,
    order_date DATE     NOT NULL,        AUTO_INCREMENT,
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


-- insert into products
INSERT INTO products(product_name, inventory)
    VALUES('Merlot', 100);
INSERT INTO products(product_name, inventory)
    VALUES('Carbernet', 100);
INSERT INTO products(product_name, inventory)
    VALUES('Chablis', 100);
INSERT INTO products(product_name, inventory)
    VALUES('Chardonnay', 100);
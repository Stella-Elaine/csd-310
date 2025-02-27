/*
    Title: winetables.sql
    
*/

-- to make the python script work and not have duplicate id errors, i added individual tables for the suppliers and worked to join them by product id primary key. -- I added more delivery date stuff to order table answer questions number 2 
-- I added a new distributor table because I think we missed this last time to answer question number 2. i'm not sure we need value  distributor products tho after all. 
-- TODO: make sure product id of wine orders and supplier orders do not overlap or cause duplication error. 

-- drop database user if exists 
DROP USER IF EXISTS 'wine_user'@'localhost';

CREATE USER 'wine_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'grapes';

-- grant all privileges to the movies database to user movies_user on localhost 
GRANT ALL PRIVILEGES ON wine.* TO 'wine_user'@'localhost';

-- drop tables if they are present
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS products;



-- create the product table and set the foreign key
CREATE TABLE products (
    product_id  INT     NOT NULL,
    product_name  VARCHAR(75)     NOT NULL,
    inventory   INT     NOT NULL,
    -- supplier_id     INT     NOT NULL,
	
    PRIMARY KEY(product_id)
    );

-- insert into products
INSERT INTO products(product_name, inventory, supplier_id)
    VALUES('Merlot', 100, (SELECT supplier_id FROM suppliers WHERE supplier_name = 'Supplier_1'));

INSERT INTO products(product_name, inventory, supplier_id)
    VALUES('Cabernet', 100, (SELECT supplier_id FROM suppliers WHERE supplier_name = 'Supplier_2'));

INSERT INTO products(product_name, inventory, supplier_id)
    VALUES('Chablis', 100, (SELECT supplier_id FROM suppliers WHERE supplier_name = 'Supplier_3'));

INSERT INTO products(product_name, inventory, supplier_id)
    VALUES('Chardonnay', 100, (SELECT supplier_id FROM suppliers WHERE supplier_name = 'Supplier_1'));

INSERT INTO products(product_name, inventory, supplier_id)
    VALUES('Pinot noir', 500, (SELECT supplier_id FROM suppliers WHERE supplier_name = 'Supplier_3'));

INSERT INTO products(product_name, inventory, supplier_id)
    VALUES('Riesling', 150, (SELECT supplier_id FROM suppliers WHERE supplier_name = 'Supplier_1'));

-- create the suppliers table and set the primary key
CREATE TABLE suppliers (
    supplier_id           INT NOT NULL AUTO_INCREMENT,
    supplier_name         VARCHAR(75)     NOT NULL,
    supplier_product1     VARCHAR(75)     NOT NULL,
    supplier_product2     VARCHAR(75)     NOT NULL,

    PRIMARY KEY(supplier_id)
);

-- insert into suppliers

INSERT INTO suppliers(supplier_name, supplier_product1, supplier_product2,))
    VALUES('Supplier_1', 'bottles', 'corks');

INSERT INTO suppliers(supplier_name, supplier_product1, supplier_product2)
    VALUES('Supplier_2', 'labels', 'boxes');

INSERT INTO suppliers(supplier_name, supplier_product1, supplier_product2)
    VALUES('Supplier_3', 'vats', 'tubing');

INSERT INTO suppliers(supplier_name, supplier_product1, supplier_product2,)
    VALUES('Supplier_2', 'labels', 'boxes');

INSERT INTO suppliers(supplier_name, supplier_product1, supplier_product2,)
    VALUES('Supplier_3', 'vats', 'tubing');


CREATE TABLE supplier_1 (
    supplier_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(75) NOT NULL,

    PRIMARY KEY(product_id)
);

INSERT INTO supplier_1 (supplier_id, product_id, product_name)
VALUES (1,2234, "bottles");

INSERT INTO supplier_1 (supplier_id, product_id, product_name)
VALUES (1, 23345, "corks");

CREATE TABLE supplier_2 (
    supplier_id INT               NOT NULL,
    product_id INT                NOT  NULL, 
    product_name VARCHAR(75)      NOT NULL,
    PRIMARY KEY(product_id)
);

INSERT INTO supplier_2 (supplier_id, product_id, product_name)
VALUES (2, 34456, "labels");
INSERT INTO supplier_2 (supplier_id, product_id, product_name) 
VALUES (2, 45567, "boxes");


CREATE TABLE supplier_3 (
    supplier_id INT               NOT NULL,
    product_id INT                NOT  NULL, 
    product_name VARCHAR(75)      NOT NULL,
    PRIMARY KEY(product_id)
);
INSERT INTO supplier_3 (supplier_id, product_id, product_name)
VALUES (3, 56678, "vats");
INSERT INTO supplier_3 (supplier_id, product_id, product_name)
VALUES (3, 67789, "tubing"); 



-- create the distributor table and set the primary key

CREATE TABLE distributor (
    -- distributor_id           INT          NOT NULL,
    distributor_name     VARCHAR(75)     NOT NULL,
    distributor_products VARCHAR(75)     NOT NULL, 
    bottles_ordered       INT             NOT NULL,

    PRIMARY KEY(distributor_name)    
);
  
--  name the distrubion stores
INSERT INTO distributor (distributor_name) 
 VALUES ('ABC Store'), ('DCs Best 711'), ('DC Liquor and Wine'),('Bellevues Party Station'), ('Bellevues 24 Hour Store');

INSERT INTO distributor(distributor_name, distributor_products, bottles_ordered)
VALUES ("abc", "Cabernet", 20);

INSERT INTO distributor(distributor_name, distributor_products, bottles_ordered)
VALUES ("abc", "Merlot", 50);


INSERT INTO distributor(distributor_name, distributor_products)
VALUES ("abc", "Riesling")
abc
INSERT INTO distributor_products (distributor_id, product_id) 
VALUES ((SELECT distributor_id FROM distributor WHERE distributor_name = 'ABC Store'),(SELECT product_id FROM products WHERE product_name = 'Merlot')),

((SELECT distributor_id FROM distributor WHERE distributor_name = 'ABC Store'), 
 (SELECT product_id FROM products WHERE product_name = 'Cabernet')),

((SELECT distributor_id FROM distributor WHERE distributor_name = 'ABC Store'), 
 (SELECT product_id FROM products WHERE product_name = 'Chardonnay')),

-- 711
((SELECT distributor_id FROM distributor WHERE distributor_name = 'DC\'S Best 711'), 
 (SELECT product_id FROM products WHERE product_name = 'Chablis')),

((SELECT distributor_id FROM distributor WHERE distributor_name = 'DC\'S Best 711'), 
 (SELECT product_id FROM products WHERE product_name = 'Pinot Noir')),

-- DC Liquor and Wine
((SELECT distributor_id FROM distributor WHERE distributor_name = 'DC Liquor and Wine'), 
 (SELECT product_id FROM products WHERE product_name = 'Merlot')),

((SELECT distributor_id FROM distributor WHERE distributor_name = 'DC Liquor and Wine'), 
 (SELECT product_id FROM products WHERE product_name = 'Cabernet')),

((SELECT distributor_id FROM distributor WHERE distributor_name = 'DC Liquor and Wine'), 
 (SELECT product_id FROM products WHERE product_name = 'Riesling')),

-- Bellevue's Party Station
((SELECT distributor_id FROM distributor WHERE distributor_name = 'Bellevues Party Station'), 
 (SELECT product_id FROM products WHERE product_name = 'Chardonnay')),

((SELECT distributor_id FROM distributor WHERE distributor_name = 'Bellevues Party Station'), 
 (SELECT product_id FROM products WHERE product_name = 'Pinot Noir')),

-- Bellevue's 24 Hour Store
((SELECT distributor_id FROM distributor WHERE distributor_name = 'Bellevues 24 Hour Store'), 
 (SELECT product_id FROM products WHERE product_name = 'Cabernet')),

((SELECT distributor_id FROM distributor WHERE distributor_name = 'Bellevues 24 Hour Store'), 
 (SELECT product_id FROM products WHERE product_name = 'Chablis')),

((SELECT distributor_id FROM distributor WHERE distributor_name = 'Bellevues 24 Hour Store'), 
 (SELECT product_id FROM products WHERE product_name = 'Riesling'));





CREATE TABLE orders (
    order_id         INT NOT NULL AUTO_INCREMENT,
    tracking_id   VARCHAR(75)      NOT NULL,
    quantity_ordered INT NOT NULL,
    date_ordered     DATE NOT NULL,
    expected_delivery_date    DATE NOT NUll ,
    date_arrived    DATE NOT NULL,
    product_id      INT NOT NULL,

    PRIMARY KEY(order_id),
    FOREIGN KEY (product_id) REFERENCES supplier_2(product_id)
);


-- insert into orders
INSERT INTO orders(date_ordered, quantity_ordered, tracking_id, product_id)
    VALUES('JAN 1 2024', 20, '12345', (SELECT product_id FROM products WHERE product_name = 'Merlot'));

INSERT INTO orders(date_ordered, quantity_ordered, tracking_id, product_id)
    VALUES('JAN 2 2024', 32, '123456', (SELECT product_id FROM products WHERE product_name = 'Cabernet'));

INSERT INTO orders(date_ordered, quantity_ordered, tracking_id, product_id)
    VALUES('JAN 5 2024', 32, '1234567', (SELECT product_id FROM products WHERE product_name = 'Riesling'));

INSERT INTO orders(date_ordered, quantity_ordered, tracking_id, product_id)
    VALUES('JAN 8 2024', 102, '2564789', (SELECT product_id FROM products WHERE product_name = 'Cabernet'));

INSERT INTO orders(date_ordered, quantity_ordered, tracking_id, product_id)
    VALUES('JAN 8 2024', 32, '6547895', (SELECT product_id FROM products WHERE product_name = 'Riesling'));

INSERT INTO orders(date_ordered, quantity_ordered, tracking_id, product_id)
    VALUES('JAN 9 2024', 102, '5468521', (SELECT product_id FROM products WHERE product_name = 'Cabernet'));

---- report one for supplier delivery time stamps 
INSERT INTO orders (quantity_ordered, date_ordered, date_arrived, product_id)
VALUES (100, "2024-01-01", "2024-01-14", (SELECT product_id FROM supplier_1 WHERE product_name = 'bottles'));

INSERT INTO orders (quantity_ordered, date_ordered, date_arrived, product_id)
VALUES (100, "2024-01-10", "2024-01-12", (SELECT product_id FROM supplier_1 WHERE product_name = 'corks'));

INSERT INTO orders (quantity_ordered, date_ordered, date_arrived, product_id)
VALUES (100, "2024-01-01", "2024-01-14", (SELECT product_id FROM supplier_2 WHERE product_name = 'labels'));

INSERT INTO orders (quantity_ordered, date_ordered, date_arrived, product_id)
VALUES (100, "2024-01-10", "2024-01-12", (SELECT product_id FROM supplier_2 WHERE product_name = 'boxes'));


INSERT INTO orders (quantity_ordered, date_ordered, date_arrived, product_id)
VALUES (100, "2024-01-01", "2024-01-14", (SELECT product_id FROM supplier_3 WHERE product_name = 'vats'));
INSERT INTO orders (quantity_ordered, date_ordered, date_arrived, product_id)  
VALUES (100, "2024-01-10", "2024-01-12", (SELECT product_id FROM supplier_3 WHERE product_name = 'tubing')); 



-- create the role table 
CREATE TABLE user_roles (
    role_id     INT             NOT NULL        AUTO_INCREMENT,
    role_name   VARCHAR(75)     NOT NULL,
     
    PRIMARY KEY(role_id)
); 

-- insert role records
INSERT INTO user_roles(role_name)
    VALUES('Owner');    

INSERT INTO user_roles(role_name)
    VALUES('Fiance and Payroll'); 

INSERT INTO user_roles(role_name)
    VALUES('Marketing'); 

INSERT INTO user_roles(role_name)
   VALUES('Production'); 

INSERT INTO user_roles(role_name)
  VALUES('Distribution'); 


-- create the owners table 
CREATE TABLE owners (
    owner_id     INT             NOT NULL AUTO_INCREMENT,
    owner_name  CHAR(50)    NOT NULL,
    role_id     INT             NOT NULL, 
        
    PRIMARY KEY(owner_id)
); 


-- insert owner records
INSERT INTO owners(owner_name, role_id)
    VALUES('Stan Bacchus', (SELECT role_id FROM user_roles WHERE role_name = 'Owner'));

INSERT INTO owners(owner_name, role_id)
    VALUES('Davis Bacchus', (SELECT role_id FROM user_roles WHERE role_name = 'Owner'));



-- create the employees table and set the foreign key
CREATE TABLE employee (
    employee_id   INT             NOT NULL        AUTO_INCREMENT,
    role_id     INT             NOT NULL,
    employee_name    VARCHAR(50) NOT NULL,	
    hours_worked    INT             NOT NULL,
    work_date       DATE   NOT NUll,
    
    PRIMARY KEY(employee_id)
    );


-- insert employee records 
-- I added the work_date and hours worked to the employee table to add  a two week pay-period hours worked, to work on reports 2 an 3 
INSERT INTO employee(employee_name, role_id, hours_worked , work_date)
    VALUES ('Janet Collins', (SELECT role_id FROM user_roles WHERE role_name = 'Fiance and Payroll')); 
    VALUES ('52 ', '2024-01-01'),(SELECT hours_worked, work_date FROM employee WHERE employee_name = 'Janet Collins');

INSERT INTO employee(employee_name, role_id, hours_worked , work_date)
    VALUES ('Roz Murphy', (SELECT role_id FROM user_roles WHERE role_name = 'Marketing'));
    VALUES ('80 ', '2024-01-01'),(SELECT hours_worked, work_date FROM employee WHERE employee_name = 'Roz Murphy');

INSERT INTO employee(employee_name, role_id, hours_worked , work_date)
    VALUES ('Bob Ulrich', (SELECT role_id FROM user_roles WHERE role_name = 'Marketing'));
    VALUES ('75 ', '2024-01-01'),(SELECT hours_worked, work_date FROM employee WHERE employee_name = 'Bob Ulrich');


INSERT INTO employee(employee_name, role_id, hours_worked , work_date)
    VALUES ('Henry Doyle', (SELECT role_id FROM user_roles WHERE role_name = 'Production'));
    VALUES ('86 ', '2024-01-01'),(SELECT hours_worked, work_date FROM employee WHERE employee_name = 'Henry Doyle');

INSERT INTO employee(employee_name, role_id, hours_worked , work_date)
    VALUES ('Maria Costanza', (SELECT role_id FROM user_roles WHERE role_name = 'Distribution'));
    VALUES ('60 ', '2024-01-01'),(SELECT hours_worked, work_date FROM employee WHERE employee_name = 'Maria Costanza');





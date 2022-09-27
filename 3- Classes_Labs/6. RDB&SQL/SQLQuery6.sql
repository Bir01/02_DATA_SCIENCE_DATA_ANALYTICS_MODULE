CREATE TABLE Product_table

(product_name VARCHAR(255),
product_ID int PRIMARY KEY,
quantity INT
);
CREATE TABLE product_component_table
(product_ID int PRIMARY KEY ,
component_id int 
);
CREATE TABLE component_table
( component_ID INT PRIMARY KEY ,
  [name] VARCHAR(255),
 [description] TEXT,
quantity INT
);
CREATE TABLE  suppliers_of_components
(
supplier_date DATE,
supplied_amount INT,
products_usage VARCHAR(255),
supplier_id INT PRIMARY KEY,
component_ID INT 
);
CREATE TABLE suppliers
(supplier_name VARCHAR(255),
supplier_id INT PRIMARY KEY,
activation_status VARCHAR(255)
);
CREATE TABLE product (
    product_ID INT IDENTITY (1, 1) PRIMARY KEY,
    product_name VARCHAR (200) NOT NULL,
    quantity INT
);
CREATE TABLE suppliers (
    supplier_ID INT IDENTITY (1, 1) PRIMARY KEY,
    [name] VARCHAR (200) NOT NULL,
    activation_status INT NULL
);
CREATE TABLE components (
    component_ID INT IDENTITY (1, 1) PRIMARY KEY,
    [name] VARCHAR (200) NOT NULL,
    [description] VARCHAR (200),
    quantity INT
);
CREATE TABLE product_component (
    component_ID INT,
    product_ID INT,
	FOREIGN KEY (component_ID)
	REFERENCES components (component_ID),
	FOREIGN KEY (product_ID)
	REFERENCES product (product_ID)
);
CREATE TABLE component_suppliers (
    component_ID INT,
    supplier_ID INT,
    supplied_date DATE NOT NULL,
    suplied_amount INT,
    FOREIGN KEY (component_ID)
    REFERENCES components (component_ID),
    FOREIGN KEY (supplier_ID)
    REFERENCES suppliers (supplier_ID)
	);
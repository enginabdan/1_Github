
--01_DBMD_ASS_01_(Charlie's Chocolate Factory)--

--Charlie's Chocolate Factory company produces chocolates.
--The following product information is stored: product name, product ID, and quantity on hand.
--These chocolates are made up of many components.
--Each component can be supplied by one or more suppliers.
--The following component information is kept:
--component ID, name, description, quantity on hand, suppliers who supply them, when and how much they supplied, and products in which they are used.
--On the other hand following supplier information is stored: supplier ID, name, and activation status.
--Assumptions
	--A supplier can exist without providing components.
	--A component does not have to be associated with a supplier. It may already have been in the inventory.
	--A component does not have to be associated with a product. Not all components are used in products.
	--A product cannot exist without components.
--Create an ERD to show how you would track this information. (You can use draw.io)
--Show entity names, primary keys, attributes for each entity, and relationship types between the entities. 
--Do the following exercises, using the data model you designed before.
	--a) Create a database named "Manufacturer"
	--b) Create the tables in the database.
	--c) Define table constraints.

CREATE DATABASE Manufacturer;

USE Manufacturer

CREATE TABLE Product (PROD_ID INT,
					  PROD_NAME VARCHAR(MAX),
					  QUANTITY INT
					  PRIMARY KEY (PROD_ID));
----------------------------------
CREATE TABLE Component (COMP_ID INT PRIMARY KEY,
						COMP_NAME VARCHAR(MAX),
						DESCRIP VARCHAR(MAX),
						QUANTITY INT);
---------------------------------
CREATE TABLE Supplier (SUPP_ID INT PRIMARY KEY,
					   SUPP_NAME VARCHAR(MAX),
					   ISACTIVE BIT);
----------------------------------
CREATE TABLE Receipt (PROD_ID INT,
					  COMP_ID INT
					  PRIMARY KEY (PROD_ID, COMP_ID),
					  FOREIGN KEY (PROD_ID) REFERENCES Product (PROD_ID),
					  FOREIGN KEY (COMP_ID) REFERENCES Component (COMP_ID));
----------------------------------
CREATE TABLE Order_Supp (COMP_ID INT,
						 SUPP_ID INT,
						 ORDER_DATE DATE,
						 ORDER_QUANTITY INT
						 PRIMARY KEY (COMP_ID, SUPP_ID),
						 FOREIGN KEY (SUPP_ID) REFERENCES Supplier (SUPP_ID),
						 FOREIGN KEY (COMP_ID) REFERENCES Component (COMP_ID));
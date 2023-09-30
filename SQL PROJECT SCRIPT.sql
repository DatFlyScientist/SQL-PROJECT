
create database grocery;

use grocery;

-- create tables
create table employee(
	EmployeeID int,
    LastName varchar(255),
    FirstName varchar(255),
    BirthDate date,
    Photo varchar(255),
    Notes text
);

create table customer(
	CustomerID int,
    CustomerName varchar(255),
    ContactName varchar(255),
    Address varchar(255),
    City varchar(255),
    PostalCode varchar(255),
    Country varchar(255)
);

create table shippers(
	ShipperID int,
    ShipperName varchar(255),
    Phone varchar(255)
);

create table orders(
	OrderID int,
    CustomerID int,
    EmployeeID int,
    OrderDate date,
    ShipperId int
);

create table suppliers(
	SupplierID int,
    SupplierName varchar(255),
    ContactName varchar(255),
    Address varchar(255),
    City varchar(255),
    PostalCode varchar(255),
    Country varchar(255),
    Phone varchar(255)
);

create table category(
	CategoryID int,
    CategoryName varchar(255),
    Description varchar(255)
);

create table products(
	ProductID int,
    ProductName varchar(255),
    SupplierID int,
    CategoryID int,
    Unit varchar(255),
    Price double
);

create table order_details(
	OrderDetailID int,
    OrderID int,
    ProductID int,
    Quantity int
    );
    
alter table category add constraint primary key (categoryid);
alter table customer add constraint primary key (customerid);
alter table employee add constraint primary key (employeeid);
alter table order_details add constraint primary key (orderdetailid);
alter table orders add constraint primary key (orderid);
alter table products add constraint primary key (productid);
alter table shippers add constraint primary key (shipperid);
alter table suppliers add constraint primary key (supplierid);

alter table products add constraint fk_products_categoryid foreign key (categoryid) references category (categoryid);
alter table products add constraint fk_products_supplierid foreign key (supplierid) references suppliers (supplierid);
alter table order_details add constraint fk_order_details_orderid foreign key (orderid) references orders (orderid);
alter table order_details add constraint fk_order_details_productid foreign key (productid) references products (productid);
alter table orders add constraint fk_orders_customerid foreign key (customerid) references customer (customerid);
alter table orders add constraint fk_orders_employeeid foreign key (employeeid) references employee (employeeid);
alter table orders add constraint fk_orders_shipperid foreign key (shipperid) references shippers (shipperid);

select distinct customer.customername, orders.OrderID, Quantity from customer 
join orders on customer.CustomerID = orders.CustomerID
join order_details on order_details.OrderID = orders.OrderID;

SELECT orders.orderid, employee.LastName, employee.firstname 
FROM orders 
JOIN employee ON orders.employeeid = employee.employeeid;


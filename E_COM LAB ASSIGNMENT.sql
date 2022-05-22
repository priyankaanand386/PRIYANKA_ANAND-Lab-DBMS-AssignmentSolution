drop database e_com;
create database e_com;
USE e_com;

CREATE TABLE IF NOT EXISTS supplier
(SUPP_ID int primary key,
SUPP_NAME varchar(50)NOT NULL,
SUPP_CITY varchar(50)NOT NULL,
SUPP_PHONE varchar(50)NOT NULL
);

CREATE table IF NOT exists customer
(CUS_ID int primary key,
CUS_NAME VARCHAR(20)NOT NULL ,
CUS_PHONE VARCHAR(10)NOT NULL ,
CUS_CITY VARCHAR(30)NOT NULL, 
CUS_GENDER CHAR
);
create table IF NOT exists category
(CAT_ID int NOT NULL,
CAT_NAME VARCHAR(20) NOT NULL,
primary key(CAT_ID)
);
create table IF NOT exists product
(PRO_ID INT NOT NULL,
PRO_NAME VARCHAR(20) NOT NULL DEFAULT "Dummy",
PRO_DESC VARCHAR(60),
CAT_ID INT NOT NULL,
PRIMARY KEY(PRO_ID),
FOREIGN KEY(CAT_ID) REFERENCES category(CAT_ID)
);
SET FOREIGN_KEY_CHECKS = 0;
create table IF NOT exists supplier_pricing
(PRICING_ID INT NOT NULL,
PRO_ID INT NOT NULL,
SUPP_ID INT NOT NULL,
SUPP_PRICE INT DEFAULT 0,
PRIMARY KEY(PRICING_ID),
FOREIGN KEY(PRO_ID) REFERENCES product(PRO_ID),
FOREIGN KEY(PRO_ID) REFERENCES supplier(SUPP_ID)
);

create table IF NOT exists `order`
(ORD_ID INT NOT NULL,
ORD_AMOUNT INT NOT NULL,
ORD_DATE DATE,
CUS_ID INT NOT NULL,
PRICING_ID INT NOT NULL,
PRIMARY KEY(ORD_ID),
FOREIGN KEY(CUS_ID) REFERENCES customer(CUS_ID),
FOREIGN KEY(PRICING_ID) REFERENCES supplier_pricing(PRICING_ID)
);

create table if not exists rating
( RAT_ID INT NOT NULL,
ORD_ID INT NOT NULL,
RAT_RATSTARS INT NOT NULL,
PRIMARY KEY (RAT_ID),
FOREIGN KEY (ORD_ID) references `order`(ORD_ID)
);

INSERT INTO supplier VALUES(1,"Rajesh Retails","Delhi",'1234567890');
INSERT INTO supplier VALUES(2,"Appario Ltd.","Mumbai",'2589631470');
INSERT INTO supplier VALUES(3,"Knome products","Banglore",'9785462315');
INSERT INTO supplier VALUES(4,"Bansal Retails","Kochi",'8975463285');
INSERT INTO supplier VALUES(5,"Mittal Ltd.","Lucknow",'7898456532');

INSERT INTO customer VALUES(1,"AAKASH",'9999999999',"DELHI",'M');
INSERT INTO customer VALUES(2,"AMAN",'9785463215',"NOIDA",'M');
INSERT INTO customer VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO customer VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO customer VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');

INSERT INTO supplier_pricing VALUES(5,4,1,1000);
INSERT INTO supplier_pricing VALUES(6,12,2,780);
INSERT INTO supplier_pricing VALUES(7,12,4,789);
INSERT INTO supplier_pricing VALUES(8,3,1,31000);
INSERT INTO supplier_pricing VALUES(9,1,5,1450);
INSERT INTO supplier_pricing VALUES(10,4,2,999);
INSERT INTO supplier_pricing VALUES(11,7,3,549);
INSERT INTO supplier_pricing VALUES(12,7,4,529);
INSERT INTO supplier_pricing VALUES(13,6,2,105);
INSERT INTO supplier_pricing VALUES(14,6,1,99);
INSERT INTO supplier_pricing VALUES(15,2,5,2999);
INSERT INTO supplier_pricing VALUES(16,5,2,2999);

INSERT INTO product VALUES(1,"GTA V","Windows 7 and above with i5 processor and 8GB RAM",2);
INSERT INTO product VALUES(2,"TSHIRT","SIZE-L with Black, Blue and White variations",5);
INSERT INTO product VALUES(3,"ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4);
INSERT INTO product VALUES(4,"OATS","Highly Nutritious from Nestle",3);
INSERT INTO product VALUES(5,"HARRY POTTER","Best Collection of all time by J.K Rowling",1);
INSERT INTO product VALUES(6,"MILK","1L Toned MIlk",3);
INSERT INTO product VALUES(7,"Boat EarPhones","1.5Meter long Dolby Atmos",4);
INSERT INTO product VALUES(8,"Jeans","Stretchable Denim Jeans with various sizes and color",5);
INSERT INTO product VALUES(9,"Project IGI","compatible with windows 7 and above",2);
INSERT INTO product VALUES(10,"Hoodie","Black GUCCI for 13 yrs and above",5);
INSERT INTO product VALUES(11,"Rich Dad Poor Dad","Written by RObert Kiyosaki",1);
INSERT INTO product VALUES(12,"Train Your Brain","By Shireen Stephen",1);

INSERT INTO category VALUES( 1,"BOOKS");
INSERT INTO category VALUES(2,"GAMES");
INSERT INTO category VALUES(3,"GROCERIES");
INSERT INTO category VALUES (4,"ELECTRONICS");
INSERT INTO category VALUES(5,"CLOTHES");

INSERT INTO `order` VALUES(101,1500,"2021-10-06",2,1);
INSERT INTO `order` VALUES(102,1000,"2021-10-12",3,5);
INSERT INTO `order` VALUES(103,30000,"2021-09-16",5,2);
INSERT INTO `order` VALUES(104,1500,"2021-10-05",1,1);
INSERT INTO `order` VALUES(105,3000,"2021-08-16",4,3);
INSERT INTO `order` VALUES(106,1450,"2021-08-18",1,9);
INSERT INTO `order` VALUES(107,789,"2021-09-01",3,7);
INSERT INTO `order` VALUES(108,780,"2021-09-07",5,6);
INSERT INTO `order` VALUES(109,3000,"2021-0-10",5,3);
INSERT INTO `order` VALUES(110,2500,"2021-09-10",2,4);
INSERT INTO `order` VALUES(111,1000,"2021-09-15",4,5);
INSERT INTO `order` VALUES(112,789,"2021-09-16",4,7);
INSERT INTO `order` VALUES(113,31000,"2021-09-16",1,8);
INSERT INTO `order` VALUES(114,1000,"2021-09-16",3,5);
INSERT INTO `order` VALUES(115,3000,"2021-09-16",5,3);
INSERT INTO `order` VALUES(116,99,"2021-09-17",2,14);

INSERT INTO rating VALUES(1,101,4);
INSERT INTO rating VALUES(2,102,3);
INSERT INTO rating VALUES(3,103,1);
INSERT INTO rating VALUES(4,104,2);
INSERT INTO rating VALUES(5,105,4);
INSERT INTO rating VALUES(6,106,3);
INSERT INTO rating VALUES(7,107,4);
INSERT INTO rating VALUES(8,108,4);
INSERT INTO rating VALUES(9,109,3);
INSERT INTO rating VALUES(10,110,5);
INSERT INTO rating VALUES(11,111,3);
INSERT INTO rating VALUES(12,112,4);
INSERT INTO rating VALUES(13,113,2);
INSERT INTO rating VALUES(14,114,1);
INSERT INTO rating VALUES(15,115,1);
INSERT INTO rating VALUES(16,116,0);

select CUS_GENDER AS GENDER,count(distinct(CUS_ID)) AS NoOfCustomers from
(select customer.CUS_ID, customer.CUS_GENDER FROM customer inner join
(select CUS_ID from e_com.ORDER where ORD_AMOUNT >= 3000) AS filter_order
on customer.CUS_ID = filter_order.CUS_ID) as filter_customer group by CUS_GENDER;


select order_details.*, prod.PRO_NAME from product as prod inner join
( select ord.*,price.PRO_ID from e_com.order as ord inner join supplier_pricing as price
on ord.PRICING_ID = price.PRICING_ID where ord.CUS_ID=2) as order_details
on order_details.PRO_ID = prod.PRO_ID;

select product.pro_name, `order`.* from `order`, supplier_pricing, product
where `order`.cus_id=2 and
`order`.pricing_id = supplier_pricing.pricing_id and supplier_pricing.pro_id = product.pro_id;

select  supplier.* from supplier where supplier.SUPP_ID in
(select SUPP_ID from supplier_pricing group by SUPP_ID having
count(PRO_ID)>1);

select category.CAT_ID,category.CAT_NAME,min(t3.min_price) as MIN_PRICE from category inner join
(select product.CAT_ID,product.PRO_NAME,t2.* from product inner join
(select PRO_ID, min(supp_price) as MIN_PRICE from supplier_pricing group by PRO_ID)
AS t2 where t2.PRO_ID= product.PRO_ID)
as t3 where t3.CAT_ID= category.CAT_ID group by t3.CAT_ID;

select product.PRO_ID,product.PRO_NAME from `order` inner join supplier_pricing on supplier_pricing.PRICING_ID=`order`.PRICING_ID inner join product
on product.PRO_ID=supplier_pricing.PRO_ID where `order`.ORD_DATE> "2021=10-05";

select customer.CUS_NAME, customer.CUS_GENDER from customer where
customer.CUS_NAME like '%A' or customer.CUS_NAME like 'A%' ;

DELIMITER &&
create procedure proc()
begin
select report.SUPP_ID,report.SUPP_NAME,report.Average,
case
when report.Average =5 then 'Excellent Service'
when report.Average >4 then 'Good Service'
when report.Average >2 then 'Average Service'
else 'Poor Service'
end as Type_Of_Service from
(select final.SUPP_ID, supplier.SUPP_NAME, final.Average from
(select test2.SUPP_ID, sum(test2.RAT_RATSTARS)/count(test2.RAT_RATSTARS)AS Average from
(select supplier_pricing.SUPP_ID, test.ORD_ID,test.RAT_RATSTARS from supplier_pricing inner join
(select `order`.PRICING_ID, rating.ORD_ID, rating.RAT_RATSTARS from `order` inner join rating on rating.ORD_ID= `order`.ORD_ID) as test
on test.PRICING_ID = supplier_pricing.PRICING_ID)
as test2 group by supplier_pricing.SUPP_ID)
as final inner join supplier where final.SUPP_ID = supplier.SUPP_ID) as report;
end &&
DELIMITER ;
call proc();

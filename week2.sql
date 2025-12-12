CREATE DATABASE insurance;
USE insurance;

CREATE TABLE person(
driverId VARCHAR(30),
name VARCHAR(30),
address VARCHAR(30),
PRIMARY KEY (driverID)
);

CREATE TABLE car(
regNum VARCHAR(30),
model VARCHAR(30),
year int,
PRIMARY KEY (regNum)
);

CREATE TABLE accident(
reportNum int PRIMARY KEY,
accidentDate date,
location VARCHAR(30)
);

CREATE TABLE owns(
driverId VARCHAR(30),
regNum VARCHAR(30),
PRIMARY KEY (driverId, regNum),
FOREIGN KEY (driverID) references person(driverId),
FOREIGN KEY (regNum) references car(regNum)
);

CREATE TABLE participated(
driverId VARCHAR(30),
regNum VARCHAR(30),
reportNum int,
damageAmount int,
PRIMARY KEY (driverid, regNum, reportNum),
FOREIGN KEY (driverId) references person(driverId),
FOREIGN KEY (regNum) references car(regNum),
FOREIGN KEY (reportNum) references accident(reportNum)
);

INSERT INTO person VALUES 
('A01','Richard','Srinivas nagar'),
('A02','Pradeep','Rajaji nagar'),
('A03','Smith','Ashok nagar'),
('A04','Venu','NR Colony'),
('A05','John','Hanumanth nagar');

SELECT * FROM person;

INSERT INTO car VALUES 
('KA052250','Indica',1990),
('KA031181','Lancer',1957),
('KA095477','Toyota',1998),
('KA053408','Honda',2008),
('KA041702','Audi',2005);

Select * from car;

INSERT INTO accident VALUES
(11,'2003-01-01','Mysore Road'),
(12,'2004-02-02','South End Circle'),
(13,'2003-01-21','Bull Temple Road'),
(14,'2008-02-17','Mysore Road'),
(15,'2005-03-04','Kanakpura Road');

SELECT * FROM accident;

INSERT INTO owns VALUES
('A01','KA052250'),
('A02','KA053408'),
('A03','KA031181'),
('A04','KA095477'),
('A05','KA041702');

SELECT * FROM owns;

INSERT INTO participated VALUES
('A01','KA052250',11,10000),
('A02','KA053408',12,50000),
('A03','KA095477',13,25000),
('A04','KA031181',14,3000),
('A05','KA041702',15,5000);

SELECT * FROM participated;

SELECT * 
FROM car
ORDER BY year ASC;

SELECT count(reportNum) as numOfAccidents
FROM participated p
JOIN car c
ON p.regNum = c.regNum 
WHERE c.model='lancer';

SELECT count(driverId) as numOfPeople
FROM participated p
JOIN accident a 
ON p.reportNum = a.reportNum
WHERE year(a.accidentDate)=2003;

SELECT * FROM participated ORDER BY damageAmount DESC;

SELECT AVG(damageAmount) as average_damage_amount FROM participated;

SELECT * FROM participated WHERE damageAmount < (SELECT AVG(damageAmount) as average_damage_amount FROM participated);

SELECT name, damageAmount
FROM person p
JOIN participated pa
ON p.driverId = pa.driverId
WHERE damageAMount > (SELECT AVG(damageAmount) as average_damage_amount FROM participated);

SELECT MAX(damageAmount)
FROM participated;
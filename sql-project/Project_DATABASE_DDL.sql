
/*
==================================================================================
LiveListing Database - DDL

Presented by: 
	Champ-Long, Maxence 11332347
	Pourcher, Simon 11335659
	Tshiya,Estha Wamonakeba 11317258
	Ward, Ben 11369514
==================================================================================
Code structure:
    1. Database creation and all related table definitions.
    2. Constraints (primary keys, foreign keys, and other rules).
    3. Cleanup section containing DROP statements for all tables (in the correct
       order) followed by the DROP statement for the database.
==================================================================================
*/

--DROP ALL TABLES :
DROP TABLE IF EXISTS BankTransfer;
DROP TABLE IF EXISTS Paypal;
DROP TABLE IF EXISTS CreditCard;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS InvoiceDetail;
DROP TABLE IF EXISTS Invoice;
DROP TABLE IF EXISTS Payment_Method;
DROP TABLE IF EXISTS Billing_Account;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS ListingSeller;
DROP TABLE IF EXISTS Subscription;
DROP TABLE IF EXISTS Clients;
DROP TABLE IF EXISTS Wishlist;
DROP TABLE IF EXISTS Property_Feature;
DROP TABLE IF EXISTS Listing;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Tax_Juridiction;
DROP TABLE IF EXISTS Feature;
DROP TABLE IF EXISTS Property_Type;

DROP DATABASE IF EXISTS LiveListing;

CREATE DATABASE LiveListing;

USE LiveListing;


--Tables Creations

CREATE TABLE Property_Type
(
	Property_TypeID INT IDENTITY(1,1) PRIMARY KEY,
	Code INT NOT NULL,
	Label_Type VARCHAR(20) NOT NULL
);


CREATE TABLE Feature
(
	FeatureID INT IDENTITY(1,1) PRIMARY KEY,
	Code INT NOT NULL,
	Label_Feature VARCHAR(20) NOT NULL,
	Value_Type VARCHAR(20) NOT NULL
);


CREATE TABLE Tax_Juridiction
(
	Tax_JuridictionID INT IDENTITY(1,1) PRIMARY KEY,
	Provincial_Taxrate DECIMAL(5,3) NOT NULL,
	National_Taxrate DECIMAL(5,3) NOT NULL
);


CREATE TABLE Address
(
	Mailing_AddressID INT IDENTITY(1,1) PRIMARY KEY,
	City VARCHAR(20) NOT NULL,
	Region VARCHAR(20) NOT NULL,
	Postal_Code VARCHAR(6) NOT NULL,
	Tax_JuridictionID INT NOT NULL FOREIGN KEY REFERENCES Tax_Juridiction(Tax_JuridictionID)
);


CREATE TABLE Property
(
	PropertyID INT IDENTITY(1,1) PRIMARY KEY,
	Property_TypeID INT NOT NULL FOREIGN KEY REFERENCES Property_Type(Property_TypeID),
	Mailing_AddressID INT NOT NULL FOREIGN KEY REFERENCES Address(Mailing_AddressID)	
);


CREATE TABLE Listing
(
	ListingID INT IDENTITY(1,1) PRIMARY KEY,
	PropertyID INT NOT NULL FOREIGN KEY REFERENCES Property(PropertyID),
	Listing_Price MONEY NOT NULL,
	Status BIT NOT NULL,
	Listing_Date DATE NOT NULL,
	Open_House_Date DATETIME
);



CREATE TABLE Property_Feature
(
	Property_FeatureID INT IDENTITY(1,1) PRIMARY KEY,
	PropertyID INT NOT NULL FOREIGN KEY REFERENCES Property(PropertyID),
	FeatureID INT NOT NULL FOREIGN KEY REFERENCES Feature(FeatureID),
	Feature_Value NVARCHAR(20) NOT NULL
);


CREATE TABLE WishList
(
	WishlistID INT IDENTITY(1,1) PRIMARY KEY,
	FeatureID INT NOT NULL FOREIGN KEY REFERENCES Feature(FeatureID),
	Weight INT 
);


CREATE TABLE Clients
(
	ClientID INT IDENTITY(1,1) PRIMARY KEY,
	Mailing_AddressID INT NOT NULL FOREIGN KEY REFERENCES Address(Mailing_AddressID),
	Fisrt_Name NVARCHAR(60) NOT NULL,
	Last_Name NVARCHAR(60) NOT NULL,
	Client_Type VARCHAR(20) NOT NULL,
	Date_Of_Birth DATE,
	Email VARCHAR(60) NOT NULL,
	Phone_Number VARCHAR(20) NOT NULL,
	Account_Creation_Date DATETIME NOT NULL	
);


CREATE TABLE Subscription
(
	SubscriptionID INT IDENTITY(1,1) PRIMARY KEY,
	ClientID INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientID),
	WishlistID INT NOT NULL FOREIGN KEY REFERENCES Wishlist(WishlistID)
);


CREATE TABLE ListingSeller
(
	ListingID INT PRIMARY KEY FOREIGN KEY REFERENCES Listing(ListingID),
	ClientID INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientID)
);


CREATE TABLE Review
(
	ReviewID INT IDENTITY(1,1) PRIMARY KEY,
	PropertyID INT NOT NULL FOREIGN KEY REFERENCES Property(PropertyID),
	ClientID INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientID),
	Rating DECIMAL(3,1),
	Comment NVARCHAR(1000) 
);


CREATE TABLE Billing_Account
(
	Billing_AccountID INT IDENTITY(1,1) PRIMARY KEY,
	ClientID INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientID),
	Mailing_AddressID INT NOT NULL FOREIGN KEY REFERENCES Address(Mailing_AddressID)
);


CREATE TABLE Payment_Method
(
	Payment_MethodID INT IDENTITY(1,1) PRIMARY KEY,
	Billing_AccountID INT NOT NULL FOREIGN KEY REFERENCES Billing_Account(Billing_AccountID),
	Method_Type VARCHAR(20) NOT NULL
);



CREATE TABLE Invoice
(
	InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
	Billing_AccountID INT NOT NULL FOREIGN KEY REFERENCES Billing_Account(Billing_AccountID),
	Status VARCHAR(20), 
	Invoice_Comment NVARCHAR(1000),
	Date DATETIME NOT NULL,
	Payment_Deadline DATE
);


CREATE TABLE InvoiceDetail
(
	InvoiceID INT PRIMARY KEY FOREIGN KEY REFERENCES Invoice(InvoiceID),
	Total_Amount MONEY NOT NULL,
	Subtotal_Amount MONEY NOT NULL,
	Provincial_Tax_Amount MONEY,
	National_Tax_Amount MONEY
);


CREATE TABLE Payment
(
	PaymentID INT IDENTITY(1,1) PRIMARY KEY,
	Payment_MethodID INT NOT NULL FOREIGN KEY REFERENCES Payment_Method(Payment_MethodID),
	InvoiceID INT NOT NULL FOREIGN KEY REFERENCES Invoice(InvoiceID),
	Confirmation_Code VARCHAR(20)
);


CREATE TABLE CreditCard
(
	Payment_MethodID INT PRIMARY KEY FOREIGN KEY REFERENCES Payment_Method(Payment_MethodID),
	Card_Number VARCHAR(20) NOT NULL,
	Expiry_Month INT NOT NULL,
	Expiry_Year INT NOT NULL,
	Security_Code INT NOT NULL
);


CREATE TABLE Paypal
(
	Payment_MethodID INT PRIMARY KEY FOREIGN KEY REFERENCES Payment_Method(Payment_MethodID),
	Paypal_Code VARCHAR(20) NOT NULL
);


CREATE TABLE BankTransfer
(
	Payment_MethodID INT PRIMARY KEY FOREIGN KEY REFERENCES Payment_Method(Payment_MethodID),
	SWIFT VARCHAR(20) NOT NULL,
	Branch_Code INT NOT NULL,
	Account_Number INT NOT NULL
);

--Constraints: 

ALTER TABLE Listing
ADD CONSTRAINT Open_House_Constraint
CHECK ( Open_House_Date IS NULL OR Open_House_Date > Listing_Date);

ALTER TABLE Invoice
ADD CONSTRAINT Due_Date_Constraint
CHECK (Payment_Deadline > Date);

ALTER TABLE CreditCard
ADD CONSTRAINT CardNumber_Constraint
CHECK (LEN(Card_Number) = 16);

ALTER TABLE CreditCard
ADD CONSTRAINT SecurityCode_Constraint
CHECK (
		(LEN(Security_Code) = 3) OR 
		(LEN(Security_Code) = 4 )
);


ALTER TABLE CreditCard
ADD CONSTRAINT ExpirationMonth_Constraint
CHECK (Expiry_Month BETWEEN 1 AND 12);

ALTER TABLE CreditCard
ADD CONSTRAINT ExpirationYear_Constraint
CHECK (LEN(Expiry_Year) = 4);

ALTER TABLE CreditCard
ADD CONSTRAINT ExpirationDate_Constraint
CHECK (
		(Expiry_Year > YEAR(GETDATE())) 
	OR
		(Expiry_Year =  YEAR(GETDATE()) 
		AND Expiry_Month > MONTH(GETDATE()))
);

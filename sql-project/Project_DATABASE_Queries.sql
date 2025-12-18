/*
================================================================================
LiveListing Database - Queries

Presented by: 
	Champ-Long, Maxence 11332347
	Pourcher, Simon 11335659
	Tshiya,Estha Wamonakeba 11317258
	Ward, Ben 11369514
================================================================================
In this section, we explore several queries by addressing different questions:
	- Question 1: Property Price Adjustment
	- Question 2: Natural Disaster Impact
	- Question 3: Data Cleaning
================================================================================
*/

--In this project we will use some functions : 

--Percentage format function: 
DROP FUNCTION IF EXISTS dbo.funcTranformInPercent; 
GO

CREATE FUNCTION dbo.funcTranformInPercent(@VALUE FLOAT) --we creating a function that will transform any value into percentage (with the percentage sign)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @PERCENT INT;
    SET @PERCENT = @VALUE * 100;
    RETURN CONCAT(@PERCENT, ' %');
END;
GO
--Money format function
DROP FUNCTION IF EXISTS dbo.funcMoneyFormat; 
GO

CREATE FUNCTION dbo.funcMoneyFormat (@Value MONEY)
RETURNS NVARCHAR(30)
AS
BEGIN
    -- Convert MONEY to NVARCHAR with 2 decimals, no scientific notation
    DECLARE @Formatted NVARCHAR(30);
    SET @Formatted = FORMAT(@Value,'C','fr-ca');
    RETURN @Formatted;
END;
GO

USE LiveListing;
GO

/*Question 1 
The price per square meter is expected to increase soon in several Ontario cities. 
To assess the impact of this upcoming change, the Director has requested two detailed
reports from our agency:

    1. A first report listing all residences that have not yet been listed.
    2. A second report listing all residences that are currently listed but not sold.

Each report must include:

    - The ID of the properties concerned
	- City
	- Region
    - The type of property (e.g., apartment, villa, townhouse)
    - The current price renamed as the previous price (Inclued the taxes of that provinces)
    - The number of features they include (e.g., pool, garden, smart home)

Note: But for the first report since there is no price yet for those properties no need to provide prices
*/

--Report 1
SELECT 
    P.PropertyID,
    A.City,
    A.Region,
    PT.Label_Type AS Property_Type,
    COUNT(PF.FeatureID) AS Number_of_Features
FROM Property P
INNER JOIN Address A ON P.Mailing_AddressID = A.Mailing_AddressID
INNER JOIN Property_Type PT ON P.Property_TypeID = PT.Property_TypeID
LEFT JOIN Property_Feature PF ON P.PropertyID = PF.PropertyID
LEFT JOIN Listing L ON P.PropertyID = L.PropertyID  -- LEFT JOIN so missing listings return NULL
WHERE L.PropertyID IS NULL   -- Means: property has no listing so it is not listed
GROUP BY P.PropertyID, A.City, A.Region, PT.Label_Type
ORDER BY P.PropertyID;


--Report 2
SELECT 
    P.PropertyID,
    A.City,
    A.Region,
    PT.Label_Type AS Property_Type,

    -- Price including taxes
    dbo.funcMoneyFormat(l.Listing_Price *(1 + TJ.Provincial_Taxrate + TJ.National_Taxrate)) 
	AS Previous_Price,
    COUNT(PF.FeatureID) AS Number_of_Features

FROM Listing L
INNER JOIN Property P ON L.PropertyID = P.PropertyID
INNER JOIN Address A ON P.Mailing_AddressID = A.Mailing_AddressID
INNER JOIN Tax_Juridiction TJ ON A.Tax_JuridictionID = TJ.Tax_JuridictionID
INNER JOIN Property_Type PT ON P.Property_TypeID = PT.Property_TypeID
LEFT JOIN Property_Feature PF ON P.PropertyID = PF.PropertyID
WHERE L.Status = 1   -- listed but not sold
GROUP BY 
    P.PropertyID, A.City, A.Region, PT.Label_Type,
    L.Listing_Price, TJ.Provincial_Taxrate, TJ.National_Taxrate
ORDER BY P.PropertyID;

/*INTERPRETATION OF RESULTS
The code produced the two required reports: 
the first lists all properties in Ontario that have not yet been listed, allowing us to identify residences that will be affected by future price changes; 
the second lists properties that are currently listed but not yet sold, providing insight into the active market inventory that may require price adjustments 
*/


/* Question 2 
Scientists are afraid that an increase in natural disasters will occur because of global warming. 
Therefore, having a database that not only gives the value of the properties but also of the land where they are built is a must for our agency. 
In case of the destruction of the property we have all the information on 
	- how much we value the land, 
	- an estimate of the cost to rebuild the property, 
	- the amount of money spent in renovation to protect 
	- the buildings against disasters 
	- and the risk of natural disasters happening. 

Disaster info per active listing
   - Land value       = 50% of property value
   - Rebuild cost     = 20% of property value
   - Reno protection  = 8% of property value
*/

SELECT
    L.ListingID,
    P.PropertyID,
    A.City,
    A.Region,
    A.Postal_Code,

    -- Base property value (listing price)
     dbo.funcMoneyFormat(L.Listing_Price) AS Property_Value,
    -- 50% of property value
     dbo.funcMoneyFormat(L.Listing_Price * 0.50) AS Land_Value,
    -- 20% of property value
     dbo.funcMoneyFormat(L.Listing_Price * 0.20) AS Estimated_Rebuild_Cost,
    -- 8% of property value
     dbo.funcMoneyFormat(L.Listing_Price * 0.08) AS Disaster_Protection_Renovation_Cost
FROM Listing L
INNER JOIN Property P ON P.PropertyID = L.PropertyID
INNER JOIN Address A ON A.Mailing_AddressID = P.Mailing_AddressID
WHERE L.Status = 1;   -- Only active listings

/*INTERPRETATION OF RESULTS
The results provide key disaster-related indicators for each active listing by estimating 
	- the value of the land, 
	- the potential rebuilding cost, 
	- and the amount typically invested in protective renovations based on fixed percentages of the property value. 
 Together, these metrics give the agency a clear overview of the financial impact that a catastrophic event could have on each property and 
 help prioritize which listings may require further assessment or adjustments. */

/* Question 3  For this question we will prepare a TRIGGER */ 
DROP TABLE IF EXISTS ClientSupp;
GO

CREATE TABLE ClientSupp
(
    ClientSuppID        INT IDENTITY(1,1) PRIMARY KEY,
    ClientID              INT         NOT NULL,
    Fisrt_Name            NVARCHAR(60) NOT NULL,
    Last_Name             NVARCHAR(60) NOT NULL,
    Email                 NVARCHAR(100) NOT NULL,
    Client_Type           VARCHAR(20)   NULL,
    Phone_Number          VARCHAR(20)   NULL,
    Mailing_AddressID     INT           NULL,
    Account_Creation_Date DATETIME      NULL,
    DeletionDate          DATETIME      NOT NULL
);
GO

DROP TRIGGER IF EXISTS dbo.ClientDeletion;
GO

CREATE TRIGGER dbo.ClientDeletion
ON dbo.Clients
AFTER DELETE
AS
BEGIN
    -- One timestamp for the whole delete operation
    DECLARE @Now DATETIME;
    SET @Now = GETDATE();
    -- Insert ALL deleted rows into the log table
    INSERT INTO ClientSupp (ClientID,Fisrt_Name,Last_Name,Email,Client_Type,Phone_Number,Mailing_AddressID,Account_Creation_Date,DeletionDate)
    SELECT D.ClientID, D.Fisrt_Name,D.Last_Name,D.Email,D.Client_Type,D.Phone_Number,D.Mailing_AddressID,D.Account_Creation_Date,@Now
    FROM DELETED AS D;
END;
GO


-- Before delete
SELECT * FROM Clients;
SELECT * FROM ClientSupp;




/* Question 3 :

An employee at the agency is responsible for cleaning the database because there are duplicate records and consistency errors. 
For example, some clients have changed address, others lost their passwords and ended up with two or more accounts, 
             and some even have two different names linked to the same email address.
Therefore, we need to display:
		- Each unique client, 
		- Their address, 
		- Email, 
		- Status, 
		- And account creation date (if available; otherwise we omit it). 

Finally, we must delete the records that need to be removed and generate a report listing what was deleted, including :
		The clients’ names and related details. 
*/

/* FISRT PART: Clients with same emails but new phone number
STEP 1 we create a function */

DROP FUNCTION IF EXISTS dbo.funcGetUniqueClient;
GO

-- Function to get the smallest ClientID for a given email (unique client determination)
CREATE FUNCTION dbo.funcGetUniqueClient (@ClientEmail NVARCHAR(100))
RETURNS INT 
AS
BEGIN
    DECLARE @MinClientID INT;

    -- Using a subquery to retrieve the minimum ClientID associated with the email
    SET @MinClientID = (
        SELECT MIN(ClientID)
        FROM Clients
        WHERE Email = @ClientEmail
    );

    RETURN @MinClientID;
END;
GO


/* STEP 2 Declare a variable to store number of duplicate records that will be deleted*/
DECLARE @DuplicatesCount INT;

-- Preview of records THAT WILL BE DELETED (duplicates)
SELECT
    C.ClientID AS 'Deleted Client ID',
    CONCAT(C.Fisrt_Name, ' ', C.Last_Name) AS 'Deleted Client Name',
    C.Email AS 'Associated Email',
    CONCAT(A.City, ', ', A.Region, ', ', A.Postal_Code) AS [Mailing Address of Deleted Record]
FROM Clients C
INNER JOIN Address A ON C.Mailing_AddressID = A.Mailing_AddressID
WHERE C.ClientID NOT IN (
    SELECT MIN(ClientID)
    FROM Clients
    GROUP BY Email)

ORDER BY C.Email ASC;

--Count duplicates before delete for 

SET @DuplicatesCount = (
    SELECT COUNT(*)
    FROM Clients
    WHERE ClientID NOT IN (
        SELECT MIN(ClientID)
        FROM Clients
        GROUP BY Email
    )
);
/* STEP 3 DELETION
Delete duplicates first in tables where there are linked as a foreign key */
DELETE FROM Review
WHERE ClientID IN (
    SELECT ClientID
    FROM Clients
    WHERE ClientID NOT IN (
        SELECT MIN(ClientID)
        FROM Clients
        GROUP BY Email
    )
);

DELETE FROM Billing_Account
WHERE ClientID IN (
    SELECT ClientID
    FROM Clients
    WHERE ClientID NOT IN (
        SELECT MIN(ClientID)
        FROM Clients
        GROUP BY Email
    )
);

DELETE FROM ListingSeller
WHERE ClientID IN (
    SELECT ClientID
    FROM Clients
    WHERE ClientID NOT IN (
        SELECT MIN(ClientID)
        FROM Clients
        GROUP BY Email
    )
);
-- Here we want to keep only unique email so for example:
--If Someone create a new account with same email it will only keep the lastest one, which means that he changed maybe the phone-number

DELETE FROM Clients
WHERE ClientID NOT IN (
    SELECT MIN(ClientID)
    FROM Clients
    GROUP BY Email -- Keep MIN(ClientID) per email, delete everything else.
);


/* STEP 4 Show remaining UNIQUE clients (one per email)*/
SELECT
    C.ClientID AS 'Unique Client ID',
    CONCAT(C.Fisrt_Name, ' ', C.Last_Name) AS [Client Name],
    C.Email AS [Email Address],
    C.Client_Type AS [Status],
    CONCAT(A.City, ', ', A.Region, ', ', A.Postal_Code) AS [Mailing Address],
    COALESCE(FORMAT(C.Account_Creation_Date, 'yyyy-MM-dd'),'') AS [Account Creation Date],
    dbo.funcGetUniqueClient(C.Email) AS 'Verified Unique Client ID'

FROM Clients C
	INNER JOIN Address A ON C.Mailing_AddressID = A.Mailing_AddressID
ORDER BY C.ClientID ASC;


/*SECOND PART: People with same name but new emails
We gonna do the same process */
DROP FUNCTION IF EXISTS dbo.funcGetUniqueName;
GO

-- Function to get the smallest ClientID for a given person
-- A "unique client" is defined by: First Name + Last Name + Date of Birth
CREATE FUNCTION dbo.funcGetUniqueName (@FirstName   NVARCHAR(60),@LastName    NVARCHAR(60),@BirthDate   DATE)
RETURNS INT 
AS
BEGIN
    DECLARE @MinClientID INT;

    -- Get the minimum ClientID for this person (same name + DOB)
    SET @MinClientID = (
        SELECT MIN(ClientID)
        FROM Clients
        WHERE Fisrt_Name   = @FirstName
          AND Last_Name    = @LastName
          AND Date_Of_Birth = @BirthDate
    );

    RETURN @MinClientID;
END;
GO


/* STEP 2 Declare a variable to store number of duplicate records that will be deleted */
DECLARE @DuplicatesCountN INT;

-- Preview of records THAT WILL BE DELETED (duplicates)
-- A duplicate is any ClientID that is NOT the minimum per (FirstName, LastName, BirthDate)
SELECT
    C.ClientID AS 'Deleted Client ID',
    CONCAT(C.Fisrt_Name, ' ', C.Last_Name) AS 'Deleted Client Name',
    C.Email AS 'Associated Email',
    CONCAT(A.City, ', ', A.Region, ', ', A.Postal_Code) AS [Mailing Address of Deleted Record]
FROM Clients C
INNER JOIN Address A ON C.Mailing_AddressID = A.Mailing_AddressID
WHERE C.ClientID NOT IN (
    SELECT MIN(ClientID)
    FROM Clients
    GROUP BY Fisrt_Name, Last_Name, Date_Of_Birth
)
ORDER BY C.Email ASC;

-- Count duplicates before delete
SET @DuplicatesCountN = (
    SELECT COUNT(*)
    FROM Clients
    WHERE ClientID NOT IN (
        SELECT MIN(ClientID)
        FROM Clients
        GROUP BY Fisrt_Name, Last_Name, Date_Of_Birth
    )
);


/* STEP 3 DELETION
   Delete duplicates first in tables where Clients is referenced as a foreign key */

DELETE FROM Review
WHERE ClientID IN (
    SELECT ClientID
    FROM Clients
    WHERE ClientID NOT IN (
        SELECT MIN(ClientID)
        FROM Clients
        GROUP BY Fisrt_Name, Last_Name, Date_Of_Birth
    )
);

DELETE FROM Billing_Account
WHERE ClientID IN (
    SELECT ClientID
    FROM Clients
    WHERE ClientID NOT IN (
        SELECT MIN(ClientID)
        FROM Clients
        GROUP BY Fisrt_Name, Last_Name, Date_Of_Birth
    )
);

DELETE FROM ListingSeller
WHERE ClientID IN (
    SELECT ClientID
    FROM Clients
    WHERE ClientID NOT IN (
        SELECT MIN(ClientID)
        FROM Clients
        GROUP BY Fisrt_Name, Last_Name, Date_Of_Birth
    )
);

-- Here we want to keep only ONE row per real person:
-- For each (FirstName, LastName, Date_Of_Birth), keep the MIN(ClientID) and delete the rest.
-- If someone created multiple accounts (possibly with different emails, phones, etc.),
-- we treat them as the same client and keep only one record.

DELETE FROM Clients
WHERE ClientID NOT IN (
    SELECT MIN(ClientID)
    FROM Clients
    GROUP BY Fisrt_Name, Last_Name, Date_Of_Birth  -- Unique person definition
);


/* STEP 4 Show remaining UNIQUE clients (one per real person) */
SELECT
    C.ClientID AS 'Unique Client ID',
    CONCAT(C.Fisrt_Name, ' ', C.Last_Name) AS [Client Name],
    C.Email AS [Email Address],
    C.Client_Type AS [Status],
    CONCAT(A.City, ', ', A.Region, ', ', A.Postal_Code) AS [Mailing Address],
    COALESCE(FORMAT(C.Account_Creation_Date, 'yyyy-MM-dd'),'') AS [Account Creation Date],

    -- Verify the unique ID for this person using the function
    dbo.funcGetUniqueName(C.Fisrt_Name, C.Last_Name, C.Date_Of_Birth) AS 'Verified Unique Client ID'

FROM Clients C
INNER JOIN Address A ON C.Mailing_AddressID = A.Mailing_AddressID
ORDER BY C.ClientID ASC;


/* AFTER delete */
SELECT * FROM Clients;

SELECT * FROM ClientSupp
ORDER BY DeletionDate DESC, ClientSuppID DESC;

/* INTERPRETATION OF RESULTS
The results first highlighted unique clients based on email, allowing us to identify duplicate accounts created under the same address. 
We then refined the analysis by grouping clients using 
	- their first name, 
	- last name, 
	- and date of birth, 
revealing cases where the same person had multiple accounts with different emails or updated information. 
By applying both filters, the code detected and removed all duplicate entries, ensuring that only one accurate record per real client remains in the database.*/

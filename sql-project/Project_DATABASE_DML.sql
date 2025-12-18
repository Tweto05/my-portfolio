/*
================================================================================
LiveListing Database - DML

Presented by: 
	Champ-Long, Maxence 
	Pourcher, Simon 
	Tshiya,Estha Wamonakeba 
	Ward, Ben 
================================================================================
Summary:
	- 3 Property Types
	- 12 Features
	- 8 Tax Jurisdictions
	- 90 Addresses (50 for properties & 40 for people)
	- 35 Properties
	- 30 Active Listings
	- 200+ Property Features
	- 40+ Clients (Sellers, Paid Users, Free Users)
	- 33 Listing-Seller
	- 12 Wishlists
	- 12 Subscriptions
	- 30 Reviews
	- 27+ Billing Accounts
	- 27+ Payment Methods (18 Credit Cards, 5 Bank Transfers, 4 PayPal)
	- 30 Invoices
	- 30 Invoice Details
	- 28 Payments
================================================================================
*/

USE LiveListing;
GO


-- 1. PROPERTY TYPES

INSERT INTO Property_Type (Code, Label_Type) VALUES
(101, 'Single-Family'),
(102, 'Multiplex'),
(103, 'Condominium');


-- 2. FEATURES

INSERT INTO Feature (Code, Label_Feature, Value_Type) VALUES
(201, 'Bedrooms', 'NUMBER'),
(202, 'Bathrooms', 'NUMBER'),
(203, 'Waterfront', 'BOOLEAN'),
(204, 'Water View', 'BOOLEAN'),
(205, 'Fireplace', 'BOOLEAN'),
(206, 'Pool', 'BOOLEAN'),
(207, 'Finished Basement', 'BOOLEAN'),
(208, 'Garage', 'BOOLEAN'),
(209, 'Air Conditioning', 'BOOLEAN'),
(210, 'Square Footage', 'NUMBER'),
(211, 'Lot Size', 'NUMBER'),
(212, 'Year Built', 'NUMBER');


-- 3. TAX JURISDICTIONS

INSERT INTO Tax_Juridiction (Provincial_Taxrate, National_Taxrate) VALUES (0.08, 0.05); -- Ontario (ON)
INSERT INTO Tax_Juridiction (Provincial_Taxrate, National_Taxrate) VALUES (0.07, 0.05); -- British Columbia (BC)
INSERT INTO Tax_Juridiction (Provincial_Taxrate, National_Taxrate) VALUES (0.09975, 0.05); -- Québec (QC)
INSERT INTO Tax_Juridiction (Provincial_Taxrate, National_Taxrate) VALUES (0.00, 0.05); -- Alberta (AB)
INSERT INTO Tax_Juridiction (Provincial_Taxrate, National_Taxrate) VALUES (0.07, 0.05); -- Manitoba (MB)
INSERT INTO Tax_Juridiction (Provincial_Taxrate, National_Taxrate) VALUES (0.06, 0.05); -- Saskatchewan (SK)
INSERT INTO Tax_Juridiction (Provincial_Taxrate, National_Taxrate) VALUES (0.10, 0.05); -- New Brunswick (NB)
INSERT INTO Tax_Juridiction (Provincial_Taxrate, National_Taxrate) VALUES (0.10, 0.05); -- Newfoundland and Labrador (NL)
INSERT INTO Tax_Juridiction (Provincial_Taxrate, National_Taxrate) VALUES (0.10, 0.05); -- Nova Scotia (NS)
INSERT INTO Tax_Juridiction (Provincial_Taxrate, National_Taxrate) VALUES (0.10, 0.05); -- Prince Edward Island (PE)

-- 4. ADDRESSES 90 addresses

INSERT INTO Address (City, Region, Postal_Code, Tax_JuridictionID) VALUES
-- 28 Ontario addresses (Tax_JuridictionID = 1)
('Toronto', 'ON', 'M5V2T6', 1),
('Toronto', 'ON', 'M4W1A8', 1),
('Mississauga', 'ON', 'L5B1M2', 1),
('Ottawa', 'ON', 'K1P5G4', 1),
('Hamilton', 'ON', 'L8P4R5', 1),
('Markham', 'ON', 'L3R5H3', 1),
('Vaughan', 'ON', 'L4L8V1', 1),
('Oakville', 'ON', 'L6H3H6', 1),
('Toronto', 'ON', 'M4C2L7', 1),
('London', 'ON', 'N6H3Y8', 1),
('Brampton', 'ON', 'L6V1R4', 1),
('Kitchener', 'ON', 'N2E3T2', 1),
('Windsor', 'ON', 'N9B2X1', 1),
('Ottawa', 'ON', 'K1C4B6', 1),
('Toronto', 'ON', 'M2H3M5', 1),
('London', 'ON', 'N1V1T7', 1),
('Ottawa', 'ON', 'K1N2C3', 1),
('Mississuaga', 'ON', 'L0P1E0', 1),
('Toronto', 'ON', 'M6J2B4', 1),
('Ottawa', 'ON', 'K2P1X9', 1),
('Mississauga', 'ON', 'L5N2R3', 1),
('Brampton', 'ON', 'L6S4M1', 1),
('Hamilton', 'ON', 'L9A3V6', 1),
('London', 'ON', 'N5Y4T2', 1),
('Kitchener', 'ON', 'N2B3K7', 1),
('Windsor', 'ON', 'N8X4G5', 1),
('Guelph', 'ON', 'N1H6N4', 1),
('Barrie', 'ON', 'L4N8S9', 1),

-- 9 British Columbia addresses (Tax_JuridictionID = 2)
('Vancouver', 'BC', 'V6B4Y8', 2),
('Victoria', 'BC', 'V8W2Y2', 2),
('Burnaby', 'BC', 'V5H4M1', 2),
('Surrey', 'BC', 'V3T4W4', 2),
('Vancouver', 'BC', 'V5K3N8', 2),
('Surrey', 'BC', 'V3T5W2', 2),
('Kelowna', 'BC', 'V1X4L9', 2),
('Victoria', 'BC', 'V8V1S3', 2),
('Burnaby', 'BC', 'V5H4B7', 2),

-- 21 Quebec addresses (Tax_JuridictionID = 3)
('Montreal', 'QC', 'H3B2E7', 3),
('Quebec City', 'QC', 'G1R4P5', 3),
('Laval', 'QC', 'H7S1Z5', 3),
('Gatineau', 'QC', 'J8T6G3', 3),
('Montréal', 'QC', 'H3N2T4', 3),
('Québec City', 'QC', 'G1R4V5', 3),
('Laval', 'QC', 'H7M3C8', 3),
('Sherbrooke', 'QC', 'J1G5A2', 3),
('Gatineau', 'QC', 'J8T2W3', 3),
('Montreal', 'QC', 'H7N2J6', 3),
('Montreal', 'QC', 'H4P3V4', 3),
('Quebec City', 'QC', 'G6V4X9', 3),
('Montreal', 'QC', 'H6H2K8', 3),
('Laval', 'QC', 'H3N2Y3', 3),
('Montréal', 'QC', 'H2X3L8', 3),
('Québec City', 'QC', 'G1S2Y3', 3),
('Laval', 'QC', 'H7G4M2', 3),
('Longueuil', 'QC', 'J4K2P8', 3),
('Trois-Rivières', 'QC', 'G8T4V1', 3),
('Sherbrooke', 'QC', 'J1H2Z9', 3),
('Gatineau', 'QC', 'J9J3C4', 3),

-- 22 Alberta addresses (Tax_JuridictionID = 4)
('Calgary', 'AB', 'T2P2M5', 4),
('Edmonton', 'AB', 'T5J2R7', 4),
('Red Deer', 'AB', 'T4N6V7', 4),
('Calgary', 'AB', 'T2P4B1', 4),
('Edmonton', 'AB', 'T5J2L9', 4),
('Red Deer', 'AB', 'T4N6Z8', 4),
('Lethbridge', 'AB', 'T1J3P5', 4),
('Banff', 'AB', 'T1L1B3', 4),
('Red Deer', 'AB', 'T9H0J1', 4),
('Red Deer', 'AB', 'T9K1V2', 4),
('Edmonton', 'AB', 'T9P1L1', 4),
('Banff', 'AB', 'T9U8L4', 4),
('Calgary', 'AB', 'T1C3H7', 4),
('Calgary', 'AB', 'T3B4T2', 4),
('Edmonton', 'AB', 'T2L2R8', 4),
('Edmonton', 'AB', 'T1V3X6', 4),
('Edmonton', 'AB', 'T2A3P9', 4),
('Banff', 'AB', 'T3H2X5', 4),
('Lethbridge', 'AB', 'T2W3M1', 4),
('Lethbridge', 'AB', 'T1P4C7', 4),
('Lethbridge', 'AB', 'T2N5H3', 4),
('Calgary', 'AB', 'T2H2J4', 4),

-- 5 Manitoba addresses (ID = 5)
('Winnipeg', 'MB', 'R3T4A1', 5),
('Brandon', 'MB', 'R7B3H2', 5),
('Steinbach', 'MB', 'R5G1M4', 5),
('Thompson', 'MB', 'R8N1Y8', 5),
('Portage la Prairie', 'MB', 'R1N3V7', 5),

-- 5 Prince Edward Island Addresses (ID = 10)
('Charlottetown', 'PE', 'C1A5E7', 10),
('Summerside', 'PE', 'C1N3V6', 10),
('Stratford', 'PE', 'C1B2L1', 10),
('Cornwall', 'PE', 'C0A1H5', 10),
('Montague', 'PE', 'C0A1R0', 10);


-- 5. PROPERTIES (50 properties)
-- Single-Family Homes (Property_TypeID = 1)
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (1, 1);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (1, 2);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (1, 3);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (1, 4);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (1, 5);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (1, 6);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (1, 7);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (1, 8);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (1, 9);

-- Multiplexes (Property_TypeID = 2)
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 10);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 11);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 12);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 13);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 14);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 15);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 16);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 17);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 18);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 19);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 20);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 21);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 22);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 23);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 24);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 25);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 26);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 27);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 28);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 29);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 30);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 31);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (2, 32);

-- Condominiums (Property_TypeID = 3)
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 33);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 34);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 35);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 36);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 37);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 38);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 39);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 40);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 41);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 42);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 43);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 44);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 45);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 46);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 47);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 48);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 49);
INSERT INTO Property (Property_TypeID, Mailing_AddressID) VALUES (3, 50);


-- 6. LISTINGS (30 active listings)
-- status of 1 means they are listed but not sold, status of 0 mean they are sold, and if it's not in listing it means they are not listed yet

INSERT INTO Listing (PropertyID, Listing_Price, Status, Listing_Date, Open_House_Date) VALUES
-- 10 Recent listings with open houses
(1, 875000.00, 1, '2024-11-15', '2024-12-07 14:00:00'),
(2, 1250000.00, 1, '2024-11-20', '2024-12-08 13:00:00'),
(3, 695000.00, 1, '2024-11-22', NULL),
(4, 825000.00, 1, '2024-11-25', '2024-12-10 15:00:00'),
(5, 550000.00, 0, '2024-11-28', NULL),
(6, 920000.00, 0, '2024-11-30', '2024-12-14 14:00:00'),
(7, 1100000.00, 1, '2024-12-01', '2024-12-15 13:00:00'),
(8, 1450000.00, 0, '2024-12-02', NULL),
(9, 780000.00, 0, '2024-10-15', NULL),
(10, 890000.00, 0, '2024-10-20', NULL),

-- 7 Multiplex listings
(16, 1350000.00, 1, '2024-11-18', '2024-12-09 15:00:00'),
(17, 980000.00, 0, '2024-11-21', NULL),
(18, 1200000.00, 0, '2024-11-24', '2024-12-11 14:00:00'),
(19, 850000.00, 0, '2024-11-27', NULL),
(20, 1100000.00, 1, '2024-12-01', NULL),
(21, 925000.00, 0, '2024-10-10', NULL),
(22, 1050000.00, 1, '2024-10-25', NULL),

-- 10 Condominium listings
(26, 425000.00, 1, '2024-11-16', '2024-12-06 16:00:00'),
(27, 385000.00, 1, '2024-11-19', NULL),
(28, 510000.00, 0, '2024-11-23', '2024-12-12 15:00:00'),
(29, 465000.00, 1, '2024-11-26', NULL),
(30, 395000.00, 0, '2024-11-29', NULL),
(31, 575000.00, 0, '2024-12-01', '2024-12-13 16:00:00'),
(32, 445000.00, 0, '2024-12-02', NULL),
(33, 520000.00, 1, '2024-10-18', NULL),
(34, 380000.00, 0, '2024-10-22', NULL),
(35, 490000.00, 0, '2024-10-28', NULL),

-- 3 Additional single-family listings
(11, 975000.00, 0, '2024-11-17', NULL),
(12, 1150000.00, 0, '2024-11-29', '2024-12-16 14:00:00'),
(13, 725000.00, 0, '2024-10-12', NULL);



-- 7. PROPERTY FEATURES (comprehensive feature data)
-- Property 1: Luxury single-family home
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES
(1, 1, '4'), (1, 2, '3'), (1, 3, 'FALSE'), (1, 4, 'TRUE'),
(1, 5, 'TRUE'), (1, 6, 'FALSE'), (1, 7, 'TRUE'), (1, 8, 'TRUE'),
(1, 9, 'TRUE'), (1, 10, '2800'), (1, 11, '6500'), (1, 12, '2015');

-- Property 2: Premium waterfront home
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES
(2, 1, '5'), (2, 2, '4'), (2, 3, 'TRUE'), (2, 4, 'TRUE'),
(2, 5, 'TRUE'), (2, 6, 'TRUE'), (2, 7, 'TRUE'), (2, 8, 'TRUE'),
(2, 9, 'TRUE'), (2, 10, '3500'), (2, 11, '8000'), (2, 12, '2018');

-- Property 3: Starter home
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES
(3, 1, '3'), (3, 2, '2'), (3, 3, 'FALSE'), (3, 4, 'FALSE'),
(3, 5, 'TRUE'), (3, 6, 'FALSE'), (3, 7, 'FALSE'), (3, 8, 'TRUE'),
(3, 9, 'TRUE'), (3, 10, '1800'), (3, 11, '4500'), (3, 12, '2005');

-- Property 4: Family home
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES
(4, 1, '4'), (4, 2, '3'), (4, 3, 'FALSE'), (4, 4, 'TRUE'),
(4, 5, 'TRUE'), (4, 6, 'FALSE'), (4, 7, 'TRUE'), (4, 8, 'TRUE'),
(4, 9, 'TRUE'), (4, 10, '2400'), (4, 11, '5500'), (4, 12, '2010');

-- Property 5: Affordable home
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES
(5, 1, '3'), (5, 2, '2'), (5, 3, 'FALSE'), (5, 4, 'FALSE'),
(5, 5, 'FALSE'), (5, 6, 'FALSE'), (5, 7, 'FALSE'), (5, 8, 'TRUE'),
(5, 9, 'TRUE'), (5, 10, '1600'), (5, 11, '4000'), (5, 12, '1998');

-- Property 6-15: Various single-family homes
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES
(6, 1, '4'), (6, 2, '3'), (6, 5, 'TRUE'), (6, 8, 'TRUE'), (6, 9, 'TRUE'),
(7, 1, '5'), (7, 2, '4'), (7, 6, 'TRUE'), (7, 7, 'TRUE'), (7, 8, 'TRUE'),
(8, 1, '5'), (8, 2, '4'), (8, 3, 'TRUE'), (8, 6, 'TRUE'), (8, 9, 'TRUE'),
(9, 1, '3'), (9, 2, '2'), (9, 5, 'TRUE'), (9, 8, 'TRUE'), (9, 9, 'TRUE'),
(10, 1, '4'), (10, 2, '3'), (10, 7, 'TRUE'), (10, 8, 'TRUE'), (10, 9, 'TRUE'),
(11, 1, '4'), (11, 2, '3'), (11, 4, 'TRUE'), (11, 5, 'TRUE'), (11, 8, 'TRUE'),
(12, 1, '5'), (12, 2, '3'), (12, 6, 'TRUE'), (12, 7, 'TRUE'), (12, 9, 'TRUE'),
(13, 1, '3'), (13, 2, '2'), (13, 5, 'TRUE'), (13, 8, 'TRUE'), (13, 9, 'TRUE'),
(14, 1, '4'), (14, 2, '3'), (14, 7, 'TRUE'), (14, 8, 'TRUE'), (14, 9, 'TRUE'),
(15, 1, '4'), (15, 2, '3'), (15, 5, 'TRUE'), (15, 6, 'FALSE'), (15, 8, 'TRUE');

-- Property 16-25: Multiplexes
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES
(16, 1, '8'), (16, 2, '6'), (16, 8, 'TRUE'), (16, 9, 'TRUE'),
(17, 1, '6'), (17, 2, '4'), (17, 8, 'TRUE'), (17, 9, 'TRUE'),
(18, 1, '10'), (18, 2, '8'), (18, 8, 'TRUE'), (18, 9, 'TRUE'),
(19, 1, '6'), (19, 2, '4'), (19, 8, 'TRUE'), (19, 9, 'TRUE'),
(20, 1, '8'), (20, 2, '6'), (20, 8, 'TRUE'), (20, 9, 'TRUE'),
(21, 1, '6'), (21, 2, '5'), (21, 8, 'TRUE'), (21, 9, 'TRUE'),
(22, 1, '8'), (22, 2, '6'), (22, 8, 'TRUE'), (22, 9, 'TRUE'),
(23, 1, '6'), (23, 2, '4'), (23, 8, 'TRUE'), (23, 9, 'TRUE'),
(24, 1, '8'), (24, 2, '6'), (24, 8, 'TRUE'), (24, 9, 'TRUE'),
(25, 1, '6'), (25, 2, '4'), (25, 8, 'TRUE'), (25, 9, 'TRUE');

-- Property 26-35: Condominiums
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES
(26, 1, '2'), (26, 2, '2'), (26, 9, 'TRUE'), (26, 10, '1100'),
(27, 1, '2'), (27, 2, '1'), (27, 9, 'TRUE'), (27, 10, '950'),
(28, 1, '3'), (28, 2, '2'), (28, 4, 'TRUE'), (28, 9, 'TRUE'), (28, 10, '1400'),
(29, 1, '2'), (29, 2, '2'), (29, 9, 'TRUE'), (29, 10, '1200'),
(30, 1, '2'), (30, 2, '1'), (30, 9, 'TRUE'), (30, 10, '900'),
(31, 1, '3'), (31, 2, '2'), (31, 4, 'TRUE'), (31, 9, 'TRUE'), (31, 10, '1500'),
(32, 1, '2'), (32, 2, '2'), (32, 9, 'TRUE'), (32, 10, '1150'),
(33, 1, '3'), (33, 2, '2'), (33, 9, 'TRUE'), (33, 10, '1350'),
(34, 1, '1'), (34, 2, '1'), (34, 9, 'TRUE'), (34, 10, '750'),
(35, 1, '2'), (35, 2, '2'), (35, 9, 'TRUE'), (35, 10, '1100');

--Additional Properties 36-50
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (36, 2, '2');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (36, 3, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (36, 4, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (36, 5, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (36, 6, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (36, 7, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (36, 8, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (36, 9, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (37, 1, '4');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (37, 2, '1');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (37, 3, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (37, 4, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (37, 5, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (37, 6, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (37, 7, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (37, 8, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (37, 9, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (38, 1, '4');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (38, 2, '1');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (38, 3, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (38, 4, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (38, 5, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (38, 6, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (38, 7, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (38, 8, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (38, 9, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (39, 1, '2');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (39, 2, '1');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (39, 3, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (39, 4, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (39, 5, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (39, 6, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (39, 7, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (39, 8, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (39, 9, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (40, 1, '5');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (40, 2, '4');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (40, 3, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (40, 4, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (40, 5, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (40, 6, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (40, 7, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (40, 8, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (40, 9, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (41, 1, '1');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (41, 2, '4');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (41, 3, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (41, 4, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (41, 5, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (41, 6, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (41, 7, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (41, 8, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (41, 9, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (42, 1, '1');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (42, 2, '4');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (42, 3, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (42, 4, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (42, 5, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (42, 6, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (42, 7, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (42, 8, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (42, 9, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (43, 1, '1');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (43, 2, '3');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (43, 3, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (43, 4, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (43, 5, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (43, 6, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (43, 7, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (43, 8, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (43, 9, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (44, 1, '4');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (44, 2, '4');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (44, 3, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (44, 4, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (44, 5, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (44, 6, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (44, 7, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (44, 8, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (44, 9, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (45, 1, '4');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (45, 2, '3');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (45, 3, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (45, 4, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (45, 5, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (45, 6, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (45, 7, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (45, 8, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (45, 9, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (46, 1, '3');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (46, 2, '3');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (46, 3, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (46, 4, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (46, 5, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (46, 6, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (46, 7, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (46, 8, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (46, 9, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (47, 1, '1');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (47, 2, '2');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (47, 3, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (47, 4, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (47, 5, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (47, 6, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (47, 7, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (47, 8, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (47, 9, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (48, 1, '4');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (48, 2, '2');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (48, 3, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (48, 4, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (48, 5, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (48, 6, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (48, 7, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (48, 8, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (48, 9, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (49, 1, '1');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (49, 2, '2');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (49, 3, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (49, 4, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (49, 5, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (49, 6, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (49, 7, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (49, 8, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (49, 9, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (50, 1, '5');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (50, 2, '4');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (50, 3, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (50, 4, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (50, 5, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (50, 6, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (50, 7, 'TRUE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (50, 8, 'FALSE');
INSERT INTO Property_Feature (PropertyID, FeatureID, Feature_Value) VALUES (50, 9, 'FALSE');


-- 8. CLIENTS (40 clients: mix of sellers, paid users, free users)

INSERT INTO Clients (Mailing_AddressID, Fisrt_Name, Last_Name, Client_Type, Date_Of_Birth, Email, Phone_Number, Account_Creation_Date) VALUES
-- Sellers
(51, 'John', 'Smith', 'Seller', '1975-03-15', 'john.smith@email.com', '416-555-0101', '2024-10-01 09:30:00'),
(52, 'Sarah', 'Johnson', 'Seller', '1982-07-22', 'sarah.j@email.com', '604-555-0102', '2024-10-05 14:20:00'),
(53, 'Michael', 'Williams', 'Seller', '1968-11-08', 'mwilliams@email.com', '514-555-0103', '2024-10-10 11:15:00'),
(54, 'Emily', 'Brown', 'Seller', '1990-05-30', 'emily.brown@email.com', '403-555-0104', '2024-10-12 16:45:00'),
(55, 'David', 'Jones', 'Seller', '1978-09-14', 'djones@email.com', '305-555-0105', '2024-10-15 10:00:00'),
(56, 'Jennifer', 'Garcia', 'Seller', '1985-12-03', 'jgarcia@email.com', '512-555-0106', '2024-10-18 13:30:00'),
(57, 'Robert', 'Martinez', 'Seller', '1972-04-25', 'rmartinez@email.com', '858-555-0107', '2024-10-20 15:00:00'),
(58, 'Lisa', 'Rodriguez', 'Seller', '1988-08-17', 'lrodriguez@email.com', '212-555-0108', '2024-10-22 09:45:00'),
(59, 'James', 'Wilson', 'Seller', '1965-02-11', 'jwilson@email.com', '416-555-0109', '2024-10-25 12:00:00'),
(60, 'Mary', 'Anderson', 'Seller', '1992-06-28', 'manderson@email.com', '604-555-0110', '2024-10-28 14:30:00'),
(61, 'William', 'Taylor', 'Seller', '1980-10-05', 'wtaylor@email.com', '214-555-0111', '2024-11-01 10:15:00'),
(62, 'Patricia', 'Thomas', 'Seller', '1976-01-19', 'pthomas@email.com', '813-555-0112', '2024-11-05 11:45:00'),
(63, 'Richard', 'Moore', 'Seller', '1983-07-07', 'rmoore@email.com', '718-555-0113', '2024-11-08 13:20:00'),
(64, 'Linda', 'Jackson', 'Seller', '1970-03-22', 'ljackson@email.com', '323-555-0114', '2024-11-10 15:30:00'),
(65, 'Charles', 'White', 'Seller', '1987-11-16', 'cwhite@email.com', '780-555-0115', '2024-11-12 09:00:00'),

-- Paid Users 
(66, 'Jessica', 'Harris', 'Paid User', '1991-04-12', 'jharris@email.com', '450-555-0201', '2024-09-01 10:00:00'),
(67, 'Daniel', 'Martin', 'Paid User', '1984-08-25', 'dmartin@email.com', '416-555-0202', '2024-09-15 14:30:00'),
(68, 'Michelle', 'Thompson', 'Paid User', '1979-12-09', 'mthompson@email.com', '604-555-0203', '2024-10-01 11:20:00'),
(69, 'Kevin', 'Lee', 'Paid User', '1986-05-18', 'klee@email.com', '514-555-0204', '2024-10-10 16:00:00'),
(70, 'Amanda', 'Walker', 'Paid User', '1993-09-03', 'awalker@email.com', '403-555-0205', '2024-10-15 09:45:00'),
(71, 'Brian', 'Hall', 'Paid User', '1977-02-27', 'bhall@email.com', '305-555-0206', '2024-10-20 13:15:00'),
(72, 'Nicole', 'Allen', 'Paid User', '1989-06-14', 'nallen@email.com', '512-555-0207', '2024-10-25 15:45:00'),
(73, 'Jason', 'Young', 'Paid User', '1981-10-31', 'jyoung@email.com', '858-555-0208', '2024-11-01 10:30:00'),
(74, 'Stephanie', 'King', 'Paid User', '1974-03-08', 'sking@email.com', '212-555-0209', '2024-11-05 12:00:00'),
(75, 'Matthew', 'Wright', 'Paid User', '1995-07-21', 'mwright@email.com', '416-555-0210', '2024-11-10 14:20:00'),
(76, 'Rebecca', 'Lopez', 'Paid User', '1988-11-04', 'rlopez@email.com', '604-555-0211', '2024-11-15 09:30:00'),
(77, 'Andrew', 'Hill', 'Paid User', '1982-01-17', 'ahill@email.com', '214-555-0212', '2024-11-20 11:00:00'),

--They created new accounts and changed their emails
(69, 'Kevin', 'Lee', 'Paid User', '1986-05-18', 'klee345@email.com', '514-555-0204', '2024-12-10 16:00:00'),
(70, 'Amanda', 'Walker', 'Paid User', '1993-09-03', 'awalker678@email.com', '403-555-0205', '2024-11-15 09:45:00'),
(71, 'Brian', 'Hall', 'Paid User', '1977-02-27', 'bhall789@email.com', '305-555-0206', '2024-12-20 13:15:00'),
(72, 'Nicole', 'Allen', 'Paid User', '1989-06-14', 'nallen890@email.com', '512-555-0207', '2024-11-25 15:45:00'),
(73, 'Jason', 'Young', 'Paid User', '1981-10-31', 'jegyoung@email.com', '858-555-0208', '2024-11-21 10:30:00'),

-- Free Users
(78, 'Elizabeth', 'Scott', 'Free User', '1990-05-29', 'escott@email.com', '813-555-0301', '2024-11-01 10:00:00'),
(79, 'Jessica', 'Harris', 'Free User', '1991-04-12', 'jharris@email.com', '450-555-0201', '2024-09-01 10:00:00'),
(80, 'Ashley', 'Adams', 'Free User', '1992-02-24', 'aadams@email.com', '323-555-0303', '2024-11-05 11:15:00'),
(81, 'Christopher', 'Baker', 'Free User', '1978-06-07', 'cbaker@email.com', '780-555-0304', '2024-11-08 16:45:00'),
(82, 'Samantha', 'Nelson', 'Free User', '1987-10-20', 'snelson@email.com', '450-555-0305', '2024-11-10 09:20:00'),
(83, 'Ryan', 'Carter', 'Free User', '1994-03-15', 'rcarter@email.com', '416-555-0306', '2024-11-12 13:00:00'),
(84, 'Lauren', 'Mitchell', 'Free User', '1983-07-28', 'lmitchell@email.com', '604-555-0307', '2024-11-15 15:30:00'),
(85, 'Kevin', 'Lee', 'Free User', '1986-05-18', 'klee@email.com', '514-555-0204', '2024-11-18 10:45:00'),
(86, 'Megan', 'Roberts', 'Free User', '1976-04-03', 'mroberts@email.com', '403-555-0309', '2024-11-20 12:15:00'),
(87, 'Tyler', 'Turner', 'Free User', '1989-08-16', 'tturner@email.com', '305-555-0310', '2024-11-22 14:00:00'),
(88, 'Matthew', 'Wright', 'Free User', '1995-07-21', 'mwright@email.com', '416-555-0210', '2024-11-25 09:30:00'),
(89, 'Justin', 'Campbell', 'Free User', '1996-05-22', 'jcampbell@email.com', '858-555-0312', '2024-11-27 11:45:00'),
(90, 'Heather', 'Parker', 'Free User', '1984-09-05', 'hparker@email.com', '212-555-0313', '2024-11-29 16:00:00'),

--They created new accounts and changed their emails
(86, 'Megan', 'Roberts', 'Free User', '1976-04-03', 'mroberts100@email.com', '403-555-0309', '2024-12-20 12:15:00'),
(87, 'Tyler', 'Turner', 'Free User', '1989-08-16', 'tturner200@email.com', '305-555-0310', '2024-12-22 14:00:00'),
(88, 'Matthew', 'Wright', 'Free User', '1995-07-21', 'mwright456@email.com', '416-555-0210', '2024-12-25 09:30:00'),
(89, 'Justin', 'Campbell', 'Free User', '1996-05-22', 'jcampbell34@email.com', '858-555-0312', '2024-12-27 11:45:00'),
(90, 'Heather', 'Parker', 'Free User', '1984-09-05', 'hparker20@email.com', '212-555-0313', '2024-12-29 16:00:00'),

--They chnaged their phone numbers
(81, 'Christopher', 'Baker', 'Free User', '1978-06-07', 'cbaker@email.com', '514-505-0304', '2024-11-08 16:45:00'),
(82, 'Samantha', 'Nelson', 'Free User', '1987-10-20', 'snelson@email.com', '438-559-0305', '2024-11-10 09:20:00'),
(83, 'Ryan', 'Carter', 'Free User', '1994-03-15', 'rcarter@email.com', '514-555-0306', '2024-11-12 13:00:00'),
(84, 'Lauren', 'Mitchell', 'Free User', '1983-07-28', 'lmitchell@email.com', '514-555-0307', '2024-11-15 15:30:00'),
(85, 'Kevin', 'Lee', 'Free User', '1986-05-18', 'klee@email.com', '514-465-0287', '2024-11-18 10:45:00');


-- 9. LISTING SELLERS (Link sellers to their listings)

INSERT INTO ListingSeller (ListingID, ClientID) VALUES
-- Single sellers
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10),
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15),
(16, 1), (17, 2), (18, 3), (19, 4), (20, 5),
(21, 6), (22, 7), (23, 8), (24, 9), (25, 10),
(26, 11), (27, 12), (28, 13), (29, 14), (30, 15);



-- 10. WISHLISTS (For paid users)

INSERT INTO WishList (FeatureID, Weight) VALUES
-- Wishlist 1: Waterfront lover
(3, 10), (4, 8), (6, 7),
-- Wishlist 2: Family-oriented
(1, 10), (7, 9), (8, 8),
-- Wishlist 3: Luxury seeker
(6, 10), (5, 9), (9, 8),
-- Wishlist 4: Practical buyer
(1, 10), (2, 9), (8, 7),
-- Wishlist 5: Modern amenities
(9, 10), (8, 8), (5, 6),
-- Wishlist 6: Waterfront enthusiast
(3, 10), (6, 9), (4, 8),
-- Wishlist 7: Space seeker
(1, 10), (10, 9), (11, 8),
-- Wishlist 8: Comfort focused
(9, 10), (5, 9), (7, 7),
-- Wishlist 9: View lover
(4, 10), (3, 8), (5, 6),
-- Wishlist 10: Complete package
(1, 10), (2, 9), (5, 8), (8, 7),
-- Wishlist 11: Outdoor enthusiast
(6, 10), (11, 9), (3, 8),
-- Wishlist 12: Urban professional
(9, 10), (1, 7), (2, 6);


-- 11. SUBSCRIPTIONS (Link paid users to wishlists)

INSERT INTO Subscription (ClientID, WishlistID) VALUES
(16, 1), (17, 2), (18, 3), (19, 4),
(20, 5), (21, 6), (22, 7), (23, 8),
(24, 9), (25, 10), (26, 11), (27, 12);


-- 12. REVIEWS (Mix of ratings and comments from all user types)

INSERT INTO Review (PropertyID, ClientID, Rating, Comment) VALUES
-- Reviews from paid users
(1, 16, 4.5, 'Beautiful home with great curb appeal. Love the finished basement!'),
(2, 17, 5.0, 'Absolutely stunning waterfront property. The pool is amazing!'),
(3, 18, 3.5, 'Good starter home but needs some updates. Price seems fair.'),
(4, 19, 4.0, 'Nice family home in a great neighborhood. Schools nearby are excellent.'),
(5, 20, 3.0, 'Decent property but lacking some modern amenities.'),
(6, 21, 4.5, 'Lovely home with a beautiful fireplace. Very cozy!'),
(7, 22, 5.0, 'Dream home! The pool and garage are perfect for our family.'),
(8, 23, 4.8, 'Luxurious waterfront estate. Worth every penny!'),
(16, 24, 4.2, 'Great investment property. Well-maintained multiplex.'),
(17, 25, 3.8, 'Good rental potential. Location could be better.'),
(26, 26, 4.0, 'Nice condo with modern finishes. Great for first-time buyers.'),
(27, 27, 3.5, 'Compact but functional. Good value for the price.'),

-- Reviews from free users
(1, 28, 4.0, 'Impressive property! Wish I could afford it.'),
(2, 29, 5.0, 'This is my dream home! Saving up for a down payment.'),
(3, 30, 4.0, 'Perfect for young families. Great location.'),
(9, 31, 3.5, 'Nice home but the listing photos could be better.'),
(10, 32, 4.5, 'Love the finished basement. Great for entertaining!'),
(18, 33, 4.0, 'Solid investment opportunity. Good rental income potential.'),
(19, 34, 3.8, 'Well-maintained property. Good for investors.'),
(28, 35, 4.5, 'Beautiful condo with water views! Love it!'),
(29, 36, 4.0, 'Modern and clean. Perfect for professionals.'),
(30, 37, 3.5, 'Good starter condo. A bit small but well-priced.'),

-- Additional reviews from sellers (viewing competition)
(11, 1, 4.0, 'Checking out the competition. Nice property!'),
(12, 2, 4.5, 'Beautiful home. Sets a high bar for the neighborhood.'),
(20, 5, 3.8, 'Good multiplex. Similar to mine but different layout.'),
(26, 8, 4.2, 'Well-presented condo. Good marketing strategy.'),
(15, 10, 4.0, 'Comparable to my listing. Good to see market trends.'),

-- More detailed reviews
(4, 38, 5.0, 'Absolutely perfect! The open concept kitchen is stunning and the backyard is ideal for kids. Highly recommend viewing this property.'),
(7, 39, 4.8, 'Exceptional property with high-end finishes throughout. The pool area is resort-quality. Only minor concern is the property tax rate.'),
(21, 40, 4.3, 'Excellent multiplex for investors. All units are currently rented with good tenants. Cash flow positive from day one.'),
(31, 16, 4.7, 'Gorgeous condo with breathtaking water views. The building amenities are top-notch. Perfect for downsizers or young professionals.'),
(13, 17, 3.9, 'Solid home in a good neighborhood. Could use some cosmetic updates but has great bones. Priced competitively.');


-- 13. BILLING ACCOUNTS (For sellers and paid users)

INSERT INTO Billing_Account (ClientID, Mailing_AddressID) VALUES
-- Sellers' billing accounts
(1, 51), (2, 52), (3, 53), (4, 54), (5, 55),
(6, 56), (7, 57), (8, 58), (9, 59), (10, 60),
(11, 61), (12, 62), (13, 63), (14, 64), (15, 65),
-- Paid users' billing accounts
(16, 66), (17, 67), (18, 68), (19, 69), (20, 70),
(21, 71), (22, 72), (23, 73), (24, 74), (25, 75),
(26, 76), (27, 77),

--related to duplicates ones
(19, 69), (20, 70),
(21, 71), (22, 72), (23, 73);


-- 14. PAYMENT METHODS (Mix of credit cards, bank transfers, PayPal)

INSERT INTO Payment_Method (Billing_AccountID, Method_Type) VALUES
-- Credit cards (majority)
(1, 'Credit Card'), (2, 'Credit Card'), (3, 'Credit Card'),
(4, 'Credit Card'), (5, 'Credit Card'), (6, 'Credit Card'),
(7, 'Credit Card'), (8, 'Credit Card'), (9, 'Credit Card'),
(10, 'Credit Card'), (16, 'Credit Card'), (17, 'Credit Card'),
(18, 'Credit Card'), (19, 'Credit Card'), (20, 'Credit Card'),
(21, 'Credit Card'), (22, 'Credit Card'), (23, 'Credit Card'),

-- Bank transfers
(11, 'Bank Transfer'), (12, 'Bank Transfer'), (13, 'Bank Transfer'),
(24, 'Bank Transfer'), (25, 'Bank Transfer'),
-- PayPal
(14, 'PayPal'), (15, 'PayPal'), (26, 'PayPal'), (27, 'PayPal'),

--related to duplicates ones
(19, 'Credit Card'), (20, 'Credit Card'),
(21, 'Credit Card'), (22, 'Credit Card'), (23, 'Credit Card');


-- 15. CREDIT CARD DETAILS

INSERT INTO CreditCard (Payment_MethodID, Card_Number, Expiry_Month, Expiry_Year, Security_Code) VALUES
(1, '4532015112830366',08,2026,123),
(2, '5425233430109903',11,2027,456),
(3, '4916338506082832',03,2026,789),
(4, '5105105105105100',07,2028,321),
(5, '4024007134564842',12,2032,654),
(6, '5555555555554444',05,2027,987),
(7, '4111111111111111',09,2026,147),
(8, '5200828282828210',02,2028,258),
(9, '4012888888881881',06,2027,369),
(10, '5425233430109903',10,2026,741),
(11, '4532015112830366',04,2028,852),
(12, '5105105105105100',01,2027,963),
(13, '4916338506082832',11,2030,159),
(14, '4024007134564842',08,2027,357),
(15, '5555555555554444',03,2026,486),
(16, '4111111111111111',12,2028,624),
(17, '5200828282828210',07,2026,735),
(18, '4012888888881881',05,2027,846),

--Related to duplicates
(28, '4024007134564842',08,2027,357),
(29, '5555555555554444',03,2026,486),
(30, '4111111111111111',12,2028,624),
(31, '5200828282828210',07,2026,735),
(32, '4012888888881881',05,2027,846);


-- 16. BANK TRANSFER DETAILS

INSERT INTO BankTransfer (Payment_MethodID, SWIFT, Branch_Code, Account_Number) VALUES
(19, 'BOFAUS3NXXX', 12345, 987654321),
(20, 'CHASUS33XXX', 23456, 876543210),
(21, 'CITIUS33XXX', 34567, 765432109),
(22, 'WFBIUS6SXXX', 45678, 654321098),
(23, 'PNBPUS3NNYC', 56789, 543210987);


-- 17. PAYPAL DETAILS

INSERT INTO Paypal (Payment_MethodID, Paypal_Code) VALUES
(24, 'PP-12345-ABCDE'),
(25, 'PP-23456-BCDEF'),
(26, 'PP-34567-CDEFG'),
(27, 'PP-45678-DEFGH');




-- 18. INVOICES (For listing fees and subscriptions)

-- Listing fee invoices ($250 each) for sellers
INSERT INTO Invoice (Billing_AccountID, Status, Invoice_Comment, Date, Payment_Deadline) VALUES
(1, 'Paid', 'Listing fee for property at Toronto, ON', '2024-11-15 10:00:00', '2024-11-29'),
(2, 'Paid', 'Listing fee for property at Toronto, ON', '2024-11-20 11:30:00', '2024-12-04'),
(3, 'Paid', 'Listing fee for property at Mississauga, ON', '2024-11-22 09:15:00', '2024-12-06'),
(4, 'Paid', 'Listing fee for property at Ottawa, ON', '2024-11-25 14:45:00', '2024-12-09'),
(5, 'Paid', 'Listing fee for property at Hamilton, ON', '2024-11-28 16:20:00', '2024-12-12'),
(6, 'Paid', 'Listing fee for property at Markham, ON', '2024-11-30 10:30:00', '2024-12-14'),
(7, 'Paid', 'Listing fee for property at Vaughan, ON', '2024-12-01 13:00:00', '2024-12-15'),
(8, 'Paid', 'Listing fee for property at Oakville, ON', '2024-12-02 15:45:00', '2024-12-16'),
(9, 'Paid', 'Listing fee for property at Montreal, QC', '2024-10-15 11:00:00', '2024-10-29'),
(10, 'Paid', 'Listing fee for property at Quebec City, QC', '2024-10-20 12:30:00', '2024-11-03'),
(11, 'Paid', 'Listing fee for property at Vancouver, BC', '2024-11-17 09:45:00', '2024-12-01'),
(12, 'Paid', 'Listing fee for property at Victoria, BC', '2024-11-29 14:15:00', '2024-12-13'),
(13, 'Paid', 'Listing fee for property at Burnaby, BC', '2024-10-12 10:20:00', '2024-10-26'),
(1, 'Paid', 'Listing fee for multiplex property', '2024-11-18 11:45:00', '2024-12-02'),
(2, 'Paid', 'Listing fee for multiplex property', '2024-11-21 13:20:00', '2024-12-05');

-- Monthly subscription invoices ($15 each) for paid users
INSERT INTO Invoice (Billing_AccountID, Status, Invoice_Comment, Date, Payment_Deadline) VALUES
(16, 'Paid', 'Monthly subscription - November 2024', '2024-11-01 00:00:00', '2024-11-15'),
(17, 'Paid', 'Monthly subscription - November 2024', '2024-11-01 00:00:00', '2024-11-15'),
(18, 'Paid', 'Monthly subscription - November 2024', '2024-11-01 00:00:00', '2024-11-15'),
(19, 'Paid', 'Monthly subscription - November 2024', '2024-11-01 00:00:00', '2024-11-15'),
(20, 'Paid', 'Monthly subscription - November 2024', '2024-11-01 00:00:00', '2024-11-15'),
(21, 'Paid', 'Monthly subscription - November 2024', '2024-11-01 00:00:00', '2024-11-15'),
(22, 'Paid', 'Monthly subscription - November 2024', '2024-11-01 00:00:00', '2024-11-15'),
(23, 'Paid', 'Monthly subscription - November 2024', '2024-11-01 00:00:00', '2024-11-15'),
(24, 'Paid', 'Monthly subscription - November 2024', '2024-11-01 00:00:00', '2024-11-15'),
(25, 'Paid', 'Monthly subscription - November 2024', '2024-11-01 00:00:00', '2024-11-15'),
(26, 'Paid', 'Monthly subscription - November 2024', '2024-11-01 00:00:00', '2024-11-15'),
(27, 'Paid', 'Monthly subscription - November 2024', '2024-11-01 00:00:00', '2024-11-15'),
-- December subscriptions
(16, 'Pending', 'Monthly subscription - December 2024', '2024-12-01 00:00:00', '2024-12-15'),
(17, 'Pending', 'Monthly subscription - December 2024', '2024-12-01 00:00:00', '2024-12-15'),
(18, 'Paid', 'Monthly subscription - December 2024', '2024-12-01 00:00:00', '2024-12-15');


-- 19. INVOICE DETAILS (Calculate taxes based on jurisdiction)

-- Listing fees ($250 base)
INSERT INTO InvoiceDetail (InvoiceID, Total_Amount, Subtotal_Amount, Provincial_Tax_Amount, National_Tax_Amount) VALUES
-- Ontario listings (8% provincial + 5% federal = 13% total)
(1, 282.50, 250.00, 20.00, 12.50),
(2, 282.50, 250.00, 20.00, 12.50),
(3, 282.50, 250.00, 20.00, 12.50),
(4, 282.50, 250.00, 20.00, 12.50),
(5, 282.50, 250.00, 20.00, 12.50),
(6, 282.50, 250.00, 20.00, 12.50),
(7, 282.50, 250.00, 20.00, 12.50),
(8, 282.50, 250.00, 20.00, 12.50),
-- Quebec listings (9.5% provincial + 5% federal = 14.5% total)
(9, 286.25, 250.00, 23.75, 12.50),
(10, 286.25, 250.00, 23.75, 12.50),
-- BC listings (7% provincial + 5% federal = 12% total)
(11, 280.00, 250.00, 17.50, 12.50),
(12, 280.00, 250.00, 17.50, 12.50),
(13, 280.00, 250.00, 17.50, 12.50),
-- Additional multiplex listings
(14, 282.50, 250.00, 20.00, 12.50),
(15, 282.50, 250.00, 20.00, 12.50);

-- Monthly subscriptions ($15 base)
INSERT INTO InvoiceDetail (InvoiceID, Total_Amount, Subtotal_Amount, Provincial_Tax_Amount, National_Tax_Amount) VALUES
-- November subscriptions
(16, 16.95, 15.00, 1.43, 0.75), 
(17, 16.95, 15.00, 1.20, 0.75),  
(18, 16.80, 15.00, 1.05, 0.75),  
(19, 16.95, 15.00, 1.20, 0.75),  
(20, 16.95, 15.00, 1.20, 0.75),  
(21, 15.90, 15.00, 0.90, 0.00),  
(22, 15.90, 15.00, 0.90, 0.00),  
(23, 16.65, 15.00, 0.90, 0.75),  
(24, 16.95, 15.00, 1.20, 0.75),  
(25, 16.95, 15.00, 1.20, 0.75),  
(26, 16.80, 15.00, 1.05, 0.75),  
(27, 16.73, 15.00, 0.98, 0.75),  
-- December subscriptions
(28, 16.95, 15.00, 1.43, 0.75),  
(29, 16.95, 15.00, 1.20, 0.75),  
(30, 16.80, 15.00, 1.05, 0.75); 


-- 20. PAYMENTS (Link invoices to payment methods with confirmation codes)

INSERT INTO Payment (Payment_MethodID, InvoiceID, Confirmation_Code) VALUES
-- Listing fee payments
(1, 1, 'CC-2024-1115-A7B9C'),
(2, 2, 'CC-2024-1120-D3E5F'),
(3, 3, 'CC-2024-1122-G8H2J'),
(4, 4, 'CC-2024-1125-K4L6M'),
(5, 5, 'CC-2024-1128-N9P1Q'),
(6, 6, 'CC-2024-1130-R5S7T'),
(7, 7, 'CC-2024-1201-U2V4W'),
(8, 8, 'CC-2024-1202-X8Y0Z'),
(9, 9, 'CC-2024-1015-B3C5D'),
(10, 10, 'CC-2024-1020-E7F9G'),
(19, 11, 'BT-2024-1117-H2J4K'),
(20, 12, 'BT-2024-1129-L6M8N'),
(21, 13, 'BT-2024-1012-P1Q3R'),
(1, 14, 'CC-2024-1118-S5T7U'),
(2, 15, 'CC-2024-1121-V9W1X'),

-- November subscription payments
(11, 16, 'CC-2024-1101-Y4Z6A'),
(12, 17, 'CC-2024-1101-B8C0D'),
(13, 18, 'CC-2024-1101-E3F5G'),
(14, 19, 'CC-2024-1101-H7I9J'),
(15, 20, 'CC-2024-1101-K2L4M'),
(16, 21, 'CC-2024-1101-N6P8Q'),
(17, 22, 'CC-2024-1101-R1S3T'),
(18, 23, 'CC-2024-1101-U5V7W'),
(22, 24, 'BT-2024-1101-X9Y1Z'),
(23, 25, 'BT-2024-1101-A4B6C'),
(26, 26, 'PP-2024-1101-D8E0F'),
(27, 27, 'PP-2024-1101-G3H5I'),

-- December subscription payment (only one paid so far)
(13, 30, 'CC-2024-1201-J7K9L');


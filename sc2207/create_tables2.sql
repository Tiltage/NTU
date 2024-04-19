drop table related;
create table related (
UID1 int,
UID2 int,
foreign key (UID1) references user_account (UID),
foreign key (UID2) references user_account (UID),
type varchar(255) not null,
constraint pk_related primary key (UID1,UID2));

drop table purchase;
create table purchase (
UID INT,
SID INT,
MID INT,
DATE_TIME_IN DATETIME,
amount_spent DECIMAL(10,2) NOT NULL,
date_time_out DATETIME NOT NULL,
CONSTRAINT pk_purchase PRIMARY KEY (UID, SID, MID, DATE_TIME_IN),
FOREIGN KEY (SID, MID) REFERENCES shop (SID, MID));

drop table complaint_on_shop;
create table complaint_on_shop (
CID INT IDENTITY(1,1) PRIMARY KEY,
text VARCHAR(255) NOT NULL,
status VARCHAR(255) NOT NULL,
filed_date_time DATETIME NOT NULL,
uid INT NOT NULL,
oid INT NOT NULL,
FOREIGN KEY (uid) REFERENCES user_account (UID),
FOREIGN KEY (oid) REFERENCES restaurant_outlet (OID));

drop table complaint_on_restaurant;
create table complaint_on_restaurant (
CID INT IDENTITY(1,1) PRIMARY KEY,
text VARCHAR(255) NOT NULL,
status VARCHAR(255) NOT NULL,
filed_date_time DATETIME NOT NULL,
uid INT NOT NULL,
oid INT NOT NULL,
foreign key (uid) references user_account (UID),
foreign key (oid) references restaurant_outlet (OID));

drop table dine;
create table dine (
UID INT,
OID INT,
DATE_TIME_IN DATETIME,
amount_spent DECIMAL(10,2) NOT NULL,
date_time_out DATETIME NOT NULL,
CONSTRAINT PK_DINE PRIMARY KEY (UID, OID, DATE_TIME_IN),
foreign key (UID) references user_account (UID),
foreign key (OID) references restaurant_outlet (OID));

CREATE TABLE day_package (
    DID INT PRIMARY KEY,
    date_of_use DATETIME,
    description VARCHAR(255),
    pack_vid datetime
);

--ALTER TABLE day_package_restaurant ADD CONSTRAINT fk_day_package_restaurant_did FOREIGN KEY (DID) REFERENCES day_package(DID);
--ALTER TABLE recommendation_info ADD CONSTRAINT fk_day_package_reccomendation_info_did FOREIGN KEY (did) REFERENCES day_package(DID);
--ALTER TABLE day_package_mall ADD CONSTRAINT fk_day_package_mall_did FOREIGN KEY (did) REFERENCES day_package(DID);
--ALTER TABLE day_package_user ADD CONSTRAINT fk_day_package_user_did FOREIGN KEY (did) REFERENCES day_package(DID);

/*
SELECT
    OBJECT_NAME(parent_object_id) AS referencing_table,
    OBJECT_NAME(referenced_object_id) AS referenced_table,
    name AS foreign_key_name
FROM 
    sys.foreign_keys
WHERE 
    referenced_object_id = OBJECT_ID('day_package');
*/	
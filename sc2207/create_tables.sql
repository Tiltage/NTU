drop table user_account;
create table user_account (
UID INT IDENTITY(1,1) PRIMARY KEY,
gender VARCHAR (1) NOT NULL,
dob DATE NOT NULL,
name VARCHAR(255) NOT NULL);

create table restaurant_chain (
RID int identity(1,1) primary key,
franchise varchar(255));

create table purchase_voucher_info (
PVID int identity(1,1) primary key,
purchase_discount int,
description VARCHAR(4000));

drop table purchase_voucher_usage;
create table purchase_voucher_usage (
PVID int,
UID int,
status varchar(255) not null, 
date_issued date not null,
expiry_date date,
date_time_use datetime
	

drop table dine_voucher_info;
create table dine_voucher_info (
DVID int identity(1,1) primary key,
cash_discount int,
description VARCHAR(4000));

drop table dine_voucher_usage;
create table dine_voucher_usage (
DVID int,
UID int,
status varchar(255) not null, 
date_issued date not null,
expiry_date date,
date_time_use datetime
constraint pk_dine_voucher_usage primary key (DVID, UID));

create table group_voucher_info (
GVID int identity(1,1) primary key,
group_discount int,
group_size int not null,
description VARCHAR(4000));

create table group_voucher_usage (
GVID int,
UID int,
status varchar(255) not null, 
date_issued date not null,
expiry_date date,
date_time_use datetime
constraint pk_group_voucher_usage primary key (GVID, UID));

create table package_voucher_info (
PACK_VID int identity(1,1) primary key,
package_discount int,
description VARCHAR(4000));

create table package_voucher_usage (
PACK_VID int,
UID int,
status varchar(255) not null, 
date_issued date not null,
expiry_date date,
date_time_use datetime
constraint pk_package_voucher_usage primary key (PACK_VID, UID));
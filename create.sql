DROP DATABASE IF EXISTS dating_service;
CREATE DATABASE dating_service;
USE dating_service;
GRANT ALL ON dating_service.* TO user280@localhost IDENTIFIED BY 'p4ssw0rd';

create table Persons(
     ssn int not null,
     firstname varchar(15) not null,
     lastname varchar(20) not null,
     DOB date not null,
     gender enum('m', 'f') not null,
     phone char(10) not null,
     ever_married boolean not null,
     children boolean not null,
     criminal_closed boolean not null default false,
     primary key(ssn)
);



### On delete cascade means that when we delete someone from Persons,
### all of their interests and sub interests are automatically deleted.
create table Interests(
ssn int not null,
interest varchar(20) not null,
primary key(ssn,interest),
foreign key(ssn) references Persons(ssn)
on delete cascade
);



create table sub_Interests(
ssn int not null,
interest varchar(20) not null,
sub_interest varchar(20) not null,
primary key(ssn,interest,sub_interest),
foreign key(ssn) references Persons(ssn) on delete cascade,
foreign key(ssn,interest) references Interests(ssn,interest) on delete cascade
);
## last foreign key constraint means that if a particular person deletes a main interest,
## all corresponding sub interests will be deleted.




create table dates(
ssn_1 int not null,
ssn_2 int not null,
location varchar(20) not null,
date_ date not null,
paid boolean not null default false,
primary key(ssn_1,ssn_2,date_),
foreign key(ssn_1) references Persons(ssn) on delete cascade,
foreign key(ssn_2) references Persons(ssn) on delete cascade
);

create table accounts(
ssn int not null,
balance int not null,
primary key (ssn),
foreign key (ssn) references Persons(ssn) on delete cascade
);

create table payments(
ssn int not null,
charge int not null,
payment_date date not null,
primary key (ssn, payment_date),
foreign key (ssn) references Persons(ssn) on delete cascade
);

create table users(
ssn int not null,
username varchar(20) not null,
passwd varchar(20) not null,
primary key (ssn),
foreign key (ssn) references Persons(ssn) on delete cascade
);

create table criminal_records(
ssn int not null,
crime varchar(20) not null,
date_closed date not null,
primary key (ssn),
foreign key (ssn) references Persons(ssn) on delete cascade
);


create table children(
ssn int not null,
child_DOB date not null,
primary key (ssn),
foreign key (ssn) references Persons(ssn) on delete cascade
);



## sets persons.criminal close = true upon insert into criminal close tabledrop 
create trigger criminal_close
after insert on criminal_records
for each row
update Persons
set criminal_closed = true
where ssn = new.ssn;

## deducts each payment from account balance, and sets dates.paid = true
delimiter $$
create trigger payment_trigger
after insert on payments
for each row
Begin
update accounts
set balance = balance - new.charge
where ssn=new.ssn;
update dates
set paid = true
where date_ = new.payment_date;
End$$



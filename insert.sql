USE dating_service;

insert into persons(ssn,firstname,lastname,DOB,gender,phone,ever_married, children) values
	(123,'Alex','Armbruster',str_to_date("8/16/1996",'%c/%d/%Y'),'M',3015804417,false,false),
	(124,'Payton','Henson',str_to_date("1/16/1995",'%c/%d/%Y'),'M',1234567891,false,true);



insert into interests(ssn,interest) values
	(123,'Sports'),
	(123,'Reading'),
	(124, 'Reading');


insert into sub_Interests(ssn,interest,sub_interest) values
	(123,'Sports','Soccer'),
	(123,'Reading','Hemingway'),
	(124, 'Reading','Tolstoy');

insert into dates(ssn_1,ssn_2,location,date_) values
	(123,124,'Pizza Paradiso',str_to_date("3/30/2018",'%c/%d/%Y')),
	(123,124,'Waterfront',str_to_date("4/1/2018",'%c/%d/%Y'));


insert into accounts(ssn,balance) values
	(123, 400),
	(124,500);

insert into payments(ssn,charge,payment_date) values
	(123,50,str_to_date("3/30/2018",'%c/%d/%Y')),
	(124,50,str_to_date("4/1/2018",'%c/%d/%Y'));

insert into criminal_records values
	(123,'Arson',str_to_date("5/30/2018",'%c/%d/%Y'));


insert into children values
	(124,str_to_date("1/30/1995",'%c/%d/%Y'));


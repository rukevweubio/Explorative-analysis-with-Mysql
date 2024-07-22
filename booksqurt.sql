-- create table 

create table  Book(
	BookId int primary key,
	Title varchar(200),
	Author varchar(50),
	Genre varchar(30),
	PublishDate date,
	ISBN varchar(50),
	CopiesAvaliable int
);

create table Loan(
	LoanID int  primary key,
	BookID int,
	MemberID int,
	LoaNDate Date,
	DueDate date,
	ReturnDate date,
	constraint fk_bookid foreign key(bookid) references Book(BookID),
	constraint fk_MemberID foreign key(MemberID) references Members(MemberID)
);


create table Members(
	MemberID int primary key,
	Firstname varchar(20),
	Lastname varchar(20),
	Email varchar(50),
	RegisterDate date
	);

	
	
set serveroutput on;

--DDL for database creation

create table flight(
    FCode varchar2(10) primary key,
    FType varchar2(20) NOT NULL,
    Departure varchar2(50),
    Arrival varchar2(50),
    DDate date,
    ADate date,
    constraint chk_FCode CHECK (FCode LIKE 'FL%')
);
/
select * from flight

/

create table maintenance(
    MID number(5) primary key,
    MDate date not null,
    MCost Number(10) not null,
    FCode varchar2(10),
    constraint fk_FCode foreign key(FCode) references flight (FCode)
);


/

create sequence maintenance_seq
start with 1
increment by 1
nocache;
/

INSERT INTO flight (
    FCode, FType, Departure, Arrival, DDate, ADate
)
VALUES (
    'FL001', 'Boeing', 'Dubai', 'Colombo', 
    TO_DATE('2024-09-30', 'YYYY-MM-DD'), 
    TO_DATE('2024-10-01', 'YYYY-MM-DD')
);

insert into maintenance (
    MID, MDate,MCost, FCode
)
values
(
    maintenance_seq.nextval,
    to_date('2024-08-30','YYYY-MM-DD'),
    5000,
    'FL001'
);
/
create table airport(
    APNo varchar2(10) primary key,
    APName varchar(50) not null,
    city varchar(50) not null
);
/
create table travels(
    FCode varchar2(10),
    APNo varchar2(10),
    constraint pk_travels primary key(FCode,APNo),
    constraint fk_travels_FCode foreign key (FCode) references flight(FCode),
    constraint fk_travels_APNo foreign key (APNo) references airport(APNo)
);

/

create table employee(
    EID Number primary key,
    EName varchar2(50) not null,
    FCode varchar(10) not null,
    constraint fk_employee_FCode foreign key (FCode) references flight(FCode)
);
/
create sequence employe_seq
start with 1
increment by 1
nocache;
/
insert into employee(
    EID,EName,FCode
)values(
    employe_seq.nextval,
    'jhon doe',
    'FL001'
    
)
/
select * from employee
/
CREATE TABLE employeeCrew (
    EID NUMBER,
    CPermitNo VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_employeeCrew PRIMARY KEY (EID),
    CONSTRAINT fk_employeeCrew_EID FOREIGN KEY (EID) REFERENCES employee(EID)
);
/

CREATE TABLE employeeAdmin (
    EID NUMBER,
    Position VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_employeeAdmin PRIMARY KEY (EID),
    CONSTRAINT fk_employeeAdmin_EID FOREIGN KEY (EID) REFERENCES employee(EID)
);
/

create table passenger(
    PID Number,
    PassportNo varchar(20) not null,
    PName varchar(50) not null,
    Gender varchar(2) not null,
    FCode varchar2(10),
    constraint fk_passenger_FCode foreign key (FCode) references flight(FCode),
    PRIMARY KEY (PID, PassportNo)
    
);
/
create sequence passemger_seq
start with 1
increment by 1
nocache;

/

create table ticket (
    TID Number primary key,
    Price Number not null,
    SeatNo varchar(5) not null,
    MealPlan varchar(50) not null,
    DateofValidation date not null,
    PID number not null,
    PassportNo varchar(20) not null,
    constraint fk_ticket_passenger foreign key (PID, PassportNo) references passenger(PID, PassportNo)
);
/
--Insert Command

INSERT INTO flight (FCode, FType, Departure, Arrival, DDate, ADate)
VALUES ('FL123', 'Commercial', 'New York', 'London', TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-02', 'YYYY-MM-DD'));

/

BEGIN
    INSERT INTO flight (FCode, FType, Departure, Arrival, DDate, ADate) 
    VALUES ('FL003', 'Commercial', 'New York', 'London', TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-02', 'YYYY-MM-DD'));

    INSERT INTO flight (FCode, FType, Departure, Arrival, DDate, ADate) 
    VALUES ('FL004', 'Private', 'Los Angeles', 'Tokyo', TO_DATE('2024-10-03', 'YYYY-MM-DD'), TO_DATE('2024-10-04', 'YYYY-MM-DD'));

    INSERT INTO flight (FCode, FType, Departure, Arrival, DDate, ADate) 
    VALUES ('FL005', 'Cargo', 'Chicago', 'Paris', TO_DATE('2024-10-05', 'YYYY-MM-DD'), TO_DATE('2024-10-06', 'YYYY-MM-DD'));

    COMMIT; -- Commit the transaction to save the changes
END;
/
select * from flight
/
begin
    insert into maintenance(MID,MDate,MCost,FCode)
    values (maintenance_seq.nextval,
    to_date('2024-08-30','YYYY-MM-DD'),
    5000,
    'FL003');
    
    insert into maintenance(MID,MDate,MCost,FCode)
    values (maintenance_seq.nextval,
    to_date('2024-08-31','YYYY-MM-DD'),
    10000,
    'FL004');
    
    insert into maintenance(MID,MDate,MCost,FCode)
    values (maintenance_seq.nextval,
    to_date('2024-09-30','YYYY-MM-DD'),
    4000,
    'FL005');
    
    commit;
end;
/
BEGIN
    INSERT INTO airport (APNo, APName, city) VALUES ('AP001', 'Bandaranaike International Airport', 'Colombo');
    INSERT INTO airport (APNo, APName, city) VALUES ('AP002', 'Mattala Rajapaksa International Airport', 'Hambantota');
    INSERT INTO airport (APNo, APName, city) VALUES ('AP003', 'Jaffna International Airport', 'Jaffna');
    INSERT INTO airport (APNo, APName, city) VALUES ('AP004', 'Batticaloa International Airport', 'Batticaloa');
    INSERT INTO airport (APNo, APName, city) VALUES ('AP005', 'Trincomalee International Airport', 'Trincomalee');
    
    COMMIT;
END;
/
BEGIN
    INSERT INTO travels (FCode, APNo) VALUES ('FL001', 'AP001');
    INSERT INTO travels (FCode, APNo) VALUES ('FL003', 'AP002');
    INSERT INTO travels (FCode, APNo) VALUES ('FL003', 'AP001');
    INSERT INTO travels (FCode, APNo) VALUES ('FL004', 'AP003');
    INSERT INTO travels (FCode, APNo) VALUES ('FL005', 'AP004');
    
    COMMIT;
END;
/
BEGIN
    INSERT INTO employee (EID, EName, FCode) VALUES (101, 'John Doe', 'FL001');
    INSERT INTO employee (EID, EName, FCode) VALUES (102, 'Jane Smith', 'FL003');
    INSERT INTO employee (EID, EName, FCode) VALUES (103, 'Emily Brown', 'FL003');
    INSERT INTO employee (EID, EName, FCode) VALUES (104, 'Michael Johnson', 'FL004');
    INSERT INTO employee (EID, EName, FCode) VALUES (105, 'Sarah Davis', 'FL005');
    
    COMMIT;
END;
/
BEGIN
    INSERT INTO employeeCrew (EID, CPermitNo) VALUES (101, 'CP001');
    INSERT INTO employeeCrew (EID, CPermitNo) VALUES (102, 'CP002');
    INSERT INTO employeeCrew (EID, CPermitNo) VALUES (103, 'CP003');
    INSERT INTO employeeCrew (EID, CPermitNo) VALUES (104, 'CP004');
    INSERT INTO employeeCrew (EID, CPermitNo) VALUES (105, 'CP005');
    
    COMMIT;
END;
/
BEGIN
    INSERT INTO employeeAdmin (EID, Position) VALUES (101, 'Flight Manager');
    INSERT INTO employeeAdmin (EID, Position) VALUES (102, 'Operations Supervisor');
    INSERT INTO employeeAdmin (EID, Position) VALUES (103, 'Safety Officer');
    INSERT INTO employeeAdmin (EID, Position) VALUES (104, 'Maintenance Coordinator');
    INSERT INTO employeeAdmin (EID, Position) VALUES (105, 'Logistics Specialist');
    
    COMMIT;
END;
/
BEGIN
    INSERT INTO passenger (PID, PassportNo, PName, Gender, FCode) VALUES (201, 'N1234567', 'Alice Johnson', 'F', 'FL001');
    INSERT INTO passenger (PID, PassportNo, PName, Gender, FCode) VALUES (202, 'N2345678', 'Bob Smith', 'M', 'FL003');
    INSERT INTO passenger (PID, PassportNo, PName, Gender, FCode) VALUES (203, 'N3456789', 'Clara Brown', 'F', 'FL003');
    INSERT INTO passenger (PID, PassportNo, PName, Gender, FCode) VALUES (204, 'N4567890', 'David Wilson', 'M', 'FL004');
    INSERT INTO passenger (PID, PassportNo, PName, Gender, FCode) VALUES (205, 'N5678901', 'Eve Davis', 'F', 'FL005');
    
    COMMIT;
END;
/
BEGIN
    INSERT INTO ticket (TID, Price, SeatNo, MealPlan, DateofValidation, PID, PassportNo) 
    VALUES (301, 15000, 'A01', 'Vegetarian', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 201, 'N1234567');
    
    INSERT INTO ticket (TID, Price, SeatNo, MealPlan, DateofValidation, PID, PassportNo) 
    VALUES (302, 18000, 'B02', 'Non-Vegetarian', TO_DATE('2024-10-16', 'YYYY-MM-DD'), 202, 'N2345678');
    
    INSERT INTO ticket (TID, Price, SeatNo, MealPlan, DateofValidation, PID, PassportNo) 
    VALUES (303, 16000, 'C03', 'Vegan', TO_DATE('2024-10-17', 'YYYY-MM-DD'), 203, 'N3456789');
    
    INSERT INTO ticket (TID, Price, SeatNo, MealPlan, DateofValidation, PID, PassportNo) 
    VALUES (304, 20000, 'D04', 'Kosher', TO_DATE('2024-10-18', 'YYYY-MM-DD'), 204, 'N4567890');
    
    INSERT INTO ticket (TID, Price, SeatNo, MealPlan, DateofValidation, PID, PassportNo) 
    VALUES (305, 17000, 'E05', 'Halal', TO_DATE('2024-10-19', 'YYYY-MM-DD'), 205, 'N5678901');
    
    COMMIT;
END;
/


select * from flight

select * from maintenance

select * from airport

select * from employee

select * from employeeCrew

select * from passenger

select * from ticket








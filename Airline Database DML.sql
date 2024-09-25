set serveroutput on;

select * from flight

/
begin
update flight
set departure = 'Los Angeles'
where FCode = 'FL001';
end;
/

begin 
update flight
set FType = 'Boeing', Departure = 'Riyadh'
where FCode = 'FL123';
end;
/
begin
delete from flight
where FCode = 'FL123';
end;
/

select * from flight
/





select * from employee
/
begin
SELECT departure, MAX(FType) AS FType
FROM flight
GROUP BY departure;
end;
/








begin
    for rec in (
        select departure, MAX(FType) As FType
        from flight
        where departure = 'Los Angeles'
        group by departure
        order by departure asc
    )
    loop
            dbms_output.put_line('Departure: '|| rec.departure || ', FType: ' || rec.FType);
    end loop;
end;
/
select * from employee
/
select * from flight
/
select f.departure,f.FType,e.eid,e.ename from flight f
inner join employee e
on  f.fcode = e.fcode;
/
select f.departure,f.FType,e.eid,e.ename from flight f
left join employee e
on f.fcode = e.fcode;
/
select f.departure,f.FType,e.eid,e.ename from flight f
right join employee e
on f.fcode = e.fcode;


/
select * from flight f
full join employee e
on f.fcode = e.fcode;
/

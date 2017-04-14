--function takes course number and returns prerequisite courses
create or replace function preReqsFor (int, REFCURSOR) returns refcursor as
$$

declare
   courseNumber int := $1;
   resultset REFCURSOR := $2;
begin 
	open resultset for
    	select num,name, credits
        from courses
        Where num in
        		(select prereqnum 
                 from prerequisites
        		where courseNumber=coursenum);
            return resultset;
            
            end;
        $$
        language plpgsql;

--tests function above. Should return 120 Intro to Prog.
select preReqsFor(308, 'results');
Fetch all from results;


--this function takes a course number and returns all courses for which the passed number is an immediate prequisite.
create or replace function isPreReqFor (int, REFCURSOR) returns refcursor as
$$

declare
   courseNumber int := $1;
   resultset REFCURSOR := $2;
begin 
	open resultset for
    	
		select name, num, credits
		from courses
		where num in
				(select coursenum
	 			from prerequisites
				where coursenumber=prereqnum);
            return resultset;
            
            end;
        $$
        language plpgsql;
		
--tests function above. Should return 308 Database Systems
select IsPreReqFor(120, 'results');
Fetch all from results;


-- Last lab, woo! (:

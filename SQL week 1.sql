
# 1. Which destination in the flights database is the furthest distance away, based on information in the flights table. Show the SQL query(s) that support your conclusion.
SELECT DISTINCT dest, origin, distance FROM flights
WHERE distance=(SELECT MAX(distance) FROM flights);


# 2. What are the different numbers of engines in the planes table? For each number of engines, which aircraft have the most number of seats? Show the SQL statement(s) that support your result.
SELECT engines,manufacturer,model,MAX(DISTINCT seats)  
FROM planes   
GROUP BY engines;  


# 3. Show the total number of flights.
SELECT COUNT(*) AS Total_Flights FROM flights;


# 4. Show the total number of flights by airline (carrier).
SELECT carrier, COUNT(*) as Number_of_flights FROM flights
 group by carrier;


# 5. Show all of the airlines, ordered by number of flights in descending order
SELECT carrier, COUNT(*) as Number_of_flights FROM flights
 GROUP BY carrier 
 ORDER BY COUNT(*)DESC;
# 6. Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order
SELECT carrier, COUNT(*) as Number_of_flights FROM flights
 GROUP BY carrier 
 ORDER BY COUNT(*)DESC
 LIMIT 0,5;


# 7. Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater, ordered by number of flights in descending order.
SELECT carrier, COUNT(*) as Number_of_flights FROM flights
 WHERE distance>=1000
 GROUP BY carrier 
 ORDER BY COUNT(*)DESC
 LIMIT 0,5;


# 8. Create a question that (a) uses data from the flights database, and (b) requires aggregation to answer it, and write down both the question, and the query that answers the question.
#Show only the top 5 airlines, by maximum distance they cover, origin and destination, ordered by distance covered in descending order.
SELECT DISTINCT carrier,flight,MAX(distance)AS Max_distance,origin,dest
FROM flights   
GROUP BY carrier
ORDER BY (distance)DESC
LIMIT 0,5;  






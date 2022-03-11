-- 1.How many songs are there in the playlist “Grunge”?
SELECT COUNT(*) FROM playlisttrack WHERE PlaylistId = (
    SELECT playlist.PlaylistId FROM playlist where Name = "Grunge");


-- 2.Show information about artists whose name includes the text “Jack” and about artists whose
-- name includes the text “John”, but not the text “Martin”.
SELECT * FROM artist WHERE Name LIKE '%John%'
                        AND Name  NOT like '%Martin%'
                        OR Name LIKE '%Jack%';


-- 3.For each country where some invoice has been issued, show the total invoice monetary amount,
-- but only for countries where at least $100 have been invoiced. Sort the information from higher to
-- lower monetary amount
SELECT BillingCountry , SUM(Total) 'monetary amount' FROM invoice GROUP BY (BillingCountry) HAVING SUM(Total) >100
ORDER BY `monetary amount` DESC ;
-- Test
-- SELECT BillingCountry ,SUM(Total) 'monetary amount' FROM invoice WHERE BillingCountry = 'Norway';


-- 4. Get the phone number of the boss of those employees who have given support to clients who have bought
-- some song composed by “Miles Davis” in “MPEG Audio File” format. [Not done yet]

SELECT employee.ReportsTo , EmployeeId FROM track, invoiceline, invoice, customer, employee WHERE Composer = 'Miles Davis' AND
    MediaTypeId = (SELECT MediaTypeId FROM mediatype WHERE mediatype.Name = 'MPEG Audio File')
    AND track.TrackId = invoiceline.TrackId AND invoiceline.InvoiceId = invoice.InvoiceId
    AND invoice.CustomerId = customer.CustomerId AND customer.SupportRepId = employee.EmployeeId;


-- 5. Show the information, without repeated records, of all albums that feature songs of the “Bossa Nova” genre whose title starts by the word “Samba”
SELECT DISTINCT album.* FROM track, album WHERE GenreId = ( SELECT GenreId FROM genre
WHERE genre.Name = 'Bossa Nova') AND track.AlbumId = album.AlbumId AND Title = 'Samba';


-- 6. For each genre, show the average length of its songs in minutes (without indicating seconds). Use the headers “Genre” and
-- “Minutes”, and include only genres that have any song longer than half an hour. [Not done Yet]
SELECT genre.Name AS Genre , COUNT(FLOOR(track.Milliseconds / 1000)) AS 'minutes' FROM genre, track
WHERE genre.GenreId = track.GenreId GROUP BY genre.Name;

-- 7. How many client companies have no state?
SELECT Company,  COUNT(Company) 'No.' FROM customer WHERE State  IS NULL GROUP BY Company;

-- 8. For each employee with clients in the “USA”, “Canada” and “Mexico” show the number of clients from these countries
-- s/he has given support, only when this number is higher than 6. Sort the query by number of clients. Regarding the
-- employee, show his/her first name and surname separated by a space. Use “Employee” and “Clients” as headers.
SELECT CONCAT (employee.FirstName, ' ' , employee.LastName ) 'Employee',  COUNT(SupportRepId) 'Clients' FROM customer, employee WHERE
        customer.SupportRepId = employee.EmployeeId AND (customer.Country = 'USA'
        OR customer.Country = 'Canada' OR customer.Country = 'Mexico') GROUP BY SupportRepId HAVING COUNT(SupportRepId) > 6;



SELECT * FROM customer WHERE SupportRepId = '3' AND customer.Country = 'Canada' ;

-- 9. For each client from the “USA”, show his/her surname and name (concatenated and separated by a comma) and their fax number.
-- If they do not have a fax number, show the text “S/he has no fax”. Sort by surname and first name.
SELECT CONCAT(LastName, ' ',  FirstName) AS Name , IFNULL(Fax, 'S/he has no fax') 'fax' FROM customer WHERE Country = 'USA' ORDER BY Name;


-- 10. For each employee, show his/her first name, last name, and their age at the time they were hired.
SELECT FirstName, LastName, (YEAR(HireDate) - YEAR(BirthDate)) 'age at the time they were hired'  FROM employee;



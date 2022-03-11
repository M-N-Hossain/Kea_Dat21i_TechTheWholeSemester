-- 1. Show the members under the name "Jens S." who
-- were born before 1970 that became members of the library in 2013.
SELECT * FROM tmember WHERE cName =  "Jens S." AND dBirth < "1970-01-01" AND dNewMember BETWEEN "2013-01-01" AND "2013-12-31";


-- 2. Show those books that have not been published by the publishing companies with
-- ID 15 and 32, except if they were published before 2000.
SELECT * FROM tbook WHERE nPublishingCompanyID != "15"
                      AND nPublishingCompanyID != "32"  AND nPublishingYear > 2000 ORDER BY nPublishingCompanyID;


-- 3. Show the name and surname of the members who have a phone number, but no address.
-- Everyone has phone number and address
SELECT cName , cSurname FROM tmember  WHERE cPhoneNo LIKE '%' AND cAddress IS NULL ;


-- 4. Show the authors with surname "Byatt" whose name starts
-- by an "A" (uppercase) and contains an "S" (uppercase).
SELECT * FROM tauthor WHERE  cSurname = "Byatt" AND cName LIKE 'A%S%';


-- 5. Show the number of books published in 2007 by the publishing company with ID 32.
SELECT COUNT(nBookID) FROM tbook WHERE nPublishingYear = '2007' AND nPublishingCompanyID = '32';


-- 6. For each day of the year 2014, show the number of books loaned by the member with CPR "0305393207";
SELECT COUNT(dLoan) FROM tloan WHERE cCPR = "0305393207" AND dLoan > "2014-01-01" AND dLoan < "2014-12-31";


-- 7. Modify the previous clause so that only those days where the member was loaned more than one book appear.
SELECT dLoan, COUNT(dLoan) FROM tloan WHERE cCPR = "0305393207" AND dLoan > "2014-01-01" AND dLoan < "2014-12-31" GROUP BY dLoan
HAVING COUNT(dLoan)>1;


-- 8. Show all library members from the newest to the oldest. Those who became members on the
-- same day will be sorted alphabetically (by surname and name) within that day.
SELECT * FROM tmember ORDER BY dNewMember DESC , cSurname ASC ;


-- 9. Show the title of all books published by the publishing company with ID 32 along with their theme or themes. [Dont understood properly]
SELECT tbook.cTitle, ttheme.cName FROM tbook, tbooktheme , ttheme WHERE nPublishingCompanyID = '32'
AND tbook.nBookID = tbooktheme.nBookID
AND tbooktheme.nThemeID = ttheme.nThemeID;


-- 10. Show the name and surname of every author along with the number of books authored by them,
-- but only for authors who have registered books on the database.
SELECT tauthorship.nAuthorID, tauthor.cName, tauthor.cSurname, COUNT(t3.nBookID) FROM tauthorship , tauthor, tbook t3
WHERE tauthorship.nAuthorID = tauthor.nAuthorID AND tauthorship.nBookID = t3.nBookID GROUP BY tauthorship.nAuthorID
HAVING COUNT(t3.nBookID)>=1 ORDER BY tauthorship.nAuthorID ASC;


 -- SELECT t3.cTitle FROM tauthor t, tauthorship t2, tbook t3 WHERE t.nAuthorID = '16'
 --  AND t.nAuthorID = t2.nAuthorID AND t2.nBookID =t3.nBookID;


-- 11.Show the name and surname of all the authors with published books along with the lowest publishing year for their books.
SELECT tauthor.cName, tauthor.cSurname, tbook.cTitle, tbook.nPublishingYear FROM tbook , tauthorship  ,tauthor  WHERE
        tauthorship.nAuthorID = tauthor.nAuthorID AND tbook.nBookID = tauthorship.nBookID ORDER BY nPublishingYear ASC ;


-- 12. For each signature and loan date, show the title of the corresponding books and the name and surname
-- of the member who had them loaned. [Not Working]
SELECT * FROM tloan, tmember  WHERE tloan.cCPR = tmember.cCPR;

SELECT * FROM tmember WHERE cCPR = '0701493893';

SELECT tmember.cName, tmember.cSurname, tbook.nBookID, tbook.cTitle FROM tloan , tbookcopy ,tbook ,tmember
WHERE tloan.cSignature = tbookcopy.cSignature ORDER BY tloan.dLoan; -- [Facing storage problem] [Not Working]


-- 13. repeat qs. 9,10,11
-- 13.1 Show the title of all books published by the publishing company with ID 32 along with their theme or themes.
SELECT tbook.cTitle, ttheme.cName FROM tbook, tbooktheme  , ttheme WHERE tbook.nPublishingCompanyID = "32"
AND tbook.nBookID = tbooktheme.nBookID AND tbooktheme.nThemeID = ttheme.nThemeID;


-- 13.2 Show the name and surname of every author along with the number of books authored by them,
-- but only for authors who have registered books on the database.
SELECT tauthorship.nAuthorID, cName, cSurname, COUNT(tbook.nBookID) FROM tauthorship , tauthor, tbook
where tauthorship.nAuthorID = tauthor.nAuthorID AND tauthorship.nBookID = tbook.nBookID GROUP BY tauthorship.nAuthorID
HAVING COUNT(tbook.nBookID)>=1 ORDER BY tauthorship.nAuthorID ASC;


-- 13.3 Show the name and surname of all the authors with published books along with the lowest publishing year for their books.
SELECT tauthor.cName, tauthor.cSurname, tbook.cTitle, tbook.nPublishingYear FROM tbook , tauthorship ,tauthor WHERE
        tauthorship.nAuthorID = tauthor.nAuthorID AND tauthorship.nBookID = tauthorship.nBookID ORDER BY nPublishingYear ASC ;


-- 14. Show all theme names along with the titles of their associated books. All themes must appear
-- (even if there are no books for some particular themes). Sort by theme name.
SELECT tbook.cTitle , ttheme.cName FROM tbooktheme , tbook, ttheme
WHERE tbooktheme.nBookID = tbook.nBookID AND tbooktheme.nThemeID = ttheme.nThemeID;


-- 15. Show the name and surname of all members who joined the library in 2013 along with the title of the books they took on loan during
-- that same year. All members must be shown, even if they did not take any book on loan during 2013. Sort by member surname and name. [Not Working]
 SELECT cName ,cSurname, tbook.cTitle FROM tmember, tloan, tbookcopy, tbook
 WHERE tmember.dNewMember BETWEEN "2013-01-01" AND "2013-12-31" AND tmember.cCPR = tloan.cCPR OR
       tmember.cCPR != tloan.cCPR OR tloan.cSignature = t3.cSignature
    OR tloan.cSignature != tbookcopy.cSignature OR tbookcopy.nBookID = tbook.nBookID; -- [Not Working]


 -- 16. Show the name and surname of all authors along with their nationality or nationalities and the titles of their books.
 -- Every author must be shown, even though s/he has no registered books. Sort by author name and surname. [Not Working]
 SELECT tauthor.cName, cSurname, tbook.cTitle, tcountry.cName FROM tauthor, tnationality ,tcountry, tauthorship, tbook
 WHERE tauthor.nAuthorID = tnationality.nAuthorID AND  tnationality.nCountryID = tcountry.nCountryID
    OR tauthor.nAuthorID = tauthorship.nAuthorID OR tauthorship.nBookID = tbook.nBookID ORDER BY tauthor.cName;
-- [Not Working]


-- 17. Show the title of those books which have had different editions published in both 1970 and 1989.
SELECT cTitle , COUNT(cTitle)  "no. of editon" FROM tbook WHERE nPublishingYear = "1970" OR nPublishingYear = "1989"
GROUP BY cTitle HAVING COUNT(cTitle) >1;

-- SELECT cTitle, nPublishingYear FROM tbook WHERE cTitle = 'Macbeth' ;


-- 18. Show the surname and name of all members who joined the library in December 2013
-- followed by the surname and name of those authors whose name is “William”.
SELECT tmember.cSurname, tmember.cName , tmember.dNewMember, tauthor.cSurname, tauthor.cName FROM tmember , tauthor
WHERE  tmember.dNewMember BETWEEN "2013-01-01"
AND "2013-12-31" AND  tauthor.cName = "William";

SELECT * FROM tauthor WHERE cName = 'William';


-- 19.Show the name and surname of the first chronological member of the library using subqueries
SELECT cName, cSurname FROM tmember ORDER BY dNewMember
limit 1;
# SELECT cName,cSurname, dNewMember FROM tmember WHERE dNewMember IN (
#     SELECT dNewMember FROM tmember ORDER BY dNewMember
# );

-- 20. For each publishing year, show the number of book titles published by publishing companies from countries
-- that constitute the nationality for at least three authors. Use subqueries.


SELECT cTitle , tpublishingcompany.cName, tcountry.cName FROM tbook, tpublishingcompany, tcountry
WHERE tpublishingcompany.nPublishingCompanyID = tbook.nPublishingCompanyID AND tpublishingcompany.nCountryID = tcountry.nCountryID ;


-- 21.Show the name and country of all publishing companies with the headings "Name" and "Country"
SELECT tpublishingcompany.cName, tcountry.cName FROM tpublishingcompany , tcountry
WHERE tpublishingcompany.nCountryID = tcountry.nCountryID;


-- 22. Show the titles of the books published between 1926 and 1978 that were not published
-- by the publishing company with ID 32.
SELECT cTitle FROM tbook WHERE nPublishingYear BETWEEN "1926" AND  "1978" AND nPublishingCompanyID != "32";


-- 23. Show the name and surname of the members who joined the library after 2016 and have no address.
SELECT cName, cSurname FROM tmember WHERE dNewMember > "2016-01-01"  AND cAddress = ' ' ;


-- 24. Show the country codes for countries with publishing companies. Exclude repeated values.
SELECT tcountry.nCountryID, tcountry.cName , tpublishingcompany.cName FROM tpublishingcompany , tcountry
WHERE tpublishingcompany.nCountryID = tcountry.nCountryID;


-- 25.Show the titles of books whose title starts by "The Tale" and that are not published by "Lynch Inc".
SELECT cTitle FROM tbook WHERE cTitle LIKE "The Tale%" AND nPublishingCompanyID != (
    SELECT nPublishingCompanyID FROM tpublishingcompany where cName = "Lynch Inc"
    );


-- 26. Show the list of themes for which the publishing company "Lynch Inc" has published books,
-- excluding repeated values.

# try 1,
SELECT ttheme.cName FROM tpublishingcompany, tbook, tbooktheme, ttheme WHERE tpublishingcompany.nPublishingCompanyID =(
    SELECT nPublishingCompanyID FROM tpublishingcompany WHERE tpublishingcompany.cName = "Lynch Inc"
    ) AND tpublishingcompany.nPublishingCompanyID = tbook.nPublishingCompanyID
    AND tbook.nBookID = tbooktheme.nBookID AND tbooktheme.nThemeID = ttheme.nThemeID;
# try 2,
SELECT nPublishingCompanyID FROM tpublishingcompany WHERE tpublishingcompany.cName = "Lynch Inc";
# try 3,
SELECT ttheme.cName FROM tpublishingcompany, tbook, tbooktheme, ttheme WHERE tpublishingcompany.nPublishingCompanyID = "13"
AND tpublishingcompany.nPublishingCompanyID = tbook.nPublishingCompanyID AND tbook.nBookID = tbooktheme.nBookID
AND tbooktheme.nThemeID = ttheme.nThemeID;


-- 27. Show the titles of those books which have never been loaned.
SELECT tbook.cTitle FROM tbook, tbookcopy WHERE tbookcopy.nBookID != tbook.nBookID;


-- 28. For each publishing company, show its number of existing books under the heading "No. of Books".
SELECT COUNT( nPublishingCompanyID) "No. of Books"  FROM tbook WHERE nPublishingCompanyID = '32';
SELECT * FROM tpublishingcompany, tbook WHERE tpublishingcompany.nPublishingCompanyID = tbook.nPublishingCompanyID
ORDER BY tpublishingcompany.nPublishingCompanyID ASC
;


-- 29. Show the number of members who took some book on a loan during 2013.
SELECT COUNT(DISTINCT cCPR ) number  FROM tloan WHERE  dLoan > '2013-01-01' AND dLoan < '2013-12-31';


-- 30. For each book that has at least two authors, show its title and number of authors under the heading "No. of Authors".
SELECT cTitle , COUNT(nAuthorID) "No. of Authors" FROM tbook , tauthorship
WHERE tbook.nBookID = tauthorship.nBookID GROUP BY tauthorship.nBookID HAVING COUNT(tauthorship.nBookID)>1;

-- SELECT * FROM tbook WHERE cTitle = 'Empire';
-- SELECT * FROM tauthorship WHERE nBookID = '1999';







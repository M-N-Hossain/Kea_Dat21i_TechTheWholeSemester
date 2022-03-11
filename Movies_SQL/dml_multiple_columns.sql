#################################
# Select                        #
#################################
SELECT Name, year FROM movies;
SELECT * FROM movies;
SELECT * FROM movies ORDER BY year ASC;
SELECT * FROM movies ORDER BY Name;
SELECT * FROM movies WHERE year = 2022;

#################################
# Insert                        #
#################################

INSERT INTO movies (Name, Year) VALUES ("The Cremator", 1965);
INSERT INTO movies VALUES ("The Cremator", 1965);

INSERT INTO movies (Name) VALUES ("The Cremator");
INSERT INTO movies (Year) VALUES (1965);





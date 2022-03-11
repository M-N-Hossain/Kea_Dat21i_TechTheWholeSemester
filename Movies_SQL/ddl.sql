SHOW TABLES ;
SELECT * FROM movies;

# Create new table with column
CREATE TABLE movies ( id int AUTO_INCREMENT PRIMARY KEY ,
    title VARCHAR(3000) NOT NULL
);

CREATE TABLE IF NOT EXISTS directors (
    dir_id INT AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(3000) NOT NULL,
    movie_id int,
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);

# Create a new column in table
ALTER table movies ADD year int NOT NULL AFTER title;
-- Define a primary key in movies
ALTER TABLE movies ADD movie_id int not null auto_increment primary key ;

-- Adding foreign keys
ALTER TABLE movies ADD FOREIGN KEY (dir_Id) REFERENCES directors(dir_ID);

ALTER TABLE directors ADD id INT;
ALTER TABLE directors ADD FOREIGN KEY (id) REFERENCES movies(id);


-- Change column name
ALTER TABLE movies CHANGE movie_Id Id int;

ALTER TABLE movies DROP column id ;

ALTER TABLE movies Modify year YEAR ;

# Delete the entire table
Drop table movies , directors;

DROP TABLE directors;
-- Adding data into the movie table
INSERT INTO movies (title, Year)  VALUES ('Spider Man No Way Back Home', '2022');

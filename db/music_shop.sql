DROP TABLE albums;
DROP TABLE artists;

CREATE TABLE artists(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);


CREATE TABLE albums(
  id SERIAL PRIMARY KEY,
  song VARCHAR(255),
  artist_id INT REFERENCES artists(id)
);

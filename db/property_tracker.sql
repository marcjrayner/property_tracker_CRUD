DROP TABLE properties;

CREATE TABLE properties(
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT8,
  number_of_bedrooms INT2,
  year_built INT2
);

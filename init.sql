CREATE TABLE Animal (
    animal_id serial PRIMARY KEY,
    animal_name text,
    dob date,
    breed text,
    color text,
    sex_at_outcome text,
    animal_type text
);

CREATE TABLE Outcome (
    date_time timestamp PRIMARY KEY, -- Modified data type
    outcome_type text,
    outcome_subtype text
);

CREATE TABLE Relationship (
    relationship_id serial PRIMARY KEY,
    animal_id integer REFERENCES Animal (animal_id),
    date_time timestamp REFERENCES Outcome (date_time),
    age_at_outcome text -- Include age_at_outcome
);

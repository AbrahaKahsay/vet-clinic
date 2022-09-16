/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY, 
    name VARCHAR(250),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

-- Add a column species of type string to your animals table.
BEGIN;
ALTER TABLE animals
ADD COLUMN species VARCHAR;
COMMIT;

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR,
    age INT,
    PRIMARY KEY (id)
 );
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR,
    PRIMARY KEY (id)
    );
    
--  Remove species column from animals table
ALTER TABLE animals
DROP COLUMN species;

-- Add species_id and owner_id to animals table
ALTER TABLE animals
ADD species_id INT;

ALTER TABLE animals
ADD owner_id INT;

-- Add foreign key constraints to aanimals table by referencing the species and owners table
ALTER TABLE animals
ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species (id);
ALTER TABLE animals
ADD CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners (id);

-- Create a table named vets with the following columns
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR,
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
    );
    
--  many-to-many relations join table for species and vets   
CREATE TABLE specializations (
    species_id INT,
    vet_id INT,
    PRIMARY KEY (species_id, vet_id),
    CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id),
    CONSTRAINT fk_vets FOREIGN KEY (vet_id) REFERENCES vets (id)
    );
--  many-to-many relations join table for animals and vets
CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    visit_date DATE,
    CONSTRAINT fk_animals FOREIGN KEY (animal_id) REFERENCES animals (id),
    CONSTRAINT fk_vets FOREIGN KEY (vet_id) REFERENCES vets (id)
    );

/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-30';
SELECT name FROM animals WHERE neutered='t' AND escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name IN ('Augmon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered='t';
SELECT * FROM animals WHERE NOT name='Gabumon';
SELECT * FROM animals WHERE weight_kg >=10.4 AND weight_kg <=17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified.Then roll back the change
-- and verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

-- update species in a transaction
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE name NOT LIKE '%mon';
COMMIT;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;

-- Delete all animals born after Jan 1st 2022
BEGIN;
DELETE FROM animals
WHERE date_of_birth >= '2022-01-01';

--Create savepoint and multipy all weights by -1
SAVEPOINT sp1;
UPDATE animals
SET weight_kg = weight_kg * (-1);
ROLLBACK TO sp1;

-- update animals with negative weight to be positive by multiplying -1
UPDATE animals
SET weight_kg = weight_kg * (-1)
WHERE weight_kg < 0;
COMMIT;

-- Count number of animals
SELECT COUNT(*) FROM animals;

-- count animals with no escape attempts
SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

--minimum and maximum weight
SELECT MIN(weight_kg) FROM animals;
SELECT MAX(weight_kg) FROM animals;

--Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals
GROUP BY neutered;

SELECT date_of_birth, AVG(escape_attempts) FROM animals
GROUP BY date_of_birth
HAVING date_of_birth > '1990-01-01' AND date_of_birth < '2000-12-30';

-- Write queries (using JOIN) to answer the following questions

-- What animals belong to Melody Pond?
SELECT name 
FROM animals 
INNER JOIN owners 
ON owner_id = owners.id 
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)
SELECT animals.name 
FROM animals 
INNER JOIN species 
ON species_id = species.id 
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal
SELECT animals.name, owners.full_name 
FROM animals 
RIGHT JOIN owners 
ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT COUNT(*), species.name AS species 
FROM animals 
JOIN species 
ON species_id = species.id 
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name AS digimons_name, owners.full_name AS owner_name 
FROM animals 
JOIN owners 
ON animals.owner_id = owners.id 
WHERE animals.species_id = 2 AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name, owners.full_name 
FROM animals 
JOIN owners 
ON animals.owner_id = owners.id
WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT full_name, COUNT(full_name) AS owns 
FROM animals 
JOIN owners 
ON animals.owner_id = owners.id 
GROUP BY full_name ORDER BY owns DESC LIMIT 1;

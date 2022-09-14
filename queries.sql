/*Queries that provide answers to the questions from all projects.*/
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
SET species = 'digimon'
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

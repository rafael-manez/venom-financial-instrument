--
-- Rule book for multilateral financial Instruments.
-- Prepared SQL queries for 'NewRule' definition.
--


--
-- SELECT template for table `NewRule`
--
SELECT `name`, `description`, `financial_instrument`, `authority`, `compatible_with_jurisdiction` FROM `NewRule` WHERE 1;

--
-- INSERT template for table `NewRule`
--
INSERT INTO `NewRule`(`name`, `description`, `financial_instrument`, `authority`, `compatible_with_jurisdiction`) VALUES (?, ?, ?, ?, ?);

--
-- UPDATE template for table `NewRule`
--
UPDATE `NewRule` SET `name` = ?, `description` = ?, `financial_instrument` = ?, `authority` = ?, `compatible_with_jurisdiction` = ? WHERE 1;

--
-- DELETE template for table `NewRule`
--
DELETE FROM `NewRule` WHERE 0;


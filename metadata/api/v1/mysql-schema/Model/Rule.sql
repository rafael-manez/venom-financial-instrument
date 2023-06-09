--
-- Rule book for multilateral financial Instruments.
-- Prepared SQL queries for 'Rule' definition.
--


--
-- SELECT template for table `Rule`
--
SELECT `name`, `description`, `financial_instrument`, `authority`, `compatible_with_jurisdiction`, `id` FROM `Rule` WHERE 1;

--
-- INSERT template for table `Rule`
--
INSERT INTO `Rule`(`name`, `description`, `financial_instrument`, `authority`, `compatible_with_jurisdiction`, `id`) VALUES (?, ?, ?, ?, ?, ?);

--
-- UPDATE template for table `Rule`
--
UPDATE `Rule` SET `name` = ?, `description` = ?, `financial_instrument` = ?, `authority` = ?, `compatible_with_jurisdiction` = ?, `id` = ? WHERE 1;

--
-- DELETE template for table `Rule`
--
DELETE FROM `Rule` WHERE 0;


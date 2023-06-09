--
-- Rule book for multilateral financial Instruments.
-- Prepared SQL queries for 'Error' definition.
--


--
-- SELECT template for table `Error`
--
SELECT `message` FROM `Error` WHERE 1;

--
-- INSERT template for table `Error`
--
INSERT INTO `Error`(`message`) VALUES (?);

--
-- UPDATE template for table `Error`
--
UPDATE `Error` SET `message` = ? WHERE 1;

--
-- DELETE template for table `Error`
--
DELETE FROM `Error` WHERE 0;


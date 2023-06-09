/* SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO"; */
/* SET AUTOCOMMIT = 0; */
/* START TRANSACTION; */
/* SET time_zone = "+00:00"; */

-- --------------------------------------------------------

--
-- Table structure for table `Error` generated from model 'Error'
--

CREATE TABLE IF NOT EXISTS `Error` (
  `message` TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Table structure for table `NewRule` generated from model 'NewRule'
--

CREATE TABLE IF NOT EXISTS `NewRule` (
  `name` TEXT NOT NULL,
  `description` TEXT DEFAULT NULL,
  `financial_instrument` TEXT DEFAULT NULL,
  `authority` TEXT DEFAULT NULL,
  `compatible_with_jurisdiction` JSON DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Table structure for table `Rule` generated from model 'Rule'
--

CREATE TABLE IF NOT EXISTS `Rule` (
  `name` TEXT NOT NULL,
  `description` TEXT DEFAULT NULL,
  `financial_instrument` TEXT DEFAULT NULL,
  `authority` TEXT DEFAULT NULL,
  `compatible_with_jurisdiction` JSON DEFAULT NULL,
  `id` BIGINT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Table structure for table `Rule_allOf` generated from model 'RuleUnderscoreallOf'
--

CREATE TABLE IF NOT EXISTS `Rule_allOf` (
  `id` BIGINT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



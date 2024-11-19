-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2024 at 10:53 AM
-- Server version: 8.0.40
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `parkingspotdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `sticker_request`
--

CREATE TABLE `sticker_request` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `vehicle_type` enum('Car','Motorcycle','Bicycle') NOT NULL,
  `vehicle_brand` varchar(50) NOT NULL,
  `plate_number` varchar(20) NOT NULL,
  `gdrive_link` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(50) DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sticker_request`
--

INSERT INTO `sticker_request` (`id`, `user_id`, `vehicle_type`, `vehicle_brand`, `plate_number`, `gdrive_link`, `created_at`, `status`) VALUES
(1, 2221131, 'Motorcycle', 'Kawasaki', 'knikn', 'https://drive.google.com/drive/folders/188olOcDgY0dNt9xnkWIKeCGX3Bvk9FjC?usp=drive_link', '2024-11-15 04:16:21', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `user_account`
--

CREATE TABLE `user_account` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_account`
--

INSERT INTO `user_account` (`id`, `username`, `password`, `created_at`, `user_id`) VALUES
(1, 'admin1', 'password123', '2024-11-15 04:13:46', 1),
(2, 'admin2', 'password123', '2024-11-15 04:13:46', 2),
(3, 'student1', 'password123', '2024-11-15 04:14:45', 2221131),
(4, 'student2', 'password123', '2024-11-15 04:14:45', 2221132),
(5, 'teacher1', 'password123', '2024-11-15 04:14:45', 1000001);

-- --------------------------------------------------------

--
-- Table structure for table `user_profile`
--

CREATE TABLE `user_profile` (
  `user_id` int NOT NULL,
  `id` int NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `contact_number` varchar(15) DEFAULT NULL,
  `account_type` enum('Student','Employee','Teacher','Admin') NOT NULL,
  `department` varchar(255) DEFAULT NULL,
  `campus` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_profile`
--

INSERT INTO `user_profile` (`user_id`, `id`, `fullname`, `email`, `contact_number`, `account_type`, `department`, `campus`) VALUES
(1, 1, 'Admin One', 'admin1@ub.edu.ph', '09171234567', 'Admin', 'Administration', 'Main Campus'),
(2, 2, 'Admin Two', 'admin2@ub.edu.ph', '09172345678', 'Admin', 'Administration', 'Main Campus'),
(2221131, 3, 'Student One', '2221131@ub.edu.ph', '09173456789', 'Student', 'Engineering', 'Main Campus'),
(2221132, 4, 'Student Two', '2221132@ub.edu.ph', '09174567890', 'Student', 'Information Technology', 'Main Campus'),
(1000001, 5, 'Teacher One', 'teacher1@ub.edu.ph', '09175678901', 'Teacher', 'Science', 'Main Campus');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `sticker_request`
--
ALTER TABLE `sticker_request`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_plate_number` (`plate_number`),
  ADD KEY `sticker_request_ibfk_1_idx` (`user_id`);

--
-- Indexes for table `user_account`
--
ALTER TABLE `user_account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `user_profile_ibfk_1_idx` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sticker_request`
--
ALTER TABLE `sticker_request`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_account`
--
ALTER TABLE `user_account`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `sticker_request`
--
ALTER TABLE `sticker_request`
  ADD CONSTRAINT `sticker_request_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_profile` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD CONSTRAINT `user_profile_ibfk_1` FOREIGN KEY (`id`) REFERENCES `user_account` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

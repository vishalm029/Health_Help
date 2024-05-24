-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 24, 2024 at 03:53 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `medilab`
--

-- --------------------------------------------------------

--
-- Table structure for table `ai_detail`
--

CREATE TABLE `ai_detail` (
  `diagnose_id` int(5) NOT NULL,
  `symptom1` varchar(255) DEFAULT NULL,
  `symptom2` varchar(255) DEFAULT NULL,
  `symptom3` varchar(255) DEFAULT NULL,
  `symptom4` varchar(255) DEFAULT NULL,
  `symptom5` varchar(255) DEFAULT NULL,
  `symptom6` varchar(255) DEFAULT NULL,
  `symptom7` varchar(255) DEFAULT NULL,
  `prediction` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `userid` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ai_detail`
--

INSERT INTO `ai_detail` (`diagnose_id`, `symptom1`, `symptom2`, `symptom3`, `symptom4`, `symptom5`, `symptom6`, `symptom7`, `prediction`, `created_at`, `userid`) VALUES
(1, '0', '0', '0', '0', '0', '0', '0', 'Fungal infection', '2024-05-24 01:24:25', 1);

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `appid` int(5) NOT NULL,
  `patient_id` int(5) NOT NULL,
  `doctor_id` int(5) NOT NULL,
  `mode` varchar(255) NOT NULL,
  `timedata` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `status` int(5) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appid`, `patient_id`, `doctor_id`, `mode`, `timedata`, `reason`, `status`, `created_at`) VALUES
(1, 1, 1, 'Virtual', '2024-05-24T07:00', 'headache', 0, '2024-05-24 01:33:24'),
(2, 1, 1, 'Virtual', '2024-05-24T07:00', 'headache', 0, '2024-05-24 01:33:40'),
(3, 1, 1, 'Virtual', '2024-05-05T09:05', 'App', 0, '2024-05-24 01:35:09');

-- --------------------------------------------------------

--
-- Table structure for table `dr_detail`
--

CREATE TABLE `dr_detail` (
  `doctor_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `education` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `age` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `about` varchar(255) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `createdat` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dr_detail`
--

INSERT INTO `dr_detail` (`doctor_id`, `name`, `phone`, `domain`, `education`, `email`, `age`, `address`, `about`, `nickname`, `password`, `createdat`) VALUES
(1, 'John Doe', '123-456-7890', 'example.com', 'MD', 'john.doe@example.com', '45', '123 Main St, Anytown, USA', 'Experienced physician specializing in cardiology.', 'JD', '12345', '2024-05-24 01:25:49'),
(2, 'Jane Smith', '234-567-8901', 'example.org', 'PhD', 'jane.smith@example.org', '38', '456 Elm St, Othertown, USA', 'Renowned researcher in the field of genetics.', 'Janie', '12345', '2024-05-24 01:25:49'),
(3, 'Alice Johnson', '345-678-9012', 'example.net', 'DDS', 'alice.johnson@example.net', '50', '789 Oak St, Anycity, USA', 'Dedicated dentist with over 20 years of experience.', 'Ally', '12345', '2024-05-24 01:25:49'),
(4, 'Bob Brown', '456-789-0123', 'example.edu', 'DVM', 'bob.brown@example.edu', '42', '101 Pine St, Anyville, USA', 'Veterinarian with a focus on large animals.', 'Bobby', '12345', '2024-05-24 01:25:49'),
(5, 'Carol White', '567-890-1234', 'example.co', 'PharmD', 'carol.white@example.co', '35', '202 Maple St, Sometown, USA', 'Pharmacist with extensive knowledge in pharmacology.', 'Carrie', '12345', '2024-05-24 01:25:49');

-- --------------------------------------------------------

--
-- Table structure for table `patient_detail`
--

CREATE TABLE `patient_detail` (
  `patient_id` int(5) NOT NULL,
  `patient_name` varchar(40) NOT NULL,
  `phone` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `address` varchar(40) NOT NULL,
  `age` varchar(40) NOT NULL,
  `gender` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `nickname` varchar(255) NOT NULL,
  `role` varchar(225) NOT NULL,
  `about` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient_detail`
--

INSERT INTO `patient_detail` (`patient_id`, `patient_name`, `phone`, `email`, `address`, `age`, `gender`, `password`, `created_at`, `nickname`, `role`, `about`) VALUES
(1, 'Navin', '8978653454', 'navin@gmail.com', 'Colombo', '23', 'Female', '12', '2024-05-22 19:08:37', 'Jonas', 'SE', 'Something'),
(2, 'Dhana', '8909890989', 'dhana@gmail.com', 'Delhi', '23', 'Male', '12345', '2024-05-23 02:05:34', '', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ai_detail`
--
ALTER TABLE `ai_detail`
  ADD PRIMARY KEY (`diagnose_id`);

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`appid`);

--
-- Indexes for table `dr_detail`
--
ALTER TABLE `dr_detail`
  ADD PRIMARY KEY (`doctor_id`);

--
-- Indexes for table `patient_detail`
--
ALTER TABLE `patient_detail`
  ADD PRIMARY KEY (`patient_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ai_detail`
--
ALTER TABLE `ai_detail`
  MODIFY `diagnose_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `appid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dr_detail`
--
ALTER TABLE `dr_detail`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `patient_detail`
--
ALTER TABLE `patient_detail`
  MODIFY `patient_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

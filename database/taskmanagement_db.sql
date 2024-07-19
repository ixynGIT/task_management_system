-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 29, 2024 at 11:54 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `taskmanagement_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteProject` (IN `delete_project_id` INT)   BEGIN
        DELETE FROM project_list WHERE id = delete_project_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteTask` (IN `delete_task_id` INT)   BEGIN
        DELETE FROM task_list WHERE id = delete_task_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTotalProjects` (OUT `total_projects` INT)   BEGIN
   SELECT COUNT(*) FROM project_list;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTotalTasks` (OUT `get_total_tasks` INT)   BEGIN
   SELECT COUNT(*), project_list.name FROM task_list INNER JOIN
   project_list ON project_list.id = task_list.project_id
   GROUP BY project_id 
   ;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `added_progress_by_user_productivity`
-- (See below for the actual view)
--
CREATE TABLE `added_progress_by_user_productivity` (
`Project` varchar(200)
,`Task` varchar(200)
,`Subject` varchar(200)
,`User` varchar(200)
);

-- --------------------------------------------------------

--
-- Table structure for table `priority`
--

CREATE TABLE `priority` (
  `priority_id` int(11) NOT NULL,
  `priority_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `priority`
--

INSERT INTO `priority` (`priority_id`, `priority_name`) VALUES
(1, 'Important!'),
(2, 'Moderate'),
(3, 'Least');

-- --------------------------------------------------------

--
-- Table structure for table `project_list`
--

CREATE TABLE `project_list` (
  `id` int(30) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `manager_id` int(30) NOT NULL,
  `user_ids` text NOT NULL,
  `priority_id` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project_list`
--

INSERT INTO `project_list` (`id`, `name`, `description`, `status`, `start_date`, `end_date`, `manager_id`, `user_ids`, `priority_id`, `date_created`) VALUES
(3, 'Advanced Database Final Project', '																																																Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quis, quaerat consequatur quia inventore, facere vitae et magni fuga deleniti sapiente error iusto natus, nostrum laborum assumenda recusandae, facilis debitis tenetur?																																																			', 2, '2024-05-01', '2024-05-30', 6, '8,7', 1, '2024-05-16 04:22:18'),
(8, 'Data Structures and Algorithms Video Presentation', 'Provide a Video Presentation', 5, '2024-05-20', '2024-05-22', 6, '', 2, '2024-05-20 17:59:34');

--
-- Triggers `project_list`
--
DELIMITER $$
CREATE TRIGGER `after_update_project_priority_logs` AFTER UPDATE ON `project_list` FOR EACH ROW BEGIN
    IF OLD.priority_id != NEW.priority_id THEN
        INSERT INTO project_priority_logs (project_id, old_priority, new_priority, change_timestamp)
        VALUES (NEW.id, OLD.priority_id, NEW.priority_id, NOW());
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_project_list_status` BEFORE INSERT ON `project_list` FOR EACH ROW BEGIN
    IF NEW.start_date > NEW.end_date OR NEW.end_date<CURRENT_DATE THEN
        SET NEW.status = 4;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `project_list_priority_changes`
-- (See below for the actual view)
--
CREATE TABLE `project_list_priority_changes` (
`Project` varchar(200)
,`Old Priority` int(11)
,`New Priority` int(11)
,`Changed On` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `project_priority_logs`
--

CREATE TABLE `project_priority_logs` (
  `project_id` int(11) NOT NULL,
  `old_priority` int(11) NOT NULL,
  `new_priority` int(11) NOT NULL,
  `change_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project_priority_logs`
--

INSERT INTO `project_priority_logs` (`project_id`, `old_priority`, `new_priority`, `change_timestamp`) VALUES
(3, 2, 1, '2024-05-18 18:52:36'),
(3, 1, 3, '2024-05-18 18:54:02'),
(3, 3, 1, '2024-05-18 18:54:17');

-- --------------------------------------------------------

--
-- Stand-in structure for view `report_view`
-- (See below for the actual view)
--
CREATE TABLE `report_view` (
`id` int(30)
,`name` varchar(200)
,`total_tasks` bigint(21)
,`completed_tasks` decimal(22,0)
,`user_productivity_count` bigint(21)
,`total_duration` double
);

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(30) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(200) NOT NULL,
  `contact` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `cover_img` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `name`, `email`, `contact`, `address`, `cover_img`) VALUES
(1, 'Task Management System', 'info@sample.comm', '+6948 8542 623', '2102  Caldwell Road, Rochester, New York, 14608', '');

-- --------------------------------------------------------

--
-- Table structure for table `task_completion_logs`
--

CREATE TABLE `task_completion_logs` (
  `project_id` int(11) NOT NULL,
  `task_id` int(11) DEFAULT NULL,
  `start_timestamp` datetime NOT NULL,
  `completion_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `task_completion_logs`
--

INSERT INTO `task_completion_logs` (`project_id`, `task_id`, `start_timestamp`, `completion_timestamp`) VALUES
(3, 10, '2024-05-20 18:17:50', '2024-05-20 11:25:27'),
(8, 9, '2024-05-20 18:00:23', '2024-05-20 18:20:34');

-- --------------------------------------------------------

--
-- Table structure for table `task_list`
--

CREATE TABLE `task_list` (
  `id` int(30) NOT NULL,
  `project_id` int(30) NOT NULL,
  `task` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(4) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `task_list`
--

INSERT INTO `task_list` (`id`, `project_id`, `task`, `description`, `status`, `date_created`) VALUES
(5, 3, 'Project Proposal', '																Create a Project Proposal for the final project												', 2, '2024-05-16 04:50:03'),
(9, 8, 'Canva Edit', '																												', 3, '2024-05-20 18:00:23'),
(10, 3, 'Research on what system to make for database', '																												', 3, '2024-05-20 18:17:50'),
(11, 3, 'Create a system', '														', 2, '2024-05-20 18:18:08');

--
-- Triggers `task_list`
--
DELIMITER $$
CREATE TRIGGER `insert_delete_task_compeletion_logs` AFTER UPDATE ON `task_list` FOR EACH ROW BEGIN
	 IF NEW.status = 3 THEN
    	INSERT INTO task_completion_logs 
        VALUES (NEW.project_id, NEW.id, NEW.date_created, NOW());
        
    ELSE 
    	DELETE FROM task_completion_logs
        WHERE task_id = NEW.id;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_project_status_after_task_update` AFTER UPDATE ON `task_list` FOR EACH ROW BEGIN
    DECLARE task_done_count INT;
    DECLARE task_total_count INT;
    
    SELECT COUNT(*) INTO task_done_count
    FROM task_list
    WHERE project_id = NEW.project_id
    AND status = 3;
    
    SELECT COUNT(*) INTO task_total_count
    FROM task_list
    WHERE project_id = NEW.project_id;

    -- If the number of done tasks is equal to the number of total tasks, update the project status to done
    IF task_done_count = task_total_count THEN
        UPDATE project_list
        SET status = 5
        WHERE id = NEW.project_id;
    ELSE
    	UPDATE project_list
        SET status = 2
        Where id = NEW.project_id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `task_list_completed`
-- (See below for the actual view)
--
CREATE TABLE `task_list_completed` (
`Project` varchar(200)
,`Task` varchar(200)
,`Started On` datetime
,`Completed On` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(30) NOT NULL,
  `firstname` varchar(200) NOT NULL,
  `lastname` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` text NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 2 COMMENT '1 = admin, 2 = staff',
  `avatar` text NOT NULL DEFAULT 'no-image-available.png',
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password`, `type`, `avatar`, `date_created`) VALUES
(1, 'Administrator', '', 'admin@admin.com', '0192023a7bbd73250516f069df18b500', 1, '1716217320_logo.png', '2020-11-26 10:57:04'),
(6, 'Christian Rafael', 'Plasabas', 'plasabas@gmail.com', '202cb962ac59075b964b07152d234b70', 2, '1715803680_renato Plasabas.jpg', '2024-05-16 04:08:47'),
(7, 'Remar John', 'Pormanis', 'tester@gmail.com', '202cb962ac59075b964b07152d234b70', 3, '1715804160_login-left (1).jpg', '2024-05-16 04:16:11'),
(8, 'Dominic', 'Prajes', 'tester2@gmail.com', '202cb962ac59075b964b07152d234b70', 3, '1715804160_B7.jpg', '2024-05-16 04:16:51');

-- --------------------------------------------------------

--
-- Table structure for table `user_productivity`
--

CREATE TABLE `user_productivity` (
  `id` int(30) NOT NULL,
  `project_id` int(30) NOT NULL,
  `task_id` int(30) NOT NULL,
  `comment` text NOT NULL,
  `subject` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `user_id` int(30) DEFAULT NULL,
  `time_rendered` float NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_productivity`
--

INSERT INTO `user_productivity` (`id`, `project_id`, `task_id`, `comment`, `subject`, `date`, `start_time`, `end_time`, `user_id`, `time_rendered`, `date_created`) VALUES
(9, 3, 10, '																										', 'Meeting', '2024-05-07', '20:24:00', '14:19:00', 1, 6.08333, '2024-05-20 20:19:25'),
(10, 3, 5, '													', 'Creating the project proposal', '2024-05-14', '16:14:00', '22:25:00', 1, 6.18333, '2024-05-20 23:14:30'),
(15, 8, 9, '													', 'Meeting', '2024-05-09', '08:19:00', '22:30:00', 1, 14.1833, '2024-05-21 02:19:36');

-- --------------------------------------------------------

--
-- Structure for view `added_progress_by_user_productivity`
--
DROP TABLE IF EXISTS `added_progress_by_user_productivity`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `added_progress_by_user_productivity`  AS SELECT `project_list`.`name` AS `Project`, `task_list`.`task` AS `Task`, `user_productivity`.`subject` AS `Subject`, `users`.`firstname` AS `User` FROM (((`user_productivity` join `project_list` on(`project_list`.`id` = `user_productivity`.`project_id`)) join `task_list` on(`task_list`.`id` = `user_productivity`.`task_id`)) join `users` on(`users`.`id` = `user_productivity`.`user_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `project_list_priority_changes`
--
DROP TABLE IF EXISTS `project_list_priority_changes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `project_list_priority_changes`  AS SELECT `project_list`.`name` AS `Project`, `project_priority_logs`.`old_priority` AS `Old Priority`, `project_priority_logs`.`new_priority` AS `New Priority`, `project_priority_logs`.`change_timestamp` AS `Changed On` FROM (`project_list` join `project_priority_logs` on(`project_list`.`id` = `project_priority_logs`.`project_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `report_view`
--
DROP TABLE IF EXISTS `report_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `report_view`  AS SELECT `p`.`id` AS `id`, `p`.`name` AS `name`, coalesce(`t`.`total_tasks`,0) AS `total_tasks`, coalesce(`t`.`completed_tasks`,0) AS `completed_tasks`, coalesce(`u`.`user_productivity_count`,0) AS `user_productivity_count`, coalesce(`u`.`total_duration`,0) AS `total_duration` FROM ((`project_list` `p` left join (select `task_list`.`project_id` AS `project_id`,count(0) AS `total_tasks`,sum(case when `task_list`.`status` = 3 then 1 else 0 end) AS `completed_tasks` from `task_list` group by `task_list`.`project_id`) `t` on(`p`.`id` = `t`.`project_id`)) left join (select `user_productivity`.`project_id` AS `project_id`,count(0) AS `user_productivity_count`,sum(`user_productivity`.`time_rendered`) AS `total_duration` from `user_productivity` group by `user_productivity`.`project_id`) `u` on(`p`.`id` = `u`.`project_id`)) ORDER BY `p`.`name` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `task_list_completed`
--
DROP TABLE IF EXISTS `task_list_completed`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `task_list_completed`  AS SELECT `project_list`.`name` AS `Project`, `task_list`.`task` AS `Task`, `task_completion_logs`.`start_timestamp` AS `Started On`, `task_completion_logs`.`completion_timestamp` AS `Completed On` FROM ((`task_list` join `task_completion_logs` on(`task_list`.`id` = `task_completion_logs`.`task_id`)) join `project_list` on(`project_list`.`id` = `task_completion_logs`.`project_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `priority`
--
ALTER TABLE `priority`
  ADD PRIMARY KEY (`priority_id`);

--
-- Indexes for table `project_list`
--
ALTER TABLE `project_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_listx` (`id`),
  ADD KEY `fk_priority_id_project_list` (`priority_id`);

--
-- Indexes for table `project_priority_logs`
--
ALTER TABLE `project_priority_logs`
  ADD KEY `fk_project_id_change` (`project_id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `task_completion_logs`
--
ALTER TABLE `task_completion_logs`
  ADD KEY `fk_task_id_completion` (`task_id`),
  ADD KEY `fk_project_id_completion` (`project_id`);

--
-- Indexes for table `task_list`
--
ALTER TABLE `task_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `task_listx` (`id`),
  ADD KEY `fk_project_id_task_list` (`project_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_productivity`
--
ALTER TABLE `user_productivity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_project_id_user_productivity` (`project_id`),
  ADD KEY `fk_task_id_user_productivity` (`task_id`),
  ADD KEY `fk_user_id_user_productivity` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `priority`
--
ALTER TABLE `priority`
  MODIFY `priority_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `project_list`
--
ALTER TABLE `project_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `task_list`
--
ALTER TABLE `task_list`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user_productivity`
--
ALTER TABLE `user_productivity`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `project_list`
--
ALTER TABLE `project_list`
  ADD CONSTRAINT `fk_priority_id_project_list` FOREIGN KEY (`priority_id`) REFERENCES `priority` (`priority_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `project_priority_logs`
--
ALTER TABLE `project_priority_logs`
  ADD CONSTRAINT `fk_project_id_change` FOREIGN KEY (`project_id`) REFERENCES `project_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `task_completion_logs`
--
ALTER TABLE `task_completion_logs`
  ADD CONSTRAINT `fk_project_id_completion` FOREIGN KEY (`project_id`) REFERENCES `project_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_task_id_completion` FOREIGN KEY (`task_id`) REFERENCES `task_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `task_list`
--
ALTER TABLE `task_list`
  ADD CONSTRAINT `fk_project_id_task_list` FOREIGN KEY (`project_id`) REFERENCES `project_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_productivity`
--
ALTER TABLE `user_productivity`
  ADD CONSTRAINT `fk_project_id_user_productivity` FOREIGN KEY (`project_id`) REFERENCES `project_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_task_id_user_productivity` FOREIGN KEY (`task_id`) REFERENCES `task_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_id_user_productivity` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

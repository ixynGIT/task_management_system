<?php
// Connect to the database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "taskmanagement_db";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "CALL GetTotalProjects(@totalCount);";
$result = $conn->query($sql);
$row = $result->fetch_assoc();
$totalCount = $row['COUNT(*)'];

// Return the total count as JSON

echo json_encode(array("totalCount" => $totalCount));

// Close the database connection
$conn->close();
?>

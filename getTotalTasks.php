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

// Call the stored procedure
$sql = "CALL GetTotalTasks(@)"; // Assuming GetTotalTasks returns a result set with project names and task counts
$result = $conn->query($sql);

$projects = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $projects[] = array(
            'name' => $row['name'], // Adjust based on your actual column name
            'totalCount' => $row['COUNT(*)'] // Adjust based on your actual column name
        );
    }
} else {
    $projects[] = array(
        'name' => 'No Projects',
        'totalCount' => 0
    );
}

// Return the total count as JSON
echo json_encode($projects);

// Close the database connection
$conn->close();
?>

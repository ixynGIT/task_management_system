<?php include 'ajax.php';?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Get Total Count</title>
</head>
<body>
    <button onclick="getTotalProjects()">Get Total Number of Projects</button>
    <script>
        function getTotalProjects() {
            // Send a request to PHP script
            fetch('test.php')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    // Display the total count in an alert
                    alert(`Total Number of Projects: ${data.totalCount}`);
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Failed to get the total count.');
                });
        }
    </script>
</body>
</html>

<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['index'])) {
    $index = $_POST['index'];

    // Read the CSV file
    $csvFile = '/usr/local/cast/etc/castmemlist.txt';
    $rows = array_map('str_getcsv', file($csvFile));

    // Ensure the index is valid
    if (isset($rows[$index])) {
        // Remove the specified row
        unset($rows[$index]);

        // Re-index the array
        $rows = array_values($rows);

        // Convert rows back to CSV format
        $csvData = implode("\n", array_map(function ($row) {
            return implode(',', $row);
        }, $rows));

        // Write the updated CSV data back to the file
        file_put_contents($csvFile, $csvData);

        echo "Row deleted successfully!";
    } else {
        echo "Invalid index!";
    }
} else {
    echo "Invalid request!";
}
?>


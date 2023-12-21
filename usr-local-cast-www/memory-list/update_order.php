<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['order'])) {
    $order = explode(',', $_POST['order']);

    // Ensure 'order' is an array with valid indices
    if (!is_array($order) || empty($order)) {
        echo "Invalid order data!";
        exit;
    }

    // Read the CSV file
    $csvFile = '/usr/local/cast/etc/castmemlist.txt';
    $rows = array_map(
        function ($row) {
            // Trim trailing commas from each element
            return array_map('rtrim', $row);
        },
        array_map('str_getcsv', file($csvFile))
    );

    // Ensure indices in 'order' are valid
    $validIndices = range(0, count($rows) - 1);
    if (count(array_diff($order, $validIndices)) > 0) {
        echo "Invalid order indices!";
        exit;
    }

    // Rearrange rows according to the new order
    $newRows = array();
    foreach ($order as $index) {
        $newRows[] = $rows[$index];
    }

    // Convert rows back to CSV format
    $csvData = implode("\n", array_map(function ($row) {
        return implode(',', $row);
    }, $newRows));

    // Write the updated order to the CSV file
    $result = file_put_contents($csvFile, $csvData);

    if ($result !== false) {
        echo "Order updated successfully!";
    } else {
        echo "Error updating order!";
    }
} else {
    echo "Invalid request!";
}
?>


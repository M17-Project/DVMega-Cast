<?php

$target_dir = "./fw/";

$original_file_name = $_FILES["fileToUpload"]["name"];
$target_file = $target_dir . basename($original_file_name);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

// Check if $uploadOk is set to 0 by an error
if ($uploadOk == 0) {
    echo "Sorry, your file was not uploaded.";
} else {
    if ($_FILES["fileToUpload"]["error"] == UPLOAD_ERR_OK) {
        // Remove (1), (2), etc., from the filename
        $new_file_name = removeDumbNames($original_file_name);

        // Set the new target file path
        $new_target_file = $target_dir . $new_file_name;

        // Copy the uploaded file directly to the target directory
        if (copy($_FILES["fileToUpload"]["tmp_name"], $new_target_file)) {
            // Unlink (delete) the temporary file
            unlink($_FILES["fileToUpload"]["tmp_name"]);

            include("confirm_main.inc");
        } else {
            echo "Sorry, there was an error copying the uploaded file to the target directory.";
        }
    } else {
        echo "Sorry, there was an error uploading your file. Error code: " . $_FILES["fileToUpload"]["error"];
    }
}

function removeDumbNames($original_file_name) {
    // Remove stupid ` (n)` from the filename
    $new_file_name = preg_replace('/\s+\(\d+\)/', '', $original_file_name);

    return $new_file_name;
}

?>

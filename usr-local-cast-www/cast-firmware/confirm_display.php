<?php
if (isset($_POST['button_clicked']) && $_POST['button_clicked'] === 'true')
{
    exec('sudo /usr/local/cast/sbin/flash_next.sh');
    header("Location: /admin/cast/cast-firmware/finish.php");
} else {
    echo "no post data";
}
?>


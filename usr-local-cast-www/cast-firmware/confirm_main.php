<?php
if (isset($_POST['button']))
    {
	shell_exec('sudo /usr/local/cast/sbin/flash_cast.sh');
	header("Location: /admin/cast/cast-firmware/finish.php");

    }
?>


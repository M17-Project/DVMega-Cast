<?php
exec('sudo mount -o remount,rw /');

exec('sudo pistar-expand');

header("Location:finish.php");


?>

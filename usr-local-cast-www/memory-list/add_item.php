<?php 

$RTG_ref = $_POST['RTG_ref'];
$RTG_mod = $_POST['RTG_mod'];
$RTG_lab = $_POST['RTG_lab']; 
$mode = $_POST['mode'];
$cont = '';

if (strlen($RTG_lab) == 0) {
    if ($mode == 'DST') {
        $RTG_lab = $RTG_ref . ' ' . $RTG_mod;
    } elseif ($mode == 'DMR' || $mode == 'YSF') {
        $RTG_lab = $RTG_ref;
    }
}

if ($mode == 'DST' && strlen($RTG_ref) > 0) {
    $RTG_ref = $RTG_ref . ' ' . $RTG_mod; 
    $cont = 'DST,' . $RTG_ref . ',' . $RTG_lab . ",\n";
}

if ($mode == 'DMR' && strlen($RTG_ref) > 0) {
    $cont = 'DMR,' . $RTG_ref . ',' . $RTG_lab . ",\n";
}

if ($mode == 'YSF' && strlen($RTG_ref) > 0) {
    $cont = 'YSF,' . $RTG_ref . ',' . $RTG_lab . ",\n";
}

$fileLocation = '/usr/local/cast/etc/castmemlist.txt';
$names = file($fileLocation);

if (strlen($cont) > 3 && count($names) < 25) {
    $new = '';
    foreach ($names as $name) {
        $name = substr($name, 0, -1);

        if (strlen($name) > 3) {  
            $new .= $name . "\n";
        }
    }
    $new .= $cont;

    $myfile = fopen($fileLocation, 'w');
    fwrite($myfile, $new);
    fclose($myfile);
}

header('Location: /admin/cast/memory-list/');

?>


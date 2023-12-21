<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/config/language.php';
require_once $_SERVER['DOCUMENT_ROOT'].'/config/version.php';
require_once $_SERVER['DOCUMENT_ROOT'].'/config/config.php';

?>

    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html lang="en">
	<head>
	    <meta name="language" content="English" />
	    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
	    <meta http-equiv="pragma" content="no-cache" />
	    <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	    <meta http-equiv="Expires" content="0" />
	    <title>WPSD <?php echo $lang['digital_voice']." ".$lang['dashboard']."";?> - DVMega CAST Firmware Manager</title>
	    <link rel="stylesheet" type="text/css" href="/css/font-awesome-4.7.0/css/font-awesome.min.css" />
<?php include_once $_SERVER['DOCUMENT_ROOT'].'/config/browserdetect.php'; ?>
	    <script type="text/javascript" src="/js/jquery.min.js?version=<?php echo $versionCmd; ?>"></script>
	    <script type="text/javascript" src="/js/functions.js?version=<?php echo $versionCmd; ?>"></script>
	</head>
	<body>
	    <div class="container">
                <div class="header">
                    <div class="SmallHeader shLeft noMob">Hostname: <?php echo exec('cat /etc/hostname'); ?></div>
                    <div class="SmallHeader shRight noMob">
                      <div id="CheckUpdate">
                      <?php
                          include $_SERVER['DOCUMENT_ROOT'].'/includes/checkupdates.php';
                      ?>
                      </div><br />
                    </div>
                    <h1>WPSD <?php echo $lang['digital_voice']; ?> -  DVMega CAST Firmware Manager</h1>
			<div class="navbar">
 			<script type= "text/javascript">
			  $(document).ready(function() {
			    setInterval(function() {
			      $("#timer").load("/includes/datetime.php");
			    }, 1000);

			    function update() {
			      $.ajax({
				type: 'GET',
				cache: false,
				url: '/includes/datetime.php',
				timeout: 1000,
				success: function(data) {
				  $("#timer").html(data); 
				  window.setTimeout(update, 1000);
				}
			      });
			    }
			  update();
			});
		      </script>
 		      <div class="headerClock">
			<span id="timer"></span>
		      </div>
 		      <a class="menuconfig" href="/admin/configure.php"><?php echo $lang['configuration'];?></a>
		      <a class="menuadmin noMob" href="/admin/"><?php echo $lang['admin'];?></a>
		      <a class="menudashboard" href="/"><?php echo $lang['dashboard'];?></a>
 	    	</div>
                </div>
		<div class="contentwide">
<br />
<h2 class="ConfSec larger center">DVMega Cast Firmware Manager</h2>
<p>This page will allow you to update the DVMega Cast Mainboard, Display, and if equipped; Hotspot Radio Board.</p>
<p><i class="fa fa-question-circle"></i> To download Cast updates to your registered Cast device, please visit the <a href="https://www.dvmega.nl/update/" target="_new">DVMega Cast Update Server</a>.<br />
   If your DVMega Cast device is not yet registered, you must <a href="https://www.dvmega.nl/registration/" target="_new">register your device</a> before you can download Cast updates.
</p>
   
<br />
 <table width="100%">
  <tr>
    <th style="white-space: normal; padding: 10px;" class="larger">DVMEGA-Cast Mainboard</th>
    <th style="white-space: normal; padding: 10px;" class="larger">DVMEGA-Cast Display</th>
    <?php if (file_exists('/dev/ttyS2')) { // only display this if the hotspot radio board is installed ?>
    <th style="white-space: normal; padding: 10px;" class="larger">DVMEGA-Cast Hotspot Radio Board</th>
    <?php } ?>
  </tr> 

  <tr>
    <td style="white-space: normal; padding: 10px;">
	<form action="upload_main.php" method="post" enctype="multipart/form-data">
	<p>Select the Firmware file to upload to the DVMEGA-Cast unit.</p>
	<p><i class="fa fa-exclamation-triangle"></i> DO NOT UNZIP THE FILE; UPLOAD AS-IS.</p>
	<input type="file" name="fileToUpload" id="fileToUpload">
        <input type="submit" value="Upload Firmware" name="submit">
	</form>
    </td>

    <td style="white-space: normal; padding: 10px;">
	<form action="upload_display.php" method="post" enctype="multipart/form-data">
        <p>Select the Firmware file to upload to the DVMEGA-Cast Display.</p>
	<p><i class="fa fa-exclamation-triangle"></i> DO NOT UNZIP THE FILE; UPLOAD AS-IS.</p>
        <input type="file" name="fileToUpload" id="fileToUpload">
        <input type="submit" value="Upload Firmware" name="submit">
	</form>
    </td>

    <?php if (file_exists('/dev/ttyS2')) { // only display this if the hotspot radio board is installed ?>
    <td style="white-space: normal; padding: 10px;">
	<form action="upload_radio.php" method="post" enctype="multipart/form-data">
        <p>Select Firmware-file to upload to the DVMEGA-Cast Hotspot Radio Board</p>
        <input type="file" name="fileToUpload" id="fileToUpload">
        <input type="submit" value="Upload Firmware" name="submit">
	</form>
    </td>
    <?php } ?>

 </tr>
</table>

		<br />
		<br />
	    </div>

	    <div class="footer">
		<a href="https://wpsd.radio/">WPSD</a> &copy; <code>W0CHP</code> 2020-<?php echo date("Y"); ?><br />
	    </div>
	</div>
    </body>
</html>

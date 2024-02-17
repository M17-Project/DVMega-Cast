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
                      <a class="menuconfig" href="/admin/configure.php"><?php echo __( 'Configuration' );?></a>
                      <a class="menuadmin noMob" href="/admin/"><?php echo __( 'Admin' );?></a>
                      <a class="menudashboard" href="/"><?php echo __( 'Dashboard' );?></a>
 	    	</div>
                </div>
		<div class="contentwide">
		<br />
		<h2 class="ConfSec larger center">DVMega Cast Mainboard Firmware Upgrade</h2>
		<h3 class="larger center">UPDATE HAS BEEN COMPLETED!</h2>
		<p><b>Your unit has been updated and reinitialized.</br>
		You will be redirected to the Main Dashboard in 10 seconds...</b></p>

               <script language="JavaScript" type="text/javascript">
                   setTimeout("location.href = \'/\'",10000);
               </script> 

		<br />
		<br />
	    </div>

	    <div class="footer">
		<a href="https://wpsd.radio/">WPSD</a> &copy; <code>W0CHP</code> 2020-<?php echo date("Y"); ?><br />
	    </div>
	</div>
    </body>
</html>

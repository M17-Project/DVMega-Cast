<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/config/language.php';
require_once $_SERVER['DOCUMENT_ROOT'].'/config/version.php';
require_once $_SERVER['DOCUMENT_ROOT'].'/config/config.php';

// Create Sample list if one does not exist.
 $fileLocation = '/usr/local/cast/etc/castmemlist.txt';
 if(!file_exists($fileLocation)) {
     $nf = fopen($fileLocation, "w");
    fwrite($nf, "DMR,91,BM World-Wide,\n");
    fclose($nf);

 }
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
	    <title>WPSD <?php echo $lang['digital_voice']." ".$lang['dashboard']."";?> - DVMega CAST Memory List Manager</title>
	    <link rel="stylesheet" type="text/css" href="/css/font-awesome-4.7.0/css/font-awesome.min.css" />
<?php include_once $_SERVER['DOCUMENT_ROOT'].'/config/browserdetect.php'; ?>
	    <script type="text/javascript" src="/js/jquery.min.js?version=<?php echo $versionCmd; ?>"></script>
	    <script type="text/javascript" src="/js/functions.js?version=<?php echo $versionCmd; ?>"></script>
	    <link href="/js/select2/css/select2.min.css?version=<?php echo $versionCmd; ?>" rel="stylesheet" />
	    <script src="/js/select2/js/select2.full.min.js?version=<?php echo $versionCmd; ?>"></script>
	    <script src="/js/select2/js/select2-searchInputPlaceholder.js?version=<?php echo $versionCmd; ?>"></script>
	    <link rel="stylesheet" href="/js/jqui/jquery-ui.css?version=<?php echo $versionCmd; ?>">
	    <link rel="stylesheet" href="/js/jqui/jquery-ui.structure.css?version=<?php echo $versionCmd; ?>">
	    <link rel="stylesheet" href="/js/jqui/jquery-ui.theme.css?version=<?php echo $versionCmd; ?>">
	    <script src="/js/jqui/jquery-ui.js?version=<?php echo $versionCmd; ?>"></script>
	    <style>
		#sortable {
		  table-layout: fixed;
		  width: 100%;
		  text-align: left;
		}

		#sortable tbody td {
		  padding: 8px;
		}

		.drag-handle {
		  cursor: move;
		  display: inline-block;
		  text-align: center;
		  padding: 10px 8px 0px 8px;
		}

		.delete-row {
		  text-align: center;
		  color: crimson;
		}
		/*
		#sortable tbody tr:hover {
		  cursor: move;
		}
		*/
	    </style>
	    <script>
                $(document).ready(function () {
                    // Make the rows sortable
                    $("#sortable tbody").sortable({
                        helper: function (e, ui) {
                            // Preserve original cell widths
                            ui.children().each(function () {
                                $(this).width($(this).width());
                            });
                            return ui;
                        },
                        update: function (event, ui) {
                            // Update order on the server
                            updateOrder();
                        },
                        stop: function (event, ui) {
                            // Update the data-index attribute after sorting stops
                            updateRowIndexes();
                        }
                    }).disableSelection();

                    // Handle row deletion
                    $("#sortable tbody").on("click", ".delete-row", function () {
                        // Get the index of the row to be deleted
                        var index = $(this).data("index");

                        // Delete the row on the server
                        deleteRow(index);
                    });

                    // Function to update order on the server
                    function updateOrder() {
                        var order = $("#sortable tbody tr").map(function () {
                            return $(this).find("button.delete-row").data("index");
                        }).get().join(",");

                        $.ajax({
                            type: "POST",
                            url: "update_order.php",
                            data: { order: order },
                            success: function (response) {
                                console.log(response);
                            }
                        });
                    }

                    // Function to update row indexes after sorting stops or row deletion
                    function updateRowIndexes() {
                        $("#sortable tbody tr").each(function (index) {
                            $(this).find("button.delete-row").data("index", index);
                        });
                    }

                    // Function to delete row on the server
                    function deleteRow(index) {
                        $.ajax({
                            type: "POST",
                            url: "delete_row.php",
                            data: { index: index },
                            success: function (response) {
                                console.log(response);

                                // Remove the deleted row from the UI
                                $("#sortable tbody tr:eq(" + index + ")").remove();

                                // Update the data-index attribute after deletion
                                updateRowIndexes();
                            }
                        });
                    }
                });
	    </script>

            <script>
            $(document).ready(function() {
            $('.dstarRef').select2({searchInputPlaceholder: 'Search...', width: '125px'});
            $('.dstarMod').select2({searchInputPlaceholder: 'Search...'});
            $('.ysfRef').select2({searchInputPlaceholder: 'Search...', width: '150px'});
            $(".RefName").select2({
              tags: true,
              width: '125px',
              dropdownAutoWidth : false,
              createTag: function (params) {
                return {
                  id: params.term,
                  text: params.term,
                  newOption: true
                }
              },
              templateResult: function (data) {
                var $result = $("<span></span>");

                $result.text(data.text);

                if (data.newOption) {
                  $result.append(" <em>(Search existing, or enter and save custom reflector value.)</em>");
                }

                return $result;
              }
            });
          });
          </script>
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
                    <h1>WPSD <?php echo $lang['digital_voice']; ?> -  DVMega CAST Memory List Manager</h1>
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
		  <br /><h2 class='ConfSec'>Add to Memory List</h2>


<table style="width:100%">
  <tr>
    <th align='left' style="width:33%" class="larger">D-Star</th>
    <th align='left' style="width:33%" class="larger">DMR</th>
    <th align='left' style="width:33%" class="larger">YSF</th>
  </tr>

  <tr>
   <td style="text-align:left;padding-left:15px;white-space:normal;">
   <form action="add_item.php" method="post">  
      <select name="RTG_ref" class="dstarRef">
	<option disabled selected>Select...</option>
<?php
        $fileLocation =  "/usr/local/etc/DCS_Hosts.txt";
        $names=file($fileLocation);
        foreach($names as $name)
        {
         if(substr($name,0,3) == "DCS")
         {
           $li = substr($name,0,6);
           echo"<option value='".$li."'>". $li . "</option>\n";
         }
        }

        $fileLocation =  "/usr/local/etc/DPlus_Hosts.txt";
        $names=file($fileLocation);
        foreach($names as $name)
        {
         if(substr($name,0,3) == "REF")
         {
           $li = substr($name,0,6);
           echo"<option value='".$li."'>". $li . "</option>\n";
         }
        }

        $fileLocation =  "/usr/local/etc/DExtra_Hosts.txt";
        $names=file($fileLocation);
        foreach($names as $name)
        {
         if(substr($name,0,3) == "XRF")
         {
           $li = substr($name,0,6);
           echo"<option value='".$li."'>". $li . "</option>\n";
         }
        }

        $fileLocation =  "/usr/local/etc/XLXHosts.txt";
        $names=file($fileLocation);
        foreach($names as $name)
        {
         if(substr($name,0,1) != "#")
         {
           $li = "XLX". substr($name,0,3);
           echo"<option value='".$li."'>". $li . "</option>\n";
         }
        }
?>
      </select>
      <select name="RTG_mod" class="dstarMod">
	<option disabled selected>Module...</option>
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
        <option value="D">D</option>
        <option value="E">E</option>
        <option value="F">F</option>
        <option value="G">G</option>
        <option value="H">H</option>
        <option value="I">I</option>
        <option value="J">J</option>
        <option value="K">K</option>
        <option value="L">L</option>
        <option value="M">M</option>
        <option value="N">N</option>
        <option value="O">O</option>
        <option value="P">P</option>
        <option value="Q">Q</option>
        <option value="R">R</option>
        <option value="S">S</option>
        <option value="T">T</option>
        <option value="U">U</option>
        <option value="V">V</option>
        <option value="W">W</option>
        <option value="X">X</option>
        <option value="Y">Y</option>
        <option value="Z">Z</option>
      </select> <label>Reflector &amp; Module</label>
     <input type="hidden" id="mode" name="mode" value="DST">
     <p><input type="text" maxlength="12" size="11" id="RTG_lab" name="RTG_lab"> <label>Description</label></p>
     <p><input style="margin:0;" type="submit" value="Add D-Star Reflector" name="submit"></p>
  </form>
  </td>

   <td style="text-align:left;padding-left:15px;white-space:normal;">
   <form action="add_item.php" method="post">  
   <p><input type="text" maxlength="9" size="11" id="RTG_ref" name="RTG_ref"> <label>Talkgroup</label></p>
    <input type="hidden" id="mode" name="mode" value="DMR">
    <p><input type="hidden" id="RTG_mod" name="RTG_mod" value="0">
    <input type="text" maxlength="12" size="11" id="RTG_lab" name="RTG_lab"> <label>Description</label></p>
   <p><input style="margin:0;" type="submit" value="Add DMR Talkgroup" name="submit"></p>
  </form>
  </td>

   <td style="text-align:left;padding-left:15px;white-space:normal;">
   <form action="add_item.php" method="post">
      <p>
      <select name="RTG_ref" class="ysfRef">
	<option disabled selected>Select...</option>
<?php
        $fileLocation =  "/usr/local/etc/YSFHosts.txt";
        $names=file($fileLocation);
        foreach($names as $name)
        {
         if(substr($name,0,1) != "#")
         {
           $i = 0;
//           $li = "YSF". substr($name,0,5) . " ";
         $li = "";
           do{
           $li .= substr($name,6+$i,1);
           $i += 1; 
          } while(substr($name,6+$i, 1) != ";");

           echo"<option value='".$li."'>". $li . "</option>\n";
         }
        }

        $fileLocation =  "/usr/local/etc/FCSHosts.txt";
        $names=file($fileLocation);
        foreach($names as $name)
        {
         if(substr($name,0,3) == "FCS")
         {
           $li = substr($name,0,8);
           echo"<option value='".$li."'>". $li . "</option>\n";
         }
        }
?>

      </select> <label>Room/Reflector</label>
     <input type="hidden" id="mode" name="mode" value="YSF">
     <p><input type="hidden" id="RTG_mod" name="RTG_mod" value="0">
     <input type="text" maxlength="12" size="11" id="RTG_lab" name="RTG_lab"> <label>Description</label></p>
     <p><input style="margin:0;" type="submit" value="Add Fusion Reflector/Room" name="submit"></p>
  </form>
  </td>

</tr>
</table>

<?php
  $csvFile = '/usr/local/cast/etc/castmemlist.txt';
  $names=file($csvFile);
  echo "  <br />\n  <h2 class='ConfSec'>Stored Memories (". count($names) . "/25)";
  if(count($names) > 24) echo " Memory full!";
  echo "  </h2>\n";
?>

<table class="larger" id="sortable">
    <thead>
        <tr>
            <th width="40px">&nbsp;</th>
            <th>Mode</th>
            <th>Reflector / YSF Room / DMR Talkgroup</th>
            <th>Description</th>
            <th width="40px">&nbsp;</th>
        </tr>
    </thead>
    <tbody>
    <?php
    // Read the CSV file and display rows
    $rows = array_map('str_getcsv', file($csvFile));

    foreach ($rows as $index => $row) {
        // Ensure each row has exactly three columns
        $row = array_slice($row, 0, 3);

        // Replace "DST" with "D-Star" in the displayed text
        $row[0] = ($row[0] === 'DST') ? 'D-Star' : $row[0];
        echo '<tr>'."\n".'<td><span class="drag-handle">&#9776;</span></td>'."\n".'<td>' . implode('</td>'."\n".'<td>', $row) . '</td>'."\n".'<td><button title="Delete from Memory" class="delete-row" data-index="' . $index . '"><i class="fa fa-trash"></i></button></td>'."\n".'</tr>';

        #echo '<tr><td><span class="drag-handle">&#9776;</span></td><td>' . implode('</td><td>', $row) . '</td><td><button class="delete-row" data-index="' . $index . '">Delete</button></td></tr>';
    }
    ?>
    </tbody>
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

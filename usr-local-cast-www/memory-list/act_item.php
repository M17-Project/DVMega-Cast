<html>
<body>

<?php 
  $cont =  $_POST["memId"]; 
  $cont = substr($cont,0,-2);
  $new ="";

  $action = $_POST['submit'];
//  echo $action;
//  echo $cont;

//============================
 if($action == "Delete")
 {
  $fileLocation = '/usr/local/cast/etc/castmemlist.txt';
  $names=file($fileLocation);
  foreach($names as $name)
  {
    $name = substr($name,0,-1);

    if($name == $cont)
    {  

    }
    else
    {
      $new .= $name;
      $new .= "\n";
    }

    shell_exec('sudo mount -o remount,rw /');
    $myfile = fopen($fileLocation, "w") or die("file open error");
    fwrite($myfile, $new);
    fclose($myfile);
  }
 }
//================================
if($action == "Up")
{
  $fileLocation = '/usr/local/cast/etc/castmemlist.txt';
  $names=file($fileLocation);
  $t = 0;
  foreach($names as $name)
  {
   if(strlen($name) > 3)
   {
    $name = substr($name,0,-1);
    $arr[$t] = $name;
    $t += 1;
   } 
  }

  $swap_flag = 0;
  for($l = 0; $l < $t; $l++)
  {
    if($arr[$l] == $cont && $swap_flag == 0)
    {
     if($l > 0)
     {
      $swap_flag = 1;
      $temp = $arr[$l];
      $arr[$l] = $arr[$l - 1];
      $arr[$l - 1] = $temp;   
     }
    }
  }

  $new ="";
  for($l = 0; $l < $t; $l++)
  {
    if(strlen($arr[$l]) > 3)
    {
      $new .= $arr[$l];
      $new .= "\n";
    }

  }
  $myfile = fopen($fileLocation, "w") or die("file open error");
  fwrite($myfile, $new);
  fclose($myfile);
}
//================================
if($action == "Down")
{
  $fileLocation = '/usr/local/cast/etc/castmemlist.txt';
  $names=file($fileLocation);
  $t = 0;
  foreach($names as $name)
  {
   if(strlen($name) > 3)
   {
    $name = substr($name,0,-1);
    $arr[$t] = $name;
    $t += 1;
   }
  }

  $swap_flag = 0;
  for($l = 0; $l < $t; $l++)
  {
    if($arr[$l] == $cont && $swap_flag == 0)
    {
     if($l < $t - 1 && $t > 1)
     {
      $swap_flag = 1;
      $temp = $arr[$l];
      $arr[$l] = $arr[$l + 1];
      $arr[$l + 1] = $temp;
     }
    }
  }

  $new ="";
  for($l = 0; $l < $t; $l++)
  {
    if(strlen($arr[$l]) > 3)
    {
      $new .= $arr[$l];
      $new .= "\n";
    }

  }
  shell_exec('sudo mount -o remount,rw /');
  $myfile = fopen($fileLocation, "w") or die("file open error");
  fwrite($myfile, $new);
  fclose($myfile);
}





//==================================
 header("Location: /admin/cast/memory-list/");


?>


</body>
</html>

<?php
var_dump($argv);
if($argc < 5)
{
    echo "Usage: $argv[0] username password folder filename\n";
}
# Callout to DB
$host = 'localhost';
$user = $argv[1];
$pass = $argv[2];
$db = $argv[1];
$mysqli = new mysqli($host, $user, $pass, $db) or die($mysqli->error);
if ($mysqli) {
    echo 'Connected to DB!';
}
$target_file=fopen("../".$argv[3]."/".$argv[4]."", "r");
if ($target_file) {
    echo "File ".$argv[4]." found!";
}
while($line=fgets($target_file,500)){
    if (preg_match("/[A-Z]{4}/",substr($line,0,4))) {
        $icao=substr($line,0,4);
        $time=substr($line,7,4);
        $report=substr($line,13);
        $query="REPLACE INTO scripting (`ICAO`, `time`, `report`) VALUES('$icao','$time','$report')";
        $result=$mysqli->query($query) or die($mysqli->error);
    }
}
?>

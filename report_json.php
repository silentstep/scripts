<?php
# Get the global $_GET variable passed through 
# the URL in the address bar of the clients browser
$q=$_GET["icao"];

# Callout to DB
$host = 'localhost';
$user = 'vagrant';
$pass = 'vagrant';
$db = 'vagrant';
$mysqli = new mysqli($host, $user, $pass, $db) or die($mysqli->error);

# Form the query
$query = "select * from scripting where `ICAO` = '".$q."'";

# Extract results
$result=$mysqli->query($query) or die($mysqli->error);
$num_results = $result->num_rows;

# Loop through the results and display each result row
for ($i = 0; $i <$num_results; $i++){
    $row = $result->fetch_assoc();
    $arr = array('icao' => $row['ICAO'], 'time' => $row['time'], 'report' => str_replace("\n", '', $row['report']));
    echo json_encode($arr);
}

?>

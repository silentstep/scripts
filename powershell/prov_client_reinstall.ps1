<# Perform initial ping test as described in documentation #>
 if (Test-Connection static.zitcom.dk -Quiet) {
    write-host 'Ping test comleted, moving on !'
 } else {
     write-host 'Failed ping test, abort !'
     exit
 }

<# Setup download variables #>
$url="http://software.zitcom.dk/ProvisioningSetup.msi"
$output="C:\Users\Public\Downloads\ProvisioningSetup.msi"
$status = (Invoke-WebRequest -Uri $url -UseBasicParsing).statuscode
<# Build installation arguments #>
$ip_address = (Test-Connection -ComputerName (hostname) -Count 1  | Select -ExpandProperty IPV4Address).IPAddressToString
$server_name = ((nslookup $ip_address | select-string "Name") -split ":")[1].trim()
$split = $server_name.split('.')
$splash = 'http://splash'+$server_name.trim((hostname))+'/'
$test_url = $split[0]+'.'+$split[1]+'server.'+$split[2]

<# Check download link HTTP status and download setup file #>
if ($status -eq 200) {
    Invoke-WebRequest -Uri $url -OutFile $output
    write-host 'Setup file download completed!'
} else {
    write-host 'Download failed .. exiting'
    exit
}

function run-uninstall {
    if ($app.uninstall().returnvalue -eq 0) {
        Remove-Item -path 'C:\Program Files (x86)\ZitCom\' -Recurse
    } else {
        write-host 'Something went wrong ... exiting script !'
        exit
    }
}

function run-install {
    <# Setup some useful vars #>
    $path = 'C:\Users\Public\Downloads\'
    $logFile = $path + 'installLog.txt'
    $msiFile = Get-ChildItem -Path $path -Recurse -Include *.msi
    <# Run installer, wait for the wizard and start the service #>
    Start-Process "msiexec.exe" -arg "/I `"$msiFile`" /qf /L*V `"$logFile`" " -wait
    write-host 'Finished installing, starting service ... '
    Start-Service 'ProvisioningClient'
}

function check-status {
    $service = Get-Service 'ProvisioningClient'
    write-host 'Service status is:' $service.Status
    if ($service.Status -eq 'Running'){
        Remove-Item -path 'C:\Users\Public\Downloads\ProvisioningSetup.msi'
        write-host 'Cleaned up setup file'
    } else {
        write-host 'ProvisioningClient service not started. Check the installation and try to start it manually. After, cleanup the setup file in'$output
        exit
    }
}

$app = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match "Provisioning Client"}

if ($app) {
    write-host 'Uninstalling ...'
    run-uninstall
    write-host 'Succesfully uninstalled Provisioning client, removing install path ...'
} else {
    write-host 'Looks like Provisioning Client is not installed, running installer'
    run-install
}

write-host 'Installing fresh ProvisioningClient. Uncheck the Enable Gene 6 Log Rotation & Enable Gene 6 Transfer Log Rotation and copy/paste the following parameters in dialogbox: '
echo $splash, $test_url
run-install
start-sleep -s 2
check-status

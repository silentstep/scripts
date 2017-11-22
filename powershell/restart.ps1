Unregister-ScheduledJob systemReboot -Force
register-ScheduledJob -Name systemReboot -ScriptBlock {
$Key = "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce"
If  ( -Not ( Test-Path "Registry::$Key")){New-Item -Path "Registry::$Key" -ItemType RegistryKey -Force}
Set-ItemProperty -path "Registry::$Key" -Name "dbadk" -Type "String" -Value '"C:\Program Files\Internet Explorer\iexplore.exe" www.dba.dk'
Restart-Computer -Force
} -Trigger (New-JobTrigger -At "11:00am" -Once) -ScheduledJobOption (New-ScheduledJobOption -RunElevated)
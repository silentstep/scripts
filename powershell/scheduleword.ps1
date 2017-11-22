$repeat = (New-TimeSpan -Minutes 5)
$duration = ([timeSpan]::maxvalue)
$trigger = New-JobTrigger -Once -At (Get-Date).Date -RepetitionInterval $repeat -RepetitionDuration $duration
Unregister-ScheduledJob updatewordreport -Force
Register-ScheduledJob -Name updatewordreport -FilePath C:\Users\Johny\Desktop\School\powershell\wordfilesexport.ps1 -Trigger $trigger
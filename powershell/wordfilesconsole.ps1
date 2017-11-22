Get-ChildItem -Path C:\ -Include *.doc,*.docx -File -Recurse -ErrorAction SilentlyContinue | % {Write-Host $_.FullName}
Read-Host -Prompt "Press Enter to exit" 


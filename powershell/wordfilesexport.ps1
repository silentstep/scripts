 Start-Job –Name "docdocxreport" –Scriptblock {
        Get-ChildItem -Path C:\ -Include *.doc,*.docx -File -Recurse -ErrorAction SilentlyContinue `
            | Select-Object FullName `
            | ConvertTo-HTML `
            | Out-file -filepath C:\Users\Johny\Desktop\School\powershell\report.html
    }
Get-Job | Wait-Job
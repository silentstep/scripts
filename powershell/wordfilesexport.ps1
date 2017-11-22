 Start-Job –Name "docdocxreport" –Scriptblock {
        Get-ChildItem -Path C:\ -Include *.doc,*.docx -File -Recurse -ErrorAction SilentlyContinue `
            | Select-Object FullName `
            | ConvertTo-HTML `
            | Out-file -filepath C:\Users\abc\wordreport.html
    }
Get-Job | Wait-Job
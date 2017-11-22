(Get-ChildItem -Path C:\Users\Johny\Desktop\School -Include *.doc,*.docx -File -Recurse -ErrorAction SilentlyContinue).FullName > filename.txt

$Username = Read-Host "Enter Username"
Import-Module ActiveDirectory
function Show-Menu
{
     cls
          
     Write-Host "1: Press '1' to reset $Username's password."
     Write-Host "2: Press '2' to disable $Username's account."
     Write-Host "3: Press '3' to enable $Username's account."
     Write-Host "4: Press '4' to unlock $Username's account."
     Write-Host "5: Press '5' to delete $Username's account."
     Write-Host "Q: Press 'Q' to quit."
}
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                $error.clear()
                try { Set-ADAccountPassword -Identity $Username -NewPassword (Read-Host -asSecureString "Enter the new password") –Reset -ErrorAction Stop -PassThru }
                catch {
                cls 
                "The password does not meet the length, complexity, or history requirement of the domain." }
                if (!$error) {
                cls
                "Password has been changed"
                }
           } '2' {
                Disable-ADAccount -Identity $Username
                cls
                "Account $Username has been disabled"
           } '3' {
                Enable-ADAccount -Identity $Username
                cls
                "Account $Username has been enabled"
           } '4' {
                Unlock-ADAccount -Identity $Username
                cls
                "Account $Username has been unlocked"
           } '5' {
                Remove-ADUser -Identity $Username
                cls
                "Account $Username has been deleted"
           } 'q' {
                return
           }
     }
     pause


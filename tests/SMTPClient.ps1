Using module "..\modules\SMTPClient.psm1"
Using module "..\modules\Account.psm1"

Import-Module -ErrorAction "Stop" -Name "$PSScriptRoot\..\modules\SMTPClient.psm1"
Import-Module -ErrorAction "Stop" -Name "$PSScriptRoot\..\modules\Account.psm1"

############################################################################### SMTPClient()
#
# VALID
#
Try {
    Write-Host "Creating a valid object... " -NoNewLine
    $SMTPClient = [SMTPClient]::New()
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected: $($_.Exception.Message)." -ForegroundColor "Red"
}

############################################################################### SetUserAccount()
#
# VALID
#
Try {
    Write-Host "Setting a valid user account... " -NoNewLine
    $UserAccount = [Account]::New()
    $SMTPClient.SetUserAccount($UserAccount)
    If (-not ($SMTPClient.UserAccount -eq $UserAccount)) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected: $($_.Exception.Message)." -ForegroundColor "Red"
}

#
# INVALID
#
Try {
    Write-Host "Setting an invalid user account... " -NoNewLine
    $SMTPClient.SetUserAccount()
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetSMTPServerFQDN()
#
# VALID
#
Try {
    Write-Host "Setting a valid SMTP server FQDN... " -NoNewLine
    $SMTPClient.SetSMTPServerFQDN("smtp.mydomain.com")
    If (-not ($SMTPClient.SMTPServerFQDN -ceq "smtp.mydomain.com")) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected: $($_.Exception.Message)." -ForegroundColor "Red"
}

#
# INVALID
#
Try {
    Write-Host "Setting an invalid SMTP server FQDN... " -NoNewLine
    $SMTPClient.SetSMTPServerFQDN()
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### GetSMTPServerFQDN()
#
# VALID
#
Try {
    Write-Host "Getting the FQDN of the SMTP server... " -NoNewLine
    If (-not ($SMTPClient.SMTPServerFQDN -eq $SMTPClient.GetSMTPServerFQDN())) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected: $($_.Exception.Message)." -ForegroundColor "Red"
}

############################################################################### GetUserAccount()
#
# VALID
#
Try {
    Write-Host "Getting the user account... " -NoNewLine
    If (-not ($SMTPClient.UserAccount -eq $SMTPClient.GetUserAccount())) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected: $($_.Exception.Message)." -ForegroundColor "Red"
}
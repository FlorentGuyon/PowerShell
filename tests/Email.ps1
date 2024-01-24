Using module "..\modules\Email.psm1"
Using module "..\modules\EmailAddress.psm1"
Using module "..\modules\Account.psm1"
Using module "..\modules\File.psm1"

Import-Module -ErrorAction "Stop" -Name "$PSScriptRoot\..\modules\Email.psm1"
Import-Module -ErrorAction "Stop" -Name "$PSScriptRoot\..\modules\EmailAddress.psm1"
Import-Module -ErrorAction "Stop" -Name "$PSScriptRoot\..\modules\Account.psm1"
Import-Module -ErrorAction "Stop" -Name "$PSScriptRoot\..\modules\File.psm1"

############################################################################### Email()
#
# VALID
#
Try {
    Write-Host "Creating a valid object... " -NoNewLine
    $Email = [Email]::New()
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected: $($_.Exception.Message)." -ForegroundColor "Red"
}

############################################################################### SetSubject()
#
# VALID
#
Try {
    Write-Host "Setting a valid subject... " -NoNewLine
    $NewSubject = "new subject"
    $Email.SetSubject($NewSubject)
    If (-not ($Email.Subject -eq $NewSubject)) {
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
    Write-Host "Setting an invalid subject... " -NoNewLine
    $Email.SetSubject()
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetBody()
#
# VALID
#
Try {
    Write-Host "Setting a valid body... " -NoNewLine
    $NewBody = "new body"
    $Email.SetBody($NewBody)
    If (-not ($Email.Body -eq $NewBody)) {
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
    Write-Host "Setting an invalid body... " -NoNewLine
    $Email.SetBody()
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetAttachments()
#
# VALID
#
Try {
    Write-Host "Setting valid attachments... " -NoNewLine
    $NewAttachments = @([File]::New())
    $Email.SetAttachments($NewAttachments)
    If (Compare-Object $Email.Attachments $NewAttachments) {
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
    Write-Host "Setting an invalid attachments... " -NoNewLine
    $Email.SetAttachments()
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetRecipients()
#
# VALID
#
Try {
    Write-Host "Setting valid recipients... " -NoNewLine
    $NewRecipients = @([EmailAddress]::New())
    $Email.SetRecipients($NewRecipients)
    If (Compare-Object $Email.Recipients $NewRecipients) {
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
    Write-Host "Setting invalid recipients... " -NoNewLine
    $Email.SetRecipients()
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetSender()
#
# VALID
#
Try {
    Write-Host "Setting a valid sender... " -NoNewLine
    $NewSender = [EmailAddress]::New("test@domain.com")
    $Email.SetSender($NewSender)
    If (-not ($Email.Sender.GetAddress() -eq "test@domain.com")) {
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
    Write-Host "Setting an invalid sender... " -NoNewLine
    $Email.SetSender()
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}
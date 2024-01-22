Using module "..\modules\EmailAddress.psm1"

Import-Module -ErrorAction "Stop" -Name "$PSScriptRoot\..\modules\EmailAddress.psm1"

############################################################################### EmailAddress()
#
# VALID
#
Try {
    Write-Host "Creating a valid object... " -NoNewLine
    $EmailAddress = [EmailAddress]::New()
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### EmailAddress($Address)
#
# VALID
#
Try {
    Write-Host "Creating a valid object from an address... " -NoNewLine
    $EmailAddress = [EmailAddress]::New("jean-dupont@mydomain.com")
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

#
# INVALID
#
Try {
    Write-Host "Creating an invalid object from an address... " -NoNewLine
    $EmailAddress = [EmailAddress]::New("jean-dupont@mydomain.com.")
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### EmailAddress($LocalPart, $Domain)
#
# VALID
#
Try {
    Write-Host "Creating a valid object from a local part and a domain... " -NoNewLine
    $EmailAddress = [EmailAddress]::New("jean-dupont", "mydomain.com")
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

#
# INVALID
#
Try {
    Write-Host "Creating an invalid object from a local part and a domain... " -NoNewLine
    $EmailAddress = [EmailAddress]::New("jean-dupont", "mydomain.com.")
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetAddress()
#
# VALID
#
Try {
    Write-Host "Setting a valid email address... " -NoNewLine
    $EmailAddress.SetAddress("jean-dupont@mydomain.com")
    If (-not ($EmailAddress.Address -ceq "jean-dupont@mydomain.com")) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

#
# INVALID
#
Try {
    Write-Host "Setting an invalid email address... " -NoNewLine
    $EmailAddress.SetAddress("jean-dupont@mydomain.com.")
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetLocalPart()
#
# VALID
#
Try {
    Write-Host "Setting a valid local part... " -NoNewLine
    $EmailAddress.SetLocalPart("jean.dupont")
    If (-not ($EmailAddress.LocalPart -ceq "jean.dupont")) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

#
# INVALID
#
Try {
    Write-Host "Setting an invalid local part... " -NoNewLine
    $EmailAddress.SetLocalPart("jean..dupont")
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetDomain()
#
# VALID
#
Try {
    Write-Host "Setting a valid domain... " -NoNewLine
    $EmailAddress.SetDomain("mydomain.com")
    If (-not ($EmailAddress.Domain -ceq "mydomain.com")) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

#
# INVALID
#
Try {
    Write-Host "Setting an invalid domain... " -NoNewLine
    $EmailAddress.SetDomain("mydomain..com")
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetAddressPattern()
#
# VALID
#
Try {
    Write-Host "Setting a valid address pattern... " -NoNewLine
    $EmailAddress.SetAddressPattern("([0-9]{6}@mydomain\.com)")
    If (-not ($EmailAddress.AddressPattern -ceq "([0-9]{6}@mydomain\.com)")) {
        Throw
    }
    $EmailAddress.SetAddress("123456@mydomain.com")
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

#
# INVALID
#
Try {
    Write-Host "Setting an invalid address pattern... " -NoNewLine
    $EmailAddress.SetAddressPattern("([0-9{6}@mydomain\.com)")
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetLocalPartPattern()
#
# VALID
#
Try {
    Write-Host "Setting a valid local part pattern... " -NoNewLine
    $EmailAddress.SetLocalPartPattern("([0-9]{6})")
    If (-not ($EmailAddress.LocalPartPattern -ceq "([0-9]{6})")) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

#
# INVALID
#
Try {
    Write-Host "Setting an invalid local part pattern... " -NoNewLine
    $EmailAddress.SetLocalPartPattern("([0-9{6})")
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetDomainPattern()
#
# VALID
#
Try {
    Write-Host "Setting a valid domain pattern... " -NoNewLine
    $EmailAddress.SetDomainPattern("(mydomain\.com)")
    If (-not ($EmailAddress.DomainPattern -ceq "(mydomain\.com)")) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

#
# INVALID
#
Try {
    Write-Host "Setting an invalid domain pattern... " -NoNewLine
    $EmailAddress.SetDomainPattern("(mydomain\.com))")
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### GetAddress()
#
# VALID
#
Try {
    Write-Host "Getting the address... " -NoNewLine
    If (-not ($EmailAddress.GetAddress() -ceq $EmailAddress.Address)) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### GetLocalPart()
#
# VALID
#
Try {
    Write-Host "Getting the local part... " -NoNewLine
    If (-not ($EmailAddress.GetLocalPart() -ceq $EmailAddress.LocalPart)) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### GetDomain()
#
# VALID
#
Try {
    Write-Host "Getting the local part... " -NoNewLine
    If (-not ($EmailAddress.GetDomain() -ceq $EmailAddress.Domain)) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### GetAddressPattern()
#
# VALID
#
Try {
    Write-Host "Getting the address pattern... " -NoNewLine
    If (-not ($EmailAddress.GetAddressPattern() -ceq $EmailAddress.AddressPattern)) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### GetLocalPartPattern()
#
# VALID
#
Try {
    Write-Host "Getting the local part pattern... " -NoNewLine
    If (-not ($EmailAddress.GetLocalPartPattern() -ceq $EmailAddress.LocalPartPattern)) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### GetDomainPattern()
#
# VALID
#
Try {
    Write-Host "Getting the domain pattern... " -NoNewLine
    If (-not ($EmailAddress.GetDomainPattern() -ceq $EmailAddress.DomainPattern)) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### GenerateAddress()
#
# VALID
#
Try {
    Write-Host "Genereting the address... " -NoNewLine
    $EmailAddress.ResetAddressPattern()
    $EmailAddress.LocalPart = "test"
    $EmailAddress.Domain = "newdomain.com"
    $EmailAddress.GenerateAddress()
    If (-not ($EmailAddress.GetAddress() -ceq "test@newdomain.com")) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected. $($EmailAddress.GetAddress())" -ForegroundColor "Red"
}

############################################################################### GenerateAddressPattern()
#
# VALID
#
Try {
    Write-Host "Genereting the address pattern... " -NoNewLine
    $EmailAddress.LocalPartPattern = "([0-9])"
    $EmailAddress.DomainPattern = "(newdomain\.com)"
    $EmailAddress.GenerateAddressPattern()
    If (-not ($EmailAddress.GetAddressPattern() -ceq "(([0-9])@(newdomain\.com))")) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### ResetAddressPattern()
#
# VALID
#
Try {
    Write-Host "Reseting the pattern of the address... " -NoNewLine
    $EmailAddress.SetAddressPattern("([0-9]@newdomain\.com)")
    $EmailAddress.ResetAddressPattern()
    If ($EmailAddress.GetAddressPattern() -ceq "([0-9]@newdomain\.com)") {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### ResetLocalPartPattern()
#
# VALID
#
Try {
    Write-Host "Reseting the pattern of the local part... " -NoNewLine
    $EmailAddress.SetLocalPartPattern("([a-z])")
    $EmailAddress.ResetLocalPartPattern()
    If ($EmailAddress.GetLocalPartPattern() -ceq "([a-z])") {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### ResetDomainPattern()
#
# VALID
#
Try {
    Write-Host "Reseting the pattern of the domain... " -NoNewLine
    $EmailAddress.SetDomainPattern("(newdomain\.net)")
    $EmailAddress.ResetDomainPattern()
    If ($EmailAddress.GetDomainPattern() -ceq "(newdomain\.net)") {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}
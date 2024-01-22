Using module "..\modules\Account.psm1"

Import-Module -ErrorAction "Stop" -Name "$PSScriptRoot\..\modules\Account.psm1"

############################################################################### Account()
#
# VALID
#
Try {
    Write-Host "Creating a valid object... " -NoNewLine
    $Account = [Account]::New()
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### Account($Username, $Password)
#
# VALID
#
Try {
    Write-Host "Creating a valid object from a username and a password... " -NoNewLine
    $Account = [Account]::New("jean dupont", "Mypassword1234!")
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

#
# INVALID
#
Try {
    Write-Host "Creating an invalid object from an invalid username and a password... " -NoNewLine
    $Account = [Account]::New("", "Mypassword1234!")
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### Account($Username, $Password)
#
# VALID
#
Try {
    Write-Host "Creating a valid object from a username and a secure password... " -NoNewLine
    $Account = [Account]::New("jean dupont", (ConvertTo-SecureString "Mypassword1234!" -AsPlainText -Force))
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

#
# INVALID
#
Try {
    Write-Host "Creating an invalid object from an invalid username and a secure password... " -NoNewLine
    $Account = [Account]::New("", (ConvertTo-SecureString "Mypassword1234!" -AsPlainText -Force))
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetUsername($Username)
#
# VALID
#
Try {
    Write-Host "Setting a valid username... " -NoNewLine
    $Account.SetUsername("jean-durand")
    If (-not ($Account.Username -ceq "jean-durand")) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected.$($_.exception.message)" -ForegroundColor "Red"
}

#
# INVALID
#
Try {
    Write-Host "Setting an invalid username... " -NoNewLine
    $Account.SetUsername("")
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetPassword($Password)
#
# VALID
#
Try {
    Write-Host "Setting a valid password... " -NoNewLine
    $OldHashCode = $Account.Password.GetHashCode()
    $Account.SetPassword("MyNewPassword")
    If ($OldHashCode -eq $Account.Password.GetHashCode()) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### SetPassword($Password)
#
# VALID
#
Try {
    Write-Host "Setting a valid secure password... " -NoNewLine
    $OldHashCode = $Account.Password.GetHashCode()
    $Account.SetPassword((ConvertTo-SecureString "Password" -AsPlainText -Force))
    If ($OldHashCode -eq $Account.Password.GetHashCode()) {
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
    Write-Host "Setting an invalid password... " -NoNewLine
    $Account.SetPassword((ConvertTo-SecureString "" -AsPlainText -Force))
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### SetCredential($Credential)
#
# VALID
#
Try {
    Write-Host "Setting a valid credential... " -NoNewLine
    $OldHashCode = $Account.Credential.GetHashCode()
    $Account.SetCredential([PSCredential]::New("jean-paul", (ConvertTo-SecureString "password" -AsPlainText -Force)))
    If ($OldHashCode -eq $Account.Credential.GetHashCode()) {
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
    Write-Host "Setting an invalid credential... " -NoNewLine
    $Account.SetCredential([PSCredential]::New("", (ConvertTo-SecureString "password" -AsPlainText -Force)))
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}

############################################################################### GetUsername()
#
# VALID
#
Try {
    Write-Host "Getting the username... " -NoNewLine
    If (-not ($Account.Username -eq $Account.GetUsername())) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### GetPassword()
#
# VALID
#
Try {
    Write-Host "Getting the password... " -NoNewLine
    If (-not ($Account.Password.GetHashCode() -eq $Account.GetPassword().GetHashCode())) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### GetCredential()
#
# VALID
#
Try {
    Write-Host "Getting the credential... " -NoNewLine
    If (-not ($Account.Credential -eq $Account.GetCredential())) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}

############################################################################### GenerateCredential()
#
# VALID
#
Try {
    Write-Host "Genereting a valid credential... " -NoNewLine
    $Account.Username = "myuser"
    $Account.Password = (ConvertTo-SecureString "password" -AsPlainText -Force)
    $OldHashCode = $Account.Credential.GetHashCode()
    $Account.GenerateCredential()
    If ($OldHashCode -eq $Account.Credential.GetHashCode()) {
        Throw
    }
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected." -ForegroundColor "Red"
}
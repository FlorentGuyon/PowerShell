# Print the called methods ?
$global:DebugAccount = $False

class Account {

    ########################################################################### ATTRIBUTES

    hidden [PSCredential]$Credential          # PSCredential (jean-dupont / MyPassword1234!)
    hidden [SecureString]$Password            # SecureString ("MyPassword1234!")
    hidden [String]$Username                  # "jean-dupont"

    ########################################################################### CONSTRUCTOR
    #
    # Construct an instance of the class
    #
    Account () {
        #
        # Log the call to this method
        #
        If ($global:DebugAccount) {Write-Host "Account()"}
    }

    #
    # Construct an instance of the class with a username and a password
    #
    Account ([String]$Username, [String]$Password) {
        #
        # Log the call to this method
        #
        If ($global:DebugAccount) {Write-Host "Account($Username, $Password)"}
        #
        # Try to set the username and the password
        #
        Try {
            $This.SetUsername($Username)
            $This.SetPassword($Password)
        }
        #
        # If it fails, throw an exception to the method caller
        #
        Catch {
            Throw "Unable to create an instance of the class: $($_.Exception.Message)"
        }
    }

    #
    # Construct an instance of the class with a username and a secure password
    #
    Account ([String]$Username, [SecureString]$Password) {
        #
        # Log the call to this method
        #
        If ($global:DebugAccount) {Write-Host "Account($Username, $Password)"}
        #
        # Try to set the username and the password
        #
        Try {
            $This.SetUsername($Username)
            $This.SetPassword($Password)
        }
        #
        # If it fails, throw an exception to the method caller
        #
        Catch {
            Throw "Unable to create an instance of the class: $($_.Exception.Message)"
        }
    }

    ########################################################################### SETTERS
    #
    # Set the name of the user
    #
    [void] SetUsername([String]$Username) {
        #
        # Log the call to this method
        #
        If ($global:DebugAccount) {Write-Host "SetUsername($Username)"}
        #
        # If the username is null or empty
        #
        If ([String]::IsNullOrWhiteSpace($Username)) {
            #
            # Throw an exception to the method caller
            #
            throw "The username of the account cannot be null or empty."
        }
        #
        # Remove the spaces around the password
        #
        # Exemple: " jean " -> "jean"
        #
        $TrimedUsername = $Username.Trim()
        #
        # Set the username
        #
        $This.Username = $TrimedUsername
        #
        # Try to generate the credential with the new password
        #
        Try {
            $This.GenerateCredential()
        }
        #
        # If it fails, throw an exception to the method caller
        #
        Catch {
            Throw "Unable to set the username of the account: $($_.Exception.Message)"
        }
    }

    #
    # Set the password of the user after converting it to a secure string
    #
    [void] SetPassword([String]$Password) {
        #
        # Log the call to this method
        #
        If ($global:DebugAccount) {Write-Host "SetPassword($Password)"}
        #
        # If the password is null
        #
        If ([String]::IsNullOrWhiteSpace($Password)) {
            #
            # Set the password as null
            #
            $This.SetPassword($Null)
            #
            # Exit the method
            #
            Return
        }
        #
        # Remove the spaces around the password
        #
        # Exemple: " 1234 " -> "1234"
        #
        $TrimedPassword = $Password.Trim()
        #
        # Convert the password to a secure PowerShell password object
        #
        $SecurePassword = ConvertTo-SecureString $TrimedPassword -AsPlainText -Force
        #
        # Try to set the new password
        #
        Try {
            $This.SetPassword($SecurePassword)
        }
        #
        # If it fails, throw an exception to the method caller
        #
        Catch {
            Throw $_
        }
    }

    #
    # Set the password of the user
    #
    [void] SetPassword([SecureString]$Password) {
        #
        # Log the call to this method
        #
        If ($global:DebugAccount) {Write-Host "SetPassword($Password)"}
        #
        # Set the password
        #
        $This.Password = $Password
        #
        # Try to generate the credential with the new password
        #
        Try {
            $This.GenerateCredential()
        }
        #
        # If it fails, throw an exception to the method caller
        #
        Catch {
            Throw "Unable to set the passord of the account: $($_.Exception.Message)"
        }
    }

    #
    # Set the credential of the user
    #
    [void] SetCredential([PSCredential]$Credential) {
        #
        # Log the call to this method
        #
        If ($global:DebugAccount) {Write-Host "SetCredential($Credential)"}
        #
        # If the credential is null
        #
        If (-not $Credential) {
            #
            # Throw an exception to the method caller
            #
            throw "The credential to connect to a SMTP server cannot be null."
        }
        #
        # Set the credential
        #
        $This.Credential = $Credential
    }

    ########################################################################### GETTERS
    #
    # Get the name of the user
    #
    [String] GetUsername() {
        #
        # Log the call to this method
        #
        If ($global:DebugAccount) {Write-Host "GetUsername()"}
        #
        # Get the username
        #
        Return $This.Username
    }

    #
    # Get the password of the user
    #
    [SecureString] GetPassword() {
        #
        # Log the call to this method
        #
        If ($global:DebugAccount) {Write-Host "GetPassword()"}
        #
        # Get the password
        #
        Return $This.Password
    }

    #
    # Get the credential of the user
    #
    [PSCredential] GetCredential() {
        #
        # Log the call to this method
        #
        If ($global:DebugAccount) {Write-Host "GetCredential()"}
        #
        # Get the credential
        #
        Return $This.Credential
    }

    ################################################################### METHODS
    #
    # Generate a PowerShell credential object with the username and password
    #
    [void] GenerateCredential() {
        #
        # Log the call to this method
        #
        If ($global:DebugAccount) {Write-Host "GenerateCredential()"}
        #
        # If the Username and Password are not null
        #
        If ($This.Username -and $This.Password) {
            #
            # Generate the new credential
            #
            $NewCredential = [PSCredential]::New($This.Username, $This.Password)
            #
            # Set the new credential
            #
            $This.SetCredential($NewCredential)
        }
    } 
}
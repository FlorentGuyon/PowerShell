# Print the called methods ?
$global:DebugEmailAddress = $False

class EmailAddress {

    ################################################################ ATTRIBUTES

    [String]$Address                   # "jean-dupont@mydomain.com"
    [String]$AddressPattern            # "(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z..."
    [String]$Domain                    # "mydomain.com"
    [String]$DomainPattern             # "(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+..."
    [String]$LocalPart                 # "jean-dupont"
    [String]$LocalPartPattern          # "(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z..."

    ############################################################## CONSTRUCTORS
    #
    # Construct an instance of the class (without an address yet)
    #
    # Exemple: [EmailAddress]::New()
    #
    EmailAddress() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "EmailAddress()"}
        #
        # Call the constructor of the class with the value of the address explicitly null
        #
        #
        # Try to call the constructor of the class with the value of the local part and the domain explicitly null
        #
        try {
            #
            # Reset the regular expressions used to check the validity of the local part and the domain of the address
            #
            $This.ResetLocalPartPattern()
            $This.ResetDomainPattern()
        }           
        #
        # If it fails
        #
        catch {
            #
            # Throw the error to the caller of the constructor
            #
            throw $_
        }
    }

    #
    # Construct an instance of the class with the email address
    #
    # Exemple: [EmailAddress]::New("jean-dupont@mydomain.com")
    #
    EmailAddress([String]$Address) {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "EmailAddress($Address)"}
        #
        # Try to call the constructor of the class with the value of the local part and the domain explicitly null
        #
        try {
            #
            # Reset the regular expressions used to check the validity of the local part and the domain of the address
            #
            $This.ResetLocalPartPattern()
            $This.ResetDomainPattern()

            #
            # Set the address
            #
            $This.SetAddress($Address)
        }           
        #
        # If it fails
        #
        catch {
            #
            # Throw the error to the caller of the constructor
            #
            throw $_
        }
    }
    
    
    # Construct an instance of the class with a the local part and the domain of the email address
    #
    # Exemple: [EmailAddress]::New("jean-dupont", "mydomain.com")
    #
    EmailAddress([String]$LocalPart, [String]$Domain) {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "EmailAddress($LocalPart, $Domain)"}
        #
        # Try to call the constructor of the class with the value of the address explicitly null
        #
        try {
            #
            # Reset the regular expressions used to check the validity of the local part and the domain of the address
            #
            $This.ResetLocalPartPattern()
            $This.ResetDomainPattern()

            #
            # Set the local part and the domain of the address
            #
            $This.SetLocalPart($LocalPart)
            $This.SetDomain($Domain)
        }           
        #
        # If it fails
        #
        catch {
            #
            # Throw the error to the caller of the constructor
            #
            throw $_
        }
    }

    ################################################################### SETTERS
    #
    # Set the value of the address if it is valid
    #
    # Exemple: $EmailAddress.SetAddress("jean-dupont@mydomain.com")
    #
    [void] SetAddress([String]$Address) {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "SetAddress($Address)"}
        #
        # If the address is null
        #
        If ($Address -eq $Null) {
            #
            # Throw an error to the caller of the method
            #
            throw "The address of an email address cannot be null."
        }
        #
        # Trim the address
        #
        # Exemple: "Jean-DUPONT@mydomain.com " -> "Jean-DUPONT@mydomain.com"
        #
        $TrimedAddress = $Address.Trim()
        #
        # If the address does not match the regular expression
        #
        If ($TrimedAddress -cnotmatch "^$($This.AddressPattern)$") {
            #
            # Throw an error to the caller of the method
            #
            throw "The address `"$TrimedAddress`" does not match the pattern `"$($This.AddressPattern)`"."
        }
        #
        # If the address matches the regular expression, set it
        #
        $This.Address = $TrimedAddress
        #
        # Extract the local part and the domain from the address
        #
        # Exemple: "jean-dupont@mydomain.com" -> @("jean-dupont", "mydomain.com")
        #
        $NewLocalPart, $NewDomain = $TrimedAddress -Split '@'
        #
        # Try to set them
        #
        try {
            $This.SetLocalPart($NewLocalPart)
            $This.SetDomain($NewDomain)
        }
        #
        # If it fails
        #
        catch {
            #
            # Throw the error to the caller of the constructor
            #
            throw "Unable to set the address of the email address: $($_.Exception.Message)."
        }
    }

    #
    # Set the pattern of the address
    #
    # Exemple: $EmailAddress.SetAddressPattern("([a-z]{2,64}@mydomain\.com)")
    #
    # Warning: The pattern of the local part and the domain are not updated through this method.s
    # Call the methods .SetLocalPartPattern() and .SetDomainPattern() to do so.
    #
    [void] SetAddressPattern([String]$AddressPattern) {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "SetAddressPattern($AddressPattern)"}

        #
        # Try to create a Regex object to validate the pattern
        #
        Try {
            [regex]::new($AddressPattern)
        }
        #
        # If it fails, throw an exception to the method caller
        #
        Catch {
            Throw "Unable to set the pattern of the address: The pattern `"$AddressPattern`" is not a valid regular expression."
        }

        #
        # Set the pattern of the adderss
        #
        $This.AddressPattern = $AddressPattern
    }

    #
    # Set the local part of the email address
    #
    # Exemple: $EmailAddress.SetLocalPart("jean-dupont")
    #
    [void] SetLocalPart([String]$LocalPart) {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "SetLocalPart($LocalPart)"}
        #
        # If the local part is null
        #
        If ($LocalPart -eq $Null) {
            #
            # Throw an error to the caller of the method
            #
            throw "The local part of an email address cannot be null."
        }
        #
        # Trim the local part
        #
        # Exemple: "Jean-DUPONT " -> "Jean-DUPONT"
        #
        $TrimedLocalPart = $LocalPart.Trim()
        #
        # If the local part does not match the regular expression
        #
        If ($TrimedLocalPart -cnotmatch "^$($This.LocalPartPattern)$") {
            #
            # Throw an error to the caller of the method
            #
            throw "The local part `"$TrimedLocalPart`" does not match the pattern `"$($This.LocalPartPattern)`"."
        }
        #
        # If the local part matches the regular expression, set it
        #
        $This.LocalPart = $TrimedLocalPart
        #
        # If the local part is different than the one in the address
        #
        If (-not $This.GetAddress().StartsWith("$TrimedLocalPart@")) {
            #
            # Try to generate a new address
            #
            Try {
                $This.GenerateAddress()
            }
            #
            # If it fails
            #
            Catch {
                #
                # Throw an exception to the method caller
                #
                Throw "Unable to set the local part of the email address: $($_.Exception.Message)"
            }
        }
    }

    #
    # Set the pattern of the local part of the address
    #
    # Exemple: $EmailAddress.SetLocalPartPattern("([a-z]{2,64})")
    #
    [void] SetLocalPartPattern([String]$LocalPartPattern) {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "SetLocalPartPattern($LocalPartPattern)"}

        #
        # Try to create a Regex object to validate the pattern
        #
        Try {
            [regex]::new($LocalPartPattern)
        }
        #
        # If it fails, throw an exception to the method caller
        #
        Catch {
            Throw "Unable to set the pattern of the local part of the address: The pattern `"$LocalPartPattern`" is not a valid regular expression."
        }

        #
        # Set the pattern of the local part of the address
        #
        $This.LocalPartPattern = $LocalPartPattern

        #
        # Try to generate a new pattern for the address
        #
        Try {
            $This.GenerateAddressPattern()
        }
        #
        # If it fails
        #
        Catch {
            #
            # Throw an exception to the method caller
            #
            Throw "Unable to set the pattern of the local part of the email address: $($_.Exception.Message)"
        }
    }

    #
    # Set the domain of the email address
    #
    # Exemple: $EmailAddress.SetSetDomain("mydomain")
    #
    [void] SetDomain([String]$Domain) {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "SetDomain($Domain)"}
        #
        # If the domain is null
        #
        If ($Domain -eq $Null) {
            #
            # Throw an error to the caller of the method
            #
            throw "The domain of an email address cannot be null."
        }
        #
        # Trim the domain
        #
        # Exemple: "MyDomain " -> "mydomain"
        #
        $TrimedDomain = $Domain.Trim()
        #
        # If the domain does not match the regular expression
        #
        If ($TrimedDomain -cnotmatch "^$($This.DomainPattern)$") {
            #
            # Throw an error to the caller of the method
            #
            throw "The domain `"$TrimedDomain`" does not match the pattern `"$($This.DomainPattern)`"."
        }
        #
        # If the domain matches the regular expression, set it
        #
        $This.Domain = $TrimedDomain
        #
        # If the domain is different than the one in the address
        #
        If (-not $This.GetAddress().EndsWith("@$TrimedDomain")) {
            #
            # Try to generate a new address
            #
            Try {
                $This.GenerateAddress()
            }
            #
            # If it fails
            #
            Catch {
                #
                # Throw an exception to the method caller
                #
                Throw "Unable to set the domain of the email address: $($_.Exception.Message)"
            }
        }
    }

    #
    # Set the pattern of the domain of the address
    #
    # Exemple: $EmailAddress.SetDomainPattern("(mydomain\.com)")
    #
    [void] SetDomainPattern([String]$DomainPattern) {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "SetDomainPattern($DomainPattern)"}

        #
        # Try to create a Regex object to validate the pattern
        #
        Try {
            [regex]::new($DomainPattern)
        }
        #
        # If it fails, throw an exception to the method caller
        #
        Catch {
            Throw "Unable to set the pattern of the domain of the address: The pattern `"$DomainPattern`" is not a valid regular expression."
        }

        #
        # Set the pattern of the domain of the address
        #
        $This.DomainPattern = $DomainPattern

        #
        # Try to generate a new pattern for the address
        #
        Try {
            $This.GenerateAddressPattern()
        }
        #
        # If it fails
        #
        Catch {
            #
            # Throw an exception to the method caller
            #
            Throw "Unable to set the pattern of the domain of the email address: $($_.Exception.Message)"
        }
    }

    ################################################################### GETTERS
    #
    # Get the address of the email address
    #
    # Exemple: ($EmailAddress.GetAddress() -eq "jean-dupont@mydomain.com")
    #
    [String] GetAddress() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "GetAddress()"}
        #
        # Return the address of the email address
        #
        return $This.Address
    }

    #
    # Get the pattern of the email address
    #
    # Exemple: ($EmailAddress.GetAddressPattern() -eq "([a-z]{2,64}@mydomain\.com)")
    #
    [String] GetAddressPattern() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "GetAddressPattern()"}
        #
        # Return the pattern of the email address
        #
        return $This.AddressPattern
    }

    #
    # Get the local part of the email address
    #
    # Exemple: ($EmailAddress.GetLocalPart() -eq "jean-dupont")
    #
    [String] GetLocalPart() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "GetLocalPart()"}
        #
        # Return the local part of the email address
        #
        return $This.LocalPart
    }

    #
    # Get the pattern of the local part of the email address
    #
    # Exemple: ($EmailAddress.GetLocalPartPattern() -eq "([a-z]{2,64})")
    #
    [String] GetLocalPartPattern() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "GetLocalPartPattern()"}
        #
        # Return the domain of the email address
        #
        return $This.LocalPartPattern
    }

    #
    # Get the domain of the email address
    #
    # Exemple: ($EmailAddress.GetDomain() -eq "mydomain.com")
    #
    [String] GetDomain() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "GetDomain()"}
        #
        # Return the domain of the email address
        #
        return $This.Domain
    }

    #
    # Get the pattern of the domain of the email address
    #
    # Exemple: ($EmailAddress.GetDomainPattern() -eq "(mydomain\.com)")
    #
    [String] GetDomainPattern() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "GetDomainPattern()"}
        #
        # Return the domain of the email address
        #
        return $This.DomainPattern
    }

    ################################################################### METHODS
    #
    # Generate the address with the current local part and the domain
    #
    [void] GenerateAddress() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "GenerateAddress()"}
        #
        # If the local part and the domain are not null
        #
        If ($This.GetLocalPart() -and $This.GetDomain()) {
            #
            # Define the new address
            #
            $NewAddress = "$($This.GetLocalPart())@$($This.GetDomain())"
            #
            # Try to set the address
            #
            try {
                $This.SetAddress($NewAddress)
            }
            #
            # If it fails
            #
            catch {
                #
                # Throw the error to the caller of the constructor
                #
                throw "Unable to generate the address of the email address: $($_.Exception.Message)."
            }
        }
    }

    #
    # Generate the pattern of the address with the current pattern of the local part and the domain
    #
    [void] GenerateAddressPattern() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "GenerateAddressPattern()"}
        #
        # If the local part and the domain are not null
        #
        If ($This.GetLocalPartPattern() -and $This.GetDomainPattern()) {
            #
            # Define the new pattern of the address
            #
            $NewAddressPattern = "($($This.GetLocalPartPattern())@$($This.GetDomainPattern()))"
            #
            # Try to set the address
            #
            try {
                $This.SetAddressPattern($NewAddressPattern)
            }
            #
            # If it fails
            #
            catch {
                #
                # Throw the error to the caller of the constructor
                #
                throw "Unable to generate the pattern of the email address: $($_.Exception.Message)."
            }
        }
    }

    #
    # Reset the pattern of the address
    #
    # Exemple: $EmailAddress.ResetAddressPattern()
    #
    [void] ResetAddressPattern() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "ResetAddressPattern()"}

        #
        # Try to reset the pattern of the local part and the domain of the address
        #
        Try {
            $This.ResetLocalPartPattern()
            $This.ResetDomainPattern()
        }
        #
        # If it fails
        #
        Catch {
            #
            # Throw an exception to the method caller
            #
            Throw "Unable to reset the pattern of the address: $($_.Exception.Message)"
        }
    }

    #
    # Reset the pattern of the local part of the address
    #
    # Exemple: $EmailAddress.ResetLocalPartPattern()
    #
    [void] ResetLocalPartPattern() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "ResetLocalPartPattern()"}

        #
        # Try to set the pattern of the domain of the address
        #
        # Documentation : https://stackoverflow.com/questions/201323/how-can-i-validate-an-email-address-using-a-regular-expression
        #
        Try {
            $This.SetLocalPartPattern("(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|`"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*`")")
        }
        #
        # If it fails
        #
        Catch {
            #
            # Throw an exception to the method caller
            #
            Throw "Unable to reset the pattern of the local part of the address: $($_.Exception.Message)"
        }
    }

    #
    # Reset the pattern of the domain of the address
    #
    # Exemple: $EmailAddress.ResetDomainPattern()
    #
    [void] ResetDomainPattern() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmailAddress) {Write-Host "ResetDomainPattern()"}

        #
        # Try to set the pattern of the domain of the email address
        #
        # Documentation : https://stackoverflow.com/questions/201323/how-can-i-validate-an-email-address-using-a-regular-expression
        #
        Try {
            $This.SetDomainPattern("(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])")
        }
        #
        # If it fails
        #
        Catch {
            #
            # Throw an exception to the method caller
            #
            Throw "Unable to reset the pattern of the domain of the email address: $($_.Exception.Message)"
        }
    }
}
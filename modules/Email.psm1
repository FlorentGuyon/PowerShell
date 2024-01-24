############################################################################### IMPORTED MODULES

Using module ".\EmailAddress.psm1"
Using module ".\File.psm1"

Import-Module -ErrorAction "Stop" -Name "$PSScriptRoot\EmailAddress.psm1"
Import-Module -ErrorAction "Stop" -Name "$PSScriptRoot\File.psm1"

############################################################################### GLOBAL VARIABLES

# Print the called methods
$global:DebugEmail = $False

############################################################################### CLASS DEFINITION

class Email {

    ########################################################################### ATTRIBUTES

    hidden [File[]]$Attachments         # @(<File>)
    hidden [EmailAddress]$Sender        # <EmailAddress>
    hidden [EmailAddress[]]$Recipients  # @(<EmailAddress>)
    hidden [String]$Subject             # "This is an email subject"
    hidden [String]$Body                # "This is an email body"
    
    ############################################################## CONSTRUCTORS
    #
    # Construct an instance of the class
    #
    # Exemple: [EmailAddress]::New()
    #
    Email() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmail) {Write-Host "Email()"}
        #
        # Set the default value of the properties
        #
        $This.Attachments = @()
        $This.Recipients = @()
        $This.Subject = ""
        $This.Body = ""
    }

    ########################################################################### SETTERS
    #
    # Set the subject of the email
    #
    # Exemple: $Email.SetSubject("new subject")
    #
    [void] SetSubject([String]$Subject) {
        #
        # Log the call to this method
        #
        If ($global:DebugEmail) {Write-Host "SetSubject($Subject)"}
        #
        # If the subject is null
        #
        If (-not $Subject) {
            #
            # Throw an exception to the method caller
            #
            Throw "The subject of the email cannot be null."
        }
        #
        # Remove the spaces around the subject
        #
        $TrimedSubject = $Subject.Trim()
        #
        # Set the subject
        #
        $This.Subject = $TrimedSubject
    }

    #
    # Set the body of the email
    #
    # Exemple: $Email.SetBody("new body")
    #
    [void] SetBody([String]$Body) {
        #
        # Log the call to this method
        #
        If ($global:DebugEmail) {Write-Host "SetBody($Body)"}
        #
        # If the body is null
        #
        If (-not $Body) {
            #
            # Throw an exception to the method caller
            #
            Throw "The body of the email cannot be null."
        }
        #
        # Remove the spaces around the subject
        #
        $TrimedBody = $Body.Trim()
        #
        # Set the body
        #
        $This.Body = $TrimedBody
    }

    #
    # Set the sender of the email
    #
    # Exemple: $Email.SetSender($Sender)
    #
    [void] SetSender([EmailAddress]$Sender) {
        #
        # Log the call to this method
        #
        If ($global:DebugEmail) {Write-Host "SetSender($Sender)"}
        #
        # If the sender is null
        #
        If (-not $Sender) {
            #
            # Throw an exception to the method caller
            #
            Throw "The sender of the email cannot be null."
        }
        #
        # Set the recipients list
        #
        $This.Sender = $Sender
    }

    #
    # Set the recipients of the email
    #
    # Exemple: $Email.SetRecipients($Recipients)
    #
    [void] SetRecipients([EmailAddress[]]$Recipients) {
        #
        # Log the call to this method
        #
        If ($global:DebugEmail) {Write-Host "SetRecipients($Recipients)"}
        #
        # If the recipients list is null
        #
        If (-not $Recipients) {
            #
            # Throw an exception to the method caller
            #
            Throw "The recipients of the email cannot be null."
        }
        #
        # Set the recipients list
        #
        $This.Recipients = $Recipients
    }

    #
    # Set the attachments of the email
    #
    # Exemple: $Email.SetAttachments($Attachments)
    #
    [void] SetAttachments([File[]]$Attachments) {
        #
        # Log the call to this method
        #
        If ($global:DebugEmail) {Write-Host "SetSetAttachments($Attachments)"}
        #
        # If the recipients list is null
        #
        If (-not $Attachments) {
            #
            # Throw an exception to the method caller
            #
            Throw "The attachments of the email cannot be null."
        }
        #
        # Set the recipients list
        #
        $This.Attachments = $Attachments
    }

    ################################################################### GETTERS
    #
    # Get the sender of the email
    #
    # Exemple: ($Email.GetSender().Address -eq "jean-dupont@mydomain.com")
    #
    [EmailAddress] GetSender() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmail) {Write-Host "GetSender()"}
        #
        # Return the sender of the email
        #
        return $This.Sender
    }

    #
    # Get the recipients of the email
    #
    # Exemple: ($Email.GetRecipients().Length -gt 2)
    #
    [EmailAddress[]] GetRecipients() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmail) {Write-Host "GetRecipients()"}
        #
        # Return the recipients of the email
        #
        return $This.Recipients
    }

    #
    # Get the attachments of the email
    #
    # Exemple: ($Email.GetAttachments().Length -gt 2)
    #
    [File[]] GetAttachments() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmail) {Write-Host "GetAttachments()"}
        #
        # Return the attachments of the email
        #
        return $This.Attachments
    }

    #
    # Get the subject of the email
    #
    # Exemple: ($Email.GetSubject() -eq "my subject")
    #
    [String] GetSubject() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmail) {Write-Host "GetSubject()"}
        #
        # Return the subject of the email
        #
        return $This.Subject
    }

    #
    # Get the body of the email
    #
    # Exemple: ($Email.GetBody() -eq "my body")
    #
    [String] GetBody() {
        #
        # Log the call to this method
        #
        If ($global:DebugEmail) {Write-Host "GetBody()"}
        #
        # Return the body of the email
        #
        return $This.Body
    }
}
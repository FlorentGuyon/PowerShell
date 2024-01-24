############################################################################### IMPORTED MODULES

Using module ".\Account.psm1"

Import-Module -ErrorAction "Stop" -Name "$PSScriptRoot\Account.psm1"

############################################################################### GLOBAL VARIABLES

# Print the called methods
$global:DebugSMTPClient = $False

############################################################################### CLASS DEFINITION

class SMTPClient {

    ########################################################################### ATTRIBUTES

    hidden [Account]$UserAccount       # Account (svc_mailuser / MyPassword1234!)
    hidden [String]$SMTPServerFQDN     # "smtp.yourmailserver.com"

    ########################################################################### CONSTRUCTOR
    #
    # Construct an instance of the class SMTPClient
    #
    SMTPClient() {
        #
        # Log the call to this method
        #
        If ($global:DebugSMTPClient) {Write-Host "SMTPClient()"}
    }

    ########################################################################### SETTERS
    #
    # Set the user account connecting to the SMTP Server
    #
    # Exemple: $SMTPClient.SetUserAccount($UserAccount)
    #
    [void] SetUserAccount([Account]$UserAccount) {
        #
        # Log the call to this method
        #
        If ($global:DebugSMTPClient) {Write-Host "SetUserAccount($UserAccount)"}
        #
        # If the account is null
        #
        If (-not $UserAccount) {
            #
            # Throw an error to the caller of the method
            #
            throw "The user account of the SMTP client cannot be null."
        }
        #
        # Set the user account
        #
        $This.UserAccount = $UserAccount
    }

    #
    # Set the FQDN of the SMTP server
    #
    # Exemple: $SMTPClient.SMTPServerFQDN($SMTPServerFQDN)
    #
    [void] SetSMTPServerFQDN([String]$SMTPServerFQDN) {
        #
        # Log the call to this method
        #
        If ($global:DebugSMTPClient) {Write-Host "SMTPServerFQDN($SMTPServerFQDN)"}
        #
        # If the account is null
        #
        If (-not $SMTPServerFQDN) {
            #
            # Throw an error to the caller of the method
            #
            throw "The FQDN of the SMTP server cannot be null."
        }
        #
        # Set the user account
        #
        $This.SMTPServerFQDN = $SMTPServerFQDN
    }

    ########################################################################### GETTERS
    #
    # Get the user account connecting to the SMTP Server
    #
    # Exemple: $SMTPClient.GetUserAccount()
    #
    [Account] GetUserAccount() {
        #
        # Log the call to this method
        #
        If ($global:DebugSMTPClient) {Write-Host "GetUserAccount()"}
        #
        # Get the user account
        #
        Return $This.UserAccount
    }

    #
    # Get the FQDN of the SMTP Server
    #
    # Exemple: $SMTPClient.SMTPServerFQDN()
    #
    [String] GetSMTPServerFQDN() {
        #
        # Log the call to this method
        #
        If ($global:DebugSMTPClient) {Write-Host "SMTPServerFQDN()"}
        #
        # Get the user account
        #
        Return $This.SMTPServerFQDN
    }

    ########################################################################### METHODS
    #
    # Send an Email to the SMTP server
    #
    # Exemple: $SMTPClient.SendEmail($Email)
    #
    [void] SendEmail([Object]$Email) {
        #
        # Log the call to this method
        #
        If ($global:DebugSMTPClient) {Write-Host "SendEmail($Email)"}
        #
        # If the sender or its address is null
        #
        If ((-not $Email.Sender) -or (-not $Email.Sender.Address)) {
            #
            # Throw an exception to the caller of the method
            #
            throw "Unable to send an email without the address of the sender."
        }
        #
        # If the list of recipients is null or empty
        #
        If ((-not $Email.Recipients) -or ($Email.Recipients.Length -eq 0)) {
            #
            # Throw an exception to the caller of the method
            #
            throw "Unable to send an email without at least one recipient."
        }
        #
        # Go through each recipient
        #
        ForEach ($Recipient in $Email.Recipients) {
            #
            # If the address of the current recipient is null
            #
            If (-not $Recipient.Address) {
                #
                # Throw an exception to the caller of the method
                #
                throw "Unable to send an email without the address of the $($Email.Recipients.Length) recipients."
            }
        }
        #
        # If the FQDN of the SMTP server is null
        #
        If ((-not $This.SMTPServerFQDN)) {
            #
            # Throw an exception to the caller of the method
            #
            throw "Unable to send an email without the FQDN of the SMTP server."
        }
        #
        # If the the user account or its credential is null
        #
        If ((-not $This.UserAccount) -or (-not $This.UserAccount.Credential)) {
            #
            # Throw an exception to the caller of the method
            #
            throw "Unable to send an email without the credential of the user account."
        }
        #
        # Go through each attachment
        #
        ForEach ($Attachment in $Email.Attachments) {
            #
            # If the attachment does not exist
            #
            If (-not $Attachment.Exist()) {
                #
                # Throw an exception to the caller of the method
                #
                throw "Unable to send an email with the attachment `"$($Attachment.GetPath())`" missing."
            }
        }
        #
        # Send the email
        #
        # Documentation : https://learn.microsoft.com/fr-fr/powershell/module/microsoft.powershell.utility/send-mailmessage?view=powershell-7.4
        #
        Send-MailMessage -From $Email.GetSender().GetAddress() -To ($Email.GetRecipients() | ForEach {$_.GetAddress()}) -Subject $Email.GetSubject() -Body $Email.GetBody() -SmtpServer $This.GetSMTPServerFQDN() -Attachments ($Email.GetAttachments() | ForEach {$_.GetPath()}) -Credential $This.GetUserAccount().GetCredential() -UseSsl
    }
}
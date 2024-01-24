############################################################################### GLOBAL VARIABLES

# Print the called methods
$global:DebugFile = $False

class File {

    ########################################################################### ATTRIBUTES

    hidden [System.IO.FileStream]$FileStream       # Open file
    hidden [string]$Path                           # "log.txt"
    hidden [System.IO.StreamWriter]$StreamWriter   # File writer

    ########################################################################### SETTERS
    #
    # Set the Path of the file
    #
    # Exemple: $File.SetPath(".\here\file.txt")
    #
    [void] SetPath([String]$Path) {
        #
        # Log the call to this method
        #
        If ($global:DebugFile) {Write-Host "SetPath($Path)"}
        #
        # If the path is null
        #
        If ([String]::IsNullOrWhiteSpace($Path)) {
            #
            # Throw an exception to the method caller
            #
            Throw "The path of the file cannot be null."
        }
        #
        # Remove the spaces around the subject
        #
        $TrimedPath = $Path.Trim()
        #
        # Set the subject
        #
        $This.Path = $TrimedPath
    }

    ########################################################################### GETTERS
    #
    # Get the Path of the file
    #
    # Exemple: ($File.GetPath() -eq ".\here\file.txt")
    #
    [String] GetPath() {
        #
        # Log the call to this method
        #
        If ($global:DebugFile) {Write-Host "GetPath()"}
        #
        # Get the path
        #
        Return $This.Path
    }

    #
    # Get the file stream of the file
    #
    # Exemple: ($File.GetFileStream() -eq $Null)
    #
    [System.IO.FileStream] GetFileStream() {
        #
        # Log the call to this method
        #
        If ($global:DebugFile) {Write-Host "GetFileStream()"}
        #
        # Get the file stream
        #
        Return $This.FileStream
    }

    #
    # Get the stream writer of the file
    #
    # Exemple: ($File.GetStreamWriter() -eq $Null)
    #
    [System.IO.StreamWriter] GetStreamWriter() {
        #
        # Log the call to this method
        #
        If ($global:DebugFile) {Write-Host "GetStreamWriter()"}
        #
        # Get the stream writer
        #
        Return $This.StreamWriter
    }

    ########################################################################### METHODS
    #
    # Check if the file exists
    #
    [bool] Exist() {
        #
        # Log the call to this method
        #
        If ($global:DebugFile) {Write-Host "Exist()"}
        #
        # If the path to the file is null
        #
        If ($This.GetPath() -eq $Null) {
            #
            # Return false
            # 
            Return $False
        }
        #
        # Return if the path to the file exists
        #
        return (Test-Path $This.GetPath())
    }

    #
    # Define the path to the file
    #
    #   Example: .\text.txt
    #
    [void] Create() {
        #
        # Log the call to this method
        #
        If ($global:DebugFile) {Write-Host "Create()"}
        #
        # If the file already exists
        #
        if ($This.Exist()) {
            #
            # Exit the function
            #
            return
        }
        #
        # If the path to the file was not passed in the arguments, exit the function
        #
        if ([string]::IsNullOrWhiteSpace($This.GetPath())) {
            throw "Unable to create a new file without a path."
        }

        # Try to create the file
        try {
            New-Item -Path $This.GetPath() -ItemType File | Out-Null
        }
        # If it fails, throw an exception to the function caller
        catch {
            throw "Unable to create the file `"$($This.GetPath())`":`n$($_.Exception.Message)"
        }
    }

    #
    # Open the file
    #
    [void] Open() {
        #
        # Log the call to this method
        #
        If ($global:DebugFile) {Write-Host "Open()"}
        #
        # If the file does not exist
        #
        if (-not $This.Exist()) {
            # Try to create the file
            try {
                $This.Create()
            }
            # If it fails, print it
            catch {
                throw "Unable to open the file `"$($This.GetPath())`":`n$($_.Exception.Message)"
            }
        }

        # Try to open the file
        try {
            # Open the file for writing with FileShare.ReadWrite (keeps it open)
            $This.FileStream = [System.IO.File]::Open($This.GetPath(), [System.IO.FileMode]::Append, [System.IO.FileAccess]::Write, [System.IO.FileShare]::ReadWrite)

            # Create a StreamWriter to write to the file
            $This.StreamWriter = [System.IO.StreamWriter]::new($This.GetFileStream())
        }
        # If it fails, throw an exception to the function caller
        catch {
            throw "Unable to open the file `"$($This.GetPath())`":`n$($_.Exception.Message)"
        }
    }

    #
    # Close the file
    #
    [void] Close() {
        #
        # Log the call to this method
        #
        If ($global:DebugFile) {Write-Host "Close()"}

        # If the file does not exist, exit the function
        if (-not $This.GetStreamWriter()) {
            throw "Unable to close the file `"$($This.GetPath())`": The file is not open."
        }

        # Try to close the file
        try {
            $This.GetStreamWriter().Close()
            $This.GetFileStream().Close()
        }
        # If it fails, throw an exception to the function caller
        catch {
            throw "Unable to close the file `"$($This.GetPath())`":`n$($_.Exception.Message)"
        }
    }

    #
    # Format the message and write it in the file and the console
    #
    [void] Write([string]$Message) {
        #
        # Log the call to this method
        #
        If ($global:DebugFile) {Write-Host "Write($Message)"}
        
        # If the log file does not exist
        if (-not $This.GetStreamWriter()) {
            # Try to open the file
            try {
                $This.Open()
            }
            # If it fails, print it
            catch {
                throw "Unable to write in the file `"$($This.GetPath())`":`n$($_.Exception.Message)"
            }
        }
        
        # Try to insert the log at the end of the log file
        try {
            $This.StreamWriter.WriteLine($Message)
        }
        # If it fails, print it
        catch {
            throw "Unable to write in the file `"$($This.GetPath())`":`n$($_.Exception.Message)"
        }
    }
}
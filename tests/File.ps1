Using module "..\modules\File.psm1"

Import-Module -ErrorAction "Stop" -Name "$PSScriptRoot\..\modules\File.psm1"

############################################################################### File()
#
# VALID
#
Try {
    Write-Host "Creating a valid object... " -NoNewLine
    $File = [File]::New()
    Write-Host "Succed, as expected." -ForegroundColor "Green"
}
Catch {
    Write-Host "Failed, not as expected: $($_.Exception.Message)." -ForegroundColor "Red"
}

############################################################################### SetPath()
#
# VALID
#
Try {
    Write-Host "Setting a valid path... " -NoNewLine
    $NewPath = "new path"
    $File.SetPath($NewPath)
    If (-not ($File.Path -eq $NewPath)) {
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
    Write-Host "Setting an invalid path... " -NoNewLine
    $File.SetPath()
    Write-Host "Succed, not as expected." -ForegroundColor "Red"
}
Catch {
    Write-Host "Failed, as expected." -ForegroundColor "Green"
}
Install-WindowsFeature FS-DFS-Namespace, RSAT-DFS-Mgmt-Con


Get-DfsnRoot – Discover all DFS Namespaces in the current domain
#Commonly used to check for available namespaces in the current domain
New-DfsnFolder – Create a new DFS Folder Name
#Commonly used to create a new DFS Folder in a NameSpace
New-DfsnFolderTarget – Assign path(s) to a DFS Folder Name
#Commonly used to assign one or more network folder paths to a DFS Folder
Remove-DfsnFolderTarget – Removes a path from a DFS Folder but does not remove the DFS Folder.
#Commonly used to remove one or more network folder paths from a DFS Folder
Remove-DfsnFolder – Removes a folder and all its paths
#Commonly used to remove a DFS Folder from a NameSpace


$Domain = 'tech.io'
(Get-DfsnRoot -Domain $Domain).Where( { $_.State -eq 'Online' } ) | Select-Object -ExpandProperty Path


$Domain = 'tech.io'
Get-DfsnFolder -Path "\\$Domain\AppRoot\*" | Select-Object -ExpandProperty Path
Get-DfsnFolder -Path "\\$Domain\DFSRoot\*" | Select-Object -ExpandProperty Path

#Creating DFS Link Folders with PowerShell

ry {
    Get-DfsnFolderTarget -Path "\\$Domain\AppRoot\PowerShell" -ErrorAction Stop
} catch {
    Write-Host "Path not found. Clear to proceed" -ForegroundColor Green
}
 
$NewDFSFolder = @{
    Path                  = "\\$Domain\AppRoot\PowerShell"
    State                 = 'Online'
    TargetPath            = '\\datacenter\FileShare\PowerShell'
    TargetState           = 'Online'
    ReferralPriorityClass = 'globalhigh'
}
 
New-DfsnFolder @NewDFSFolder
 
# Check that folder now exists:
Get-DfsnFolderTarget -Path "\\$Domain\AppRoot\PowerShell"
 
# Check that the new DFS Link works using Windows Explorer
Invoke-Expression "explorer '\\$Domain\AppRoot\PowerShell\'"
 
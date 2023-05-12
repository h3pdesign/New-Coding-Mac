Get-CimInstance -ClassName Win32_Desktop -ComputerName 
#Directory
Get-ChildItem -Recurse | ? { $_.PSIsContainer } | Select-Object FullName
dir -Directory

﻿#Requires -Version 4.0
#Requires -Modules Hyper-V

<#
    .SYNOPSIS
        Gets the virtual network adapters of a virtual machine
    
    .DESCRIPTION  
        Use "Win2K12R2 or Win8.x" for execution on Windows Server 2012 R2 or on Windows 8.1,
        when execute on Windows Server 2016 / Windows 10 or newer, use "Newer Systems"

    .NOTES
        This PowerShell script was developed and optimized for ScriptRunner. The use of the scripts requires ScriptRunner. 
        The customer or user is authorized to copy the script from the repository and use them in ScriptRunner. 
        The terms of use for ScriptRunner do not apply to this script. In particular, ScriptRunner Software GmbH assumes no liability for the function, 
        the use and the consequences of the use of this freely available script.
        PowerShell is a product of Microsoft Corporation. ScriptRunner is a product of ScriptRunner Software GmbH.
        © ScriptRunner Software GmbH

    .COMPONENT
        Requires Module Hyper-V

    .LINK
        https://github.com/scriptrunner/ActionPacks/tree/master/Hyper-V/_QUERY_

    .Parameter HostName
        Specifies the name of the Hyper-V host

    .Parameter VMName
        Specifies the virtual machine whose virtual network adapters are to be retrieved

    .Parameter AccessAccount
        Specifies the user account that have permission to perform this action
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$VMName,
    [string]$HostName,
    [PSCredential]$AccessAccount
)

Import-Module Hyper-V

try {
    if([System.String]::IsNullOrWhiteSpace($HostName)){
        $HostName = "."
    } 
    if($null -eq $AccessAccount){
        $Script:VM = Get-VM -ErrorAction Stop | Where-Object {$_.VMName -eq $VMName -or $_.VMID -eq $VMName}
    }
    else {
        $Script:Cim = New-CimSession -ComputerName $HostName -Credential $AccessAccount
        $Script:VM = Get-VM -CimSession $Script:Cim -ErrorAction Stop | Where-Object {$_.VMName -eq $VMName -or $_.VMID -eq $VMName}
    }             
    if($null -ne $Script:VM){
        [string[]]$Properties = @('Name','VMName','MacAddress','DynamicMacAddressEnabled','IPAddresses','Connected','SwitchName','AdapterId','Status','StatusDescription','IsManagementOs','IsExternalAdapter')
        $Script:result = Get-VMNetworkAdapter -VM $Script:VM | Select-Object $Properties | Where-Object {$_.Connected -eq $true} | Sort-Object Name
        
        foreach($item in $Script:result){
            if($SRXEnv) {            
                $null = $SRXEnv.ResultList2.Add("Name: $($item.Name) - Status: $($item.Status) - IPAddresses: $($item.IPAddresses)") # DisplayValue            
                $null = $SRXEnv.ResultList.Add($item.SwitchName) # Value
            }
            else{
                Write-Output $item.Name
            }
        }
    }
    else{
        if($SRXEnv) {
            $SRXEnv.ResultMessage = "Virtual machine $($VMName) not found"
        }    
        Throw "Virtual machine $($VMName) not found"
    }
}
catch {
    throw
}
finally{
    if($null -ne $Script:Cim){
        Remove-CimSession $Script:Cim 
    }
}
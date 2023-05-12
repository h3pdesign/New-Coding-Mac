﻿#Requires -Version 5.0

<#
    .SYNOPSIS
        Updates a service instance
    
    .DESCRIPTION  

    .NOTES
        This PowerShell script was developed and optimized for ScriptRunner. The use of the scripts requires ScriptRunner. 
        The customer or user is authorized to copy the script from the repository and use them in ScriptRunner. 
        The terms of use for ScriptRunner do not apply to this script. In particular, ScriptRunner Software GmbH assumes no liability for the function, 
        the use and the consequences of the use of this freely available script.
        PowerShell is a product of Microsoft Corporation. ScriptRunner is a product of ScriptRunner Software GmbH.
        © ScriptRunner Software GmbH

    .COMPONENT
        Requires the library script CitrixLibrary.ps1
        Requires PSSnapIn Citrix*

    .LINK
        https://github.com/scriptrunner/ActionPacks/blob/master/Citrix/Sites
        
    .Parameter SiteServer
        [sr-en] Specifies the address of a XenDesktop controller. 
        This can be provided as a host name or an IP address
        [sr-de] Name oder IP Adresse des XenDesktop Controllers

    .Parameter ServiceInstanceUid  
        [sr-en] Unique identifier for the service instance
        [sr-de] Uid der Service Instanz

    .Parameter Address
        [sr-en] New address for the service instance
        [sr-en] Neue Adresse der Service Instanz
#>

param( 
    [Parameter(Mandatory = $true)]
    [string]$ServiceInstanceUid ,
    [Parameter(Mandatory = $true)]
    [string]$Address ,
    [string]$SiteServer
)                                                            

$LogID = $null
[bool]$success = $false
try{ 
    [string[]]$Properties = @('Address','Binding','InterfaceType','ServiceAccount','ServiceGroupName','ServiceType')
    StartCitrixSessionAdv -ServerName ([ref]$SiteServer)
    StartLogging -ServerAddress $SiteServer -LogText "Set registered service instance" -LoggingID ([ref]$LogID)

    [hashtable]$cmdArgs = @{'ErrorAction' = 'Stop'
                            'AdminAddress' = $SiteServer
                            'ServiceInstanceUid' = $ServiceInstanceUid
                            'PassThru' = $null
                            }        

    $null = Set-ConfigRegisteredServiceInstance @cmdArgs -Address $Address
    $ret = Get-ConfigRegisteredServiceInstance @cmdArgs | Select-Object $Properties
    $success = $true
    if($SRXEnv) {
        $SRXEnv.ResultMessage = $ret
    }
    else{
        Write-Output $ret
    }
}
catch{
    throw 
}
finally{
    StopLogging -LoggingID $LogID -ServerAddress $SiteServer -IsSuccessful $success
    CloseCitrixSession
}
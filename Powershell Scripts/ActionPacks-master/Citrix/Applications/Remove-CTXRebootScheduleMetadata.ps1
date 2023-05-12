﻿#Requires -Version 5.0

<#
    .SYNOPSIS
        Deletes Metadata from the Reboot Schedule object
    
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
        https://github.com/scriptrunner/ActionPacks/blob/master/Citrix/Applications
        
    .Parameter SiteServer
        [sr-en] Address of a XenDesktop controller. 
        This can be provided as a host name or an IP address
        [sr-de] Name oder IP Adresse des XenDesktop Controllers

    .Parameter RebootScheduleUid
        [sr-en] Uid of the Reboot Schedule
        [sr-de] Uid des Neustartzeitplans

    .Parameter PropertyName	
        [sr-en] Name of the metadata to be deleted
        [sr-de] Name der Eigenschaft die gelöscht wird
#>

param( 
    [Parameter(Mandatory = $true)]
    [string]$RebootScheduleUid,
    [Parameter(Mandatory = $true)]
    [string]$PropertyName,
    [string]$SiteServer
)                                                            

$LogID = $null
[bool]$success = $false
try{ 
    StartCitrixSessionAdv -ServerName ([ref]$SiteServer)
    
    [hashtable]$cmdArgs = @{'ErrorAction' = 'Stop'
                            'AdminAddress' = $SiteServer
                            'Uid' = $RebootScheduleUid
                        }

    $itm = Get-BrokerRebootScheduleV2 @cmdArgs

    StartLogging -ServerAddress $SiteServer -LogText "Remove reboot schedule metadata $($PropertyName)" -LoggingID ([ref]$LogID)
    [hashtable]$delArgs = @{'ErrorAction' = 'Stop'
                            'AdminAddress' = $SiteServer
                            'InputObject' = $itm
                            'Name' = $PropertyName
                            'LoggingId' = $LogID
                            }
    
    $null = Remove-BrokerRebootScheduleV2Metadata @delArgs
    $success = $true
    $ret = Get-BrokerRebootScheduleV2 @cmdArgs | Select-Object -ExpandProperty MetadataMap
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
#
# Module manifest for module 'Logic.Monitor'
#
# Generated by: Steven Villardi
#
# Generated on: 1/25/2021
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'Logic.Monitor.psm1'

# Version number of this module.
ModuleVersion = '3.2.2'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = 'a44fe534-bd11-4d75-827a-520efbb53a9c'

# Author of this module
Author = 'Steven Villardi'

# Company or vendor of this module
CompanyName = 'LogicMonitor'

# Copyright statement for this module
Copyright = '(c) Steven Villardi. All rights reserved.'

# Description of the functionality provided by this module
Description = 'PowerShell module to query the Logic Monitor API. This is a personal project and is not an offically supported LogicMonitor integration.'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @('PSWriteHTML')

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = @('System.Web')

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = @('Logic.Monitor.Format.ps1xml')

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @('Get-LMDeviceDatasourceInstanceAlertSetting','Import-LMRepositoryLogicModules','Get-LMRepositoryLogicModules','Invoke-LMActiveDiscovery','Get-LMPropertySource','Export-LMLogicModule','Import-LMLogicModule','Invoke-LMCollectorDebugCommand','Get-LMCollectorDebugResult','Get-LMPortalInfo','New-LMCollector','Format-LMFilter','Get-LMv4Error','Connect-LMAccount','Disconnect-LMAccount','Get-LMWebsite','Get-LMWebsiteCheckpoint','Get-LMDevice','Get-LMAlert','Get-LMAlertRule','Get-LMAPIToken','Get-LMAppliesToFunction','Get-LMAuditLogs','Get-LMCollector','Get-LMCollectorGroup','Get-LMCollectorVersions','Get-LMCollectorInstaller','Get-LMDashboard','Get-LMDashboardGroup','Get-LMDashboardWidget','Get-LMDatasource','Get-LMDatasourceAssociatedDevices','Get-LMDatasourceUpdateHistory','Get-LMDeviceGroup','Get-LMDeviceGroupProperty','Get-LMDeviceGroupAlerts','Get-LMDeviceGroupDevices','Get-LMDeviceGroupSDT','Get-LMDeviceGroupSDTHistory','Get-LMDevice','Get-LMDeviceAlertSettings','Get-LMDeviceDatasourceList','Get-LMDeviceProperty','Get-LMDeviceNetflowEndpoints','Get-LMDeviceNetflowFlows','Get-LMDeviceNetflowPorts','Get-LMDeviceSDTHistory','Get-LMDeviceSDT','Get-LMDeviceInstanceList','Get-LMUnmonitoredDevices','Get-LMEscalationChain','Get-LMEventSource','Get-LMConfigSource','Get-LMTopologySource','Get-LMUsageMetrics','Get-LMNetscan','Get-LMOpsNotes','Get-LMRecipientGroup','Get-LMReport','Get-LMReportGroup','Get-LMRole','Get-LMSDT','Get-LMUser','Get-LMWebsite','Get-LMWebsiteAlerts','Get-LMWebsiteProperty','Get-LMWebsiteSDT','Get-LMWebsiteSDTHistory','Get-LMWebsiteGroup','Get-LMWebsiteGroupSDTHistory','Get-LMUserGroup','Get-LMWebsiteGroupSDT','Get-LMWebsiteGroupAlerts','Get-LMDeviceAlerts','New-LMAlertAck','New-LMAlertNote','New-LMAPIToken','New-LMUser','Set-LMUser','Remove-LMUser','Remove-LMWebsite','Remove-LMAPIToken','Set-LMAPIToken','New-LMDeviceGroup','Remove-LMDeviceGroup','Set-LMDeviceGroup','Set-LMDevice','Remove-LMDevice','Remove-LMDatasource','Remove-LMDashboard','Remove-LMDashboardWidget','Set-LMWebsite','New-LMWebsite','Get-LMWebsiteData','New-LMDeviceDatasourceInstance','Remove-LMDeviceDatasourceInstance','Get-LMDeviceDatasourceInstance','Get-LMTopologyMap','Get-LMDeviceGroupGroups','Get-LMTopologyMapData','Export-LMTopologyMap','Set-LMDeviceProperty','Remove-LMDeviceProperty','New-LMDeviceProperty','New-LMDevice','Get-LMDeviceEventSourceList')

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @("LogicMonitor")

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/stevevillardi/Logic.Monitor'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'See github product site for change log: https://github.com/stevevillardi/Logic.Monitor'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}


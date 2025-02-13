
Function Initialize-LMPOVSetup {

    [CmdletBinding()]
    Param (
        [String]$Website,

        [String]$WebsiteHttpType = "https",

        [string]$PortalMetricsAPIUsername = "lm_portal_metrics",

        [string]$LogsAPIUsername = "lm_logs",

        [Parameter(ParameterSetName = 'Individual')]
        [Switch]$SetupWebsite,

        [Parameter(ParameterSetName = 'Individual')]
        [Switch]$SetupPortalMetrics,

        [Parameter(ParameterSetName = 'Individual')]
        [Switch]$MoveMinimalMonitoring,

        [Parameter(ParameterSetName = 'Individual')]
        [Switch]$CleanupDynamicGroups,

        [Parameter(ParameterSetName = 'Individual')]
        [Switch]$SetupWindowsLMLogs,

        [String]$WindowsLMLogsEventChannels = "Application,System",

        [Parameter(ParameterSetName = 'All')]
        [Switch]$RunAll
    )
    #Check if we are logged in and have valid api creds
    Begin {}
    Process {
        If ($Script:LMAuth.Valid) {
            $PortalName = $Script:LMAuth.Portal
            $DeviceName = "$PortalName.logicmonitor.com"

            #Generate hastable of new dynamic groups to create
            $DynamicGroupList = @{
                "All Devices" = 'true()'
                "AWS Resources" = 'isAWSService()'
                "Azure Resources" = 'isAzureService()'
                "GCP Resources" = 'isGCPService()'
                "K8s Resources" = 'system.devicetype == "8"'
                "Dead Devices" = 'system.hoststatus == "dead" || system.hoststatus == "dead-collector" || system.gcp.status == "TERMINATED" || system.azure.status == "PowerState/stopped" || system.aws.stateName == "terminated"'
                "Palo Alto" = 'hasCategory("PaloAlto")'
                "Cisco ASA" = 'hasCategory("CiscoASA")'
                "Logs Enabled Devices" = 'hasPushModules("LogUsage")'
                "Netflow Enabled Devices" = 'isNetflow()'
                "Cisco UCS" = 'hasCategory("CiscoUCSFabricInterconnect") || hasCategory("CiscoUCSManager")'
                "Oracle" = 'hasCategory("OracleDB")'
                "Domain Controllers" = 'hasCategory("MicrosoftDomainController")'
                "Exchange Servers" = 'hasCategory("MSExchange")'
                "IIS" = 'hasCategory("MicrosoftIIS")'
                "Citrix XenApp" = 'hasCategory("CitrixBrokerActive") || hasCategory("CitrixMonitorServiceV2") || hasCategory("CitrixLicense") || hasCategory("CitrixEUEM")'

            }

            #Create readonly API use for Portal Metrics
            If ($SetupPortalMetrics -or $RunAll) {
                $CheckAPIUser = Get-LMUser -Name "$PortalMetricsAPIUsername"
                $CheckPortalDevice = Get-LMDevice -Name $DeviceName

                If(!$CheckAPIUser -and !$CheckPortalDevice){
                    Write-Host "[INFO]: Setting up API user: $PortalMetricsAPIUsername"
                    $APIUser = New-LMAPIUser -Username "$PortalMetricsAPIUsername" -note "Auto provisioned for use with LM Portal Metrics Datasources" -RoleNames @("readonly")
                    If ($APIUser) {
                        Write-Host "[INFO]: Successfully setup API user: $PortalMetricsAPIUsername"
        
                        Write-Host "[INFO]: Creating readonly API token for user: $PortalMetricsAPIUsername"
                        $APIInfo = New-LMAPIToken -id $APIUser.id -Note "Auto provisioned for use with LM Portal Metrics Datasource"
                    }
        
                    #Setup portal mertics device if we have a valid API token
                    If ($APIInfo) {
                        Write-Host "[INFO]: Successfully created API token for user: $PortalMetricsAPIUsername | $($APIInfo.accessId) | $($APIInfo.accessKey)"
        
                        If ($PortalName) {
                            $PortalDeviceGroup = New-LMDeviceGroup -Name "LogicMonitor Portal Metrics" -AppliesTo "hasCategory(`"LogicMonitorPortal`")" -ParentGroupName "Devices by Type"
                            If ($PortalDeviceGroup) {
                                Write-Host "[INFO]: Created Portal Metrics dynamic group in Devices by Type: $($PortalDeviceGroup.name)"
                            }
    
                            $CollectorId = (Get-LMCollector | Where-Object {$_.collectorSize -ne "n/a"} | Select-Object -Last 1).id
                            Write-Host "[INFO]: Creating Portal Metrics resource: $DeviceName"
                            $PortalDevice = New-LMDevice -Name $DeviceName -DisplayName $DeviceName -Description "Auto provisioned resource to collect LM Portal Metrics" -Properties @{"lmaccess.id" = $APIInfo.accessId; "lmaccess.key" = $APIInfo.accessKey; "lmaccount" = $PortalName } -PreferredCollectorId  $CollectorId
                            If ($PortalDevice) {
                                Write-Host "[INFO]: Successfully created Portal Metrics resource: $DeviceName"
                            }
                        }
                    }
                }
                Else{
                    Write-Host "[INFO]: API User ($PortalMetricsAPIUsername) or portal metrics device ($DeviceName) already exists in portal, skipping setup for portal metrics" -ForegroundColor Yellow
                }
            }

            #Setup Company Website
            If (($SetupWebsite -or $RunAll) -and $Website) {
                Write-Host "[INFO]: Setting up external webcheck for: $Website"
                $Website = $Website.split("//")[-1] #Make sure http/https is not in the entered site name
                $WebsiteResult = New-LMWebsite -Type "webcheck" -Name $Website -HttpType $WebsiteHttpType -WebsiteDomain $Website
                If ($WebsiteResult) {
                    Write-Host "[INFO]: Successfully setup external webcheck for: $Website"
                }
            }

            #Move minimal monitoring folder into devices by type
            If ($MoveMinimalMonitoring -or $RunAll) {
                $DeviceFolderId = (Get-LMDeviceGroup -Name "Devices by Type").id
                $MinimalFolderId = (Get-LMDeviceGroup -Name "Minimal Monitoring").id
                If ($DeviceFolderId -and $MinimalFolderId) {
                    Write-Host "[INFO]: Moving minimal monitoring folder into Devices by Type"
                    $MinimalFolderGroup = Set-LMDeviceGroup -id $MinimalFolderId -ParentGroupId $DeviceFolderId
                    If ($MinimalFolderGroup) {
                        Write-Host "[INFO]: Successfully moved minimal monitoring folder into Devices by Type"
                    }
                    $MinimalFolderAppliesTo = (Get-LMDeviceGroup -Name "Minimal Monitoring").appliesTo
                    If ($MinimalFolderAppliesTo) {
                        Write-Host "[INFO]: Updating Minimal Monitoring folder to exclude Meraki and Portal Metrics resources"
                        $MinimalFolderAppliesTo = $MinimalFolderAppliesTo + " && !hasCategory(`"LogicMonitorPortal`")  && !hasCategory(`"MerakiAPIOrg`")  && !hasCategory(`"MerakiAPINetwork`")"
                        $MinimalFolder = Set-LMDeviceGroup -Id $MinimalFolderId -AppliesTo $MinimalFolderAppliesTo
                        If ($MinimalFolder) {
                            Write-Host "[INFO]: Successfully updated minimal monitoring appliesTo query"
                        }
                    }
                }
            }

            #Cleanup dynamic groups will add Linux_SSH to the Linux folder and delete the Misc folder
            If ($CleanupDynamicGroups -or $RunAll) {
                Write-Host "[INFO]: Cleaning up default dynamic groups"
                $LinuxDeviceGroupId = (Get-LMDeviceGroup -Name "Linux Servers" | Where-Object {$_.fullPath -like "Devices by Type*"}).id
                $MiscDeviceGroupId = (Get-LMDeviceGroup -Name "Misc").id
                If(!$DeviceFolderId){
                    $DeviceFolderId = (Get-LMDeviceGroup -Name "Devices by Type").id
                }
                If ($LinuxDeviceGroupId) {
                    $ModifedLinuxGroup = Set-LMDeviceGroup -Id $LinuxDeviceGroupId -AppliesTo "isLinux() || hasCategory(`"Linux_SSH`")"
                    If ($ModifedLinuxGroup) {
                        Write-Host "[INFO]: Updated Linux Servers group to include Linux_SSH devices"
                    }
                }
                If ($MiscDeviceGroupId) {
                    $MiscDeviceGroup = Remove-LMDeviceGroup -Id $MiscDeviceGroupId
                    If ($ModifedLinuxGroup) {
                        Write-Host "[INFO]: Removed Misc devices group from Devices by Type"
                    }
                }
                Write-Host "[INFO]: Creating additional default dynamic groups"
                Foreach($Group in $DynamicGroupList.GetEnumerator()){
                    $NewGroup = New-LMDeviceGroup -Name $Group.Name -ParentGroupId $DeviceFolderId -AppliesTo $Group.Value
                    If($NewGroup){
                        Write-Host "[INFO]: Created new dynamic group: $($Group.Name)"
                    }
                }
            }

            If($SetupWindowsLMLogs -or $RunAll){
                $LogsAPIRoleName = "lm-logs-ingest"
                $LogsAPIUser = Get-LMUser -Name "$LogsAPIUsername"
                $LogsAPIRole = Get-LMRole -Name $LogsAPIRoleName
                If(!$LogsAPIRole){
                    Write-Host "[INFO]: Setting up LM Logs API Role: lm-logs-ingest"
                    $LogsAPIRole = New-LMRole -Name $LogsAPIRoleName -ResourcePermission view -LogsPermission manage -Description "Auto provisioned to allow for windows events ingest via datasource"
                    If($LogsAPIRole){
                        Write-Host "[INFO]: Successfully setup API role: $LogsAPIRoleName"
                    }
                }
                Else{
                    Write-Host "[INFO]: LM Logs API Role ($LogsAPIRoleName) already exists in portal, skipping setup" -ForegroundColor Yellow
                }
                If(!$LogsAPIUser){
                    Write-Host "[INFO]: Setting up LM Logs API user: $LogsAPIUsername"
                    $LogsAPIUser = New-LMAPIUser -Username "$LogsAPIUsername" -note "Auto provisioned for use with Windows LM Logs Datasource" -RoleNames @($LogsAPIRoleName)
                    If ($LogsAPIUser) {
                        Write-Host "[INFO]: Successfully setup API user: $LogsAPIUsername"
        
                        Write-Host "[INFO]: Creating administrator API token for user: $LogsAPIUsername"
                        $LMLogsAPIINfo = New-LMAPIToken -id $LogsAPIUser.id -Note "Auto provisioned for use with Windows LM Logs Datasource"
                    }
        
                    #Import Datasource and apply properties to windows server group
                    If ($LMLogsAPIINfo) {
                        Write-Host "[INFO]: Successfully created API token for user: $LogsAPIUsername | $($LMLogsAPIINfo.accessId) | $($LMLogsAPIINfo.accessKey)"
        
                        $WindowsServerDeviceGroup =  Get-LMDeviceGroup -Name "Windows Servers" | Where-Object {$_.fullPath -like "Devices by Type*"}


                        If ($WindowsServerDeviceGroup) {
                            Write-Host "[INFO]: Adding API properties to Windows Server device group"
                            $UpdatedWindowsServerDeviceGroup = Set-LMDeviceGroup -Id $WindowsServerDeviceGroup.Id -Properties @{"lmaccess.id" = $LMLogsAPIINfo.accessId; "lmaccess.key" = $LMLogsAPIINfo.accessKey; "lmaccount" = $PortalName; "lmlogs.winevent.channels" = $WindowsLMLogsEventChannels; "lmlogs.winevent.detailed_message" = "false" }
                            If ($UpdatedWindowsServerDeviceGroup) {
                                Write-Host "[INFO]: Successfully updated Windows Server device group for LM Logs"
                            }
                        }


                    }
                    #Import LM Logs Datasource
                    #Use imporved version with metadata over the orginal version
                    #Import-LMExchangeModule -LMExchangeId "896d0c2c-a993-4f0b-8db2-2bb29947cb52" #v2 modules
                    Import-LMExchangeModule -LMExchangeId "16831b61-4ab1-4f8e-810c-64c39d0128ba" #core module
                    Start-Sleep -Seconds 5 #Added manual pause to ensure datasource is available after importing from the exchange
                    $LogsDatasource = Set-LMDatasource -Name Windows_Events_LMLogs -appliesTo "isWindows() && lmlogs.winevent.channels && lmaccess.id && lmaccess.key && lmaccount"
                    If($LogsDatasource){
                        Write-Host "[INFO]: Successfully added core module (Windows_Events_LMLogs) and updated appliesto logic"
                    }
                    Else{
                        Write-Host "[WARN]: Successfully added core module (Windows_Events_LMLogs) but was unable to modify the appliesTo criteria, please manually set the appliesTo criteria for the datasource to apply: 'isWindows() && lmlogs.winevent.channels && lmaccess.id && lmaccess.key && lmaccount'" -ForegroundColor Yellow
                    }
                }
                Else{
                    Write-Host "[INFO]: LM Logs API User ($LogsAPIUsername) already exists in portal, skipping setup" -ForegroundColor Yellow
                }
            }
            
        }
        Else {
            Write-Error "Please ensure you are logged in before running any commands, use Connect-LMAccount to login and try again."
        }
    }
    End {}
}

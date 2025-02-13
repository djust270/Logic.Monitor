---
external help file: Logic.Monitor-help.xml
Module Name: Logic.Monitor
online version:
schema: 2.0.0
---

# Get-LMDeviceDatasourceInstanceAlertSetting

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### Name-dsName
```
Get-LMDeviceDatasourceInstanceAlertSetting -DatasourceName <String> -Name <String> -HdsiId <String>
 [-Filter <Hashtable>] [-BatchSize <Int32>] [<CommonParameters>]
```

### Id-dsName
```
Get-LMDeviceDatasourceInstanceAlertSetting -DatasourceName <String> -Id <Int32> -HdsiId <String>
 [-Filter <Hashtable>] [-BatchSize <Int32>] [<CommonParameters>]
```

### Name-dsId
```
Get-LMDeviceDatasourceInstanceAlertSetting -DatasourceId <Int32> -Name <String> -HdsiId <String>
 [-Filter <Hashtable>] [-BatchSize <Int32>] [<CommonParameters>]
```

### Id-dsId
```
Get-LMDeviceDatasourceInstanceAlertSetting -DatasourceId <Int32> -Id <Int32> -HdsiId <String>
 [-Filter <Hashtable>] [-BatchSize <Int32>] [<CommonParameters>]
```

### Id-HdsId
```
Get-LMDeviceDatasourceInstanceAlertSetting -Id <Int32> -HdsId <String> -HdsiId <String> [-Filter <Hashtable>]
 [-BatchSize <Int32>] [<CommonParameters>]
```

### Name-HdsId
```
Get-LMDeviceDatasourceInstanceAlertSetting -Name <String> -HdsId <String> -HdsiId <String>
 [-Filter <Hashtable>] [-BatchSize <Int32>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -BatchSize
{{ Fill BatchSize Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DatasourceId
{{ Fill DatasourceId Description }}

```yaml
Type: Int32
Parameter Sets: Name-dsId, Id-dsId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DatasourceName
{{ Fill DatasourceName Description }}

```yaml
Type: String
Parameter Sets: Name-dsName, Id-dsName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
{{ Fill Filter Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HdsId
{{ Fill HdsId Description }}

```yaml
Type: String
Parameter Sets: Id-HdsId, Name-HdsId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HdsiId
{{ Fill HdsiId Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
{{ Fill Id Description }}

```yaml
Type: Int32
Parameter Sets: Id-dsName, Id-dsId, Id-HdsId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
{{ Fill Name Description }}

```yaml
Type: String
Parameter Sets: Name-dsName, Name-dsId, Name-HdsId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

---
external help file: Logic.Monitor-help.xml
Module Name: Logic.Monitor
online version:
schema: 2.0.0
---

# Import-LMDashboard

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### File-GroupName
```
Import-LMDashboard -FilePath <String> -ParentGroupName <String> [-ReplaceAPITokensOnImport]
 [-PrivateUserName <String>] [<CommonParameters>]
```

### File-GroupId
```
Import-LMDashboard -FilePath <String> -ParentGroupId <String> [-ReplaceAPITokensOnImport]
 [-PrivateUserName <String>] [<CommonParameters>]
```

### Repo-GroupName
```
Import-LMDashboard -GithubUserRepo <String> [-GithubAccessToken <String>] -ParentGroupName <String>
 [-ReplaceAPITokensOnImport] [-PrivateUserName <String>] [<CommonParameters>]
```

### Repo-GroupId
```
Import-LMDashboard -GithubUserRepo <String> [-GithubAccessToken <String>] -ParentGroupId <String>
 [-ReplaceAPITokensOnImport] [-PrivateUserName <String>] [<CommonParameters>]
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

### -FilePath
{{ Fill FilePath Description }}

```yaml
Type: String
Parameter Sets: File-GroupName, File-GroupId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GithubAccessToken
{{ Fill GithubAccessToken Description }}

```yaml
Type: String
Parameter Sets: Repo-GroupName, Repo-GroupId
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GithubUserRepo
{{ Fill GithubUserRepo Description }}

```yaml
Type: String
Parameter Sets: Repo-GroupName, Repo-GroupId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentGroupId
{{ Fill ParentGroupId Description }}

```yaml
Type: String
Parameter Sets: File-GroupId, Repo-GroupId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentGroupName
{{ Fill ParentGroupName Description }}

```yaml
Type: String
Parameter Sets: File-GroupName, Repo-GroupName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrivateUserName
{{ Fill PrivateUserName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReplaceAPITokensOnImport
{{ Fill ReplaceAPITokensOnImport Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
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

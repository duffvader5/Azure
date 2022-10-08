Connect-AzAccount
Get-AzSubscription | foreach-object { 
 
    Write-Verbose -Message "Changing to Subscription $($_.Name)" -Verbose 
 
    Select-AzSubscription -TenantId $_.TenantId -Name $_.Id -Force 
    $Name     = $_.Name 
    $TenantId = $_.TenantId 
 
 
    Get-AzRoleAssignment -IncludeClassicAdministrators | Select RoleDefinitionName,DisplayName,SignInName,ObjectType,Scope, 
        @{name='TenantId';expression = {$TenantId}},@{name='SubscriptionName';expression = {$Name}} -OutVariable ra 
 
    # Also export the individual subscriptions to excel documents on your Desktop. 
    # One file per subscription 
    $ra | Export-Csv -Path C:\Temp\$Name.csv -NoTypeInformation 
 
} 
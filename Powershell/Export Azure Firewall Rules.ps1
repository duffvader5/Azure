Connect-AzAccount
Set-AzContext -SubscriptionId "Subscription ID"
$FormatEnumerationLimit = -1

$AFW = Get-AzFirewall -Name "Firewall Name" -ResourceGroupName "Reousrce Group Name"

$AFW_ApplicationRuleCollection_Dump = @()
$AFW_ApplicationRuleCollections = $AFW.ApplicationRuleCollections
foreach($AFW_ApplicationRuleCollection in $AFW_ApplicationRuleCollections)
{
    foreach($AFW_ApplicationRuleCollectionRule in $AFW_ApplicationRuleCollection.Rules)
    {
        $obj = New-Object -TypeName psobject
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Name -Value $AFW_ApplicationRuleCollection.Name
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_Name -Value $AFW_ApplicationRuleCollectionRule.Name
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_SourceAddresses -Value ($AFW_ApplicationRuleCollectionRule.SourceAddresses -join "; ")
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_TargetFqdns -Value ($AFW_ApplicationRuleCollectionRule.TargetFqdns -join "; ")
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_TargetProtocolType -Value ($AFW_ApplicationRuleCollectionRule.Protocols.ProtocolType -join "; ")
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_TargetProtocolPort -Value ($AFW_ApplicationRuleCollectionRule.Protocols.Port -join "; ")
        $AFW_ApplicationRuleCollection_Dump += $obj
    }
}

$AFW_ApplicationRuleCollection_Dump | Out-GridView


$AFW_NetworkRuleCollection_Dump = @()
$AFW_NetworkRuleCollections = $AFW.NetworkRuleCollections
foreach($AFW_NetworkRuleCollection in $AFW_NetworkRuleCollections)
{
    foreach($AFW_NetworkRuleCollectionRule in $AFW_NetworkRuleCollection.Rules)
    {
        $obj = New-Object -TypeName psobject
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Name -Value $AFW_NetworkRuleCollection.Name
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_Name -Value $AFW_NetworkRuleCollectionRule.Name
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_TargetProtocolType -Value ($AFW_NetworkRuleCollectionRule.Protocols -join "; ")
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_SourceAddresses -Value ($AFW_NetworkRuleCollectionRule.SourceAddresses -join "; ")
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_DestinationAddresses -Value ($AFW_NetworkRuleCollectionRule.DestinationAddresses -join "; ")
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_DestinationPorts -Value ($AFW_NetworkRuleCollectionRule.DestinationPorts -join "; ")
        $AFW_NetworkRuleCollection_Dump += $obj
    }
}

$AFW_NetworkRuleCollection_Dump | Out-GridView
$AFW_NatRuleCollection_Dump = @()
$AFW_NatRuleCollections = $AFW.NatRuleCollections
foreach($AFW_NatRuleCollection in $AFW_NatRuleCollections)
{
    foreach($AFW_NatRuleCollectionRule in $AFW_NatRuleCollection.Rules)
    {
        $obj = New-Object -TypeName psobject
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Name -Value $AFW_NatRuleCollection.Name
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_Name -Value $AFW_NatRuleCollectionRule.Name
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_SourceAddresses -Value ($AFW_NatRuleCollectionRule.SourceAddresses -join "; ")
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_DestinationAddresses -Value ($AFW_NatRuleCollectionRule.DestinationAddresses -join "; ")
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_TranslatedAddress -Value ($AFW_NatRuleCollectionRule.TranslatedAddress -join "; ")
        $obj | Add-Member -MemberType NoteProperty -Name ARC_Rule_TranslatedPort -Value ($AFW_NatRuleCollectionRule.TranslatedPort -join "; ")
        $AFW_NatRuleCollection_Dump += $obj
    }
   
}
$AFW_NatRuleCollection_Dump | Out-GridView

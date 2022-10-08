Connect-AzAccount

Get-AzSubscription | Foreach-Object {
    $sub = Set-AzContext -SubscriptionId $_.SubscriptionId
    $vnets = Get-AzVirtualNetwork

    foreach ($vnet in $vnets) {
        [PSCustomObject]@{
            Subscription = $sub.Subscription.Name
            Name = $vnet.Name
            Vnet = $vnet.AddressSpace.AddressPrefixes -join ', '
            Subnets = $vnet.Subnets.AddressPrefix -join ', '
        }
    }
} | Export-Csv -Delimiter ";" -Path "AzureVnet.csv"



$resourceGroupName = "RG-VNET-PROD-ZAN"
$virtualNetworkName = "VNET-WHUB-ZAN"
$subnetName = "Management_Subnet"

$virtualNetwork = Get-AzVirtualNetwork '
    -Name $virtualNetworkName '
    -ResourceGroupName $resourceGroupName

$subnet = Get-AzVirtualNetworkSubnetConfig '
    -VirtualNetwork $virtualNetwork '
    -Name $subnetName

$subnetMask = $subnet.AddressPrefix.Split("/")[1]

$netmaskLength = [Math]::Pow(2, 32 - [int]$subnetMask)

$availableIpAddresses = $netmaskLength - 5 - $subnet.IpConfigurations.Count

$availableIpAddresses
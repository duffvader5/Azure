Connect-AzAccount
Set-AzContext -Subscription "subscription name"
$azfw = Get-AzFirewall -Name "firewall name" -ResourceGroupName "resource gorup"
$vnet = Get-AzVirtualNetwork -ResourceGroupName "vnet resource group" -Name "vnet name"
$publicip = Get-AzPublicIpAddress -Name "public ip of firewall" -ResourceGroupName "pip resource group name"
$azfw.Allocate($vnet,$publicip)
Set-AzFirewall -AzureFirewall $azfw
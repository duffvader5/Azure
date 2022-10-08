Connect-AzAccount
Set-AzContext -Subscription "c1a0ef4a-95ea-4c95-9ec1-6eeb59f974c4"
$azfw = Get-AzFirewall -Name "AFW-TAPS-MTP-PROD-ZAN" -ResourceGroupName "RG-PROD-VNET-MTP-ZAN"
$vnet = Get-AzVirtualNetwork -ResourceGroupName "RG-PROD-VNET-MTP-ZAN" -Name "VNET-PROD-MTP-ZAN"
$publicip = Get-AzPublicIpAddress -Name "PIP-AFW-TAPS-MTP-PROD-ZAN" -ResourceGroupName "RG-PROD-VNET-MTP-ZAN"
$azfw.Allocate($vnet,$publicip)
Set-AzFirewall -AzureFirewall $azfw
Connect-AzAccount
Set-AzContext -Subscription "cf23bc63-db1c-4648-88ee-26c6535d6e4c"
$azfwrg = "RG-PROD-NETWORK-ZAN"
$fw = "AFW-PROD-CORE-ZAN"
$vnetname = "VNET-PROD-CORE-ZAN"
$pip = "PIP-PROD-CORE-AFW-ZAN"
$azfw = Get-AzFirewall -Name $fw -ResourceGroupName $azfwrg
$vnet = Get-AzVirtualNetwork -ResourceGroupName $azfwrg -Name $vnetname
$publicip = Get-AzPublicIpAddress -Name $pip -ResourceGroupName $azfwrg
$azfw.Allocate($vnet,$publicip)
Set-AzFirewall -AzureFirewall $azfw
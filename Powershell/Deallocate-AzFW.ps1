Connect-AzAccount
Set-AzContext -Subscription "c1a0ef4a-95ea-4c95-9ec1-6eeb59f974c4"
$azfw = Get-AzFirewall -Name "AFW-TAPS-MTP-PROD-ZAN" -ResourceGroupName "RG-PROD-VNET-MTP-ZAN"
$azfw.Deallocate()
Set-AzFirewall -AzureFirewall $azfw
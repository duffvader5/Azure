Connect-AzAccount
# Peer myVnetA to myVnetB.
$vNetA=Get-AzVirtualNetwork -Name vneta -ResourceGroupName test
Add-AzVirtualNetworkPeering `
  -Name 'myVnetAToMyVnetB' `
  -VirtualNetwork $vNetA `
  -RemoteVirtualNetworkId "/subscriptions/3a8f21da-5e2e-423b-8afe-653ade2a5cb3/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/vnetb"

  # Peer myVnetA to myVnetB.
$vNetA=Get-AzVirtualNetwork -Name vnetb -ResourceGroupName test
Add-AzVirtualNetworkPeering `
  -Name 'myVnetAToMyVnetB' `
  -VirtualNetwork $vNetA `
  -RemoteVirtualNetworkId "/subscriptions/3a8f21da-5e2e-423b-8afe-653ade2a5cb3/resourceGroups/test/providers/Microsoft.Network/virtualNetworks/vneta"
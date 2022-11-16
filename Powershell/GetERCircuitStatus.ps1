Connect-AzAccount
Set-AzContext -Subscription "subscription id"
$RG = "resource group name"
$CircuitName = "er circuit name"
$GateWayName = "er gateway name"
Get-AzVirtualNetworkGatewayBgpPeerStatus -ResourceGroupName $RG -VirtualNetworkGatewayName $GateWayName
Get-AzExpressRouteCircuitRouteTable -DevicePath Primary -ExpressRouteCircuitName $CircuitName -PeeringType AzurePrivatePeering -ResourceGroupName $RG
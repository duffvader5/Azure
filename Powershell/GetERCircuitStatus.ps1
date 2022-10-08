Connect-AzAccount
Set-AzContext -Subscription "65c959c3-fcac-4ebc-966b-98754151cef0"
$RG = "RG-VNET-PROD-ZAN"
$CircuitName = "WCG-CIR-LIQ"
$GateWayName = "WCG-EXPR-LIQ-SITA-ZAN"
Get-AzVirtualNetworkGatewayBgpPeerStatus -ResourceGroupName $RG -VirtualNetworkGatewayName $GateWayName
Get-AzExpressRouteCircuitRouteTable -DevicePath Primary -ExpressRouteCircuitName $CircuitName -PeeringType AzurePrivatePeering -ResourceGroupName $RG
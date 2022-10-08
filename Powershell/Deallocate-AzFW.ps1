Connect-AzAccount
#Define the subscription name variable#
$subname = "subscription name"
#Define the Resource Group name variable"
$rgname = "resource group name"
#Define the Firwall name variable#
$asfwname = "firewall name"
$azfw = Get-AzFirewall -Name $asfwname -ResourceGroupName $rgname
$azfw.Deallocate()
#Set the context for which subscription contains the firewall that this script must run against#
Set-AzContext -Subscription $subname
Set-AzFirewall -AzureFirewall $azfw
$SubscriptionId = "subscriptio id"
$ResourceGroupName = "rg name"
$VMName = “vm name”
$NICName = Get-azNetworkInterface -Name "nic name" -ResourceGroupName $ResourceGroupName
$VNetName = "vnet name"
$subnetName = "default"
$Location = "region"
$osDisk = "os disk name"
$availabilitySet = Get-azAvailabilitySet -ResourceGroupName $resourcegroupname -AvailabilitySetName "availability set name"
$addressPrefix = "vnet address prefix"
$PlanName = "plan name"
$PlanProduct = "arcgis-enterprise-106"
$PlanPublisher = "esri"

# Select subscription
Set-azContext -Subscription $SubscriptionId

# Get the managed OS disk
$ManagedDisk = Get-azDisk -ResourceGroupName $ResourceGroupName -DiskName $osDisk
 
 
# Accept licence terms for the publisher plan
Get-azMarketplaceTerms -Publisher $PlanPublisher -Product $PlanProduct -Name $PlanName | Set-azMarketplaceTerms -Accept
 
 
# Create the virtual machine
$newVM = New-azVMConfig -VMName $VMName -VMSize Standard_D5_v2 -AvailabilitySetId $availabilitySet.Id
$newVM = Set-azVMOSDisk -VM $newVM -ManagedDiskId $ManagedDisk.Id -CreateOption Attach -Windows
$newVM = Add-azVMNetworkInterface -VM $newVM -Id $NICName.Id
$newVM.Plan = New-Object -TypeName 'Microsoft.Azure.Management.Compute.Models.Plan'
$newVM.Plan.Name = $PlanName
$newVM.Plan.Product = $PlanProduct
$newVM.Plan.Publisher = $PlanPublisher
New-azVM -VM $newVM -ResourceGroupName $ResourceGroupName -Location $Location

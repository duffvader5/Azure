$vm = Get-AzVM -ResourceGroupName "rg-prod-sccm-zan" -Name "VM-HUB-SCCM-SEC"
$vm.Extensions | select Publisher, VirtualMachineExtensionType, TypeHandlerVersion

$rg = "rg-prod-sccm-zan"
$vmname = "VM-HUB-SCCM-SEC"
$extension = "MDE.Windows"

## Rerun a VM extension
Remove-AzVMExtension -ResourceGroupName $rg -VMName $vmname -Name $extension
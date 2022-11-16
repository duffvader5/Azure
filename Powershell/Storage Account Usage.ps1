Connect-AzAccount
Set-AzContext -Subscription "subscription id"

$storageaccountusage = @()
Get-AzResourceGroup | foreach-object {
    Get-AzStorageAccount -resourcegroupname $_.resourcegroupname | foreach-object {
        $length = 0
        $context = $_.Context
        Get-AzRmStorageContainer -ResourceGroupName $_.ResourceGroupName -StorageAccountName $_.StorageAccountName | ForEach-Object {
            Get-AzStorageBlob -Container $_.Name -Context $context | ForEach-Object {
                $length = $length + $_.Length
            }
        }
        $item = New-Object PSObject
        $item | Add-Member -Type NoteProperty -Name "Storage Account" -Value $_.StorageAccountName
        $item | Add-Member -type NoteProperty -Name "Length" -Value $length
        $storageaccountusage += $item
    }
}
$storageaccountusage | Export-Csv -path "outfile.csv" -NoTypeInformation
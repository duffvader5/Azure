$appServiceCertificateName = "WCG-Exchange-Cert-2021"
$resourceGroupName = "RG-PROD0-KV-ZAN"
$azureLoginEmailId = "az-c1821005@westerncape.onmicrosoft.com"
$subscriptionId = "65c959c3-fcac-4ebc-966b-98754151cef0"

Login-azAccount
Set-azContext -SubscriptionId $subscriptionId

$ascResource = Get-azResource -ResourceName $appServiceCertificateName -ResourceGroupName $resourceGroupName -ResourceType "Microsoft.CertificateRegistration/certificateOrders" -ApiVersion "2015-08-01"
$keyVaultId = "/subscriptions/3f3aa3e5-2feb-4c26-8398-6419da6fc02b/resourceGroups/RG-DEV-SNIPEIT-ZAN/providers/Microsoft.KeyVault/vaults/Keyvault-DEV-SNIP-ZAN"
$keyVaultSecretName = "cei-assetswesterncapegovza"

$certificateProperties=Get-Member -InputObject $ascResource.Properties.certificates[0] -MemberType NoteProperty
$certificateName = $certificateProperties[0].Name
$keyVaultId = $ascResource.Properties.certificates[0].$certificateName.KeyVaultId
$keyVaultSecretName = $ascResource.Properties.certificates[0].$certificateName.KeyVaultSecretName

$keyVaultIdParts = $keyVaultId.Split("/")
$keyVaultName = $keyVaultIdParts[$keyVaultIdParts.Length - 1]
$keyVaultResourceGroupName = $keyVaultIdParts[$keyVaultIdParts.Length - 5]
Set-azKeyVaultAccessPolicy -ResourceGroupName $keyVaultResourceGroupName -VaultName $keyVaultName -UserPrincipalName $azureLoginEmailId -PermissionsToSecrets get
$secret = Get-AzureKeyVaultSecret -VaultName $keyVaultName -Name $keyVaultSecretName
$pfxCertObject=New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 -ArgumentList @([Convert]::FromBase64String($secret.SecretValueText),"", [System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::Exportable)
$pfxPassword = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count 50 | % {[char]$_})
$currentDirectory = (Get-Location -PSProvider FileSystem).ProviderPath
[Environment]::CurrentDirectory = (Get-Location -PSProvider FileSystem).ProviderPath
[io.file]::WriteAllBytes(".\appservicecertificate.pfx", $pfxCertObject.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Pkcs12, $pfxPassword))
Write-Host "Created an App Service Certificate copy at: $currentDirectory\appservicecertificate.pfx"
Write-Warning "For security reasons, do not store the PFX password. Use it directly from the console as required."
Write-Host "PFX password: $pfxPassword"
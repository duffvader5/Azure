#Connect to Azure and select subscription
Connect-AzAccount
Select-AzSubscription -SubscriptionId "3f3aa3e5-2feb-4c26-8398-6419da6fc02b"
   
#Obtain the secret from keyvault
$vaultName = "Keyvault-DEV-SNIP-ZAN"
$secretName = "b0975ed5c8644b7eaa5f7e6385cd3e90"
$certString = Get-AzKeyVaultSecret -VaultName $vaultName -Name $secretName
   
#Create a PFX from the secret and write to disk
$kvSecretBytes = [System.Convert]::FromBase64String($certString.SecretValueText)
$certCollection = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2Collection
$certCollection.Import($kvSecretBytes,$null,[System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::Exportable)
$password = "Telephone@1"
$protectedCertificateBytes = $certCollection.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Pkcs12, $password)
$pfxPath = "C:\Users\trsimon\OneDrive - Microsoft\Microsoft\Clients\WCG\Snipe.pfx"
[System.IO.File]::WriteAllBytes($pfxPath, $protectedCertificateBytes)
#Connect to Azure and select subscription
Connect-AzAccount
Select-AzSubscription -SubscriptionId "sub id"
   
#Obtain the secret from keyvault
$vaultName = "kv name"
$secretName = "secret name"
$certString = Get-AzKeyVaultSecret -VaultName $vaultName -Name $secretName
   
#Create a PFX from the secret and write to disk
$kvSecretBytes = [System.Convert]::FromBase64String($certString.SecretValueText)
$certCollection = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2Collection
$certCollection.Import($kvSecretBytes,$null,[System.Security.Cryptography.X509Certificates.X509KeyStorageFlags]::Exportable)
$password = "Telephone@1"
$protectedCertificateBytes = $certCollection.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Pkcs12, $password)
$pfxPath = "C:\Users\trsimon\OneDrive - Microsoft\Microsoft\Clients\WCG\Snipe.pfx"
[System.IO.File]::WriteAllBytes($pfxPath, $protectedCertificateBytes)
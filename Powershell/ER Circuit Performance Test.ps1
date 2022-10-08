(new-object Net.WebClient).DownloadString("https://aka.ms/AzureCT") | Invoke-Expression
Install-LinkPerformance
#Connect-AzAccount
#Set-AzContext -subscription "<Subscription ID>"
Get-LinkPerformance -RemoteHost 10.0.0.1 -TestSeconds 10
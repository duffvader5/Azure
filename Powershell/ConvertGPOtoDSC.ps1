Install-Module BaselineManagement
Import-Module BaselineManagement
ConvertFrom-GPO -Path '.\Windows 10 server 20H2\GPOs\' -OutputConfigurationScript -Verbose
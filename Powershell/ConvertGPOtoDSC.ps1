Install-Module BaselineManagement
Import-Module BaselineManagement
ConvertFrom-GPO -Path '.\GPOs' -OutputConfigurationScript -Verbose

ConvertFrom-GPO -Path '.\GPOs' -ConfigName 'Windows_Server_2022' -OutputConfigurationScript -Verbose

ConvertFrom-GPO -Path .\Windows-Server-2022\GPOs -OutputConfigurationScript -OutputPath '.\Windows-Server-2022\Output' -Verbose
# Cogemos datos del equipo
$file = "mac_$($env:UserName).txt"

Write-Output "Usuario: $($env:UserName)" | Out-File -FilePath $file
Write-Output "Equipo: $($env:ComputerName)" | Out-File -FilePath $file -Append 
Write-Output "Dominio: $($env:UserDomain)" | Out-File -FilePath $file -Append 
getmac | Out-File -FilePath $file -Append 
 
# Logueamos con Storage Account

############ LOGIN ############
$tenantId = ""
$pass = ""
$appId = ""
$suscription = ""

$password = ConvertTo-SecureString $pass -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($appId, $password)
Connect-AzAccount -Credential $psCred -TenantId $tenantId -ServicePrincipal -SubscriptionId $suscription

# Enviamos fichero al Blob
Set-AzCurrentStorageAccount -ResourceGroupName "rg-temp-wifi" -AccountName "storagetempwifi"
Set-AzureStorageBlobContent -Container "container-temp-wifi" -File $file -Blob $file

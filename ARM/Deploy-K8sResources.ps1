
# Deploy K8s resources to Azure

# TODO:
# 1. Run ssh-keygen and generate a pair of keys
# 2. Create Key Vault with ARM Template
# 3. Add ssh public key in the Key Vault

# Manual steps:
# 1. Fill adminPublicKey with your private key
# 2. Change values of $TemplateFilePath_* and $TemplateFileParametersPath_* variables

param(
    [string]$TemplateFilePath_master = "C:\Users\VooDoo\Documents\LEARN\Kubernetes\ARM\k8s-master.json",
    [string]$TemplateFileParametersPath_master = "C:\Users\VooDoo\Documents\LEARN\Kubernetes\ARM\k8s-master.parameters.json",
    [string]$TemplateFilePath_worker01 = "C:\Users\VooDoo\Documents\LEARN\Kubernetes\ARM\k8s-worker01.json",
    [string]$TemplateFileParametersPath_worker01 = "C:\Users\VooDoo\Documents\LEARN\Kubernetes\ARM\k8s-worker01.parameters.json",
    [string]$TemplateFilePath_worker02 = "C:\Users\VooDoo\Documents\LEARN\Kubernetes\ARM\k8s-worker02.json",
    [string]$TemplateFileParametersPath_worker02 = "C:\Users\VooDoo\Documents\LEARN\Kubernetes\ARM\k8s-worker02.parameters.json",

    [string]$ResouceGroup = "k8s-lab-strakh",
    [string]$Location = "westeurope"
)

Set-ExecutionPolicy Unrestricted

if(-not (Get-InstalledModule Azz)) {
    Install-Module Az -Force
}

Import-Module Az.Accounts

Login-AzAccount

New-AzResourceGroup -Name $ResouceGroup -Location $Location

New-AzResourceGroupDeployment -ResourceGroupName $ResouceGroup -TemplateFile $TemplateFilePath_master -TemplateParameterFile $TemplateFileParametersPath_master
New-AzResourceGroupDeployment -ResourceGroupName $ResouceGroup -TemplateFile $TemplateFilePath_worker01 -TemplateParameterFile $TemplateFileParametersPath_worker01
New-AzResourceGroupDeployment -ResourceGroupName $ResouceGroup -TemplateFile $TemplateFilePath_worker02 -TemplateParameterFile $TemplateFileParametersPath_worker02
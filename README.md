# AI-3026 Azure AI Foundry - Agent Service Infrastructure

This template could be used as a starting point for Azure AI Foundry - AI Agent Service deployment, which is related to Microsoft Learn AI-3026 ILT. 

This scenario is part of the broader Azure Demo Catalog, available at [Trainer-Demo-Deploy](https://aka.ms/trainer-demo-deploy). 

## ⬇️ Installation
- [Azure Developer CLI - AZD](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/install-azd)
    - When installing AZD, the above the following tools will be installed on your machine as well, if not already installed:
        - [GitHub CLI](https://cli.github.com)
        - [Bicep CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)
    - You need Owner or Contributor access permissions to an Azure Subscription to  deploy the scenario.

## 🚀 Cloning the scenario in 4 steps:

1. Create a new folder on your machine.
```
mkdir tdd-azd-ai3026proj
```
2. Next, navigate to the new folder.
```
cd tdd-azd-ai3026proj
```
3. Next, run `azd init` to initialize the deployment.
```
azd init -t petender/tdd-azd-ai3026proj
```
4. Copy the starter template into its own directory and modify the template.
```
Update the main.bicep and resources.bicep with your own resource information
```
5. Update the azure.yaml metadata
```
Update the name and metadata.template parameters in the azure.yaml, with your preferred scenario name, e.g. tdd-azd-trafficmgr
```




 

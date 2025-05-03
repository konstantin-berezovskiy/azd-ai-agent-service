// Parameters
param location string
param hubName string
param projectName string
param aiServiceName string

// (Optional) Storage Account for Hub artifacts
resource storageAcct 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: '${toLower(hubName)}stor'    // simplistic naming; ensure uniqueness in real use
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    publicNetworkAccess: 'Enabled'   
  }
}

// (Optional) Key Vault for Hub secrets
resource hubKeyVault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: '${hubName}-kv'
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: { name: 'standard' }
    accessPolicies: []  // (could add policies for hub identity after hub created)
    publicNetworkAccess: 'Enabled'   
  }
}

// (Optional) App Insights for monitoring (Log Analytics workspace omitted for brevity)
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${hubName}-ai'
  location: location
  properties: {
    Application_Type: 'web'
  }
}

// Azure AI Services Account (Cognitive Services multi-service)
resource aiService 'Microsoft.CognitiveServices/accounts@2024-10-01-preview' = {
  name: aiServiceName
  location: location
  kind: 'AIServices'                                   // Multi-service AI account[1](https://learn.microsoft.com/en-us/azure/ai-foundry/concepts/architecture)
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    // customSubDomainName helps form the endpoint URL; use a unique value
    customSubDomainName: toLower(uniqueString(resourceGroup().id, aiServiceName))
    apiProperties: {
      statisticsEnabled: false
    }
  }
}

// Azure AI Hub (Foundry Hub)
resource hub 'Microsoft.MachineLearningServices/workspaces@2024-04-01-preview' = {
  name: hubName
  location: location
  kind: 'Hub'                                          // Create a Hub resource[1](https://learn.microsoft.com/en-us/azure/ai-foundry/concepts/architecture)
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    friendlyName: hubName
    description: 'AI Foundry Hub deployed via Bicep'
    storageAccount: storageAcct.id                     // Attach Storage account[2](https://blog.timja.dev/azure-ai-studio-with-terraform/)
    keyVault: hubKeyVault.id                           // Attach Key Vault[2](https://blog.timja.dev/azure-ai-studio-with-terraform/)
    applicationInsights: appInsights.id                // Attach App Insights (optional)
    // (If omitted, Azure can auto-create required ones, but we provided them)
  }
}

// Azure AI Project (Foundry Project)
resource project 'Microsoft.MachineLearningServices/workspaces@2024-04-01-preview' = {
  name: projectName
  location: location
  kind: 'Project'                                      // Create a Project resource[1](https://learn.microsoft.com/en-us/azure/ai-foundry/concepts/architecture)
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    friendlyName: projectName
    description: 'AI Foundry Project under the Hub'
    hubResourceId: hub.id                              // Link to parent Hub[2](https://blog.timja.dev/azure-ai-studio-with-terraform/)
  }
}

// Connection from Hub to AI Services
resource aiConnection 'Microsoft.MachineLearningServices/workspaces/connections@2024-04-01-preview' = {
  name: aiServiceName
  parent: hub                                          // This connection is within the Hub[2](https://blog.timja.dev/azure-ai-studio-with-terraform/)
  properties: {
    category: 'AIServices'                             // Connecting an Azure AI Services resource[2](https://blog.timja.dev/azure-ai-studio-with-terraform/)
    target: aiService.properties.endpoint              // Use the AI service endpoint URL[2](https://blog.timja.dev/azure-ai-studio-with-terraform/)
    authType: 'AAD'                                    // Use Azure AD auth (managed identity)[2](https://blog.timja.dev/azure-ai-studio-with-terraform/)
    isSharedToAll: true                                // Share with all projects in the Hub[2](https://blog.timja.dev/azure-ai-studio-with-terraform/)
    metadata: {
      ApiType: 'Azure'
      ResourceId: aiService.id                         // Azure Resource ID of the AI Services account[2](https://blog.timja.dev/azure-ai-studio-with-terraform/)
    }
  }
}

// Role Assignment: Grant Hub identity access to AI Services (Cognitive Services User role)
resource hubToAIServiceAccess 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(hub.id, aiService.id, 'CognitiveServicesUser')  // generate unique GUID for assignment
  scope: aiService                                      // scope is the AI Services resource
  properties: {
    roleDefinitionName: 'Cognitive Services OpenAI User' // built-in role for accessing cognitive endpoints
    principalId: hub.identity.principalId                // Hub's managed identity object ID
    principalType: 'ServicePrincipal'
  }
}

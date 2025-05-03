targetScope = 'resourceGroup'

param instanceId string

param location string = resourceGroup().location

param modelName string 
param modelVersion string 
param deploymentName string
param capacity int 
param deploymentType string 


var hubName = length('hub${instanceId}') > 20 ? substring('hub${instanceId}', 0, 20) : 'hub${instanceId}'
var projectName = length('proj${instanceId}') > 20 ? substring('proj${instanceId}', 0, 20) : 'proj${instanceId}'
var aiServiceName = length('aisrv${instanceId}') > 20 ? substring('aisrv${instanceId}', 0, 20) : 'aisrv${instanceId}'

var strageName = length('st${instanceId}') > 20 ? substring('st${instanceId}', 0, 20) : 'st${instanceId}'
var keyVaultName = length('kv${instanceId}') > 20 ? substring('kv${instanceId}', 0, 20) : 'kv${instanceId}'


resource aiservice 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: aiServiceName
  location: location
  kind: 'AIServices'
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
  properties: {
    customSubDomainName: aiServiceName
    publicNetworkAccess: 'Enabled'
  }

  resource deploy 'deployments@2025-04-01-preview' = {
    name: deploymentName
    properties: {
      model: {
        format: 'OpenAI'
        name: modelName
        version: modelVersion
      }
    }
    sku: {
      name: deploymentType
      capacity: capacity
    }    
  }

}

resource storage 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: strageName   // simplistic naming; ensure uniqueness in real use
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2024-12-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
    accessPolicies: []  // (could add policies for hub identity after hub created)
    publicNetworkAccess: 'Enabled'
  }
}

resource hub 'Microsoft.MachineLearningServices/workspaces@2025-01-01-preview' = {
  name: hubName
  location: location

  kind: 'Hub'
  properties: {
    description: hubName
    friendlyName: hubName
    storageAccount: storage.id
    keyVault: keyVault.id
  }

  identity: {
    type: 'SystemAssigned'
  }

  resource hubConnection 'connections@2025-01-01-preview' = {
    name: 'hubConnection'
    properties: {
      category: 'AIServices'
      target: aiservice.properties.endpoint
      authType: 'ApiKey'
      credentials: {
        key: aiservice.listKeys().key1
      }
      isSharedToAll: true
      metadata: {
        ApiType: 'Azure'
        ResourceId: aiservice.id
      }
    }
  }
}

resource project 'Microsoft.MachineLearningServices/workspaces@2025-01-01-preview' = {
  name: projectName
  location: location
  kind: 'Project'
  
  properties: {
    description: projectName
    friendlyName: projectName
    hubResourceId: hub.id
  }

  identity: {
    type: 'SystemAssigned'
  }

}

output projconnstring string = '${location}.api.azureml.ms;${subscription().subscriptionId};${resourceGroup().name};${projectName}'
output aiagentmodelname string = deploymentName

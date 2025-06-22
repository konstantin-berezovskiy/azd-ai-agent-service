[comment]: <> (please keep all comment items at the top of the markdown file)
[comment]: <> (please do not change the ***, as well as <div> placeholders for Note and Tip layout)
[comment]: <> (please keep the ### 1. and 2. titles as is for consistency across all demoguides)
[comment]: <> (section 1 provides a bullet list of resources + clarifying screenshots of the key resources details)
[comment]: <> (section 2 provides summarized step-by-step instructions on what to demo)


[comment]: <> (this is the section for the Note: item; please do not make any changes here)
***
### Azure AI Foundry with AI Agent Service

This demo scenario predeploys all necessary Azure AI building blocks to showcase how to set up an Azure AI Agent Service within Azure AI Foundry. The Agent Service gets created as part of the deployment, where you can jump right into adding Knowledge and Actions.

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/AIFoundrywithAgent.png?raw=true" alt="Azure AI Foundry with Agent Service" style="width:70%;">
<br></br>

<div style="background: lightgreen; 
            font-size: 14px; 
            color: black;
            padding: 5px; 
            border: 1px solid lightgray; 
            margin: 5px;">

**Note:** Below demo steps should be used **as a guideline** for doing your own demos. Please consider contributing to add additional demo steps.
</div>

[comment]: <> (this is the section for the Tip: item; consider adding a Tip, or remove the section between <div> and </div> if there is no tip)

***
### 1. What Resources are getting deployed
<add a one-paragraph lengthy description of what the scenario is about, and what is getting deployed>

The following resources are getting deployed:

* RG-<azd-env-name> : The Resource Group using the AZD env name you specified
* aisrvsora%uniquestring% : Azure AI Foundry Service for AI Agent Service
* hubsora%uniquestring%: Azure AI Foundry Hub for AI Agent Service
* projsora%uniquestring% : Azure AI Foundry Project for AI Agent Service
* kvsora%uniquestring%: Key Vault Resource
* stsora%uniquestring%: Storage Account which is used by AI Foundry

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/ResourceGroup_Overview.png" alt="Resource Group Overview" style="width:70%;">
<br></br>


### 2. What can I demo from this scenario after deployment

Assumption for this demo is that your learner is already familiar with AI Foundry navigation, as well as the Hub & Project concepts. If not, spend some time on explaining the topology first, before moving into this specific demo scenario.

1. From the Azure Portal, navigate to the scenario Resource Group, and **open the Azure AI Foundry resource object**. Highlight that this is similar to other Azure Resources, allowing you to define Networking settings, Defender for Cloud security integration, and show the Keys and Endpoints, emphasizing those are the usual object parameters a developer would need to interact with the service from an application perspective.

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/AIFoundry_Resource.png" alt="Azure AI Foundry Resource view" style="width:70%;">
<br></br>

1. Next, **emphasize** the actual management of the service, integration with all common AI building blocks such as LLM Models, Machine Learning, etc... is not managed from within the Azure Portal, but from the **Azure AI Foundry Portal**. Open the AI Foundry Portal by clicking the "Go to Azure AI Foundry Portal" button.

Mention admins or developers can navigate directly to this portal from **https://ai.azure.com**

1. From within the AI Foundry Portal, navigate to the "top" of the portal, by clicking the **Azure AI Foundry** title in the upper left corner. 

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/AIFoundry_top.png" alt="Azure AI Foundry in AI Foundry Portal" style="width:70%;">
<br></br>

1. Depending on your setup, it might show a list of already deployed hubs & projects, or show an empty list. This list is using some cache, so it might not be 100% in line with your actual active resources, but could still show resources which got deleted already. To update this view to the **correct state**, select **view all resources**.

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/AIFoundry_allresourcesview.png" alt="Azure AI Foundry Resources view" style="width:70%;">
<br></br>

1. As you can see from my example, this 'all resources view' is different from the previous screenshot, now showing the **actively deployed resources** for this scenario.

1. From the list of resources, **select** the **hub** project, to open the **Hub details** within the **AI Foundry Management Center**. 

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/AIFoundry_Hubview.png" alt="Azure AI Foundry Hub view" style="width:70%;">
<br></br>

1. From the **Management Center**, navigate to **Connected Resources** for the selected Hub. This list shows the different Service Connections already available, from the AI Hub into other Azure Resources, such as Azure Blob Storage, AI Service and also the Azure Open AI Service which we need later on. 

Take note of the name of the OpenAI Service Connection (hubConnection_aoai)

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/AIFoundry_Hub_ConnectedResources.png" alt="Azure AI Foundry Hub Connected Resources" style="width:70%;">
<br></br>

1. From the **Management Center**, click **Go to Project**, to navigate to the AI Foundry Project within the Hub.

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/AIFoundry_Projectview.png" alt="Azure AI Foundry Project view" style="width:70%;">
<br></br>

1. From the Project view, navigate to **Agents** under the **Build and customize** section.

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/AIFoundry_Project_Agents.png" alt="Azure AI Foundry Agents" style="width:70%;">
<br></br>

1. You are asked to **Select an Azure OpenAI resource**; from the list, select **hubConnection_aoai**, and confirm by clicking **Let's Go**.   


1. Notice an Agent Service got already deployed as part of the template, called **Agent123** where 123 is a unique number in your AI Foundry. 

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/AIFoundry_Agent.png" alt="Azure AI Foundry Agents" style="width:70%;">
<br></br>

1. By **selecting** the Agent, the **Agent Setup** blade appears. It shows the Agent ID, Agent Name (which can be modified), which AI Foundry Hub it is attached to, and what OpenAI Model Deployment it is linked to:

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/AIFoundry_Agent_Setup.png" alt="Azure AI Foundry Agents Setup" style="width:70%;">
<br></br>

1. Next, provide a **clear instruction** of what your agent's purpose is. The more specific the description, the more accurate the chat completion responses will be. For example, this is description you could use to build an **Microsoft Ignite Conference Agent**, which would help (potential) attendees of the conference with their questions.

```
You are a virtual assistant for the Microsoft Ignite Annual Conference. You assist actual and potential visitors of this conference with any possible question they might have related to the conference. Sample questions you can expect are e.g. date and location of the conference, session agenda with details, speaker overview with details, venue specific information, what hotels are available near the area, cost for a ticket and alike. Be specific, professionally polite and apologize if you are not able to answer the question.
```

1. **Optionally**, you can also provide a description; this will not influence the behavior of the Agent itself. For the same sample scenario, you could use the following:

```
You are a virtual assistant for the Microsoft Ignite Annual Conference, answering questions.
```

1. Right now, the Agent technically "works", and would try to respond to questions, based on the trained information from the LLM. To experiment with this, click **Try in the Playground**. Once there, provide a sample question to the Agent:

```
what is the Microsoft Ignite conference?
```

1. Wait for the Agent to respond. The response should look something similar to below:

```
The Microsoft Ignite conference is a premier annual event organized by Microsoft that brings together IT professionals, developers, decision-makers, and technology enthusiasts from around the world. The conference serves as a platform for showcasing the latest innovations in Microsoft's technologies, cloud computing, artificial intelligence, cybersecurity, productivity tools, and other solutions. It is highly regarded for delivering:

Keynotes from Microsoft Leadership: These typically include addresses from executives like Microsoft’s CEO Satya Nadella, and other senior leaders who provide insights into the future of technology.

Breakout Sessions: In-depth technical workshops and presentations tailored for different skill levels and areas of interest, such as Azure, Microsoft 365, Power Platform, Dynamics 365, and more.

Hands-On Labs: Opportunities to get practical experience with Microsoft products and technologies under expert guidance.

Networking: The conference connects attendees with Microsoft engineers, MVPs, colleagues, and peers in the industry.

Exclusive Insights: Attendees can dive into upcoming features, updates, and strategies for implementation from Microsoft.

Microsoft Ignite offers both in-person and virtual experiences, making it accessible to participants worldwide. Details like conference dates, location, agenda, ticket pricing, and accommodations are updated yearly.

Let me know if you would like specific details about the next Microsoft Ignite event!
```

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/Ignite_Agent_Response.png" alt="Ignite Agent Response" style="width:70%;">
<br></br>


1. As you can see, the information is not wrong, but it might not be able to respond to more specific questions, such as 
```
where is the conference location
```

as it can only rely on the information it got trained on, which will be out-of-date, and not helping the conference attendees. 

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/Ignite_Agent_Response2.png" alt="Ignite Agent Response" style="width:70%;">
<br></br>

1. To fix this LLM limitation, it is time to add **knowledge**, which the Agent will use when formulating a response to prompts. From the **Agent side blade**, navigate to **Knowledge** and click **+ Add**. 

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/Agent_Knowledge_Options.png" alt="Ignite Agent Response" style="width:70%;">
<br></br>

1. There are several different options to add more information to the Agent, for example uploading files, SharePoint sites, Azure Fabric, or Bing Search integration which uses web data. For our example, we will use an offline **Ignite_Flyer_Sample.docx**, which you can find in the demoguide source folder of this AZD-repo. Select **Files / Upload Local Files**.

Use the following settings in the **Adding Files** popup window:
- Vector Store : **Create a new vector store**
- Name: **Ignite_AgentVectorStore_58631**
- Add Files: **Upload Local**, and upload the **Ignite_Flyer_Sample.docx**

<img src="https://raw.githubusercontent.com/petender/azd-ai-agent-service/refs/heads/main/demoguide/Agent_Files.png" alt="Upload Files" style="width:70%;">
<br></br>

1. **Click Upload & Save** and wait for the document upload status to complete. You are automatically returned to the Agent Playground when done. From the chat pane, ask a new prompt:

``` 
When and where exactly is the next edition of the conference
```

Where it will now nicely respond with the upcoming event date, week of November 17 2025 in Chicago.



[comment]: <> (this is the closing section of the demo steps. Please do not change anything here to keep the layout consistant with the other demoguides.)
<br></br>
***
<div style="background: lightgray; 
            font-size: 14px; 
            color: black;
            padding: 5px; 
            border: 1px solid lightgray; 
            margin: 5px;">

**Note:** This is the end of the current demo guide instructions.
</div>





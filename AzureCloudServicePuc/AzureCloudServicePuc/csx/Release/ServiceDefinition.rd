<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="AzureCloudServicePuc" generation="1" functional="0" release="0" Id="127f4a56-df12-4a83-a195-5d12837cb617" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="AzureCloudServicePucGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="Api:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/LB:Api:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="Api:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/MapApi:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="ApiInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/MapApiInstances" />
          </maps>
        </aCS>
        <aCS name="Processa Pedidos:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/MapProcessa Pedidos:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="Processa PedidosInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/MapProcessa PedidosInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:Api:Endpoint1">
          <toPorts>
            <inPortMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/Api/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapApi:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/Api/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapApiInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/ApiInstances" />
          </setting>
        </map>
        <map name="MapProcessa Pedidos:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/Processa Pedidos/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapProcessa PedidosInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/Processa PedidosInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="Api" generation="1" functional="0" release="0" software="C:\Users\aluno.PUCMINAS\documents\visual studio 2015\Projects\AzureCloudServicePuc\AzureCloudServicePuc\csx\Release\roles\Api" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="-1" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;Api&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;Api&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;Processa Pedidos&quot; /&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/ApiInstances" />
            <sCSPolicyUpdateDomainMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/ApiUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/ApiFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
        <groupHascomponents>
          <role name="Processa Pedidos" generation="1" functional="0" release="0" software="C:\Users\aluno.PUCMINAS\documents\visual studio 2015\Projects\AzureCloudServicePuc\AzureCloudServicePuc\csx\Release\roles\Processa Pedidos" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaWorkerHost.exe " memIndex="-1" hostingEnvironment="consoleroleadmin" hostingEnvironmentVersion="2">
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;Processa Pedidos&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;Api&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;Processa Pedidos&quot; /&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/Processa PedidosInstances" />
            <sCSPolicyUpdateDomainMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/Processa PedidosUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/Processa PedidosFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="ApiUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyUpdateDomain name="Processa PedidosUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="ApiFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyFaultDomain name="Processa PedidosFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="ApiInstances" defaultPolicy="[1,1,1]" />
        <sCSPolicyID name="Processa PedidosInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="47110e0b-1660-4948-8fdd-521994700732" ref="Microsoft.RedDog.Contract\ServiceContract\AzureCloudServicePucContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="884b384c-5a28-4c0d-a385-c1a076cc7107" ref="Microsoft.RedDog.Contract\Interface\Api:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/AzureCloudServicePuc/AzureCloudServicePucGroup/Api:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>
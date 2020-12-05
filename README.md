# AzureEx

An Azure API client.

## Current state

Due to the huge number of Azure APIs, this library only provides a small part of the API. For similar reasons, models and model fields are also very lacking!

Therefore, I very much need your contributions to finally complete this library. Just like me, just submit the part you need!

## Installation

Add Telegex to your mix.exs dependencies:

```elixir
def deps do
  [{:azure_ex, "~> 0.1.0-rc.0"}]
end
```

Run the mix deps.get command to install.

## Configuration

Obtain the necessary parameters for applying for Token through [this article](https://mauridb.medium.com/calling-azure-rest-api-via-curl-eb10a06127), and fill in the following template configuration types:

```elixir
config :azure_ex,
  tenant: "<Tenant ID>",
  client_id: "<App ID>",
  client_secret: "<Password>"
```

You can also learn about the role and creation process of the service principal based on this [official document](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli).

## Usage

We use a sample code to show how to create a virtual machine. Please prepare the values of some variables, including the subscription ID of your Azure account, the name of the resource group, and your local SSH public key data.

```elixir
def create_virtual_machine() do
  alias AzureEx.Model.{
    VirtualNetworks,
    Subnets,
    PublicIPAddress,
    NetworkInterfaces,
    VirtualMachines
  }

  # Initialize some variables.
  location = "eastasia"
  subscription_id = "<Subscription ID>"
  resource_group = "<Resource group>"
  os_username = "ubuntu"
  vm_name = "ubuntu20-test"
  vm_size = "Standard_B1s"
  ssh_public_key_data = "<SSH public key data>"

  # Create a virtual network.
  virutal_network_create = %VirtualNetworks.CreateOrUpdate{
    location: location,
    properties: %VirtualNetworks.CreateOrUpdate.Properties{
      addressSpace: %VirtualNetworks.CreateOrUpdate.AddressSpace{
        addressPrefixes: ["10.0.0.0/16"]
      }
    }
  }

  {:ok, _} =
    AzureEx.create_or_update_virtual_networks(
      subscription_id,
      resource_group,
      "#{resource_group}-vnet-#{location}",
      data: virutal_network_create
    )

  # Create a default subnet.
  subnet_create = %Subnets.CreateOrUpdate{
    name: "default",
    properties: %Subnets.CreateOrUpdate.Properties{
      addressPrefix: "10.0.0.0/16"
    }
  }

  AzureEx.create_or_update_subnets(
    subscription_id,
    resource_group,
    "#{resource_group}-vnet-#{location}",
    "default",
    data: subnet_create
  )

  # Create a public IP address.
  public_ip_address_create = %PublicIPAddress.CreateOrUpdate{
    location: location,
    properties: %PublicIPAddress.CreateOrUpdate.Properties{
      publicIPAddressVersion: "ipv4"
    }
  }

  {:ok, public_ip_address} =
    AzureEx.create_or_update_public_ip_address(
      subscription_id,
      resource_group,
      "#{vm_name}-ip",
      data: public_ip_address_create
    )

  # Create a network interface.
  network_interface_create = %NetworkInterfaces.CreateOrUpdate{
    location: location,
    properties: %NetworkInterfaces.CreateOrUpdate.Properties{
      ipConfigurations: [
        %NetworkInterfaces.CreateOrUpdate.NetworkInterfaceIPConfiguration{
          name: "#{vm_name}-ic",
          properties:
            %NetworkInterfaces.CreateOrUpdate.NetworkInterfaceIPConfiguration.Properties{
              subnet: %NetworkInterfaces.CreateOrUpdate.Subnet{
                id:
                  "/subscriptions/#{subscription_id}/resourceGroups/#{resource_group}/providers/Microsoft.Network/virtualNetworks/#{
                    resource_group
                  }-vnet-#{location}/subnets/default"
              },
              publicIPAddress: %NetworkInterfaces.CreateOrUpdate.PublicIPAddress{
                id: public_ip_address[:id]
              }
            }
        }
      ]
    }
  }

  {:ok, network_interface} =
    AzureEx.create_or_update_network_interfaces(
      subscription_id,
      resource_group,
      "#{vm_name}-ni",
      data: network_interface_create
    )

  # Create a virtual machine.
  virtual_machine_create = %VirtualMachines.CreateOrUpdate{
    location: location,
    properties: %VirtualMachines.CreateOrUpdate.Properties{
      hardwareProfile: %VirtualMachines.CreateOrUpdate.HardwareProfile{
        vmSize: vm_size
      },
      networkProfile: %VirtualMachines.CreateOrUpdate.NetworkProfile{
        networkInterfaces: [
          %VirtualMachines.CreateOrUpdate.NetworkInterfaceReference{
            id: network_interface[:id]
          }
        ]
      },
      storageProfile: %VirtualMachines.CreateOrUpdate.StorageProfile{
        osDisk: %VirtualMachines.CreateOrUpdate.OSDisk{
          name: "#{vm_name}-disk",
          createOption: "FromImage"
        },
        imageReference: %VirtualMachines.CreateOrUpdate.ImageReference{
          offer: "0001-com-ubuntu-server-focal",
          publisher: "canonical",
          sku: "20_04-lts",
          version: "latest"
        }
      },
      osProfile: %VirtualMachines.CreateOrUpdate.OSProfile{
        adminUsername: os_username,
        computerName: vm_name,
        linuxConfiguration: %VirtualMachines.CreateOrUpdate.LinuxConfiguration{
          ssh: %VirtualMachines.CreateOrUpdate.SshConfiguration{
            publicKeys: [
              %VirtualMachines.CreateOrUpdate.SshPublicKey{
                path: "/home/ubuntu/.ssh/authorized_keys",
                keyData: ssh_public_key_data
              }
            ]
          }
        }
      }
    }
  }

  {:ok, _} =
    AzureEx.create_or_update_virtual_machines(
      subscription_id,
      resource_group,
      "#{vm_name}-vm",
      data: virtual_machine_create
    )
end
```

Call this function:

```elixir
iex> AzureEx.create_virtual_machine()
{:ok, %{...}}
```

Visit https://portal.azure.com/ to view the virtual machine and associated resources just created.

## Documentation

All necessary parameters in the API are the path parameters of the URL. In addition, each API has an optional parameter.

The `options` parameter in all APIs:

- `data`: Create or update the required data model, the type is `map`. It will eventually be converted into a JSON string and sent as the request body.
- `params`: A list of keywords, used as query parameters to construct the complete URL of the API. For example, you can override the default value of the `api-version` parameter: `callAPI(arg1, arg2, params: ["api-version": "2010-06-01"])`

## Development

This library uses a well-designed macro to parse the original URI in the Azure document during compilation and create the corresponding API, so you only need to copy it (via the Copy it button in the document page) to add a new API. E.g:

```
defendpoint(
  "ListByResourceGroupResources",
  "GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/resources?api-version=2020-06-01"
)
```

The `defendpoint/2` call needs to be defined in the `lib/azure.ex` file.

In addition, APIs involved in creating or updating also include data models. You should define them under the `lib/model` directory.

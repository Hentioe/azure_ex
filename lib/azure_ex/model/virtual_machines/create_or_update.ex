defmodule AzureEx.Model.VirtualMachines.CreateOrUpdate do
  @moduledoc false

  use TypedStruct

  alias __MODULE__.{
    Properties,
    NetworkInterfaceReference,
    OSDisk,
    StorageProfile,
    LinuxConfiguration,
    SshConfiguration,
    SshPublicKey
  }

  typedstruct module: HardwareProfile do
    @derive Jason.Encoder

    field :vmSize, String.t()
  end

  typedstruct module: ImageReference do
    @derive Jason.Encoder

    field :offer, String.t()
    field :publisher, String.t()
    field :sku, String.t()
    field :version, String.t()
  end

  typedstruct module: OSDisk do
    @derive Jason.Encoder

    field :name, String.t()
    field :createOption, String.t()
  end

  typedstruct module: StorageProfile do
    @derive Jason.Encoder

    field :imageReference, ImageReference.t()
    field :osDisk, OSDisk.t()
  end

  typedstruct module: NetworkInterfaceReference do
    @derive Jason.Encoder

    field :id, String.t()
  end

  typedstruct module: NetworkProfile do
    @derive Jason.Encoder

    field :networkInterfaces, [NetworkInterfaceReference.t()]
  end

  typedstruct module: SshPublicKey do
    @derive Jason.Encoder

    field :path, String.t()
    field :keyData, String.t()
  end

  typedstruct module: SshConfiguration do
    @derive Jason.Encoder

    field :publicKeys, [SshPublicKey.t()]
  end

  typedstruct module: LinuxConfiguration do
    @derive Jason.Encoder

    field :ssh, SshConfiguration.t()
  end

  typedstruct module: OSProfile do
    @derive Jason.Encoder

    field :adminPassword, String.t()
    field :adminUsername, String.t()
    field :computerName, String.t()
    field :linuxConfiguration, LinuxConfiguration.t()
  end

  typedstruct module: Properties do
    @derive Jason.Encoder

    field :hardwareProfile, HardwareProfile.t()
    field :networkProfile, NetworkProfile.t()
    field :storageProfile, StorageProfile.t()
    field :osProfile, OSProfile.t()
  end

  typedstruct do
    @derive Jason.Encoder

    field :location, String.t()
    field :properties, Properties.t(), default: %Properties{}
  end
end

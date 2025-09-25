provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_virtual_machine_scale_set" "example" {
  name                = "example-vmss"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard_DS1_v2"
  instances           = 3

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "vmss"
    admin_username = "adminuser"

    admin_ssh_key {
      username   = "adminuser"
      public_key = file("~/.ssh/id_rsa.pub")
    }
  }

  network_profile {
    name    = "example-nic"
    primary = true
  }

  tags = {
    environment = "dev"
  }
}

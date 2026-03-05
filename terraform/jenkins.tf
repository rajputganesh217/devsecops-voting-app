resource "azurerm_linux_virtual_machine" "jenkins_vm" {

  name                = "jenkins-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B2as_v2"

  admin_username = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.jenkins_nic.id
  ]

  admin_ssh_key {

    username   = "azureuser"
    public_key = file("/home/ganesh/.ssh/id_rsa.pub")
  }

  os_disk {

    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }

  source_image_reference {

    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"

  }

  custom_data = base64encode(file("../scripts/jenkins-install.sh"))

}

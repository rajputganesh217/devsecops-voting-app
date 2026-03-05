resource "azurerm_public_ip" "jenkins_ip" {

name                = "jenkins-public-ip"
location            = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name

allocation_method = "Static"
sku               = "Standard"

}

resource "azurerm_network_security_group" "jenkins_nsg" {

name                = "jenkins-nsg"
location            = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name

security_rule {


name                       = "allow-ssh"
priority                   = 1000
direction                  = "Inbound"
access                     = "Allow"
protocol                   = "Tcp"
source_port_range          = "*"
destination_port_range     = "22"
source_address_prefix      = "*"
destination_address_prefix = "*"


}

security_rule {

name                       = "allow-jenkins"
priority                   = 1010
direction                  = "Inbound"
access                     = "Allow"
protocol                   = "Tcp"
source_port_range          = "*"
destination_port_range     = "8080"
source_address_prefix      = "*"
destination_address_prefix = "*"

}

}

resource "azurerm_network_interface" "jenkins_nic" {

name                = "jenkins-nic"
location            = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name

ip_configuration {

name                          = "internal"
subnet_id                     = azurerm_subnet.aks_subnet.id
private_ip_address_allocation = "Dynamic"
public_ip_address_id          = azurerm_public_ip.jenkins_ip.id

}

}

resource "azurerm_network_interface_security_group_association" "jenkins_nsg_assoc" {

network_interface_id      = azurerm_network_interface.jenkins_nic.id
network_security_group_id = azurerm_network_security_group.jenkins_nsg.id

}

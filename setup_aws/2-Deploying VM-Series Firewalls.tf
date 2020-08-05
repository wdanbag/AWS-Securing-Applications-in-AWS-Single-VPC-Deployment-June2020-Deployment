/* Deploying a VM-Series Instance on AWS */
//The majority of this is taken care of via bootstrap and vm-series modules
    # 2.1 Create the VM-Series Firewalls
    # 2.2 Create Elastic Network Interfaces for the VM-Series Firewalls
    # 2.3 Attach the Interfaces to the Firewalls
    # 2.4 Label the Primary Interfaces for the VM-Series Instance
    # 2.5 Create Elastic IP Addresses for the VM-Series Firewall
    # 2.6 Log in to the VM-Series Firewall
    # 2.7 License the VM-Series Firewalls



////////////////////////////////////////////////////////////////////////////////
// Create a BootStrap S3 Bucket, IAM access role and firewall for ngfw_inbound_a
////////////////////////////////////////////////////////////////////////////////

module "s3bucket_inbound_a" {
  source = "./create_bootstrap_bucket/"
  bucket = var.s3bootstrapbuckets.s3bucket_a
  init_cfg_source = "bootstrap_files/init-cfg_a.txt"
  license_content = var.vm_series_authcodes.s3bucket_a
}

//Create the NGFW
module "ngfw_a" {
  source = "./vm-series/"

  name = var.vmseries_a.namee
  aws_key = var.aws_key

  instance_type           = var.fw_instance_type
  ngfw_versionn            = var.ngfw_version
  ngfw_license_typee       = var.ngfw_license_type
  trust_subnet_id         =  aws_subnet.FW_2a.id
  trust_security_group_id =  aws_security_group.Firewall_Private.id
  trustfwip               =  var.vmseries_a.private_ip_address

  untrust_subnet_id         = aws_subnet.Public_2a.id
  untrust_security_group_id = aws_security_group.Firewall_Public.id
  untrustfwip               = var.vmseries_a.public_ip_address

  management_subnet_id         = aws_subnet.Mgmt_2a.id
  management_security_group_id = aws_security_group.Firewall_Mgmt.id
  management_ip                 = var.vmseries_a.managment_ip_address

  bootstrap_profile = "${module.s3bucket_inbound_a.iam_profile}"
  bootstrap_s3bucket = var.s3bootstrapbuckets.s3bucket_a

  aws_region = var.aws_region
}
output "Inbound-FW-1-MGMT" {
  value = "Access the firewall MGMT via:  https://${module.ngfw_a.eip_mgmt}"
}


////////////////////////////////////////////////////////////////////////////////
// Create a BootStrap S3 Bucket, IAM access role and firewall for ngfw_inbound_b
////////////////////////////////////////////////////////////////////////////////
module "s3bucket_inbound_b" {
  source = "./create_bootstrap_bucket/"
  bucket = var.s3bootstrapbuckets.s3bucket_b
  init_cfg_source = "bootstrap_files/init-cfg_b.txt"
  license_content = var.vm_series_authcodes.s3bucket_b
}

//Create the NGFW
module "ngfw_b" {
  source = "./vm-series/"

  name = var.vmseries_b.namee
  aws_key = var.aws_key

  instance_type           = var.fw_instance_type
  ngfw_versionn            = var.ngfw_version
  ngfw_license_typee       = var.ngfw_license_type
  trust_subnet_id         =  aws_subnet.FW_2b.id
  trust_security_group_id =  aws_security_group.Firewall_Private.id
  trustfwip               =  var.vmseries_b.private_ip_address

  untrust_subnet_id         = aws_subnet.Public_2b.id
  untrust_security_group_id = aws_security_group.Firewall_Public.id
  untrustfwip               = var.vmseries_b.public_ip_address

  management_subnet_id         = aws_subnet.Mgmt_2b.id
  management_security_group_id = aws_security_group.Firewall_Mgmt.id
  management_ip                 = var.vmseries_b.managment_ip_address

  bootstrap_profile = "${module.s3bucket_inbound_b.iam_profile}"
  bootstrap_s3bucket = var.s3bootstrapbuckets.s3bucket_b

  aws_region = var.aws_region
}




output "Inbound-FW-2-MGMT" {
  value = "Access the firewall MGMT via:  https://${module.ngfw_b.eip_mgmt}"
}


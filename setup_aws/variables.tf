////////////////////////////////////////////////////////////
//This section should be verified and modified accordingly.
////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////
//The following items are not in this file but must or should as noted be changed in other files
//In files:
//  bootstrap_files/init-cfg_a.txt
//  bootstrap_files/init-cfg_b.txt
//must change the following items:
//  panorama-server  (Primary Panorama Server)
//  panorama-server-2 (Secondary Panorama Server)
//  vm-auth-key (Change to your generated vm-auth-key - see https://docs.paloaltonetworks.com/vm-series/9-1/vm-series-deployment/bootstrap-the-vm-series-firewall/generate-the-vm-auth-key-on-panorama.html)
//
//Might change the following if you have altered your Panorama device group and templates outside of the guide
//  tplname 
//  dgname
//
//////////////////////////////////////////////////////////////////////////////////////////////////////


//**Must Change**
//These S3 buckets need to be uniquie so please change
variable s3bootstrapbuckets {
    default ={
        "s3bucket_a" = "xxx-singlevpc-bootstrap-bucket-a"
        "s3bucket_b" = "xxx-singlevpc-bootstrap-bucket-b"
    }
}

//**Must Change**
//You will need to enter in authcodes for each of these vm-series firewalls. 
//You may have a single code with multiple copies available and can repeat the authcode if that is the case
variable vm_series_authcodes{
    default = {
        "s3bucket_a" = ""
        "s3bucket_b" = ""
    }
}

//**Must Change**
variable aws_key {
  description = "aws_key"
  default     = "Oregon Key Pair"
}

//Change according to your IP to access the vm-series management ssh and https UI
//SSH (FW ssh console)  and HTTPS (FW web console) Access IP addresses
//This should be fairly restictive access
variable ssh_https_access_cidr_blocks {
    default = ["0.0.0.0/0"]
}


//Panorama Setting which need to be changed accordingly - It is expected that the Panorama is in the same account
//It must be in same account.  If different account you would need to alter this. 
//Used for creating the VPC attachment to the TGW
variable vpc_panorama_managment{
    description = "Management VPC id where Panorama is located."
    default ={
        "cidr" = "10.255.0.0/16"
        "vpc_id"     = "vpc-XXXXXX"
        "subnet_management_id_2a" = "subnet-xxxxxxx"
        "subnet_management_id_2b" = "subnet-xxxxxxxx"
        "panorama_management_route_table" = "rtb-xxxxxx"
        "panorama_sg" = "sg-xxxxxxxxx"

    }
}


variable aws_region {
  description = "AWS Region for deployment"
  default     = "us-west-2"
}

variable fw_instance_type {
  default = "m5.xlarge"
}

//Change according to your license type.  Has only been tested with byol
variable ngfw_license_type {
  default = "byol"
}

//Change according to the vm-series version required
variable ngfw_version {
  default = "9.1.3"
}

//May need to change if creating webserver instance fails with unknown ami id
//It must be an Amazon Linux 2 ami
variable amazon_linux_2_ami_id{
    default = "ami-0b1e2eeb33ce3d66f"
    }



//////////////////DO NOT CHANGE BELOW THIS LINK///////////////////////////////////////////////
//AZ for the set region
data "aws_availability_zones" "available" {
  state = "available"
}


# 1.1 Create the VPC
variable vpc_Example_Application {
    description         = "Example Application VPC"

    default = {
    "cidr"                  = "10.200.0.0/16"
    "vpc_name"              = "SVPC_Example_Application"
    "edit_dns_hostnames"    = "true"

    "Public_2a"             = "10.200.0.0/24"
    "FW_2a"                 = "10.200.1.0/24"
    "Web_server_2a"         = "10.200.2.0/24"
    "Business_2a"           = "10.200.3.0/24"
    "DB_2a"                 = "10.200.4.0/24"
    "Mgmt_2a"               = "10.200.127.0/24"

    "Public_2b"             = "10.200.128.0/24"
    "FW_2b"                 = "10.200.129.0/24"
    "Web_server_2b"         = "10.200.130.0/24"
    "Business_2b"           = "10.200.131.0/24"
    "DB_2b"                 = "10.200.132.0/24"
    "Mgmt_2b"               = "10.200.255.0/24"
   
    "Public_2a_Name"        = "SVPC_Public_2a"
    "FW_2a_Name"            = "SVPC_FW_2a"
    "Web_server_2a_Name"    = "SVPC_Web-server-2a"
    "Business_2a_Name"      = "SVPC_Business-2a"
    "DB_2a_Name"            = "SVPC_DB-2a"
    "Mgmt_2a_Name"          = "SVPC_Mgmt-2a"

    "Public_2b_Name"        = "SVPC_Public_2b"
    "FW_2b_Name"            = "SVPC_FW_2b"
    "Web_server_2b_Name"    = "SVPC_Web-server-2b"
    "Business_2b_Name"      = "SVPC_Business-2b"
    "DB_2b_Name"                 = "SVPC_DB-2b"
    "Mgmt_2b_Name"          = "SVPC_Mgmt-2b"
    
    "igw_name"              = "SVPC_Example Application IGW"
    "public_route_table"    = "SVPC_Public-Example Application"
    "mgmt_route_table"      = "SVPC_Mgmt-Example Application"
    "default_destination_route"     = "0.0.0.0/0"



    }
}
   
# 1.2 Create IP Subnets
# 1.3 Create a VPC Internet Gateway
# 1.4 Create VPC Route Tables
# 1.5 Create Security Groups
# 1.6 Configure VPC Peering


# 2.1 Create the VM-Series Firewalls
variable vmseries_a {
    
    default = {
    "managment_ip_address"      = "10.200.127.10"
    "private_ip_address"        = "10.200.1.10"
    "public_ip_address"         = "10.200.0.10"
    "namee"                      = "SVPC_vmseries-a"
    }
}

variable vmseries_b {
    
    default = {
    "managment_ip_address"      = "10.200.255.10"
    "private_ip_address"        = "10.200.129.10"
    "public_ip_address"         = "10.200.128.10"
    "namee"                      = "SVPC_vmseries-b"
    }
}


# 2.2 Create Elastic Network Interfaces for the VM-Series Firewalls
# 2.3 Attach the Interfaces to the Firewalls
# 2.4 Label the Primary Interfaces for the VM-Series Instance
# 2.5 Create Elastic IP Addresses for the VM-Series Firewall
# 2.6 Log in to the VM-Series Firewall
# 2.7 License the VM-Series Firewalls


//  5.1 Configure the Public Application Load Balancer
variable inbound_http_alb{
    default = {
        "name" = "SVPC-ExampleApplication-ALB"
    }
}

#  5.2 Configure the NAT Policy
#  5.3 Enable the XFF and URL Profile
#  5.4 Configure the Security Policy
#  5.5 Locate the Inbound Load-Balancer DNS Name

#6.3 Configure AWS Route Tables

variable private_route_table_a{
    default={
        route = "0.0.0.0/0"
        name = "SVPC_Private-a Example Application"
    }
}
variable private_route_table_b{
    default={
        route = "0.0.0.0/0"
        name = "SVPC_Private-b Example Application"
    }
}
  





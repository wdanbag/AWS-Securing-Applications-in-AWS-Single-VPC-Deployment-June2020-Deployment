# AWS-Securing-Applications-in-AWS-Single-VPC-Deployment-June2020-Deployment
The following terraform templates implement the Reference Architecture for Palo Alto Networks VM-Series Single VPC Model for June 2020 release found at https://www.paloaltonetworks.com/resources/reference-architectures/aws.

# Single VPC Topology
In the topology below everything but the Panorama Management VPC is create.  Communication between the Panorama Management VPC and Application VPC is via a created VPC Peering.
![image TransitVPC](https://user-images.githubusercontent.com/55389530/89411742-e8d6a700-d6f3-11ea-91b5-a0b66db69464.png)

# Instructions
Instructions for creating the VM-Series Single VPC Model can be found under the docs folder in Readme.docx.

# Prerequisites
The following are the prerequisites to successfully launch the templates:
1.	AWS account
2.	Clone or download the files and folders to your local machine
3.	Deploy Panorama in the same AWS account using the deployment guide, Panorama on AWS - Deployment Guide - Jun20.pdf, which can be found in the docs folder. 
4.	Generate a Panorama VM-Auth Key via the following document, https://docs.paloaltonetworks.com/vm-series/9-1/vm-series-deployment/bootstrap-the-vm-series-firewall/generate-the-vm-auth-key-on-panorama.html.
5.	If one does not already exist, generate an api key for your primary panorama instance per https://docs.paloaltonetworks.com/pan-os/9-1/pan-os-panorama-api/get-started-with-the-pan-os-xml-api/get-your-api-key.html.
6.	Ensure AWS credentials are setup for terraform to use. Here are two guides that may assist with this: 
a.	https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html 
b.	https://www.terraform.io/docs/providers/aws/index.html 
7.	BYOL licensing is used and requires two authcode(s) or an authcode that has at least two vm-series associated with it.  The authcode(s) must be registered with the support portal. The following link provides instructions on how to do this https://docs.paloaltonetworks.com/vm-series/9-1/vm-series-deployment/license-the-vm-series-firewall/register-the-vm-series-firewall.html.
8.	In addition to the Panorama AWS Elastic IP, an additional 4 Elastic IP (EIP) will be required.  By default, AWS generally only allots 5 initial Elastic IP addresses.  You can log a support case for additional EIP.  In total you will need at least 5 or if Panorama is in HA, 6.


# Support Policy
The guide in this directory and accompanied files are released under an as-is, best effort, support policy. These scripts should be seen as community supported and Palo Alto Networks will contribute our expertise as and when possible. We do not provide technical support or help in using or troubleshooting the components of the project through our normal support options such as Palo Alto Networks support teams, or ASC (Authorized Support Centers) partners and backline support options. The underlying product used (the VM-Series firewall) by the scripts or templates are still supported, but the support is only for the product functionality and not for help in deploying or using the template or script itself. Unless explicitly tagged, all projects or work posted in our GitHub repository (at https://github.com/PaloAltoNetworks) or sites other than our official Downloads page on https://support.paloaltonetworks.com are provided under the best effort policy.


# License
Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

/* This terraform template only creates the stub device group and templates for loading the singlevpc_pan_file.xml configuration */


# 3.1 Configure Device Groups
resource "panos_panorama_device_group" "AWS" {
    name = var.device_group
}
# 3.3 Create Templates
resource "panos_panorama_template" "baseline" {
    name = var.templates.Baseline_VMSeries_Settings
    
}

resource "panos_panorama_template" "network_settings" {
    name = var.templates.Single_VPC_Network_Settings
    
}

resource "panos_panorama_template_stack" "AZ_a_Stack" {
    name = var.templates.AZ_a_Stack
    templates = ["${panos_panorama_template.baseline.name}","${panos_panorama_template.network_settings.name}"]

#     depends_on = [
#     panos_panorama_template.baseline,panos_panorama_template.network_settings
#   ]

}

resource "panos_panorama_template_stack" "AZ_b_Stack" {
    name = var.templates.AZ_b_Stack
    templates = ["${panos_panorama_template.baseline.name}","${panos_panorama_template.network_settings.name}"]
}
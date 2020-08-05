////////////////////////////////////////////////////////////
//This section should be verified and modified accordingly.
////////////////////////////////////////////////////////////
variable primary_panorama{
    description = "Primary Panorama Information"
    default ={
        "ip" = "X.X.X.X" //Primary IP address of the Panorama Server
        "api_key" = "XXXXXXX" //Generated API Key

    }
}

#####################################DO NOT ALTER BELOW VARIABLES#############################
# 3.1 Configure Device Groups
 variable device_group{
     default = "SVPC_AWS"
 }

# 3.3 Create Templates

variable templates{
    default = {
        "Baseline_VMSeries_Settings"    = "SVPC_Baseline-VMSeries-Setting"
        "Single_VPC_Network_Settings"   = "SVPC_Single-VPC-Network-Setting"
        "AZ_a_Stack"                    = "SVPC_AZ-a-Stack"
        "AZ_b_Stack"                    = "SVPC_AZ-b-Stack"
        
    }
}
# AKS Landing Zone Accelerator: Creating P2S VPN using Terraform
Create a P2S VPN to access private AKS clusters locally without a need for a bastion host

## Important Note
1. This guide demonstrates how to use P2S for increased convenience to developers, yet it does NOT offer a production ready setup. For example, self-signed certificates are used for simplicity and VPN gatewaysku with no redundancy is used to reduce costs

2. There is a non-negligible cost associated with provisioning a new VPN gateway, which is ideally justifiable when being shared across a team of developers or engineers connecting to AKS. For example, the VpnGW1 SKU used in this demo costs $138.7 a month (730 hours) in West Europe. 

## Pre-requisites:
- Create an AKS landing zone following the steps in the official guide https://github.com/Azure/AKS-Landing-Zone-Accelerator/tree/main/Scenarios/AKS-Secure-Baseline-PrivateCluster/Terraform
- Create self-signed P2S certificates following the guidance here: https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-certificates-point-to-site-linux




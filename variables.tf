variable "project_id" {
    description = "The ID of the project in which the resource belongs."
    type        = string
}

variable "region" {
    description = "The default region to manage resources in."
    type        = string
}


####################
# Cluster basics
####################
variable "cluster_name" {
    description = "The name of the cluster, unique within the project and location."
    type        = string
}

variable "cluster_description" {
  description = "Description of the cluster."
  type        = string
}

variable "cluster_location_type" {
    description = "The location (region or zone) in which the cluster master will be created. If you specify a zone (such as us-central1-a), the cluster will be a zonal cluster with a single cluster master. If you specify a region (such as us-west1), the cluster will be a regional cluster with multiple masters spread across zones in the region."
    type        = string
}

variable "node_locations" {
    description = "value"
    type        = list
}

variable "release_channel" {
  description = "The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `UNSPECIFIED`."
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version of the masters."
  type        = string
}


####################
# Networking
####################
variable "vpc_network" {
    description = "The name or self_link of the Google Compute Engine network to which the cluster is connected. For Shared VPC, set this to the self link of the shared network."
    type        = string
}

variable "subnetwork" {
    description = "The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched."
    type        = string
}

variable "enable_private_endpoint" {
  description = "When true, the cluster's private endpoint is used as the cluster endpoint and access through the public endpoint is disabled. When false, either endpoint can be used."
  type        = bool
}

variable "enable_private_nodes" {
  description = "Enables the private cluster feature, creating a private endpoint on the cluster. In a private cluster, nodes only have RFC 1918 private addresses and communicate with the master's private endpoint via private networking."
  type        = bool
}

variable "master_ipv4_cidr_block" {
  description = "The IP range in CIDR notation to use for the hosted master network. This range will be used for assigning private IP addresses to the cluster master(s) and the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network, and it must be a /28 subnet."
  type        = string
}

variable "master_global_access_config" {
  description = "Whether the cluster master is accessible globally or not."
  type        = bool
}

variable "networking_mode" {
  description = "Determines whether alias IPs or routes will be used for pod IPs in the cluster. Options are VPC_NATIVE or ROUTES."
  type        = string
}

variable "cluster_ipv4_cidr_block" {
    description = "The name of the existing secondary range in the cluster's subnetwork to use for pod IP addresses."
    type        = string
}

variable "services_ipv4_cidr_block" {
    description = "The IP address range for the cluster pod IPs. Set to blank to have a range chosen with the default size. Set to /netmask (e.g. /14) to have a range chosen with a specific netmask. Set to a CIDR notation (e.g. 10.96.0.0/14) from the RFC-1918 private networks (e.g. 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) to pick a specific range to use."
    type        = string
}

variable "datapath_provider" {
  description = "The desired datapath provider for this cluster. By default, `DATAPATH_PROVIDER_UNSPECIFIED` enables the IPTables-based kube-proxy implementation. `ADVANCED_DATAPATH` enables Dataplane-V2 feature."
  type        = bool
}

# variable "master_authorized_networks" {
#   description = "List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists)."
#   type        = list(object({ cidr_block = string, display_name = string }))
# }

variable "master_authorized_networks_cidr_block" {
  description = "test"
  type        = list
}

variable "master_authorized_networks_display_name" {
  description = "test"
  type        = list

}
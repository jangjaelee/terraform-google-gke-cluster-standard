locals {
  module_name    = "terraform-google-gke-cluster-standard"
  module_version = "v0.0.1"

  # The desired configuration options for master authorized networks
  master_authorized_networks_config = length(var.master_authorized_networks) == 0 ? [] : [{
    cidr_blocks : var.master_authorized_networks
  }]

  # `kube-proxy` enables the IPTables-based kube-proxy implementation feature
  gke_cni_kubenet = var.gke_cni == "kube-proxy" ? true : false

  # `calico` enables the Network Policy feature
  gke_cni_calico  = var.gke_cni == "calico" ? true : false

  # `cilium` enables the Dataplane v2 feature
  gke_cni_cilium  = var.gke_cni == "cilium" ? true : false

  # The maintenance policy to use for the cluster
  cluster_maintenance_window_is_recurring = var.maintenance_recurrence != "" && var.maintenance_end_time != "" ? [1] : []
  cluster_maintenance_window_is_daily     = length(local.cluster_maintenance_window_is_recurring) > 0 ? [] : [1]

  autoscaling_resource_limits = var.cluster_autoscaling.enabled ? concat([{
    resource_type = "cpu"
    minimum       = var.cluster_autoscaling.min_cpu_cores
    maximum       = var.cluster_autoscaling.max_cpu_cores
    }, {
    resource_type = "memory"
    minimum       = var.cluster_autoscaling.min_memory_gb
    maximum       = var.cluster_autoscaling.max_memory_gb
  }], var.cluster_autoscaling.gpu_resources) : []

  # Confidential Nodes for this cluster
  confidential_node_config = var.enable_confidential_nodes == true ? [{ enabled = true }] : []

  # Workload Identity lets you connect securely to Google APIs from Kubernetes Engine workloads
  workload_identity_enabled                  = !(var.identity_namespace == null || var.identity_namespace == "null")
  cluster_workload_identity_config = !local.workload_identity_enabled ? [] : var.identity_namespace == "enabled" ? [{
    workload_pool = "${var.project_id}.svc.id.goog" }] : [{ workload_pool = var.identity_namespace
  }]

  # Google Groups for RBAC allows you to grant roles to all members of a Google Workspace group
  cluster_authenticator_security_group = var.authenticator_security_group == null ? [] : [{
  security_group = var.authenticator_security_group
  }]
}
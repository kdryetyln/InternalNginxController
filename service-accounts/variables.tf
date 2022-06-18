variable "aks_rg_name" {
  type        = string
  description = "The name of the cluster's resource group."
  default     = <your-resource-group-name>
}
variable "aks_cluster_name" {
  type        = string
  description = "The name of the cluster."
  default     = <your-aks-cluster-name>
}

variable "adminsa_name" {
  type        = string
  default     = "admin-sa"
}

variable "subscription_id" {
  type        = string
  default     = <your-az-subs-id>
}
 
variable "tenant_id" {
  type        = string
  default     = <your-az-subs-taint-id>
}

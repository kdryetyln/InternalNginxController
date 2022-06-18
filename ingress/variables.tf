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

variable "ingress_nginx_helm_version" {
  type        = string
  description = "The Helm version for the nginx ingress controller."
  #default     = "4.1.3" #k8s-ingress controller
  default     = "2.2.2" #nginx-ingress controller
}

variable "ingress_nginx_namespace" {
  type        = string
  description = "The nginx ingress namespace (it will be created if needed)."
  default     = "ingress-nginx-controller"
}

variable "subscription_id" {
  type        = string
  default     = <your-az-subs-id>
}
 
variable "tenant_id" {
  type        = string
  default     = <your-az-subs-taint-id>
}

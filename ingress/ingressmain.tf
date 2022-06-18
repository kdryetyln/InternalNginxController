provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}


data "azurerm_kubernetes_cluster" "akscluster" {
  name                = var.aks_cluster_name
  resource_group_name = var.aks_rg_name
}

# ##Remote State Datas
 data "terraform_remote_state" "akssa" {
   backend = "local"
   config = {
    path = "${path.root}/service-accounts/terraform.tfstate"
  }
 }

######You can also use tfstate from a remote repository
######Terraform supports many repository
#  data "terraform_remote_state" "akssa" {
#    backend = "artifactory"
#    config = {
#      url      = "https://<remote_state_repository_url>/repository"
#      # the repository name you just created
#      repo     = "terraform"
#      # an unique path to for identification
#      subpath  = "<SUB_PATH>"
#    }
#  }

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.akscluster.kube_config.0.host
  cluster_ca_certificate = lookup(data.terraform_remote_state.akssa.outputs.adminsasecret, "ca.crt")
  token                  = lookup(data.terraform_remote_state.akssa.outputs.adminsasecret, "token")
}
provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.akscluster.kube_config.0.host
    cluster_ca_certificate = lookup(data.terraform_remote_state.akssa.outputs.adminsasecret, "ca.crt")
    token                  = lookup(data.terraform_remote_state.akssa.outputs.adminsasecret, "token")
  }
}

#Nginx-Ingress Controller
resource "helm_release" "nginx-ingress" {
  name       = "nginx-ingress"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
  #version    = var.ingress_nginx_helm_version  
  namespace        = var.ingress_nginx_namespace
  create_namespace = true
  dependency_update          = true #eğer bunu koymazsak repoyu indirirken hata alıyor  
  values = [file("${path.module}/templates/ingressvalues.yaml")]
}
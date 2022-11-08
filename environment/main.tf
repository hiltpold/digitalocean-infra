resource "digitalocean_vpc" "k8s" {
  name   = "calypso-vpc"
  region = var.region

  timeouts {
    delete = "4m"
  }
}

module "kubernetes_cluster" {
  source   = "../modules/kubernetes_cluster"
  do_token = var.do_token
  region   = var.region
}

module "kubgres" {
  source                    = "../modules/kubegres"
  manifest_pattern          = "../modules/kubegres/manifests/*.yaml"
  super_user_password       = var.super_user_password
  replication_user_password = var.replication_user_password
  kubernetes_host           = module.kubernetes_cluster.kubernetes_host
  kubernetes_token          = module.kubernetes_cluster.kubernetes_token
  kubernetes_ca_certificate = module.kubernetes_cluster.kubernetes_ca_certificate
}

module "pgadmin" {
  source                    = "../modules/pgadmin"
  manifest_pattern          = "../modules/pgadmin/manifests/*.yaml"
  pgadmin_password          = var.pgadmin_password
  kubernetes_host           = module.kubernetes_cluster.kubernetes_host
  kubernetes_token          = module.kubernetes_cluster.kubernetes_token
  kubernetes_ca_certificate = module.kubernetes_cluster.kubernetes_ca_certificate
}

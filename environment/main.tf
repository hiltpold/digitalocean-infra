module "kubernetes_cluster" {
  source   = "../modules/kubernetes_cluster"
  do_token = var.do_token
}

module "kubgres" {
  source                    = "../modules/kubegres"
  kubernetes_host           = module.kubernetes_cluster.kubernetes_host
  kubernetes_token          = module.kubernetes_cluster.kubernetes_token
  kubernetes_ca_certificate = module.kubernetes_cluster.kubernetes_ca_certificate
  manifest_pattern          = "../modules/kubegres/manifests/*.yaml"
}

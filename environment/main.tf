resource "digitalocean_vpc" "dolos_vpc" {
  name   = "dolos-vpc"
  region = var.region

  timeouts {
    delete = "4m"
  }
}

module "kubernetes_cluster" {
  source   = "../modules/kubernetes_cluster"
  do_token = var.do_token
  region   = var.region
  vpc_id   = digitalocean_vpc.dolos_vpc.id

}

resource "digitalocean_firewall" "kubernetes_firewall" {
  name = "kubernetes-firewall"

  droplet_ids = module.kubernetes_cluster.worker_nodes.*.droplet_id

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
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

module "ingress" {
  source                    = "../modules/ingress"
  manifest_pattern          = "../modules/ingress/manifests/*.yaml"
  value_file                = "../modules/ingress/conf/nginx-ingress-values.yaml"
  kubernetes_cluster_name   = module.kubernetes_cluster.cluster_name
  kubernetes_worker_nodes   = module.kubernetes_cluster.worker_nodes
  kubernetes_host           = module.kubernetes_cluster.kubernetes_host
  kubernetes_token          = module.kubernetes_cluster.kubernetes_token
  kubernetes_ca_certificate = module.kubernetes_cluster.kubernetes_ca_certificate
}

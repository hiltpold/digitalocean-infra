resource "digitalocean_container_registry" "docker_registry" {
  name                   = var.owner
  subscription_tier_slug = "basic"
  region                 = var.region
}

resource "digitalocean_vpc" "project_vpc" {
  name   = "${var.project_name}-vpc"
  region = var.region

  timeouts {
    delete = "4m"
  }
}

module "kubernetes_cluster" {
  source       = "../modules/kubernetes_cluster"
  do_token     = var.do_token
  owner        = var.owner
  region       = var.region
  vpc_id       = digitalocean_vpc.project_vpc.id
  project_name = var.project_name
  environment  = var.environment
}

resource "digitalocean_firewall" "kubernetes_firewall" {
  name = "${var.project_name}-k8s-firewall"

  droplet_ids = [module.kubernetes_cluster.worker_nodes.*.droplet_id[0]]

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
  project_name              = var.project_name
  environment               = var.environment
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
  project_name              = var.project_name
  environment               = var.environment
  kubernetes_cluster_name   = module.kubernetes_cluster.cluster_name
  kubernetes_worker_nodes   = module.kubernetes_cluster.worker_nodes
  kubernetes_host           = module.kubernetes_cluster.kubernetes_host
  kubernetes_token          = module.kubernetes_cluster.kubernetes_token
  kubernetes_ca_certificate = module.kubernetes_cluster.kubernetes_ca_certificate
}

module "lakelandcup" {
  source                    = "../modules/lakelandcup"
  kubernetes_host           = module.kubernetes_cluster.kubernetes_host
  kubernetes_token          = module.kubernetes_cluster.kubernetes_token
  kubernetes_ca_certificate = module.kubernetes_cluster.kubernetes_ca_certificate
}

resource "digitalocean_domain" "project_www_domain" {
  name = "www.hiltpold.tech"
}

resource "digitalocean_domain" "project_domain" {
  name = "hiltpold.tech"
}

resource "digitalocean_project" "project" {
  name        = "${upper(substr(var.project_name, 0, 1))}${substr(var.project_name, 1, -1)}"
  description = "A project to represent development resources."
  purpose     = "All purpose project"
  environment = var.environment == "prod" ? "Production" : "Development"
  is_default  = false
}

resource "digitalocean_project_resources" "project_resources" {
  project = digitalocean_project.project.id
  resources = [
    module.kubernetes_cluster.cluster_urn,
    digitalocean_domain.project_www_domain.urn,
    digitalocean_domain.project_domain.urn
  ]
}

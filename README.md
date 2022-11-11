# Digitalocean Infrastructure
## Setup
Provide a env.tfvars file int the `environment` folder with the following entries:
```bash
do_token                  = 
super_user_password       = 
replication_user_password =
```
# Misc
Configure kubernetes cluster
```
doctl kubernetes cluster kubeconfig save <cluster_name>
```
Get cluster config
```
doctl kubernetes cluster node-pool get <cluster_name> worker-pool -o json
```
Get worker node ip
````
doctl compute droplet get <worker_pool_name> --template '{{.PublicIPv4}}'
```
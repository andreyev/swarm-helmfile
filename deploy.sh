#!/bin/bash

for tenant in ./tenants/*.yaml ; do 
  helmfile -q -f ./helmfiles.yaml template  --values $tenant | yq ea '. as $item ireduce ({}; . * $item )' | docker stack deploy -d tenant-$(basename $tenant .yaml) -c -
done

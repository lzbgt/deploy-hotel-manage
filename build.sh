#!/bin/bash
set -e

ver=1.0
proj_base=/Users/Bruce/work/dfws/wkxhotel-parent
docker_registry=docker-registry.cluster.dfwsgroup.cn/library

cd $proj_base
mvn clean install package -DskipTests

declare -a dir_services=("wkxhotel-eureka-server" "wkxhotel-file" "wkxhotel-redis" "wkxhotel-service-job" "wkxhotel-service-statistics" "wkxhotel-service-gateway" "wkxhotel-web-customer" "wkxhotel-web-waiter" "wkxhotel-company-manage" "wkxhotel-dfws-manage")
for i in "${dir_services[@]}"
do
  echo "building $i"
  cd $proj_base/$i
  mvn docker:build -DskipTests
  docker push $docker_registry/$i:$ver
done

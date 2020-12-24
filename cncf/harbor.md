# [harbor](https://github.com/vmware/harbor)

An open source trusted cloud native registry project that stores, signs, and scans content. <http://vmware.github.io/harbor/>

```sh
wget https://storage.googleapis.com/harbor-releases/release-1.10.0/harbor-offline-installer-v1.10.5.tgz

docker run -it --rm -v /home/harbor/harbor.cfg:/harbor-migration/harbor-cfg/harbor.cfg -v /home/harbor/1.8.6/harbor/harbor.yml:/harbor-migration/harbor-cfg-out/harbor.yml goharbor/harbor-migrator:v1.8.6 --cfg up

docker run -it --rm -v /home/harbor/1.8.6/harbor/harbor.yml:/harbor-migration/harbor-cfg/harbor.yml -v /home/harbor/1.9.0/harbor/harbor.yml: /harbor-migration/harbor-cfg-out/harbor.yml goharbor/harbor-migrator:v1.9.0 --cfg up

docker run -it --rm -v /:/hostfs goharbor/prepare:v2.1.1 migrate -i /home/harbor/1.10.5/harbor/harbor.yml -o /home/21/harbor/harbor.yml

./install.sh  --with-chartmuseum --with-clair
```

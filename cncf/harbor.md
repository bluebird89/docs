# [harbor](https://github.com/vmware/harbor)

An open source trusted cloud native registry project that stores, signs, and scans content. <http://vmware.github.io/harbor/>

```sh
wget https://storage.googleapis.com/harbor-releases/release-1.10.0/harbor-offline-installer-v1.10.5.tgz

docker run -it --rm -v /home/harbor/harbor.cfg:/harbor-migration/harbor-cfg/harbor.cfg -v /home/harbor/1.8.6/harbor/harbor.yml:/harbor-migration/harbor-cfg-out/harbor.yml goharbor/harbor-migrator:v1.8.6 --cfg up

docker run -it --rm -v /home/harbor/1.8.6/harbor/harbor.yml:/harbor-migration/harbor-cfg/harbor.yml -v /home/harbor/1.9.0/harbor/harbor.yml: /harbor-migration/harbor-cfg-out/harbor.yml goharbor/harbor-migrator:v1.9.0 --cfg up

docker run -it --rm -v /:/hostfs goharbor/prepare:v2.1.1 migrate -i /home/harbor/1.10.5/harbor/harbor.yml -o /home/21/harbor/harbor.yml

./install.sh  --with-chartmuseum --with-clair
```

## 存储

*  manifest 针对registry服务端的配置信息
*  同步两个 registry 上的镜像
    -  docker pull 镜像时会对 registry 上的 layer 进行解压缩
    -
*  registry 中存储的镜像 layer 格式是 vnd.docker.image.rootfs.diff.tar.gzip ，这是一个 tar.gz 类型的文件

```
tree
`-- registry
    `-- v2      # registry V2 版本
        |-- blobs # blobs 目录下存储镜像的 raw 数据，存储的最小单元为 layer
        |   `-- sha256
        |       |-- 39
        |       |-- cb
        |       `-- f7
        `-- repositories # 镜像的元数据信息
            `-- library
                `-- alpine
```

```sh
skopeo inspect docker://index.docker.io/library/alpine:latest --raw
```

## skopeo

* copy：复制一个镜像从 A 到 B，这里的 A 和 B 可以为本地 docker 镜像或者 registry 上的镜像。
* inspect：查看一个镜像的 manifest 火车 image config 详细信息
* delete：删除一个镜像，可以是本地 docker 镜像或者 registry 上的镜像
* list-tags：列出一个 registry 上某个镜像的所有 tag
* login：登录到某个 registry，和 docker login 类似
* logout： 退出已经登录到某个 registry 的 auth 信息，和 docker logout 类似
* manifest-digest、standalone-sign、standalone-verify 这三个用的不多
* sync：同步一个镜像从 A 到 B，感觉和 copy 一样，但 sync 支持的参数更多，功能更强大。在 0.14.0 版本的时候是没有 sync 选项的，到了 0.14.2 才有，现在是 1.0.0
* IMAGE NAMES
    - containers-storage:*docker-reference* An image located in a local containers/storage image store. Both the location and image store are specified in /etc/containers/storage.conf. (Backend for Podman, CRI-O, Buildah and friends)
    - dir:*path* An existing local directory path storing the manifest, layer tarballs and signatures as individual files. This is a non-standardized format, primarily useful for debugging or noninvasive container inspection.
    - docker://*docker-reference* An image in a registry implementing the “Docker Registry HTTP API V2”. By default, uses the authorization state in either $XDG_RUNTIME_DIR/containers/auth.json, which is set using (skopeo login). If the authorization state is not found there, $HOME/.docker/config.json is checked, which is set using (docker login).
    - docker-archive:*path[:*docker-reference*] An image is stored in the docker save formatted file. *docker-reference is only used when creating such a file, and it must not contain a digest.
    - docker-daemon:*docker-reference* An image docker-reference stored in the docker daemon internal storage. docker-reference must contain either a tag or a digest. Alternatively, when reading images, the format can be docker-daemon:algo:digest (an image ID).
    - oci:*path:tag* An image tag in a directory compliant with “Open Container Image Layout Specification” at path.

```sh
skopeo copy docker://k8s.gcr.io/kube-apiserver:v1.17.5 docker://index.docker.io/webpsh/kube-apiserver:v1.17.5 --dest-authfile /root/.docker/config.json
skopeo copy docker-daemon:alpine:latest oci:alpine
skopeo inspect docker-daemon:alpine:latest --raw | jq "."
```

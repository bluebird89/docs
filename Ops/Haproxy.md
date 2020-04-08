# [haproxy/haproxy](https://github.com/haproxy/haproxy)

HAProxy Load Balancer's development branch http://www.haproxy.org

## docker

```
# haproxy.cfg
/dev/log    local0
    log /dev/log    local1 notice

defaults
        mode    tcp
        option  dontlognull
        timeout connect 5s
        timeout client 50s
        timeout server 50s
        timeout tunnel 1h
        timeout client-fin 50s
### frontends
# Optional HAProxy Stats Page accessible at http://<host-ip>:8181/haproxy?stats
frontend dtr_stats
        mode http
        bind 0.0.0.0:8181
        default_backend dtr_stats
frontend dtr_80
        mode tcp
        bind 0.0.0.0:80
        default_backend dtr_upstream_servers_80
frontend dtr_443
        mode tcp
        bind 0.0.0.0:443
        default_backend dtr_upstream_servers_443
### backends
backend dtr_stats
        mode http
        option httplog
        stats enable
        stats admin if TRUE
        stats refresh 5m
backend dtr_upstream_servers_80
        mode tcp
        option httpchk GET /_ping HTTP/1.1\r\nHost:\ <DTR_FQDN>
        server node01 <DTR_REPLICA_1_IP>:80 check weight 100
        server node02 <DTR_REPLICA_2_IP>:80 check weight 100
        server node03 <DTR_REPLICA_N_IP>:80 check weight 100
backend dtr_upstream_servers_443
        mode tcp
        option httpchk GET /_ping HTTP/1.1\r\nHost:\ <DTR_FQDN>
        server node01 <DTR_REPLICA_1_IP>:443 weight 100 check check-ssl verify none
        server node02 <DTR_REPLICA_2_IP>:443 weight 100 check check-ssl verify none
        server node03 <DTR_REPLICA_N_IP>:443 weight 100 check check-ssl verify none

docker run --detach \
  --name dtr-lb \
  --publish 443:443 \
  --publish 80:80 \
  --publish 8181:8181 \
  --restart=unless-stopped \
  --volume ${PWD}/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro \
  haproxy:1.7-alpine haproxy -d -f /usr/local/etc/haproxy/haproxy.cfg
```

## 参考

* [docker-library/haproxy](https://github.com/docker-library/haproxy):Docker Official Image packaging for HAProxy http://www.haproxy.org/

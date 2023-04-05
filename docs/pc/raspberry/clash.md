---
title: 树莓派Clash+Clash Web
description:  Clash代理 + Clash Web管理页面
tags:
  - Raspberry
---

## 一、安装 clash for linux

下载最新版本 clash：[https://github.com/Dreamacro/clash/releases](https://github.com/Dreamacro/clash/releases)

查看树莓派版本

```c
pi@raspberrypi:~/soft/clash $ uname -a
Linux raspberrypi 5.15.61-v8+ #1579 SMP PREEMPT Fri Aug 26 11:16:44 BST 2022 aarch64 GNU/Linux
```

根据自己Linux版本选择对应的下载，

```c
wget -O clash.gz https://github.121rh.com/https://github.com/Dreamacro/clash/releases/download/v1.14.0/clash-freebsd-arm64-v1.14.0.gz
```

- `https://github.121rh.com` 自建的github文件加速地址

解压到当前文件夹

```c
gzip -f clash.gz -d 
```

授权可执行权限

```c
chmod +x clash
```

初始化执行 clash

```c
./clash 
```

初始化执行 clash 会默认在 `~/.config/clash/` 目录下生成配置文件和全球IP地址库：`config.yaml` 和 `Country.mmdb`

如果这一步`Country.mmdb`不能自动完成下载，可以手工下载：

[https://github.com/Dreamacro/maxmind-geoip/releases/latest/download/Country.mmdb](https://github.com/Dreamacro/maxmind-geoip/releases/latest/download/Country.mmdb)

后放到 `~/.config/clash/` 目录

```c
pi@raspberrypi:~/.config/clash $ pwd
/home/pi/.config/clash
pi@raspberrypi:~/.config/clash $ ls
cache.db  config.yaml  Country.mmdb
```


## 二、下载 clash 配置文件


在"飞机场"下载clash.conf文件，放在
```c
pi@raspberrypi:~/soft/clash $ ls
clash     config.yaml  
```

然后，再次启动clash

```
./clash
```


## 三、Clash Web 管理

Github 项目地址：[Clash Dashboard](https://github.com/Dreamacro/clash-dashboard)

1. 克隆代码

从 Clash Dashboard 的项目上克隆到服务器上；

2. 修改配置

不需要修改 Clash Dashboard 的文件，需要修改的是 Clash 的配置文件。

```c
pi@raspberrypi:~/soft/clash $ cd ~/.config/clash/
pi@raspberrypi:~/.config/clash $ vim config.yaml

```

config.yaml 文件
```c
mixed-port: 7890
external-controller: 0.0.0.0:9090 # 修改ip地址和端口；
external-ui: /home/pi/soft/clash/tmp/clash-dashboard # clash-dashboard的路径；
secret: '666666' # 666666是连接的密钥，自行设置

```

3. 访问测试

在浏览器中输入即可访问 `local:9090/ui`


## 四、Docker部署Clash&ClashWeb

1. Clash

```sh
docker run -d --name=clash -v "/home/pi/soft/clash/config.yaml:/root/.config/clash/config.yaml" --network macnet -p "7890:7890" -p "9090:9090" --restart=unless-stopped dreamacro/clash
```

- 如果要更新config.yaml配置文件，用wget命令下载yaml文件后，重启docker容器。

2. Clash Web UI 

下载地址：[clash_web](https://yxcai.top/wp-content/uploads/2023/02/clash_web.zip "clash_web")

```sh
docker run --name clashNginx -p 80:80 -v /home/pi/soft/clash/clash_web/clash.conf:/etc/nginx/conf.d/clash.conf -v /home/pi/soft/clash/clash_web:/wwww/  --network macnet -d nginx
```

## 五、使用clash代理

firefox浏览器，设置 -- > 常规 --> 网络设置 -- >手动配置代理：

- HTTP 代理 ip + 端口号7890
- HTTPS 代理 ip + 端口号7890
- SOCKS主机 ip + 端口号7891


## 六、macnet 虚拟网卡
-   macvlan不创建网络，只创建虚拟网卡。
-   macvlan会 `共享物理网卡->eth0` 所链接的 `外部网络->路由器IP` ，与桥连接效果一样！

```sh
docker network create -d macvlan --subnet=192.168.0.0/24 --gateway=192.168.0.1 -o parent=eth0 macnet
```

-   `-d` 指定 Docker 网络 driver
-   `--subnet` 指定 macvlan 网络所在的网络
-   `--gateway` 指定网关
-   `-o parent` 指定用来分配 macvlan 网络的物理网卡

```sh
pi@raspberrypi:~/.config/clash $ ip a
pi@raspberrypi:~/.config/clash $ docker network inspect macnet
[
    {
        "Name": "macnet",
        "Id": "c70081e39d326dfa2bcf8c072b9679b80d2b33a2126c8ffed565e38742ce537d",
        "Created": "2023-04-02T21:03:49.751091421+08:00",
        "Scope": "local",
        "Driver": "macvlan",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "192.168.0.0/24",
                    "Gateway": "192.168.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "0fbf607ce358c1774d8d51e0a003153fac523d9c43eba7c52b2647d59ec7ff2b": {
                "Name": "clash",
                "EndpointID": "abedaf06bfec2aa4533e79b1e39c33d998b294fc8e05965c66f18f823d1f5a95",
                "MacAddress": "02:42:c0:a8:00:02",
                "IPv4Address": "192.168.0.2/24",
                "IPv6Address": ""
            },
            "81cdf9fbbd5da8ad9c91895ed926c176954953945e99dc9d9dec7505675b1475": {
                "Name": "clashNginx",
                "EndpointID": "78781dc17af6ddccd1695d564ca5a7acf3874cd464e7c785a18506eb023a369c",
                "MacAddress": "02:42:c0:a8:00:03",
                "IPv4Address": "192.168.0.3/24",
                "IPv6Address": ""
            }
        },
        "Options": {
            "parent": "eth0"
        },
        "Labels": {}
    }
]

```

【坑】**macnet 虚拟网卡 与 宿主机ping不通**

可再建一个网卡“mynet”继承eth0，mynet与macnet互相通信，没有操作过，待以后实现！
---
title: 树莓派作为OpenWrt路由器
description:  OpenWrt路由器
tags:
  - Raspberry
---

## 一、介绍OpenWrt


OpenWrt 是一个 Linux 操作系统，主要用于嵌入式设备如路由器、交换机等网络设备上。通过 OpenWrt，您可以将路由器升级为更强大、更灵活的设备，并添加额外的功能。

下面是一些关于 OpenWrt 路由器的常见问题和回答：

1.  什么是 OpenWrt 路由器？
    
    OpenWrt 路由器是指在运行 OpenWrt 操作系统的路由器设备。OpenWrt 可以使路由器变得更加灵活，提供更多功能，比如 VPN、热点、远程管理等等。
    
2.  如何安装 OpenWrt 到路由器上？
    
    安装 OpenWrt 到路由器上需要先检查路由器型号是否支持 OpenWrt 并确定正确的版本。可以从 OpenWrt 官方网站下载适用于您的路由器的固件，然后按照官方指引进行安装。
    
3.  我可以自定义 OpenWrt 路由器吗？
    
    在 OpenWrt 上，您可以根据自己的需要完全自定义路由器。您可以选择安装所需的软件包，或编写自己的程序来实现特定的功能。
    
4.  如何在 OpenWrt 上配置 VPN？
    
    OpenWrt 支持多种 VPN 协议，包括 PPTP、L2TP、OpenVPN 等。您可以使用 OpenWrt 的 Web 界面或 SSH 登录来配置 VPN。
    
5.  如何在 OpenWrt 上配置热点？
    
    OpenWrt 支持多种热点模式，包括 Wi-Fi、认证门户、Captive Portal 等。您可以使用 OpenWrt 的 Web 界面来配置热点，也可以使用命令行界面。
    
6.  如何远程管理 OpenWrt 路由器？
    
    OpenWrt 支持 SSH 和 Web 界面两种远程管理方式。您可以使用 SSH 客户端连接到路由器并执行命令，或使用浏览器访问路由器的 Web 界面进行管理。
    

- OpenWrt 在树莓派上正常运行时，资源占用率只有不到 1/10
- 树莓派与路由器通过网线连接。


## 二、旁路网关

旁路网关通常是指在企业或组织内部网络中，为了实现网络流量监测、控制和管理等需要而引入的一种特殊网络部署模式。

在旁路网关模式下，部署了一个额外的设备（旁路网关）来截取网络流量，把流量经过预先配置的过滤和处理操作后再转发到内部网络，从而达到监测流量、防止网络攻击、优化网络性能等目的。

旁路网关通常被应用于以下场景：

1.  网络安全：可以使用旁路网关来监测入侵攻击、病毒、垃圾邮件等网络活动，并根据安全策略进行处理。
    
2.  网络性能：可以使用旁路网关来监测带宽使用情况、应用程序性能等，并根据需要进行优化。
    
3.  合规性：对于一些需要遵循监管要求的行业和组织，如金融、医疗等，可以使用旁路网关来监测和记录网络活动以满足合规性要求。
    

旁路网关通常具有高可用性和高性能的特点，采用冗余和负载均衡技术来保证网络连续性和可靠性。但是，与传统网关相比，旁路网关需要更多的配置和维护工作，对网络管理员的技术水平要求较高。

总之，旁路网关是一种特殊的网络部署模式，提供了一系列网络管理、监测和控制功能，可以帮助组织实现更高的网络安全性、性能和合规性。


## 三、具体步骤

### 1、打开网卡混杂模式

```bash
sudo ip link set eth0 promisc on
```

### 2、创建docker网络

```c
docker network create -d macvlan --subnet=192.168.0.123/24 --gateway=192.168.0.1 -o parent=eth0 mymacnet
```

这是一个创建 Docker 网络的命令，使用了 macvlan 驱动程序来实现将容器连接到宿主机网络的效果。该命令的具体含义如下：

??? warning "macvlan 驱动程序"
	
	macvlan 是一种 Linux 内核网络驱动程序，可以用于创建虚拟的 MACVLAN 接口，该接口拥有和物理接口相同的 MAC 地址，并独立地处理网络流量。在 Docker 中，macvlan 驱动程序可以用于将 Docker 容器连接到宿主机网络，从而实现容器和宿主机共享物理网络接口。
	
	使用 macvlan 驱动程序，可以让 Docker 容器直接连接到宿主机网络中，不需要 NAT 或其他中间网络设备的干扰，从而提高了网络性能和容器的可靠性。同时，macvlan 驱动程序还支持多种模式，如 bridge 模式、private 模式和 VEPA 模式等，可以根据不同的应用场景进行选择。
	
	需要注意的是，在使用 macvlan 驱动程序时，容器和宿主机网络接口的配置需要正确设置，以避免网络冲突和安全问题。此外，不同版本的 Linux 内核和 Docker 环境可能对 macvlan 驱动程序的支持存在差异，需要在具体环境下进行测试和调整。

-   docker network create：创建 Docker 网络。
-   -d macvlan：指定使用 macvlan 驱动程序，可以让容器拥有和宿主机相同的 MAC 地址。
-   --subnet=192.168.0.123/24：指定子网地址，该命令将创建一个名为“mymacnet”的网络，其 IP 地址范围为 192.168.0.123/24。
-   --gateway=192.168.0.1：设置网关地址，该命令将设置网络的默认网关为 192.168.0.1。
-   -o parent=eth0：指定宿主机上的物理接口（即 parent 接口），该命令将使用名为 eth0 的接口连接到宿主机网络中。
-   mymacnet：指定要创建的网络的名称。

总之，上述命令创建了一个名为“mymacnet”的 Docker 网络，使得该网络内的容器可以通过指定的网关访问宿主机网络，并且可以使用与宿主机相同的 MAC 地址，从而更方便地进行网络通信和管理。需要注意的是，使用 macvlan 驱动程序时，容器和宿主机之间需要处于同一子网内。

查看docker 网络 `docker network ls`
```js
pi@raspberrypi:~ $ docker network ls
NETWORK ID     NAME                    DRIVER    SCOPE
bab99c0c4c2d   aliyun-driver_default   bridge    local
6cf1b9e9542c   bitwarden_default       bridge    local
66ebb324836a   bridge                  bridge    local
dbacc8ad17fe   host                    host      local
8546bc867a7c   mymacvlan               macvlan   local
f6a4c2fd3b97   none                    null      local
876a79d48a92   vaultwarden_default     bridge    local
4abf0b6b2cf9   webdav_default          bridge    local
```

### 3、拉取镜像

```c
docker pull unifreq/openwrt-aarch64:latest
```

`docker images` 查看本地镜像
```c
pi@raspberrypi:~ $ docker images
REPOSITORY                    TAG       IMAGE ID       CREATED         SIZE
unifreq/openwrt-aarch64       latest    c4d047e9d49a   15 months ago   301MB
```

### 4、创建并启动容器

```c
docker run --restart always --name openwrt -d -v /home/pi/soft/openwrt/network:/etc/config/network --cap-add NET_ADMIN --device /dev/net/tun \
-p 192.168.0.6:80:80/tcp -p 192.168.0.6:443:443/tcp -p 192.168.0.6:22:22/tcp \
-e TZ=Asia/Shanghai --network mymacvlan unifreq/openwrt-aarch64:latest /sbin/init
```

这段命令使用 Docker 运行一个名为 "openwrt" 的容器，具体内容如下：

-   `--restart always`：指定 Docker 在自动重启容器时使用 “always” 参数，即容器退出时总是重新启动。
-   `--name openwrt`：为容器指定名称 "openwrt"，以便于管理和操作。
-   `-d`：在后台运行容器。
-   `-v /home/pi/soft/openwrt/network:/etc/config/network`：将宿主机上的 /home/pi/soft/openwrt/network 目录挂载到容器中的 /etc/config/network 目录，用于配置 OpenWrt 网络参数。
-   `--cap-add NET_ADMIN`：授予容器管理员网络监控和控制权限。
-   `--device /dev/net/tun`：授权容器使用 /dev/net/tun 设备，用于支持虚拟私有网络 (VPN)。
-   `-p 192.168.0.6:80:80/tcp -p 192.168.0.6:443:443/tcp -p 192.168.0.6:22:22/tcp`：将容器中的端口映射到宿主机上，使得从外部可以访问这些端口。例如，将容器中的 80 端口映射到宿主机的 192.168.0.6:80 端口。
-   `-e TZ=Asia/Shanghai`：设置容器时区为 “Asia/Shanghai”。
-   `--network mymacvlan`：将容器连接到一个自定义的 MACVLAN 网络，以实现容器和宿主机之间的通信。
-   `unifreq/openwrt-aarch64:latest`：使用指定的Docker镜像创建容器。
-   `/sbin/init`：用于启动容器。

这个命令的作用是在 Docker 中运行一个 OpenWrt 容器，并对容器进行配置和设置，使其支持网络、VPN、Web 服务和 SSH 连接等功能。

network 配置

```c
config interface 'loopback'
	option ifname 'lo'
	option proto 'static'
	option ipaddr '127.0.0.1'
	option netmask '255.0.0.0'

config globals 'globals'
	option ula_prefix 'fd62:dcc5:5c23::/48'

config interface 'lan'
	option type 'bridge'
	option ifname 'eth0'
	option proto 'static'
	option ipaddr '192.168.0.6'
	option netmask '255.255.255.0'
	option gateway '192.168.0.1'
	option ip6assign '60'
	option dns '192.168.0.1'

config interface 'VPN'
	option ifname 'ipsec0'
	option proto 'static'
	option ipaddr '10.10.10.1'
	option netmask '255.255.255.0'

config interface 'vpn0'
	option ifname 'tun0'
	option proto 'none'

```

### 5、进入容器并修改相关参数

```c
 docker exec -it openwrt bash
```

进行编写OpenWrt 的网络配置文件：`vim /etc/config/network`

更改 Lan 口设置

```c
config interface 'lan'
        option type 'bridge'
        option ifname 'eth0'
        option proto 'static' 
        option ipaddr '192.168.0.6' 
        option netmask '255.255.255.0'
        option ip6assign '60'
        option gateway '192.168.0.1'
        option broadcast '192.168.123.255'
        option dns '192.168.0.1' 
```

-  改三处：option ipaddr、option netmask、option dns，填写**路由器**的IP地址

??? warning "interface Lan介绍"

	这是 OpenWrt 系统中的一个网络配置文件，其中 `config interface 'lan'` 表示的是对一个名为 "lan" 的网络接口进行配置。具体解释如下：
	
	-   `option type 'bridge'`：设置该网络接口类型为 bridge，即桥接模式；
	-   `option ifname 'eth0'`：指定了该网络接口的名称为 eth0，表示用于连接宿主机的物理网卡；
	-   `option proto 'static'`：指定了该网络接口的协议类型为静态 IP 地址模式；
	-   `option ipaddr '192.168.0.6'`：指定了该网络接口的 IP 地址为 192.168.0.6；
	-   `option netmask '255.255.255.0'`：指定了该网络接口的子网掩码为 255.255.255.0；
	-   `option ip6assign '60'`：指定了该网络接口的 IPv6 前缀长度为 60；
	-   `option gateway '192.168.0.1'`：指定了该网络接口的默认网关为 192.168.0.1；
	-   `option broadcast '192.168.123.255'`：设置该网络接口的广播地址为 192.168.123.255；
	-   `option dns '192.168.0.1'`：指定了该网络接口使用的 DNS 服务器为 192.168.0.1。
	
	这个配置文件的作用是将 OpenWrt 系统中的 "lan" 网络接口配置为桥接模式，并设置了该网络接口的 IP 地址、子网掩码、默认网关、广播地址和 DNS 服务器，以实现对该网络接口的控制和管理。


### 6、在容器内重启网络

```c
/etc/init.d/network restart
```


### 7、进入openwrt 管理页面

浏览器中输入` http://192.168.0.6 ` ，此IP是在容器内设置的，即option ipaddr '192.168.0.6'，就可以看到Openwrt的管理界面。

- 用户名： root
- 密码： password 

SSH 连接openwrt容器

- IP： 192.168.0.6
- 端口：22
- 用户名： root
- 密码： password 

连接后显示

```c
Connecting to 192.168.0.6:22...
Connection established.
To escape to local shell, press 'Ctrl+Alt+]'.

WARNING! The remote SSH server rejected X11 forwarding request.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
\    ____                 _       __     __  /
\   / __ \____  ___  ____| |     / /____/ /_ /
\  / / / / __ \/ _ \/ __ \ | /| / / ___/ __/ /
\ / /_/ / /_/ /  __/ / / / |/ |/ / /  / /_   /
\ \____/ .___/\___/_/ /_/|__/|__/_/   \__/   /
\     /_/  W I R E L E S S   F R E E D O M   /
\                                            /
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The docker aarch64 special edition
\n
cat: can't open '/proc/device-tree/model': No such file or directory
设备信息： 
CPU 型号:  AArch64 : Cortex-A53 x 4
系统负载:  0.02 0.06 0.11  	运行时间:  1小时 7分钟 1秒		
环境温度:  38.6 °C           	当前频率:  1200 Mhz
内存已用:  23% of 859MB  	IP  地址:  192.168.0.6
系统存储:  31% of 29.0G  	

```

### 8、关闭DHCP服务

在 `网络 -> 接口 ->  Lan -> 修改 `  界面中，勾选下方的 “**忽略此接口（不在此接口提供 DHCP 服务）**”，并“**保存&应用**”


### 9、主路由 DHCP 设置

> 如果想要局域网内所有的设备走树莓派这个网关，那么在路由器内设置：DHCP中的网关和DNS->刚刚容器内的IP地址。


> 不想路由器下所有设备走openwrt，就不设置。那就单个设备指定网关

### 10、单个设备指定网关

1）Windows平台：

> 设置-->网络和Internet-->状态-->更改适配器选项-->"选择网络适配器WLAN"-->属性-->Internet协议 TCP/IPv4（设置手动IP地址、DNS服务器地址）


2）安卓

>WLAN-->IP设置(DHCP) 改 ”静态“ -->DNS1、DNS2 改 容器内设置的IP

## 四、科学上网


>从机场获取订阅链接扔到Openwrt中的插件shadowsocksR-plus中

最好使用clash：OpenWRT 可以使用 [OpenClash 插件](https://github.com/vernesong/OpenClash)

----

## 参考

- [Docker安装OpenWRT做旁路由，魔法上网](https://www.kejiwanjia.com/jiaocheng/57242.html)
- [在docker中搭建openwrt软路由系统，实现多网口以及主路由功能](https://www.cnblogs.com/mokou/p/16173553.html)
- [Docker 部署的 openWrt 软路由, 并解决无法与宿主机通信问题](https://www.treesir.pub/post/n1-docker/#%E7%8E%AF%E5%A2%83%E8%AF%B4%E6%98%8E)

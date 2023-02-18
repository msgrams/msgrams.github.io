---
title: 树莓派自建Bitwarden
description: Install RaspberrySystems & Bitwarden & Docker & Nginx & Deployment CloudfareTunnels
tags:
  - raspberry
---
## 一、安装系统

### 安装老版系统(新版本系统此方法失败)

1.利用DiskGenius格式化U盘， 使用软件安装将TF卡烧录位`FAT-32`格式

![image.png](https://qiniu.121rh.com/obsidian/img/20230215214204.png)

![](安装Systems_20230215214203311.png)
  
2.下载系统 [2022-09-22-raspios-bullseye-arm64-lite.img](https://www.raspberrypi.com/software/operating-systems/)

3.使用[Win32 DiskImager](https://sourceforge.net/projects/win32diskimager/)软件将64位`resbian`系统烧录到TF卡中

4.新建名为`ssh`的文件到目录下（自动开启ssh服务）

### 树莓派新版系统SSH连接被拒绝问题处理

[官方文档](https://www.raspberrypi.com/documentation/computers/getting-started.html#sd-cards-for-raspberry-pi)中有段话

In older versions of Imager you should push Ctrl-Shift-X to open the "Advanced" menu.

If you are installing Raspberry Pi OS Lite and intend to run it headless, you will still need to create a new user account. Since you will not be able to create the user account on first boot, you MUST configure the operating system using the Advanced Menu.


![ssh开启 ](https://www.raspberrypi.com/documentation/computers/images/rpi_imager_2.png)

安装新版本系统必须使用[Raspberry Pi Imager](https://downloads.raspberrypi.org/imager/imager_latest.exe)

### 安装新版系统
  
从现在开始，通过向导工作不再是可选的，因为这是创建用户帐户的方式;除非你创建一个用户帐号，否则你不能登录到桌面。因此，向导不再像以前那样作为应用程序在桌面上运行，而是在首次靴子时在专用环境中运行。

向导本身与以前相比基本上没有变化，主要区别是以前提示您输入新密码时，现在提示您输入用户名和密码。(If如果您确实需要，您可以像以前一样将它们设置为“pi”和“raspberry”-您将收到一条警告消息，指出这样做是不明智的，但这是您的选择-某些软件可能需要“pi”用户，因此我们在这方面并不完全专制。但是我们真的建议你选择别的酒店！）


要生成加密密码，最简单的方法是在已经运行的Raspberry Pi上使用OpenSSL-打开终端窗口并输入

  
```sh
echo 'mypassword' | openssl passwd -6 -stdin
```


### 查看版本


```sh

pi@raspberrypi:~ $ lsb_release -a

No LSB modules are available.

Distributor ID: Debian

Description:    Debian GNU/Linux 11 (bullseye)

Release:    11

Codename:   bullseye

```

## 二、树莓派apt换源

### apt换源
```sh
sudo vi /etc/apt/sources.list
```

注释文件原有内容，添加如下内容
```sh
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free
deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free


deb http://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb http://mirrors.aliyun.com/debian-security/ bullseye-security main
deb-src http://mirrors.aliyun.com/debian-security/ bullseye-security main
deb http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib
```

```sh
sudo vi /etc/apt/sources.list.d/raspi.list
```

注释原有内容，新增

```sh
deb http://mirrors.tuna.tsinghua.edu.cn/raspberrypi/ buster main ui
```


同步更新源，执行如下命令：

```sh
sudo apt-get update
```

更新升级以安装软件包，这个过程耗时较长。

```sh
sudo apt-get upgrade
```


## 三、安装Docker


docker 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，然后发布到任何流行的Linux机器上，也可以实现虚拟化，容器是完全使用沙箱机制，相互之间不会有任何接口。简言之，就是可以在Linux上镜像使用的这么一个容器。

### 安装方法一（脚本安装）

查看本系统参数

```sh
pi@raspberrypi:~/soft $ lsb_release -a
No LSB modules are available.
Distributor ID:	Debian
Description:	Debian GNU/Linux 11 (bullseye)
Release:	11
Codename:	bullseye

```


### 1、更新环境软件所
```sh
sudo apt-get update
sudo apt-get  dist-update -y
```

### 2、安装依赖项：
```sh
sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
```

### 3、脚本安装
是最推荐的方式，只需要输入下面的命令，等待自动安装好即可。

```sh
curl -fsSL https://get.docker.com | bash -s docker
```


### 4、添加用户组和用户

```sh
#添加docker用户组，可能已经存在，已存在就可以直接进行下一步
sudo groupadd docker 
#将当前登录用户（pi）加入到docker用户组中
sudo gpasswd -a $USER docker  
#更新用户组
sudo newgrp docker
```

### 5、重启 docker服务

```bash
$ sudo service docker restart 
```

### 6、查看版本
```sh
pi@raspberrypi:~/soft $ sudo newgrp docker 
root@raspberrypi:/home/pi/soft# 
root@raspberrypi:/home/pi/soft# sudo service docker restart 
root@raspberrypi:/home/pi/soft# docker -v
Docker version 23.0.1, build a5ee5b1
root@raspberrypi:/home/pi/soft# docker version
Client: Docker Engine - Community
 Version:           23.0.1
 API version:       1.42
 Go version:        go1.19.5
 Git commit:        a5ee5b1
 Built:             Thu Feb  9 19:46:41 2023
 OS/Arch:           linux/arm64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          23.0.1
  API version:      1.42 (minimum version 1.12)
  Go version:       go1.19.5
  Git commit:       bc3805a
  Built:            Thu Feb  9 19:46:41 2023
  OS/Arch:          linux/arm64
  Experimental:     false
 containerd:
  Version:          1.6.16
  GitCommit:        31aa4358a36870b21a992d3ad2bef29e1d693bec
 runc:
  Version:          1.1.4
  GitCommit:        v1.1.4-0-g5fd4c4d
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

```


### 7、运行hello-world容器

出现以下内容证明docker安装成功。

```sh
root@raspberrypi:/home/pi/soft# docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
7050e35b49f5: Pull complete 
Digest: sha256:aa0cc8055b82dc2509bed2e19b275c8f463506616377219d9642221ab53cf9fe
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (arm64v8)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

运行docker在特殊用户下使用

```sh
sudo newgrp docker
```

### 8、使用pip安装docker-compose
2022-09-22-raspios-bullseye-arm64-lite.img镜像自带版本的python     python3    python3.9

```sh
pi@raspberrypi:~/soft $ python --version
Python 2.7.16
```

Python 安装pip，请以root或具有[sudo权限](https://www.myfreax.com/how-to-create-a-sudo-user-on-ubuntu/)的用户在终端中运行命令

`sudo apt install python-pip`安装python 2.7的PIP。

```shell
pip3 install scrapy #最新版本
pip3 install scrapy==1.5 #安装指定版本
pip3 install -r requirements.txt #从requirements文件安装python包

pip3 list #列出已安装的软件包
pip3 install --upgrade package_name #使用pip升级python包
pip3 uninstall package_name #使用Pip卸载软件包
```

```sh
pi@raspberrypi:~/soft $ pip2 --version
pip 18.1 from /usr/lib/python2.7/dist-packages/pip (python 2.7)
```


```sh
curl -L "https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

curl -L "https://get.daocloud.io/docker/compose/releases/download/v1.25.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

查看docker-compse版本：

```sh
pi@raspberrypi:/srv $ docker-compose version
docker-compose version 1.29.2, build unknown
docker-py version: <module 'docker.version' from '/home/pi/.local/lib/python3.9/site-packages/docker/version.py'>
CPython version: 3.9.2
OpenSSL version: OpenSSL 1.1.1n  15 Mar 2022
```


## 四、安装Nginx


拉取nginx
```sh
docker pull nginx #拉取最新版本
```

创建Nginx配置文件 

启动前需要先创建Nginx外部挂载的配置文件（ /home/pi/soft/nginx/conf）
之所以要先创建 , 是因为Nginx本身容器只存在/etc/nginx 目录 , 本身就不创建 nginx.conf 文件
当服务器和容器都不存在 nginx.conf 文件时, 执行启动命令的时候 docker会将nginx.conf 作为目录创建 , 这并不是我们想要的结果 。

```sh
# 创建挂载目录
mkdir -p /home/pi/soft/nginx/conf
mkdir -p /home/pi/soft/nginx/log
mkdir -p /home/pi/soft/nginx/html
```


> 容器中的nginx.conf文件和conf.d文件夹复制到宿主机

```cobol
# 生成容器
docker run --name nginx -p 9001:80 -d nginx

# 将容器nginx.conf文件复制到宿主机
docker cp nginx:/etc/nginx/nginx.conf /home/pi/soft/nginx/conf/nginx.conf
# 将容器conf.d文件夹下内容复制到宿主机
docker cp nginx:/etc/nginx/conf.d /home/pi/soft/nginx/conf/conf.d
# 将容器中的html文件夹复制到宿主机
docker cp nginx:/usr/share/nginx/html /home/pi/soft/nginx/
```

### 创建Nginx容器并运行

> Docker 创建Nginx容器

```sh
# 直接执行docker rm nginx或者以容器id方式关闭容器
# 找到nginx对应的容器id
docker ps -a
# 关闭该容器
docker stop nginx
# 删除该容器
docker rm nginx
 
# 删除正在运行的nginx容器
docker rm -f nginx
```


```sh
docker run \
-p 9002:80 \
--name nginx \
-v /home/pi/soft/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
-v /home/pi/soft/nginx/conf/conf.d:/etc/nginx/conf.d \
-v /home/pi/soft/nginx/log:/var/log/nginx \
-v /home/pi/soft/nginx/html:/usr/share/nginx/html \
-d nginx:latest
```


	命令	   描述
	–name nginx	启动容器的名字
	-d	后台运行
	-p 9002:80	将容器的 9002(后面那个) 端口映射到主机的 80(前面那个) 端口
	-v /home/pi/soft/nginx/conf/nginx.conf:/etc/nginx/nginx.conf	挂载nginx.conf配置文件
	-v /home/pi/soft/nginx/conf.d:/etc/nginx/conf.d	挂载nginx配置文件
	-v /home/pi/soft/nginx/log:/var/log/nginx	挂载nginx日志文件
	-v /home/pi/soft/nginx/html:/usr/share/nginx/html	挂载nginx内容
	nginx:latest	本地运行的版本
	\	shell 命令换行

单行模式

```sh
docker run -p 9002:80 --name nginx -v /home/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v /home/nginx/conf/conf.d:/etc/nginx/conf.d -v /home/nginx/log:/var/log/nginx -v /home/nginx/html:/usr/share/nginx/html -d nginx:latest
```


重启容器
```sh
docker restart nginx
```


## 五、Bitwarden安装【成功】

[bitwarden-vaultwarden-docker搭建](https://blog.csdn.net/dyq94310/article/details/120250963)

### 安装bitwardenr密码管理程序

下载镜像
```sh
docker pull vaultwarden/server:1.27.0
```

创建密码保存
```sh
sudo mkdir /srv/bitwarden
sudo chmod go-rwx /srv/bitwarden
```

启动bitwarden
```sh
sudo docker run -d --name bitwarden -v /srv/bitwarden:/data -e WEBSOCKET_ENABLED=true -p 127.:80 -p 3012:3012 --restart on-failure vaultwarden/server:1.27.0
```

	-d 在后台运行
	
	-v 卷/srv/bitwarden 映射 docker镜像的/data，保证数据不丢失
	
	-e WEBSOCKET_ENABLED 开启websocket 需要使用websocket
	
	-p 端口映射 8080 是主程序的端口，3012是ws的端口
	
	–restart on-failure 在容器非正常退出时，重启



## 六、利用CF打洞，内网http映射公网https

### Public Hostname Page

### 给隧道起个名字 

根据要连接的网络使用描述性名称。建议仅为每个网络创建一个隧道。

### 选择您的环境

Choose an operating system: 选择操作系统：

Debian

Choose an architecture: 选择一种体系结构：

arm64-bit

###  安装和运行连接器

要将隧道连接到Cloudflare，请将以下命令之一复制粘贴到终端窗口中。远程管理的隧道要求您安装cloudflared 2022.03.04或更高版本。

```sh
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb && 

sudo dpkg -i cloudflared.deb && 

sudo cloudflared service install eyJhIjoiMDJmODVlXXXXXXXXXXXXXXXXXXXXXX
```

编辑演示隧道的公共主机名

![image.png](https://qiniu.121rh.com/obsidian/img/20230216230532.png)
![](安装bitwarden_20230216230531660.png)


## 七、Chrome插件无法登陆等问题

网友留言
1. 好像是老版本的服务端与新版本的插件不兼容，老版本的服务端被弃用了，所以要么用回老版本插件，要么更新服务端，但是大部分人用的docker镜像，服务端更新应该没那么快吧
2. 最新版无法登录的问题，如果用的是docker部署, 可以直接下载vaultwarden/server 1.27.0版本的，不要直接下载vaultwarden/server latest版本的， latest不知道是缓存还是什么原因，下载下来之后一直是1.23.1版本的， 这个版本还是21年发布的。想要确定版本的话docker启动的时候日志会打印版本号

![弃用通知](http://imgsrc.baidu.com/forum/pic/item/521d20ca39dbb6fdbc95d5e34c24ab18952b3775.jpg)

使用Docker拉取镜像，bitwarden指定版本号 V1.27.0 ，不指明版本号，就下载老版本[Bitwarden-2022.10.1](https://github.com/bitwarden/clients/releases/tag/browser-v2022.10.1) 插件（包括 android版、chrome插件、firefox插件）



## 八、登入bitwarden

注册并登入

![image.png](https://qiniu.121rh.com/obsidian/img/20230218214619.png)
![](bitwarden密码管理程序_20230218214618957.png)

Chrome浏览器利用[bitwarden插件](https://github.121rh.com/https://github.com/bitwarden/clients/releases/download/browser-v2023.2.1/dist-chrome-2023.2.1.zip)自动填充CSDN账号密码

![image.png](https://qiniu.121rh.com/obsidian/img/20230218214523.png)
![](bitwarden密码管理程序_20230218214521816.png)

[Windows平台](https://github.com/bitwarden/clients/releases/download/desktop-v2023.2.0/Bitwarden-Installer-2023.2.0.exe)

![image.png](https://qiniu.121rh.com/obsidian/img/20230218214906.png)
![](bitwarden密码管理程序_20230218214905349.png)



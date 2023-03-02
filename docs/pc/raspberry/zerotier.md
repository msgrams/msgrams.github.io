---
title: 树莓派zerotier组建局域网
description: zerotier组建局域网
tags:
  - raspberry
---
# zerotier 组建局域网

支持设备：windows、MacOS、Android、IOS、Linux、NAS

## 步骤：

1，创建一个ZeroTier网络

2，安装ZeroTie One客户端

3，在客户端中添加网络

4，授权客户端加入网络

![image.png](https://qiniu.121rh.com/obsidian/img/20230216082643.png)
![](zerotier_20230216082642240.png)


## 一、创建网络


登陆之后，直接点击create a network：创建一个网络
 
默认分配一个网络id，网络ID是非常重要的，其它设备要加入的这个网络，就需要这个网络ID


## 二、其它设备加入这个网络

电脑或者手机安装 zerotier ，加入网络 （join），记得在 zerotier 后台也同意接入。

然后到zerotier后台，对刚开的设备进行授权，允许它加入局域网中，红色虚线的是没有网络授权的设备，蓝色的表示授权了，只需要勾选上，此设备就可以加入网里面了

![image.png](https://qiniu.121rh.com/obsidian/img/20230216074807.png)
![](zerotier_20230216074805762.png)

## 三、开始各个设备互通

在zerotier主页面就可以看到各个设备的内网IP，然后复制这个内网ip，打开上面的服务，就可以了

Managed IPs

![image.png](https://qiniu.121rh.com/obsidian/img/20230216074922.png)
![](zerotier_20230216074921261.png)

组网成功后，直接通过IP访问该设备的共享文件或者访问nas设备

### 3.1首先了解我们需要认识的参数

1. Address 你使用的zeroTier客户端生成的参数。
2. Managed IPs，这些代表你们设备在局域网里各自的局域网ip地址。
3. Last Seen 最后一次看到这台设备在线的时间。
4. Version 客户端使用的ZeroTier的版本。
5. Physical IP 你的真实ip地址，别暴露了


```
Network ID
XXXXXXXXXXXXXXXX
```

在Linux系统下，安装并加入Net网

```sh
curl -s https://install.zerotier.com | sudo bash

sudo zerotier-cli join XXXXXXXXXXXXXXXX

sudo zerotier-cli listnetworks

```

![image.png](https://qiniu.121rh.com/obsidian/img/20230216083345.png)
![](zerotier_20230216083344046.png)


## 文章来源
- [zeroTier文档](https://docs.zerotier.com/getting-started/getting-started)
- [ZeroTier实现内网穿透详细教程，其实5分钟就可以搞定](https://blog.csdn.net/weixin_44786530/article/details/128283075)

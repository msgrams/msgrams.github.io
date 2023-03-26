---
title: 树莓派防火墙UFW
description:  使用ufw
tags:
  - Raspberry
---

## 一、启动防火墙

安装ufw

```sh
sudo apt-get install ufw
```

启动ufw

```sh
sudo ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup

```

设置入站规则为全关闭，出站规则为全开放

注意：ssh的22端口要及时添加到入站规则中，否则下次ssh将连接不上

```sh
sudo ufw default deny
Default incoming policy changed to 'deny'
(be sure to update your rules accordingly)

sudo ufw allow 22/tcp
Rule added
Rule added (v6)
```

## 二、防火墙规则

开启、关闭防火墙

```sh
sudo ufw enable
sudo ufw disable
```

查看防火墙的状态
```sh
sudo ufw status
```

## 三、端口的设置

开放tcp协议80端口
```sh
sudo ufw allow 80/tcp
```

移除80端口
```sh
 sudo ufw delete allow 80/tcp
```

开放RDP的3389端口
```sh
sudo ufw allow 3389
```

 移除3389端口
```sh
sudo ufw delete allow 3389
```

 开放10000-11000端口，需指定协议(tcp/udp)
```sh
sudo ufw allow 10000:11000/tcp
```

移除上述端口
```sh
sudo ufw delete allow 10000:11000/tcp
```

禁止外部访问smtp服务
```sh
sudo ufw deny smtp 
```

删除上面建立的某条规则
```sh
sudo ufw delete allow smtp 
```

## 四、IP的设置

允许192.168.1.110的访问，不限端口、协议

```sh
sudo ufw allow from 192.168.1.110
```

移除上条规则

```sh
sudo ufw delete allow from 192.168.1.110
```


## 五、raspberrypi 开发端口

```sh
pi@raspberrypi:~ $ sudo ufw status 
Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       Anywhere                  
8775/tcp                   ALLOW       Anywhere                  
Anywhere                   ALLOW       192.168.0.114             
22/tcp (v6)                ALLOW       Anywhere (v6)             
8775/tcp (v6)              ALLOW       Anywhere (v6) 
```


参考文章

- [树莓配置派防火墙](https://blog.51cto.com/u_15304255/3114511)
- [树莓派防火墙配置](https://blog.csdn.net/zifengzwz/article/details/112756566)


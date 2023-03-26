---
title: 树莓派安装OMV系统
description: 安装OMV系统
tags:
  - Raspberry
---
# 安装OMV系统
## 【1】DiskGenius 格式化SD卡

## 【2】树莓派系统 
2020-08-20-raspios-buster-arm64-lite.img

    系统下载地址：rasp_2020_download

## 【3】Win32 Disk Imager 重新烧入系统...

    软件下载地址：Win32_Disk_Imager

## 【4】在根目录boot下新建ssh文件
需要开启wifi访问也需要创建一个wpa_supplicant.conf文件写入wifi信息(安装omv最好用有线来安装）

## 【5】设置临时代理

```
export http_proxy=http://192.168.0.114:10809
export https_proxy=https://192.168.0.114:10809
```

## 【6】添加源 中科大和清华源 
【注意】只是添加不要把原来的源删除！！！

1.备份源文件。执行如下命令：

```
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.bak
```

2.修改软件更新源，执行如下命令：

```
sudo nano /etc/apt/sources.list
```

3.将第一行修改成中科大的软件源地址，「Ctrl+O」进行保存，然后回车，「Ctrl+X」退出。

```
# 中科大
deb http://mirrors.ustc.edu.cn/raspbian/raspbian/ buster main contrib non-free rpi
# 清华
deb http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main contrib non-free rpi
deb-src http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main contrib non-free rpi

```

4.修改系统更新源，执行如下命令：

```
sudo nano /etc/apt/sources.list.d/raspi.list
```

5.将第一行修改成中科大的系统源地址，「Ctrl+O」进行保存，然后回车，「Ctrl+X」退出。

```
#注释之前的，拷贝下面的中科大和清华镜像源到文件中
#中科大
deb http://mirrors.ustc.edu.cn/archive.raspberrypi.org/debian/ buster main ui
# 清华
deb http://mirrors.tuna.tsinghua.edu.cn/raspberrypi/ buster main ui
deb-src http://mirrors.tuna.tsinghua.edu.cn/raspberrypi/ buster main ui
```

6.同步更新源，执行如下命令：

```
sudo apt-get update
```

7.更新升级以安装软件包，这个过程耗时较长。

```
sudo apt-get upgrade
```

## 【7】安装Openmediavault 
安装openmediavault可以直接使用脚本一键安装

```
// 出现错误
sudo wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash

//暂时用这条命令(成功）
sudo wget -O - https://cdn.jsdelivr.net/gh/OpenMediaVault-Plugin-Developers/installScript@master/install | sudo bash
```

自此系统安装完成，打开http://192.168.0.108/

    用户名 admin
    密码 openmediavault


## 【8】映射网络驱动器

命令CMD
```
\\192.168.0.108
```
选中共享文件夹--右键--映射网络驱动器--驱动器选择Z盘--确定OK啦
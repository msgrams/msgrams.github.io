---
title: mysql无法启动服务
description: 无法启动服务
tags:
  - MySQL
---

## 一、【笨方法】
找了几个办法试了试都没解决问题，白白的浪费时间，所以用了这个笨方法！

1.备份C:\ProgramData\MySQL\MySQL Server 8.0 下的Data目录

2.删除MySQL8程序

3.删除目录

C:\ProgramData\MySQL\MySQL Server 8.0
```
Data
Uploads
installer_config.xml
my.ini
```

C:\Program Files\MySQL\MySQL Server 8.0
```
bin
docs
etc
include
lib
share
LICENSE
LICENSE.router
README
README.router
```

4.安装MySQL8.0（无报错)

5.停止mysql80服务

6.把备份的Data目录覆盖C:\ProgramData\MySQL\MySQL Server 8.0 下的Data

7.重启mysql80服务

8.尝试连接mysql数据库，发现连接上了并且数据没丢失。

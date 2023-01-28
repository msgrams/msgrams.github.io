---
title: mysql安装
description: mysql8安装简单介绍
tags:
  - MySQL
---
# mysql安装
## 1. MySQL的版本

版本分为四种：Alpha版、Beta版、RC版(Release Candidate)、GA版(Generally Available)。

Alpha版软件，这是软件工程对软件开发过程软件版本定义使用的版本说明。Alpha是内部测试版,一般不向外部发布,会有很多Bug.除非你也是测试人员,否则不建议使用.是希腊字母的第一位,表示最初级的版本，alpha 就是α。

Beta版软件，这也是软件工程中对软件开发测试版本控制的版本说明。Beta一般是Alpha后面的版本。该版本相对于α版已有了很大的改进，消除了严重的错误，但还是存在着一缺陷，需要经过多次测试来进一步消除。这个阶段的版本会一直加入新的功能。beta 就是β。

RC版，RC即Release Candidate的简写。这是Beta后面的版本，一般RC版并没有新增功能，而是修复了一些反馈的Beta中存在的BUG。所以RC版更接近最终发行版即稳定版(GA版)

GA版，GA即Generally Available的简写。这就是软件最终的发行版。这个版本一般BUG相对较少。这个发行版也可以叫稳定版。

Release版，在有些软件存在，在MySQL中一般没有这个版本。该版本意味“最终版本”，在前面版本的一系列测试版之后，终归会有一个正式版本，是最终交付用户使用的一个版本。该版本有时也称为标准版。一般情况下，Release不会以单词形式出现在软件封面上，取而代之的是符号(R)。  

> mysql8社区版[下载地址](https://dev.mysql.com/downloads/windows/installer/8.0.html)  

> mysql8.0参考手册[参考手册](https://dev.mysql.com/doc/refman/8.0/en/)

## 2. 安装过程

1.双击MySQL安装文件mysql-installer-community-8.0.18.0.msi，出现安装类型选项。

- Developer Default：开发者默认
- **Server only：只安装服务器端**    
- Client only：只安装客户端
- Full：安装全部选项
- Custom：自定义安装

2.选择，然后继续：

3.进入产品配置向导，配置多个安装细节，点击Next按钮即可。

4.高可靠性High Availability，采用默认选项即可。

- **Standalone MySQL Server/Classic MySQL Replication:独立MySQL服务器/经典MySQL复制**
- InnoDB Cluster:InnoDB集群

5.类型和网络 Type and Networking，采用默认选项即可。记住MySQL的监听端口默认是3306。

6.身份验证方法Authentication Method，采用默认选项即可。

7.账户和角色 Accounts and Roles。MySQL管理员账户名称是root，在此处指定root用户的密码。还可以在此处通过Add User按钮添加其他新账户，此处省略该操作。

8.Windows服务：Windows Service。

- Configure MySQL Server as a Windows Service:给MySQL服务器配置一个服务项。
- Windows Service Name:服务名称，采用默认名称**MySQL80**即可。
- Start the MySQL at System Startup：**系统启动时开启MySQL服务**

9.Apply Configuration：点击Execute按钮执行开始应用这些配置项。

- Writing configuration file: 写配置文件。
- Updating Windows Firewall rules：更新Windows防火墙规则
- Adjusting Windows services：调整Windows服务
- Initializing database：初始化数据库
- Starting the server： 启动服务器
- Applying security setting：应用安全设置
- Updating the Start menu link：更新开始菜单快捷方式链接

10.产品配置Product Configuration到此结束：点击Next按钮。

11.安装完成 Installation Complete。点击Finish按钮完成安装。

## 3. 查看MySQL的安装结果

1)安装了Windows Service：MySQL80，并且已经启动。
Win+R 输入services.msc 查看服务，搜索mysql80，并且启动。

2)安装了MySQL软件。安装位置为：C:\Program Files\MySQL。此目录是放的是**软件的内容**  

3)安装了MySQL数据文件夹，用来存放**MySQL基础数据和以后新增的数据**，安装位置为：C:\ProgramData\MySQL\MySQL Server 8.0（MySQL文件下的内容才是真正的MySQL中数据）

4)在MySQL数据文件夹中有MySQL的配置文件：my.ini。它是MySQL数据库中使用的配置文件，修改这个文件可以达到更新配置的目的。以下几个配置项需要大家特别理解。

- port=3306：监听端口是3306
- basedir="C:/Program Files/MySQL/MySQL Server 8.0/"：软件安装位置
- datadir=C:/ProgramData/MySQL/MySQL Server 8.0/Data：数据文件夹位置
- default_authentication_plugin=caching_sha2_password：默认验证插件
- default-storage-engine=INNODB：默认存储引擎
  （这些内容在Linux下可能会手动更改）

## 4. MySQL登录，访问，退出操作

1.登录：访问MySQL服务器对应的命令：mysql.exe ,位置：C:\Program Files\MySQL\MySQL Server 8.0\bin
打开控制命令台：win+r:【需要配置path环境变量】登录的命令：mysql  -hlocalhost -uroot –p  

- mysql：bin目录下的文件mysql.exe。mysql是MySQL的命令行工具，是一个客户端软件，可以对任何主机的mysql服务（即后台运行的mysqld）发起连接。
- -h：host主机名。后面跟要访问的数据库服务器的地址；如果是登录本机，可以省略
- -u：user 用户名。后面跟登录数据的用户名，第一次安装后以root用户来登录，是MySQL的管理员用户
- -p:   password 密码。一般不直接输入，而是回车后以保密方式输入。  

2.访问数据库  
显示数据库列表 show databases;  
切换当前数据库 use mysql;  
显示当前所有数据库表 show tables;  

3.退出  
使用quit或exit命令

## 5. 卸载数据库

1.停止服务：net stop mysql  
2.删除mysql软件  
3.删除软件文件夹Program Files中的mysql  
4.删除数据文件夹ProgramData中的mysql  
5.删除环境变量path路径  

## 5. 使用Navicat12

1.在连接mysql之前：  
MySQL8之前版本中加密规则mysql_native_password，而在MySQL8以后的加密规则为caching_sha2_password。解决此问题有两种方法，一种是更新navicat驱动来解决此问题，一种是将mysql用户登录的加密规则修改为mysql_native_password。此处采用第二种方式。  
2.设置密码永不过期  

```sql
alter user 'root'@'localhost' identified by 'root' password expire never;  
```

3.设置加密规则为mysql_native_password   

```sql
alter user 'root'@'localhost' identified with mysql_native_password by 'root';  
```

重新访问navicat，提示连接成功。

## 参考文章

- [mysql版本详解](https://blog.csdn.net/fuhanghang/article/details/104471877)
- [马士兵教育](https://space.bilibili.com/318518352)
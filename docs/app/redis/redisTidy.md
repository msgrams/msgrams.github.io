---
title: Redis
description: RedisTidy
tags:
  - Redis
---

# Redis
## 为什么使用Redis ?

数据库：关系型 、非关系型

关系型数据库：数据存储在文件中，并且字段必须要给出schema类型(字节宽度)，存储倾向于行级存储，那么当数据库中的表很大、性能就会下降，而且硬盘I/O也会成为瓶颈，此时查询速度变慢：少量数据查询很快，但在高并发场景下受硬盘限制就会影响速度。

- 磁盘：性能指标 1.寻址(ms)  2.带宽(G/M)
  鉴于硬盘等因素影响查询速度就出现-非关系型数据库：NoSQL(Not Only SQL)
- 内存：性能指标 1.寻址(ns) 2.带宽(很大)

A.基于内存的数据库，虽然掉电会失去数据，但是作为临时存储和查询来说，可以大大减少对磁盘IO操作和增大并发量。

B.从磁盘来看，一扇区512Byte，在索引4K操作系统上，一次读取数据至少4K。假如从磁盘读取1KB，但实际上读取4K。

常见的NoSQL数据库

- memcached ：键值对，内存型数据库，所有数据都在内存中。
- Redis：Memcached类似，还具备持久化能力。
- HBase：以列作为存储。
- MongoDB：以Document做存储

Redis以key-value形式存储在内存的数据库(平时操作的数据都存储在内存)，redis使用C语言编写的，可用作数据库、缓存、消息中间件。Redis以solt(槽)作为数据存储单元，每个槽存储N多个键值对，槽固定有16384个。理论上一个槽就是一个redis，每个向redis存储数据的Key都会进行crc16算法，得出一个值后对16384取余，这个Key存放solt的位置。

Redis支持多种类型数据结构：strings、hashs、lists、sets、sorted sets 范围查找、bitmaps ...

Redis内置 replication、LuaScripting、Transaction、persistence(磁盘持久化)、Sentinel + Cluster提高高可用性(High Availability)



技术选型、对比：[db-engines](https://db-engines.com/en/)

![image.png](https://qiniu.121rh.com/obsidian/img/20230209222723.png)
![](Redis整理_20230209222722114.png)


## 二、安装

### 环境

- centos 7
- redis官方 6.X    [redis-6.0.6.tar.gz](http://download.redis.io/releases/redis-6.0.6.tar.gz)

```sh
yum install -y wget  
cd ~ #当前用户目录
mkdir soft
cd soft
wget http://download.redis.io/releases/redis-6.0.6.tar.gz #
yum install -y lrzsz
tar xf redis-6.0.6.tar.gz

# 看README.md文档 ,直接make报错
yum -y install gcc gcc-c++ kernel-devel
make
```

### make报错
![image.png](https://qiniu.121rh.com/obsidian/img/20230209233256.png)

解决办法（升级gcc)
```sh
yum -y install centos-release-scl
yum -y install devtoolset-9-gcc devtoolset-9-gcc-c++ devtoolset-9-binutils
# 临时覆盖系统原有的gcc引用
scl enable devtoolset-9 bash
# 查看gcc版本 
gcc -v
```

升级gcc之后
```sh
make distclean
make
```

### 成功编译
![image.png](https://qiniu.121rh.com/obsidian/img/20230209233559.png)

cd src 目录
![image.png](https://qiniu.121rh.com/obsidian/img/20230209233805.png)

### 安装
```sh
# 默认安装
make install
# 自定义安装
make install PREFIX=/usr/local/redis
```
![image.png](https://qiniu.121rh.com/obsidian/img/20230209234120.png)

### 添加环境变量
```sh
vi /etc/profile
export REDIS_HOME=/usr/local/redis
export PATH=$PATH:$REDIS_HOME/bin

source /etc/profile
```

install_server.sh 可以执行一次或多次
```sh
cd ~/soft/redis-6.0.6/utils/
./install_server.sh
```
- 一个物理机通port来区别多个redis实例（进程）
- 一个redis实例在一份目录里，但多个实例在内存中需要各自的配置文件、持久化目录...
- 脚本自启动

查看redis进程
```sh
ps -ef | grep redis
```

### 启动并连接
```sh
# 启动
./redis-server
#连接
./redis-cli -p 6379
```

![image.png](https://qiniu.121rh.com/obsidian/img/20230209235747.png)





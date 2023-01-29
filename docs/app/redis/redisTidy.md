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
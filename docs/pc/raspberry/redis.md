---
title: 树莓派安装Redis
description:  To Using Docker Install Redis
tags:
  - Raspberry
---

## 一、Docker搜索redis镜像

> 命令：docker search <镜像名称>

```bash
docker search redis
```

可以看到有很多redis的镜像，此处因没有指定版本，所以下载的就是默认的最新版本 。**redis latest.**

## 二、Docker拉取镜像

> 命令：：docker pull <镜像名称>:<版本号>

```bash
docker pull redis
```

##  三、Docker挂载配置文件

接下来就是要将redis 的配置文件进行挂载，以配置文件方式启动redis 容器。（挂载：即将宿主的文件和容器内部目录相关联，相互绑定，在宿主机内修改文件的话也随之修改容器内部文件）

1）、挂载 redis 的配置文件

2）、挂载 redis 的持久化文件（为了数据的持久化）。

本人的配置文件是放在

liunx 下redis.conf文件位置：/home/pi/soft/redis/redis.conf

liunx 下redis的data文件位置 ：/home/pi/soft/redis/data


## 四、启动redis 容器

```sh
sudo docker run -p 6379:6379 --name redis -v /home/pi/soft/redis/redis.conf:/etc/redis/redis.conf -v /home/pi/soft/redis/data:/data -d redis redis-server /etc/redis/redis.conf --appendonly yes --restart=always --log-opt max-size=100m --log-opt max-file=2 --requirepass password
```

```
--restart=always 总是开机启动

--log是日志方面的

-p 6379:6379 将6379端口挂载出去

--name 给这个容器取一个名字

-v 数据卷挂载
	-/home/pi/soft/redis/redis.conf:/etc/redis/redis.conf:/etc/redis/redis.conf 这里是将 liunx 路径下的redis.conf 和 redis下的redis.conf 挂载在一起。
	- /home/pi/soft/redis/data:/data 这个同上
-d redis 表示后台启动redis

redis-server /etc/redis/redis.conf 以配置文件启动redis，加载容器内的conf文件，最终找到的是挂载的目录 /etc/redis/redis.conf 也就是liunx下的/home/pi/soft/redis/redis.conf

–appendonly yes 开启redis 持久化

–requirepass password 设置密码 （如果你是通过docker 容器内部连接的话，就随意，可设可不设。但是如果想向外开放的话，一定要设置）

```

报错

```sh
*** FATAL CONFIG FILE ERROR (Redis 6.2.6) ***
Reading the configuration file, at line 624
>>> 'repl-diskless-sync-max-replicas 0'
Bad directive or wrong number of arguments
```

解决： redis.conf 版本与docker pull redis最新版本不一致导致报错！！！


## 五、测试

1、通过docker ps指令查看启动状态

```bash
docker ps -a | grep redis # 通过docker ps指令查看启动状态，是否成功.
```

2、查看容器运行日志

> 命令：docker logs --since 30m <容器名>

此处 `--since 30m` 是查看此容器30分钟之内的日志情况。

```bash
docker logs --since 30m myredis
```


3、容器内部连接进行测试

进入容器

> 命令：docker exec -it <容器名> /bin/bash

此处跟着的 redis-cli 是直接将命令输在上面了。
```sh
docker exec -it redis redis-cli
```

进入之后，输入查看命令：

error是没有权限验证。~~（因为设置了密码的。）~~

**验证密码：**

```bash
auth 密码
```

**查看当前redis有没有设置密码：**~~（得验证通过了才能输入的）~~

```bash
config get requirepass
```



## 六、配置文件

**redis6.2.6-Chinese.conf**

```conf

#redis 配置

################################## 配置 include ###################################


# 加载配置文件
# include /path/to/local.conf
# include /path/to/other.conf

################################## 模块 #####################################


# 加载模块
# loadmodule /path/to/my_module.so
# loadmodule /path/to/other_module.so

################################## 网络 #####################################

#指定 redis 只接收来自于该IP地址的请求，如果不进行设置，那么将处理所有请求
#bind 127.0.0.1 -::1

#是否开启保护模式，默认开启。要是配置里没有指定bind和密码。开启该参数后，redis只会本地进行访问，
#拒绝外部访问。要是开启了密码和bind，可以开启。否则最好关闭，设置为no
protected-mode no

#tcp keepalive参数。如果设置不为0，就使用配置tcp的SO_KEEPALIVE值，
#使用keepalive有两个好处:检测挂掉的对端。降低中间设备出问题而导致网络看似连接却已经与对端端口的问题。
#在Linux内核中，设置了keepalive，redis会定时给对端发送ack。检测到对端关闭需要两倍的设置值
tcp-keepalive 300

################################# TLS/SSL #####################################

# 默认情况下，禁用TLS / SSL。要启用它，请使用“ tls-port”配置。
# tls-port 6379

# tls-cert-file redis.crt 
# tls-key-file redis.key

# tls-key-file-pass secret


# tls-client-cert-file client.crt
# tls-client-key-file client.key

# tls-client-key-file-pass secret

# tls-dh-params-file redis.dh

# tls-ca-cert-file ca.crt
# tls-ca-cert-dir /etc/ssl/certs

# tls-auth-clients no
# tls-auth-clients optional

# tls-replication yes

# tls-cluster yes

# tls-ciphers DEFAULT:!MEDIUM

# tls-ciphersuites TLS_CHACHA20_POLY1305_SHA256

# tls-prefer-server-ciphers yes

# tls-session-caching no

# tls-session-cache-size 5000

# tls-session-cache-timeout 60


################################# 通用 #####################################


# 是否后台启动（静默）
daemonize yes

# 可以通过upstart和systemd管理Redis守护进程，这个参数是和具体的操作系统相关的
# supervised auto

# redis的进程文件 
pidfile /var/run/redis_6379.pid

#指定了服务端日志的级别。级别包括：debug（很多信息，方便开发、测试），verbose（许多有用的信息）
#notice（适当的日志级别，适合生产环境），warn（只有非常重要的信息）
loglevel notice

 
#指定了记录日志的文件。空字符串的话，日志会打印到标准输出设备。后台运行的redis标准输出是/dev/null
logfile ""


#是否打开记录syslog功能
# syslog-enabled no


#syslog的标识符
# syslog-ident redis


#日志的来源、设备.
# syslog-facility local0


#数据库的数量，默认使用的数据库是0。可以通过”SELECT 【数据库序号】“命令选择一个数据库，序号从0开始
databases 16

# 是否显示redis logo
always-show-logo no

# By default, Redis modifies the process title (as seen in 'top' and 'ps') to
# provide some runtime information. It is possible to disable this and leave
# the process name as executed by setting the following to no.
set-proc-title yes

# When changing the process title, Redis uses the following template to construct
# the modified title.
#
# Template variables are specified in curly brackets. The following variables are
# supported:
#
# {title}           Name of process as executed if parent, or type of child process.
# {listen-addr}     Bind address or '*' followed by TCP or TLS port listening on, or
#                   Unix socket if only that's available.
# {server-mode}     Special mode, i.e. "[sentinel]" or "[cluster]".
# {port}            TCP port listening on, or 0.
# {tls-port}        TLS port listening on, or 0.
# {unixsocket}      Unix domain socket listening on, or "".
# {config-file}     Name of configuration file used.
#
proc-title-template "{title} {listen-addr} {server-mode}"

################################ rdb快照持久化  ################################

# rdb 持久化触发   每seconds(秒)有changes(个)键改变 在触发一次rdb持久化
# save <seconds> <changes>

#
# save 3600 1
# save 300 100
# save 60 10000


#当RDB持久化出现错误后，是否依然进行继续进行工作，yes：不能进行工作，no：可以继续进行工作
stop-writes-on-bgsave-error yes

# 配置存储至本地数据库时是否压缩数据，默认为yes。Redis采用LZF压缩方式，但占用了一点CPU的时间。
# 若关闭该选项，但会导致数据库文件变的巨大。建议开启。
rdbcompression yes

#是否校验rdb文件;从rdb格式的第五个版本开始，在rdb文件的末尾会带上CRC64的校验和。
#这跟有利于文件的容错性，但是在保存rdb文件的时候，会有大概10%的性能损耗，所以如果你追求高性能，可以关闭该配置
rdbchecksum yes

# rdb快照文件存储地址
dbfilename dump.rdb

# 在没有持久性的情况下删除复制中使用的RDB文件，通常情况下保持默认即可
rdb-del-sync-files no

数据目录，数据库的写入会在这个目录。rdb、aof文件也会写在这个目录
dir ./

################################# 主从集群 #################################

#
# 当本机为从服务时，设置主服务的IP及端口。例如：replicaof 192.168.233.233 6379。
# replicaof <masterip> <masterport>

#当本机为从服务时，设置主服务的连接密码
# masterauth <master-password>

# 当本机为从服务时，设置主服务的用户名
# masteruser <username>

#当slave失去与master的连接，或正在拷贝中，
#如果为yes，slave会响应客户端的请求，数据可能不同步甚至没有数据，
#如果为no，slave会返回错误"SYNC with master in progress"
replica-serve-stale-data yes

# 如果为yes，slave实例只读，如果为no，slave实例可读可写
replica-read-only yes

# 新的或者重连后不能继续备份的从服务器，需要做所谓的“完全备份”，即将一个RDB文件从主站传送到从站。这个传送有以下两种方式：
# 1、硬盘备份：redis主站创建一个新的进程，用于把RDB文件写到硬盘上。过一会儿，其父进程递增地将文件传送给从站。
# 2、无硬盘备份：redis主站创建一个新的进程，子进程直接把RDB文件写到从站的套接字，不需要用到硬盘。
# 在硬盘备份的情况下，主站的子进程生成RDB文件。一旦生成，多个从站可以立即排成队列使用主站的RDB文件。
#在无硬盘备份的情况下，一次RDB传送开始，新的从站到达后，需要等待现在的传送结束，才能开启新的传送。
#如果使用无硬盘备份，主站会在开始传送之间等待一段时间（可配置，以秒为单位），希望等待多个子站到达后并行传送。
repl-diskless-sync no

# 无盘复制延时开始秒数，默认是5秒，意思是当PSYNC触发的时候，master延时多少秒开始向master传送数据流，
# 以便等待更多的slave连接可以同时传送数据流，
#因为一旦PSYNC开始后，如果有新的slave连接master，只能等待下次PSYNC。可以配置为0取消等待，立即开始
repl-diskless-sync-delay 5

#是否使用无磁盘加载，有三项：
# 1、disabled：不要使用无磁盘加载，先将rdb文件存储到磁盘
# 2、on-empty-db：只有在完全安全的情况下才使用无磁盘加载
# 3、swapdb：解析时在RAM中保留当前db内容的副本，直接从套接字获取数据
repl-diskless-load disabled

# 指定slave定期ping master的周期，默认10秒钟
# repl-ping-replica-period 10

# 从服务ping主服务的超时时间，若超过repl-timeout设置的时间，slave就会认为master已经宕了
# repl-timeout 60

# 在slave和master同步后（发送psync/sync），后续的同步是否设置成TCP_NODELAY . 
# 假如设置成yes，则redis会合并小的TCP包从而节省带宽，但会增加同步延迟（40ms），
# 造成master与slave数据不一致 假如设置成no，则redis master会立即发送同步数据，没有延迟。
repl-disable-tcp-nodelay no

# 设置主从复制backlog容量大小。这个 backlog 是一个用来在 slaves 被断开连接时存放 slave 数据的 buffer，
#所以当一个 slave 想要重新连接，通常不希望全部重新同步，只是部分同步就够了，
#仅仅传递 slave 在断开连接时丢失的这部分数据。这个值越大，salve 可以断开连接的时间就越长
# repl-backlog-size 1mb

# 配置当master和slave失去联系多少秒之后，清空backlog释放空间。当配置成0时，表示永远不清空
# repl-backlog-ttl 3600

#当 master 不能正常工作的时候，Redis Sentinel 会从 slaves 中选出一个新的 master，
#这个值越小，就越会被优先选中，但是如果是 0 ， 那是意味着这个 slave 不可能被选中。 默认优先级为 100
replica-priority 100




################################## SECURITY(安全) ###################################
#ACL日志存储在内存中并消耗内存，设置此项可以设置最大值来回收内存
acllog-max-len 128

# acl 日志文件
# aclfile /etc/redis/users.acl

# 设置Redis连接密码
requirepass xiu123

# 将命令重命名。为了安全考虑，可以将某些重要的、危险的命令重命名。
#当你把某个命令重命名成空字符串的时候就等于取消了这个命令。
# rename-command CONFIG ""


################################### CLIENTS(客户端) ####################################

# 客户端最大连接数
# maxclients 10000

############################## MEMORY MANAGEMENT(内存管理) ################################

# 指定Redis最大内存限制。达到内存限制时，Redis将尝试删除已到期或即将到期的Key
# maxmemory <bytes>

# 存储到达最大内存限制的key删除策略
#1.volatile-lru：利用LRU算法移除设置过过期时间的key (LRU:最近使用 Least Recently Used )
#2.allkeys-lru：利用LRU算法移除任何key
#3.volatile-random：移除设置过过期时间的随机key
#4.allkeys-random：移除随机key
#5.volatile-ttl：移除即将过期的key(minor TTL)
#6.noeviction：不移除任何key，只是返回一个写错误 。默认选项
# maxmemory-policy noeviction

# LRU 和 minimal TTL 算法都不是精准的算法，但是相对精确的算法(为了节省内存)，随意你可以选择样本大小进行检测
# maxmemory-samples 5

# 从 Redis 5 开始，默认情况下，replica 节点会忽略 maxmemory 设置（除非在发生 failover 后，此节点被提升为 master 节点）。
# 这意味着只有 master 才会执行过期删除策略，并且 master 在删除键之后会对 replica 发送 DEL 命令。
# replica-ignore-maxmemory yes


############################# LAZY FREEING （惰性删除） ####################################


# 针对redis内存使用达到maxmeory，并设置有淘汰策略时，在被动淘汰键时，是否采用lazy free机制。
# 因为此场景开启lazy free, 可能使用淘汰键的内存释放不及时，导致redis内存超用，超过maxmemory的限制
lazyfree-lazy-eviction no

# 针对设置有TTL的键，达到过期后，被redis清理删除时是否采用lazy free机制。
# 此场景建议开启，因TTL本身是自适应调整的速度。
lazyfree-lazy-expire no

# 针对有些指令在处理已存在的键时，会带有一个隐式的DEL键的操作。如rename命令，当目标键已存在,redis会先删除目标键，
# 如果这些目标键是一个big key,那就会引入阻塞删除的性能问题。 此参数设置就是解决这类问题，建议可开启。
lazyfree-lazy-server-del no

# 针对slave进行全量数据同步，slave在加载master的RDB文件前，会运行flushall来清理自己的数据场景，参数设置决定是否采用异常flush机制。
# 如果内存变动不大，建议可开启。可减少全量同步耗时，从而减少主库因输出缓冲区爆涨引起的内存使用增长
replica-lazy-flush no

# 对于替换用户代码DEL调用的情况，也可以这样做
# 使用UNLINK调用是不容易的，要修改DEL的默认行为
# 命令的行为完全像UNLINK。
lazyfree-lazy-user-del no

lazyfree-lazy-user-flush no

################################ THREADED I/O(线程 IO) #################################


# io-threads 4
#
# 
# io-threads-do-reads no


############################ KERNEL OOM CONTROL ##############################

# On Linux, it is possible to hint the kernel OOM killer on what processes
# should be killed first when out of memory.
#
# Enabling this feature makes Redis actively control the oom_score_adj value
# for all its processes, depending on their role. The default scores will
# attempt to have background child processes killed before all others, and
# replicas killed before masters.
#
# Redis supports three options:
#
# no:       Don't make changes to oom-score-adj (default).
# yes:      Alias to "relative" see below.
# absolute: Values in oom-score-adj-values are written as is to the kernel.
# relative: Values are used relative to the initial value of oom_score_adj when
#           the server starts and are then clamped to a range of -1000 to 1000.
#           Because typically the initial value is 0, they will often match the
#           absolute values.
oom-score-adj no

# When oom-score-adj is used, this directive controls the specific values used
# for master, replica and background child processes. Values range -2000 to
# 2000 (higher means more likely to be killed).
#
# Unprivileged processes (not root, and without CAP_SYS_RESOURCE capabilities)
# can freely increase their value, but not decrease it below its initial
# settings. This means that setting oom-score-adj to "relative" and setting the
# oom-score-adj-values to positive values will always succeed.
oom-score-adj-values 0 200 800


#################### KERNEL transparent hugepage CONTROL ######################

# Usually the kernel Transparent Huge Pages control is set to "madvise" or
# or "never" by default (/sys/kernel/mm/transparent_hugepage/enabled), in which
# case this config has no effect. On systems in which it is set to "always",
# redis will attempt to disable it specifically for the redis process in order
# to avoid latency problems specifically with fork(2) and CoW.
# If for some reason you prefer to keep it enabled, you can set this config to
# "no" and the kernel global to "always".

disable-thp yes

############################## APPEND ONLY MODE （AOF持久化） ###############################

#是否启用aof持久化方式
appendonly no

#aof持久化文件名
appendfilename "appendonly.aof"

#aof文件刷新的频率。有三种：
# 1.no 依靠OS进行刷新，redis不主动刷新AOF，这样最快，但安全性就差。
# 2.always 每提交一个修改命令都调用fsync刷新到AOF文件，非常非常慢，但也非常安全。
# 3.everysec 每秒钟都调用fsync刷新到AOF文件，很快，但可能会丢失一秒以内的数据。

# appendfsync always
appendfsync everysec
# appendfsync no

# 指定是否在后台aof文件rewrite期间调用fsync，默认为no，表示要调用fsync
# Redis在后台写RDB文件或重写AOF文件期间会存在大量磁盘IO，此时，在某些linux系统中，调用fsync可能会阻塞
no-appendfsync-on-rewrite no

# aof自动重写配置，aof文件增长比例到达该配置后重写。
# aof重写即在aof文件在一定大小之后，重新将整个内存写到aof文件当中，以反映最新的状态(相当于bgsave)。
# 避免了aof文件过大而实际内存数据小的问题(频繁修改数据问题)
auto-aof-rewrite-percentage 100
#aof文件重写最小的文件大小，即最开始aof文件必须要达到这个文件时才触发，
#后面的每次重写就不会根据这个变量了(根据上一次重写完成之后的大小)
auto-aof-rewrite-min-size 64mb

#指redis在恢复时，会忽略最后一条可能存在问题的指令。默认值yes。
#即在aof写入时，可能存在指令写错的问题(突然断电，写了一半)，这种情况下，yes会log并继续，而no会直接恢复失败。
aof-load-truncated yes

#混合持久化 在开启了这个功能之后，AOF重写产生的文件将同时包含RDB格式的内容和AOF格式的内容
aof-use-rdb-preamble yes

################################ LUA SCRIPTING(LUA 脚本) ###############################

#一个Lua脚本最长的执行时间，单位为毫秒
lua-time-limit 5000

################################ REDIS CLUSTER (集群) ###############################


# 如果是yes，表示启用集群，否则以单例模式启动
# cluster-enabled yes

# 集群配置文件 Redis集群节点自动持久化每次配置的改变，为了在启动的时候重新读取它
# cluster-config-file nodes-6379.conf

# 集群节点不可用的最大时间。如果一个master节点不可到达超过了指定时间，则认为它失败了
# cluster-node-timeout 15000

# 在进行故障转移的时候，全部slave都会请求申请为master，
# 但是有些slave可能与master断开连接一段时间了，导致数据过于陈旧，这样的slave不应该被提升为master。
# 该参数就是用来判断slave节点与master断线的时间是否过长。
#判断方法是：
#比较slave断开连接的时间和(node-timeout * slave-validity-factor) + repl-ping-slave-period
#如果节点超时时间为三十秒, 并且slave-validity-factor为10,假设默认的repl-ping-slave-period是10
秒，即如果超过310秒slave将不会尝试进行故障转移
# cluster-replica-validity-factor 10

# 一个master和slave保持连接的最小数量（即：最少与多少个slave保持连接），
#也就是说至少与其它多少slave保持连接的slave才有资格成为master(故障转移)
# cluster-migration-barrier 1


# 是否允许故障自动迁移
# cluster-allow-replica-migration yes

# 集群全部的slot有节点负责，集群状态才为ok，才能提供服务。设置为no，可以在slot没有全部分配的时候提供服务。
#不建议打开该配置，这样会造成分区的时候，小分区的master一直在接受写请求，而造成很长时间数据不一致
# cluster-require-full-coverage yes

# 此选项设置为yes时，可防止从设备尝试对其进行故障转移master在主故障期间。仍然可以强制执行手动故障转移
# cluster-replica-no-failover no

# This option, when set to yes, allows nodes to serve read traffic while the
# the cluster is in a down state, as long as it believes it owns the slots. 
#
# This is useful for two cases.  The first case is for when an application 
# doesn't require consistency of data during node failures or network partitions.
# One example of this is a cache, where as long as the node has the data it
# should be able to serve it. 
#
# 是否允许集群在宕机时读取
# cluster-allow-reads-when-down no

########################## CLUSTER DOCKER/NAT support(docker集群/NAT支持)  ########################


# 宣布IP地址
# cluster-announce-ip 10.1.1.5
# 宣布服务端口 tls端口
# cluster-announce-tls-port 6379
# cluster-announce-port 0
# 宣布集群总线端口
# cluster-announce-bus-port 6380

################################## SLOW LOG(慢查询日志) ###################################

# 超过该查询配置事件的操作记录为慢查询
slowlog-log-slower-than 10000

# 决定 slow log 最多能保存多少条日志， slow log 本身是一个 FIFO 队列（淘汰策略也是FIFO）
slowlog-max-len 128

################################ LATENCY MONITOR(延时监控) ##############################

# 能够采样不同的执行路径来知道redis阻塞在哪里。这使得调试各种延时问题变得简单，设置一个毫秒单位的延时阈值来开启延时监控。  
latency-monitor-threshold 0

############################# EVENT NOTIFICATION(事件通知) ##############################

# 键事件通知，可用参数：
# K 键空间通知，所有通知以 keyspace@ 为前缀.
# E 键事件通知，所有通知以 keyevent@ 为前缀
# g DEL 、 EXPIRE 、 RENAME 等类型无关的通用命令的通知
# $ 字符串命令的通知
# l 列表命令的通知
# s 集合命令的通知
# h 哈希命令的通知
# z 有序集合命令的通知
# x 过期事件：每当有过期键被删除时发送
# e 驱逐(evict)事件：每当有键因为 maxmemory 策略而被删除时发送
# A 参数 g$lshzxe 的别名
# 书写：notify-keyspace-events Ex
# 默认配置项：notify-keyspace-events " "

#  notify-keyspace-events Ex
#


############################### GOPHER SERVER(GOPHER协议服务) #################################

# 开启gopher功能 Intemet上广泛使用的菜单式信息浏览工具
# gopher-enabled no

############################### ADVANCED CONFIG（高级配置） ###############################

# 这个参数指的是ziplist中允许存储的最大条目个数，默认为512，建议为128。
hash-max-ziplist-entries 512
# ziplist中允许条目value值最大字节数，默认为64，建议为1024。
hash-max-ziplist-value 64

# ziplist列表最大值，默认存在五项：
#   -5:最大大小:64 Kb <——不建议用于正常工作负载
#   -4:最大大小:32 Kb <——不推荐
#   -3:最大大小:16 Kb <——可能不推荐
#   -2:最大大小:8 Kb<——很好
#   -1:最大大小:4 Kb <——好
list-max-ziplist-size -2

#  一个quicklist两端不被压缩的节点个数。
# 0: 表示都不压缩。这是Redis的默认值。
# 1: 表示quicklist两端各有1个节点不压缩，中间的节点压缩。
# 3: 表示quicklist两端各有3个节点不压缩，中间的节点压缩。
list-compress-depth 0

# 当集合中的元素全是整数,且长度不超过set-max-intset-entries(默认为512个)时,redis会选用intset作为内部编码，大于512用set
set-max-intset-entries 512

# 当有序集合的元素小于zset-max-ziplist-entries配置(默认是128个)
# 同时每个元素的值都小于zset-max-ziplist-value(默认是64字节)时
# Redis会用ziplist来作为有序集合的内部编码实现,ziplist可以有效的减少内存的使用。
zset-max-ziplist-entries 128
zset-max-ziplist-value 64

# value大小 小于等于hll-sparse-max-bytes使用稀疏数据结构（sparse），大于hll-sparse-max-bytes使用稠密的数据结构
hll-sparse-max-bytes 3000

# Streams单个节点的字节数，以及切换到新节点之前可能包含的最大项目数。
stream-node-max-bytes 4096
stream-node-max-entries 100

# 主动重新散列每100毫秒CPU时间使用1毫秒，以帮助重新散列主Redis散列表（将顶级键映射到值）
activerehashing yes

# 对客户端输出缓冲进行限制可以强迫那些不从服务器读取数据的客户端断开连接，用来强制关闭传输缓慢的客户端
client-output-buffer-limit normal 0 0 0
# 对于slave client和MONITER client，如果client-output-buffer一旦超过256mb，又或者超过64mb持续60秒，那么服务器就会立即断开客户端连接。
client-output-buffer-limit replica 256mb 64mb 60
# 对于pubsub client，如果client-output-buffer一旦超过32mb，又或者超过8mb持续60秒，那么服务器就会立即断开客户端连接。
client-output-buffer-limit pubsub 32mb 8mb 60

# 客户端查询缓冲区累积新命令。 默认情况下，它被限制为固定数量，以避免协议失步（例如由于客户端中的错误）将导致查询缓冲区中的未绑定内存使用。
# 但是，如果您有非常特殊的需求，可以在此配置它，例如我们巨大执行请求。
# client-query-buffer-limit 1gb

# 在Redis协议中，批量请求（即表示单个字符串的元素）通常限制为512 MB。 但是，您可以在此更改此限制
# proto-max-bulk-len 512mb

# 默认情况下，hz设置为10.提高值时，在Redis处于空闲状态下，将使用更多CPU。范围介于1到500之间，
# 大多数用户应使用默认值10，除非仅在需要非常低延迟的环境中将此值提高到100。
hz 10

# 启用动态HZ时，实际配置的HZ将用作基线，但是一旦连接了更多客户端，将根据实际需要使用配置的HZ值的倍数。
dynamic-hz yes

# 当一个子进程重写AOF文件时，如果启用下面的选项，则文件每生成32M数据会被同步
aof-rewrite-incremental-fsync yes

# 当redis保存RDB文件时，如果启用了以下选项，则每生成32 MB数据将对文件进行fsync。 
# 这对于以递增方式将文件提交到磁盘并避免大延迟峰值非常有用
rdb-save-incremental-fsync yes


# lfu-log-factor 10
# lfu-decay-time 1

########################### ACTIVE DEFRAGMENTATION（活跃的碎片整理） #######################


# 是否启用碎片整理
# activedefrag no

# 启动活动碎片整理的最小碎片浪费量
# active-defrag-ignore-bytes 100mb

# 启动碎片整理的最小碎片百分比
# active-defrag-threshold-lower 10

# 使用最大消耗时的最大碎片百分比
# active-defrag-threshold-upper 100

# 在CPU百分比中进行碎片整理的最小消耗
# active-defrag-cycle-min 1

# 在CPU百分比达到最大值时，进行碎片整理
# active-defrag-cycle-max 25

# 从set / hash / zset / list 扫描的最大字段数
# active-defrag-max-scan-fields 1000

# 默认情况下，用于清除的Jemalloc后台线程是启用的。
jemalloc-bg-thread yes



# 设置 redis server的IO线程数
# server_cpulist 0-7:2
#

# 设置 阻塞IO线程数
# bio_cpulist 1,3
#

# aof_rewrite_cpulist 8-11
#

# bgsave_cpulist 1,10-11

# In some cases redis will emit warnings and even refuse to start if it detects
# that the system is in bad state, it is possible to suppress these warnings
# by setting the following config which takes a space delimited list of warnings
# to suppress
#
# ignore-warnings ARM64-COW-BUG

```


## 参考文章

- [最详细Docker安装Redis （含每一步的图解）实战](https://blog.csdn.net/weixin_45821811/article/details/116211724)
- [Redis-6.2.* 版本配置文件redis.conf详解](https://blog.csdn.net/qq_34908167/article/details/127090690)

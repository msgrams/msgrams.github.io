---
title: 代码问题归纳
description: Java代码、MySQL数据库、Nacos注册中心...出现问题记录
tags:
  - Java
---


# 代码问题归纳

## nacos注册中心启动报错

```java
2023-05-05 13:45:38,604 WARN Exception encountered during context initialization - cancelling refresh attempt: org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'memoryMonitor' defined in URL [jar:file:/D:/Program1it/nacos/target/nacos-server.jar!/BOOT-INF/lib/nacos-config-2.0.3.jar!/com/alibaba/nacos/config/server/monitor/MemoryMonitor.class]: Unsatisfied dependency expressed through constructor parameter 0; nested exception is org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'asyncNotifyService': Unsatisfied dependency expressed through field 'dumpService'; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'externalDumpService': Invocation of init method failed; nested exception is ErrCode:500, ErrMsg:Nacos Server did not start because dumpservice bean construction failure :
No DataSource set

2023-05-05 13:45:38,635 INFO Nacos Log files: D:\Program1it\nacos\logs
2023-05-05 13:45:38,635 INFO Nacos Log files: D:\Program1it\nacos\conf
2023-05-05 13:45:38,635 INFO Nacos Log files: D:\Program1it\nacos\data
2023-05-05 13:45:38,635 ERROR Startup errors :

org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'memoryMonitor' defined in URL 
```

解决

1、检查是否启动mysql服务

2、没有启动，则先启动mysql服务`net start 本地mysql服务的名称`

3、再次启动nacos，不报错！

## Navicat 可视化操作MySQL数据库--时间问题

当gmt_create、gmt_modified，时间类型字段，如果被勾选上“根据当前时间戳更新”

每次有其他字段被更新时，该行记录的gmt_create、gmt_modified字段都会自动更新为当前时间。

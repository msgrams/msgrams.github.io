---
title: 代码问题归纳
description: Java代码、MySQL数据库、Nacos注册中心...出现问题记录
tags:
  - Java
---

# 代码问题归纳

## Nacos注册中心启动报错

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

## restTemplate.postForEntity()方法

```java
@Autowired  
private RestTemplate restTemplate;
```

注入RestTemplate之后，使用restTemplate.postForEntity()方法

- `restTemplate.postForEntity(URI.create(url.toString()), null, String.class);`
- `restTemplate.postForEntity(url.toString(), null, String.class);`

这两行代码都是使用 Spring 框架提供的 `RestTemplate` 类进行 HTTP POST 请求。

第一行代码中，使用了 `URI.create(url.toString())` 方法将一个字符串类型的 URL 转换为 `URI` 类型，然后将该 `URI` 对象作为第一个参数传递给了 `postForEntity` 方法。第二个参数用于指定请求所需的数据，这里传入了一个空对象。第三个参数则指定了响应体的类型，这里是 `String.class`，表示接收到的响应体将被解析为字符串。

第二行代码与第一行代码基本相同，只是将 `postForEntity` 方法的第一个参数直接传入了一个字符串类型的 URL，而没有使用 `URI` 类型。在内部实现中，Spring 会自动将该字符串类型的 URL 转换成 `URI` 对象，然后再继续执行请求。

两行代码的区别在于第一个参数的类型不同，第一行代码中的参数类型是 `URI`，第二行代码中的参数类型是字符串。通常来说，我们可以直接将字符串类型的 URL 传递给 `postForEntity` 方法，而不需要显式地创建一个 `URI` 对象。但是，在某些情况下，比如需要额外的 URL 格式验证或者需要处理 URL 中的特殊字符时，我们需要先将字符串类型的 URL 转换成 `URI` 对象，然后将其传递给 `postForEntity` 方法。

另外，两行代码中都传入了一个空对象作为请求体，这是因为在某些情况下，HTTP POST 请求不需要传递请求体，只需要传递一些请求参数即可。此时，我们可以将请求体设置为空对象或者为 null。

参考文献：

[[1](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/client/RestTemplate.html#postForEntity-java.net.URI-java.lang.Object-java.lang.Class-)]

[[2](https://docs.oracle.com/javase/10/docs/api/java/net/URI.html)]


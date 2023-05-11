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

## MySQLGenerator自动生成代码工具类

引入两个包：mybatis-plus-generator、freemarker

- mybatis-plus-generator

  MyBatis-Plus Generator 是 MyBatis-Plus 代码生成器模块，可以通过使用代码生成器快速生成 MyBatis-Plus 的实体类、Mapper接口、Service接口、ServiceImpl实现、controller等常用文件，从而提高开发效率。

  MyBatis-Plus Generator 支持自定义模板，内置 Velocity、Freemarker、Beetl、Jinjava 四种模板引擎，并且支持自定义注释、自定义类型转换器等功能，方便进行二次开发和集成。

  使用 MyBatis-Plus Generator 可以大量减少开发人员的重复工作，提高开发效率，同时也更加规范化地生成代码，保证了代码风格的统一性。

  具体使用方法可以参考 MyBatis-Plus 官方文档，在文档中有详细的使用示例和配置说明。

  参考文献：

  [[1](https://mybatis.plus/guide/generator.html)]

- freemarker

  FreeMarker 是一款基于模板的通用性文本生成引擎，支持多种文本输出格式，包括 HTML、XML、JSON、CSS、JavaScript 等。它提供了一种灵活的模板语言，可以方便地进行动态生成文件的工作。

  FreeMarker 采用面向对象的思想，将模板和数据分离，将数据传递给模板引擎进行处理，并生成最终的结果。由于模板和代码分离，因此在开发过程中可以更加专注于业务逻辑的实现，提高了代码的可维护性。

  FreeMarker 支持多种数据源，可以将数据从数据库、Web服务、本地文件等不同来源获取，并在模板中进行处理和转换。同时，它还提供了一些实用的工具和标签，可以用于流程控制、条件判断、循环遍历、格式化输出等操作，非常方便实用。

  FreeMarker 同时也是 MyBatis-Plus 的代码生成器模块所使用的一种模板引擎，可以通过配置模板文件和数据源，快速生成带有样板代码的实体类及其相应的 Mapper 接口、Service 接口、ServiceImpl 实现类等常用文件。

```xml
        <dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-generator</artifactId>
            <version>3.5.1</version>
        </dependency>
        <dependency>
            <groupId>org.freemarker</groupId>
            <artifactId>freemarker</artifactId>
        </dependency>
```



```java
 public static void main(String[] args) {

        FastAutoGenerator.create(
                "jdbc:mysql://localhost:3306/service-price?characterEncoding=utf-8&serviceTimezone=GMT%2B8",
                "root",
                "password"
        )
                .globalConfig(builder -> {
                    builder.author("lizhi").fileOverride().outputDir("D:\\....\\src\\main\\java");
                })
                .packageConfig(builder -> {
                    builder.parent("com.msb.serviceprice").pathInfo(Collections.singletonMap(OutputFile.mapperXml,
                            "D:\\.....\\serviceprice\\mapper"));
                })
                .strategyConfig(builder -> {
                    builder.addInclude("price_rule");
                })
                .templateEngine(new FreemarkerTemplateEngine())
                .execute();
    }
```



## 两个主键插入不成功

在一个表中，主键是用来唯一标识每一条记录的，同一个表中不能有重复的主键值。如果尝试向表中插入两条具有相同主键的记录，就会引起唯一性约束冲突，从而导致插入失败。

解决这个问题的方法可以是：

1. 检查数据是否真的需要使用主键进行标识，如果可以使用其他列或者多列组合作为复合主键，则可以避免该问题。
2. 如果必须使用主键作为唯一标识符，可以考虑重新设计主键生成策略，如使用自增序列、UUID等方式保证主键唯一性。
3. 对于已经存在的记录，在插入新纪录前需要查询表中是否已经存在相同主键值的记录。如果已经存在，则需要进行更新操作。

总之，在处理主键冲突时，需要根据实际情况选择合适的解决方案，以保证表中数据的完整性和正确性。

```sql
    int update(@Param("et") T entity, @Param("ew") Wrapper<T> updateWrapper);
```

这是MyBatis-Plus框架提供的通用Mapper中的一个更新方法。其中，@Param("et")表示要更新的实体对象，@Param("ew")表示更新条件。

具体来说，该方法用于根据where条件更新表中的一条或多条记录。参数"et"为更新后的实体对象，参数"ew"为查询条件对象。查询条件对象可以使用QueryWrapper和LambdaQueryWrapper等对象进行构造。

该方法会动态地生成SQL语句，根据updateWrapper中的条件，更新符合条件的记录。

在实际开发中，可以通过调用该方法来方便地进行数据更新操作。

### 为什么本来2个主键 不能重复 三个主键就可以重复插入数据

在关系型数据库中，主键是用来唯一标识每条记录的字段，它的作用在于确保表中每个记录都有一个唯一的标识符。因为主键的值不能为空，而且必须具有唯一性，所以在设计表结构时需要选取合适的字段作为主键。

如果一个表中定义了两个主键，则这两个主键组成了一个复合主键，复合主键的唯一性要求是所有主键字段值的组合都不能重复。也就是说，只有当这两个主键的组合在表中都不存在时，才能插入新记录，否则将会产生唯一性冲突。

而三个主键可以重复插入数据的情况，可能是因为在这种情况下，三个主键的组合不是唯一性约束条件，还有别的字段或条件在起作用。例如，在某些情况下可以使用复合主键加上一个唯一索引来实现该表的唯一性约束，即使是主键之间有重复数据，但只要其他唯一索引不冲突，仍然可以插入新数据。

总之，主键的唯一性是确保表中记录唯一正确的重要保证，需要根据具体的业务场景和需求来选择合适的主键设计方式，并严格按照设置的唯一性约束条件来进行数据操作。


---
title: mysql基础
description: 表的创建、约束、查询
tags:
  - MySQL
---
# mysql基础知识
## 1. 五个部分

1.DQL 数据查询语言（Data Query Language），用于数据查询，组合来查询一条或多条数据 

- select 子句
- form 子句
- where 子句  

2.DML 数据操作语言（Data Manipulation Language），对数据进行增加、修改、删除  

- insert 增加数据  
- update 修改数据  
- delete 删除数据 

3.DDL 数据定义语言（Data Definition Language，DDL）用针对是数据库对象（数据库、表、索引、视图、触发器、存储过程、函数）进行创建、修改和删除操作  

- create 创建数据库对象
- alter 修改数据库对象
- drop 删除数据库对象

4.DCL 数据控制语言（Data Control Language，DCL）用来授予或回收访问 数据库的权限  

- grant 授予用户权限
- revoke 回收授予权限

5.TCL 事务控制语言（Transaction Control Language，TCL）用于数据库的事务管理

- start transaction 开启事务
- commit 提交事务
- rollback 回滚事务
- set transaction 设置事务属性

## 2. DDL_DML_创建数据库表

### 创建t_student表

- 建立一张用来存储学生信息的表
- 字段包含学号、姓名、性别，年龄、入学日期、班级，email等信息
- 学号是主键 = 不能为空 +  唯一
- 姓名不能为空
- 性别默认值是男
- Email唯一

1.用Navicat图形界面连接mysql后，新建数据库，起个数据库名字mytestdb，字符集utf8mb4（对应utf-8字符集）  
2.新建查询

```sql
注释写法
#单行注释
-- 单行注释
/*多行注释*/

-- 创建数据库表：
create table t_student(
    sno int(6), #6为显示的长度
    sname varchar(5), #5为显示字符数量
    sex char(1), #1个字符
    age int(3),
    enterdate date, #入学日期
    classname varchar(10),
    email varchar(15)
);

-- 查看表结构：展示表的字段信息
desc t_student;

-- 查看表中数据
select * from t_student;

-- 查看建表语句
show create table t_student;

```

### 数据库表列类型

1.整数类型

| 整数类型  | 大小    | 表数范围        | 表数范围 | 作用     |
| :-------- | :------ | :-------------- | :------- | :------- |
| tinyint   | 1字节   | -128,127        | 0,255    | 小整数值 |
| smallint  | 2字节   | -32768,32767    | 0,65535  | 大整数值 |
| mediumint | 3字节   | -838868,8388607 | 0~1677万 | 大整数值 |
| int       | 4个字节 | -21亿~21亿      | 0~21亿   | 一般整数 |
| bigint    | 8个字节 | 64位            |          | 最大整数 |

eg: int(4) 整数数值(显示宽度),"显示宽度"并不限制在列内保存值的范围，也不限制超过列的指定宽度的值的显示  
主键自增：不适用序列，整数类型，通过auto_increment

2.浮点数类型

| 浮点数类型 | 大小  | 作用         |
| :--------- | :---- | :----------- |
| float      | 4字节 | 单精度浮点数 |
| double     | 8字节 | 双精度浮点数 |

eg: 浮点与整数类型不一样，浮点类型宽度不会自动扩充，score double(4,1) 总宽度4位，小数位1位，并且不会自动扩充。

3.字符串类型

| 字符串类型 | 大小                | 描述                          |
| :--------- | :------------------ | :---------------------------- |
| char(M)    | 0~255字节           | 允许长度0~M个字符的定长字符串 |
| varchar(M) | 0~65535字节         | 允许长度0~M个字符的定长字符串 |
| blob       | binary large object | 二进制形式的长文本数据        |
| text       |                     | 长文本数据                    |

eg：char 和 varchar类型相似，都用在存储较短的字符串，但是存储方式不同，**char类型长度固定，varchar类型长度可变**因为varchar类型能够根据字符串的实际长度来动态改变所占字节的大小，所以在不能明确该字段具体需要多少字符时推荐使用VARCHAR类型，这样可以大大地节约磁盘空间、提高存储效率。  
char和varchar表示的是字符的个数，而不是字节的个数

4.日期和时间类型

| 类型     | 格式                | 取值范围              | 0值        |
| :------- | :------------------ | :-------------------- | :--------- |
| date     | YYYY-MM-DD          | 1000-01-01,9999-12-32 | 0000-00-00 |
| datetime | YYYY-MM-DD HH:MM:SS |                       |            |

### DML_添加数据

```sql
-- 查看表记录
select * from t_student;

-- 在t_student表中插入数据
insert into t_student values(1,'小红','女',17,'2022-6-6','java2班','123@136.com');
insert into t_student values(2,'小黑','男',18,'2021-5-5','python3班','235@136.com');
insert into t_student values(3,'小张','男',18,'2020.8.9','mysql6班','555@136.com');
insert into t_student values(9,'小李','女',20,'2023-12-1','java2班','666@136.com');
insert into t_student values(7,'小龙','男',19,'2022-2-13','python3班','777@136.com');
insert into t_student (sno,sname,sex,enterdate) values (10,'小欧','男','2023-5-25');    
```

**注意**

1. int类型 宽度为显示宽度，如果宽度超过设定的位数，则自动增大宽度int底层都是4个字节
2. 时间方式：'2022-5-6' '2022.5.6' '2022/5/6'
3. 字符串不区分单引号'' 和 双引号""
4. 写入当前时间 now(),sysdate(),current_date()
5. char、varchar是字符个数，不是字节个数，可以使用binary，varbinary表示定长和不定长的字节个数
6. 如果不是全字段插入数据的话，需要加入字段的名字

### DML_修改，删除数据

```sql
-- 修改表中数据
update t_student set sex = '女';
update t_student set sex = '男' where sno = 9;
update t_student set classname = 'java2班' where sno = 10;
update t_student set classname = 'mysql6班' where sno = 7;
update t_student set age = 29 where classname = 'python3班';

-- 删除操作
delete from t_student where sno = 2;

```

**注意**

1. 关键字，表名，字段名 不区分大小写
2. 默认情况下，内容不区分大小写
3. 删除操作from关键字不可少
4. 修改、删除数据莫忘加限制条件

### DDL_修改，删除数据库表

```sql
-- 查看数据
select * from t_student;

-- 修改表的结构(增加、修改、删除)
-- 增加一列
alter table t_student add score double(5,2); #5：总位数，2：小数位数
update t_student set score = 123.456 where sno = 9

-- 增加一列（放在最前面）
alter table t_student add score double(5,2) first;

-- 增加一列（放在age列的后面）
alter table t_student add score double(5,2) after age;

-- 删除一列
alter table t_student drop score;

-- 修改一列
-- modify只修改列类型定义，不改变列的名字
alter table t_student modify score float(4,1);
-- change 修改列名以及列类型定义
alter table t_student change score score2 double(5,1);

-- 删除表
drop table t_student;
```

## 3. 表的完整性约束

> 为防止不符合规范的数据存入数据库，在用户对数据进行插入、修改、删除等操作时，MySQL提供了一种机制来检查数据库中的数据是否满足规定的条件，以保证数据库中数据的准确性和一致性，这种机制就是完整性约束。  

|    约束条件    | 约束描述                                     |
| :------------: | :------------------------------------------- |
|  primary key   | 主键约束，约束字段的值**唯一标识对应的记录** |
|    not null    | 非空约束，约束字段的值不能为空               |
|     unique     | 唯一约束，约束字段的值是唯一的               |
|     check      | 检查约束，限制某个字段的取值范围             |
|    default     | 默认值约束，约束字段的默认值                 |
| auto_increment | 自动增加约束，约束字段的值自动递增           |
|  foreign key   | 外键约束，约束表与表之间的关系               |

### 非外键约束

1.sql代码

```sql
-- 创建数据库表
create table t_stu(
    sno int(6) primary key auto_increment, #sno学号是主键并自动递增
    sname varchar(5) not null, #sname姓名不能为空
    sex char(1) default '男' check(sex='男' or sex='女'), #sex性别默认男
    age int(3) check(age>=18 and age<=50),
    enterdate date,
    classname varchar(10),
    email varchar(15) unique #email地址唯一
)

-- 添加数据：
insert into t_stu values (1,'小张','男',21,'2025/7/1','java09班','xz@136.com');

insert into t_stu values (1,'小张','男',21,'2025/7/1','java09班','xz@136.com');
--> 1062 - Duplicate entry '1' for key 't_stu.PRIMARY'主键重复

insert into t_stu values (2,'小张','男',21,'2025/7/1','java09班','xz@136.com');
--> 1062 - Duplicate entry 'xz@136.com' for key 't_stu.email'违反唯一约束

insert into t_stu values (1,'小张','',21,'2025/7/1','java09班','xz@136.com');
--> 3819 - Check constraint 't_stu_chk_1' is violated.违反检查约束

insert into t_stu values (2,null,'男',21,'2025/7/1','java09班','x@136.com');
--> 1048 - Column 'sname' cannot be null 不能为null

-- 如果主键没有设定值，或者用null.default都可以完成主键自增的效果
insert into t_stu(sname,enterdate) values('小红','2021/7/9');
insert into t_stu value (null,'小明','男',23,'2022/8/21','java09班','xm@136.com');
insert into t_stu values(default,'小刚','男',22,'2022/5/12','java09班','xgg@136.com');

-- 如果sql报错，可能主键就浪费了，后续插入的主键是不连号的，我们主键也不要求连号的
insert into t_stu values (null,'小龙','男',21,'2023-9-1','java01班','xm@126.com');

-- 查看数据：
select * from t_stu;
```

2.约束从作用上分为两类

- 表级约束：可以约束表中任意一个或多个字段。与列定义相互独立，不包含在列定义中；与定义用'，'分隔；必须指出要约束的列的名称；（针对多列属性的约束）
- 列级约束：包含在列定义中，直接跟在该列的其它定义之后,用空格分隔；不必指定列名；（只针对某一列）

```sql
-- 删除数据库表
drop table t_stu

-- 创建数据库表
create table t_student(
    sno int(6) auto_increment,
    sname varchar(5) not null,
    sex char(1) default '男',
    age int(3),
    enterdate date,
    classname varchar(10),
    email varchar(15),
    constraint pk_stu_sno primary key(sno), #pk_stu 为主键约束的名字
    constraint ck_stu_sex check (sex='男' or sex ='女'),
    constraint ck_stu_age check (age>=18 and age <=60),
    constraint uq_stu_email unique (email)
)

-- 添加数据：
insert into t_student values(1,'小张','男',22,'2023/2/22','java02班','xz@136.com');

insert into t_student values(1,'小张','男',22,'2023/2/22','java02班','xz@136.com');

-- 查看数据：
select * from t_student;

```

3.在创建表以后添加约束：

```sql
-- 删除表
drop table t_student;

create table t_student(
    sno int(6),
    sname varchar(5) not null,
    sex char(1) default '男',
    age int(3),
    enterdate date,
    classname varchar(10),
    email varchar(15)
)
--sno int(6) auto_increment,出现错误> 1075 - Incorrect table definition; there can be only one auto column and it must be defined as a key
---- 错误的解决办法：就是auto_increment去掉

-- 在创建表以后添加约束：
alter table t_student add constraint pk_stu primary key (sno); #主键约束sno
alter table t_student modify sno int(6) auto_increment; #修改自增条件sno
alter table t_student add constraint ck_stu_sex check(sex='男' or sex='女'); #检查约束sex
alter table t_student add constraint ck_stu_age check(age>=18 and age<=50); #检查约束age
alter table t_student add constraint up_stu_email unique(email); #唯一约束email

-- 查看表结构
desc t_student;

```

### 总结

1. 主键约束

> 主键约束（PRIMARY KEY，缩写PK），是数据库中最重要的一种约束，其作用是约束表中的某个字段可以**唯一标识一条记录**。因此，使用主键约束可以快速查找表中的记录。就像人的身份证、学生的学号等等，**设置为主键的字段取值不能重复（唯一），也不能为空（非空）**，否则无法唯一标识一条记录。
> **主键可以是单个字段，也可以是多个字段组合。**对于单字段主键的添加可使用表级约束，也可以使用列级约束；而对于多字段主键的添加只能使用**表级约束**。

2. 非空约束（NOT NULL，缩写NK）

> 规定了一张表中指定的某个字段的值不能为空（NULL）。设置了非空约束的字段，在插入的数据为NULL时，数据库会提示错误，导致数据无法插入。
> 无论是单个字段还是多个字段非空约束的添加只能使用**列级约束**（非空约束无表级约束）  
> 为已存在表中的字段添加非空约束 

```sql
 alter table t_stu modify stu_sex varchar(1) not null;
```

> 使用alter table语句删除非空约束 

```sql
 alter table t_stu modify stu_sex varchar(1) null;
```

3. 唯一约束

> 唯一约束（UNIQUE，缩写UK）比较简单，它规定了一张表中指定的某个字段的值不能重复，即这一字段的每个值都是唯一的。如果想要某个字段的值不重复，那么就可以为该字段添加为唯一约束。
> 无论单个字段还是多个字段唯一约束的添加均可使用列级约束和表级约束

4. 检查约束

> 检查约束（CHECK）用来限制某个字段的取值范围，可以定义为列级约束，也可以定义为表级约束。MySQL8开始支持检查约束。 

5. 默认值约束 

> 默认值约束（DEFAULT）用来规定字段的默认值。如果某个被设置为default约束的字段没插入具体值，那么该字段的值将会被默认值填充。
> 默认值约束的设置与非空约束一样，也只能使用列级约束。

6. 字段值自动增加约束

> 自增约束（AUTO_INCREMENT）可以使表中某个字段的值自动增加。一张表中只能有一个自增长字段，并且该字段必须定义了约束（该约束可以是主键约束、唯一约束以及外键约束），如果自增字段没有定义约束，数据库则会提示“Incorrect table definition; there can be only one auto column and it must be defined as a key”错误。
> 由于自增约束会自动生成唯一的ID，所以自增约束通常会配合主键使用，并且只适用于整数类型。一般情况下，设置为自增约束字段的值会从1开始，每增加一条记录，该字段的值加1。


## 4.mysql基本操作

### 外键约束

> 外键约束（foreign key，缩写FK）是用来实现数据库表的参照完整性的。外键约束可以使两张表紧密的结合起来，特别是针对修改或者删除的级联操作时，会保证数据的完整性。

> 外键是指表中某个字段的值依赖于另一张表中某个字段的值，而**被依赖的字段必须具有主键约束或者唯一约束**。被依赖的表我们通常称之为父表或者主表，设置外键约束的表称为子表或者从表。  

> 举个例子：如果想要表示学生和班级的关系，首先要有学生表和班级表两张表，然后学生表中有个字段为stu_clazz（该字段表示学生所在的班级），而该字段的取值范围由班级表中的主键cla_no字段（该字段表示班级编号）的取值决定。那么班级表为主表，学生表为从表，且stu_clazz字段是学生表的外键。通过stu_clazz字段就建立了学生表和班级表的关系。  

班级表

| **班级编号** | 班级名称 |
| :----------: | :------: |
|      1       |  Java08  |
|      2       | python09 |

学生表

| 编号 | 姓名 | 年龄 | 性别 | **班级编号** |
| :--: | :--: | :--: | :--: | :----------: |
|  1   | 小红 |  22  |  女  |      1       |
|  2   | 小黑 |  21  |  男  |      1       |
|  3   | 小彭 |  23  |  男  |      2       |
|  4   | 小强 |  20  |  男  |      2       |

主表（父表）：班级表  -  班级编号 - 主键  
从表（子表）：学生表 - 班级编号 - 外键

```sql
-- 先创建父表：班级表
create table t_class(
    cno int(4) primary key auto_increment, #主键&自增
    cname varchar(10) not null, #不为空
    room char(4) 
)

-- 添加班级数据
insert into t_class values (null,'java09','r613');
insert into t_class values (null,'java08','r306');
insert into t_class values (null,'bigdata09','r512');

--可以一次性添加多条记录
insert into t_class values (null,'java06','r304'),(null,'java05','r604'),(null,'bigdata06','r516');

--查询班级表
select * from t_class;

--删除学生表
drop table t_student;

--创建子表，学生表
create table t_student(
    sno int(6) primary key auto_increment, #主键&自增
    sname varchar(5) not null, #不为空
    classno int(4)
    #我们要关联外键，所有classno取值参考t_class表中的cno字段，字段的名字可以不相同，但类型长度定义 尽量要求相同。
)

--添加学生信息
insert into t_student values (null,'张三',1),(null,'李四',2),(null,'王五',1);

-- 查看学生表
select * from t_student;

-- 查看表结构
desc t_student;

-- 发现，学生表没有添加外键

-- 出现问题：
--1.添加一位学生对应的班级编号为4
insert into t_student values(null,'小红',4);
--2.删除班级编号为2
delete from t_class where cno = 2;
-- 此时的外键是你认为的，没有真正添加进去。

-- 解决办法，添加外键约束：
-- 注意：外键约束只有表级约束
-- 法一
--删除学生表
drop table t_student;
create table t_student(
    sno int(6) primary key auto_increment, #主键&自增
    sname varchar(5) not null, #不为空
    classno int(4),
    constraint fk_stu_classno foreign key (classno) references t_class (cno)
);
-- 法二
create table t_student(
        sno int(6) primary key auto_increment, 
        sname varchar(5) not null, 
        classno int(4)
);
-- 在创建表以后添加外键约束：
alter table t_student add constraint fk_stu_classno foreign key (classno) references t_class (cno);

-- 上面的两个问题都解决了：
-- 添加学生信息
-- > 1452 - Cannot add or update a child row: a foreign key constraint fails 
insert into t_student values (null,'张三',1),(null,'李四',1),(null,'王五',2);

-- 删除班级1：
-- 2.删除班级2：
insert into t_student values (null,'张三',3),(null,'李四',3),(null,'王五',3);
-- > 1451 - Cannot delete or update a parent row: a foreign key constraint fails
delete from t_class where cno = 3;

```

外键

|       名       |  字段   | 参考模式 | 参考表  | 参考字段 |  删除时  |  更新时  |
| :------------: | :-----: | :------: | :-----: | :------: | :------: | :------: |
| fk_stu_classno | classno | mytestdb | t_class |   cno    | restrict | restrict |

### 外键策略

```sql
--删除学生表
--删除班级表
--顺序：先删除从表，再删除主表。(有外键删主表删不掉的)
drop table t_student;
drop table t_class;

--先创建父表：班级表
create table t_class(
    cno int(4) primary key auto_increment,
    cname varchar(10) not null,
    room char(4)
)
-- 可以一次性添加多条记录：
insert into t_class values (null,'java06','r304'),(null,'java05','r604'),(null,'bigdata06','r516');

-- 添加学生表，添加外键约束：
create table t_student(
    sno int(6) primary key auto_increment,
    sname varchar(5) not null,
    classno int(4),
    constraint fk_stu_classno foreign key (classno) references t_class(cno)
);

-- 可以一次性添加多条记录：
insert into t_student values (null,'张三',1),(null,'李四',2),(null,'王五',1);

-- 查看班级表和学生表：
select * from t_class;


-- 删除班级2(主表中字段)：如果直接删除的话肯定不行因为有外键约束：
-- 操作：加入外键策略
-- 策略1：no action 不允许操作
-- 通过操作sql来完成：
-- 先把班级2中学生对应的班级 改为null (班级中没有学生，才能删除班级。)
update t_student set classno = null where classno = 2;
-- 然后再删除班级2：
delete from t_class where cno = 2;

-- 策略2：cascade 级联操作：操作主表的时候影响从表的外键信息：
-- 先删除之前的外键约束：
alter table t_student drop foreign key fk_stu_classno;
-- 重新添加外键约束：
alter table t_student add constraint fk_stu_classno foreign key (classno) references t_class (cno) on update cascade on delete cascade;
-- 试试更新：
update t_class set cno = 5 where cno = 3;
-- 试试删除：
delete from t_class where cno = 5;


-- 策略3：set null  置空操作：
-- 先删除之前的外键约束：
alter table t_student drop foreign key fk_stu_classno;
-- 重新添加外键约束：
alter table t_student add constraint fk_stu_classno foreign key (classno) references t_class (cno) on update set null on delete set null;
-- 试试更新：
update t_class set cno = 8 where cno = 1;
-- 试试删除：
delete from t_class where cno = 8;

-- 注意：
-- 联级操作 和 删除操作 可以混着使用：
alter table t_student add constraint fk_stu_classno foreign key (classno) references t_class (cno) on update cascade on delete set null ;

```

## 5.DDL和DML的补充

```sql
-- 创建表：
create table t_student(
        sno int(6) primary key auto_increment, 
        sname varchar(5) not null, 
        sex char(1) default '男' check(sex='男' || sex='女'),
        age int(3) check(age>=18 and age<=50),
        enterdate date,
        classname varchar(10),
        email varchar(15) unique
);
-- 添加数据：
insert into t_student values (null,'小红','女',21,'2022.3.25','java09班','xh@136.com');
insert into t_student values (null,'小李','男',22,'2022/8/21','java08班','xl@136.com');
insert into t_student values (null,'小四','男',21,'2023-9-1','java04班','xs@136.com');
insert into t_student values (null,'小黑','男',23,'2023-5-27','java01班','xh@126.com');

-- 查看学生表：
select * from t_student;

-- 添加一张表：快速添加：结构和数据跟t_student 都是一致的
create table t_student2
as
select * from t_student;
--查看t_student2表
select * from t_student2;


-- 快速添加，结构跟t_student一致，数据没有：
create table t_student3
as
select * from t_student where 1=2;
--查看t_student3表
select * from t_student3;


-- 快速添加：只要部分列，部分数据：
create table t_student4
as
select sno,sname,age from t_student where sno = 2;
-- 查看t_student4表
select * from t_student4;

-- 删除数据操作 :清空数据
delete from t_student;
truncate table t_student2;

```

【注】delete和truncate的区别：
从最终的结果来看，虽然使用truncate操作和使用delete操作都可以删除表中的全部记录，但是两者还是有很多区别的，其区别主要体现在以下几个方面：

1. delete为数据操作语言DML；truncate为数据定义语言DDL。
2. delete操作是将表中所有记录一条一条删除直到删除完；truncate操作则是保留了表的结构，重新创建了这个表，所有的状态都相当于新表。因此，truncate操作的效率更高。
3. delete操作可以回滚；truncate操作会导致隐式提交，因此不能回滚。
4. delete操作执行成功后会返回已删除的行数（如删除4行记录，则会显示“Affected rows：4”）；截断操作不会返回已删除的行量，结果通常是“Affected rows：0”。DELETE操作删除表中记录后，再次向表中添加新记录时，对于设置有自增约束字段的值会从删除前表中该字段的最大值加1开始自增；truncate操作则会重新从1开始自增。

## 6.DQL-查询操作

> 准备四张表
> dept(部门表)

```sql
-- dept:department 部分 ；loc - location 位置
create table DEPT(  
  DEPTNO int(2) not null,  
  DNAME  VARCHAR(14),  
  LOC    VARCHAR(13)  
);  

alter table DEPT 
 add constraint PK_DEPT primary key (DEPTNO); 

insert into DEPT (DEPTNO, DNAME, LOC)  
values (10, 'ACCOUNTING', 'NEW YORK');  
insert into DEPT (DEPTNO, DNAME, LOC)  
values (20, 'RESEARCH', 'DALLAS');  
insert into DEPT (DEPTNO, DNAME, LOC)  
values (30, 'SALES', 'CHICAGO');  
insert into DEPT (DEPTNO, DNAME, LOC)  
values (40, 'OPERATIONS', 'BOSTON');  
```

emp(员工表)

```sql
-- emp:employee 员工；mgr：manager上级领导编号；hiredate 入职日期 ；firedate 解雇日期 
-- deptno 外键 参考  dept - deptno字段
-- mgr 外键  参考  自身表emp - empno  产生了自关联
create table EMP  
(  
  EMPNO    int(4) primary key,  
  ENAME    VARCHAR(10),  
  JOB      VARCHAR(9),  
  MGR      int(4),  
  HIREDATE DATE,  
  SAL      double(7,2),  
  COMM     double(7,2),  
  DEPTNO   int(2)  
);  

alter table EMP  
  add constraint FK_DEPTNO foreign key (DEPTNO)  
  references DEPT (DEPTNO);  


insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, null, 20);  
insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30);  
insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30);  
insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, null, 20);  
insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30);  
insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, null, 30);  
insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, null, 10);  
insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000, null, 20);  
insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7839, 'KING', 'PRESIDENT', null, '1981-11-17', 5000, null, 10);  
insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30);  
insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100, null, 20);  
insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, null, 30);  
insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, null, 20);  
insert into EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)  
values (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, null, 10);  


```

salgrade(薪资等级表)

```sql
-- losal - lowsal 低工资
-- hisal - highsal 高工资
create table SALGRADE  
(  
  GRADE int primary key,  
  LOSAL double(7,2),  
  HISAL double(7,2)  
);  

insert into SALGRADE (GRADE, LOSAL, HISAL)  
values (1, 700, 1200);  
insert into SALGRADE (GRADE, LOSAL, HISAL)  
values (2, 1201, 1400);  
insert into SALGRADE (GRADE, LOSAL, HISAL)  
values (3, 1401, 2000);  
insert into SALGRADE (GRADE, LOSAL, HISAL)  
values (4, 2001, 3000);  
insert into SALGRADE (GRADE, LOSAL, HISAL)  
values (5, 3001, 9999);  
```

bonus(奖金表)

```sql
-- job 职位 sal薪资；common：补助
create table BONUS  
(  
  ENAME VARCHAR(10),  
  JOB   VARCHAR(9),  
  SAL   double(7,2),  
  COMM  double(7,2)  
);  
```

查看表

```sql
-- 查看表：
select * from dept; 

select * from emp;

select * from salgrade;

select * from bonus;

```

### 单表查询

#### 1) 最简单的SQL查询

```sql
-- 对emp表查询
select * from emp; # * 代表着所有数据

-- 显示部分列
select empno,ename,sal from emp;

-- 显示部分列，部分行
select empno,ename,job,mgr from emp where sal > 2000;

-- 起别名
-- as 省略, '' 或者""省略了
select empno 员工编号,ename 姓名,sal 工资 from emp; 

-- as alias 别名
select empno as 员工编号, ename as 姓名, sal as 工资 from emp;
select empno as '员工编号', ename as "姓名", sal as 工资 from emp;

-- 1064 - You have an error in your SQL syntax;
-- 1064出错的原因，在起别名时候不能存在特殊符号，''或者""不可以省略不写
select empno as 员工 编号, ename as "姓 名", sal as 工资 from emp;

-- 算术运算符
select empno,ename,sal,sal+1000 as '涨薪后',deptno from emp where sal < 2500;
select empno,ename,sal,comm,sal+comm from emp; #某数+null=null 此句有问题

-- 去重操作
select job from emp;
select distinct job from emp;
select job,deptno from emp;
-- 对职位和员工编号的组合 去重
select distinct job,deptno from emp;


-- 排序
select * from emp order by sal; #升序排序
select * from emp order by sal asc; #asc指升序，默认不写
select * from emp order by sal desc; #desc指降序
select * from emp order by sal asc, deptno desc; #工资升序，编号降序

```

#### 2) where子句

指定查询条件使用where子句，可以查询**符合条件的部分记录**。

```sql
-- 查看emp表
select * from emp;

-- where子句：where + 过滤条件 
-- where子句 + 关系运算符
select * from emp where deptno = 10;
select * from emp where deptno > 10;
select * from emp where deptno >= 10;
select * from emp where deptno < 10;
select * from emp where deptno <= 10;
select * from emp where deptno <> 10;
select * from emp where deptno != 10;
select * from emp where job = 'clerk';
select * from emp where job = 'CLERK';  #不区分大小写
select * from emp where binary job = 'clerk'; #binary(二元)区分大小写
select * from emp where hiredate < '1982-1-1';

-- where 子句 + 逻辑运算符：amd
select * from emp where sal > 1500 and sal < 3000; #开区间
select * from emp where sal > 1500 && sal < 3000;
select * from emp where sal > 1500 and sal < 3000 order by sal;
select * from emp where sal between 1500 and 3000; #闭区间

-- where 子句 + 逻辑运算符：or
select * from emp where deptno = 10 or deptno = 20;
select * from emp where deptno = 10 || deptno = 20;
select * from emp where deptno in(10,20);
select * from emp where job in ('manager','clerk','analyst');

-- where 子句 + 模糊查询
-- 查询名字中带B的员工  % 表示 多个字符
select * from emp where ename like '%B%';
-- 任意一个字符
select * from emp where ename like '_B%';

-- 关于null判断
select * from emp where comm is null;
select * from emp where comm is not null;

-- 小括号的使用: 因为不同的运算符的优先级别不同，加括号为了可读性
select * from emp where job = 'salesman' or job = 'clerk' and sal >= 1500; #先and后or : and > or
select * from emp where job = 'salesman' or (job = 'clerk' and sal >= 1500);
select * from emp where (job = 'salesman' or job = 'clerk') and sal >= 1500;

```

#### 3)使用函数

> 函数只是对查询结果中的数据进行处理，不会改变数据库中数据表的值。

##### 单行函数

> 单行函数是指对每一条记录输入值进行计算，并得到相应的计算结果，然后返回给用户，也就是说，每条记录作为一个输入参数，经过函数计算得到每条记录的计算结果。 
> 常用的单行函数主要包括字符串函数、数值函数、日期与时间函数、流程函数以及其他函数
> 除了（max,min,count,sum,avg），都是单行函数

1. 字符串函数(String StringBuilder)

| 函数                       | 描述                                                    |
| :------------------------- | :------------------------------------------------------ |
| concat(str1,str2,..)       | 将str1 str2 ..拼成新的字符串                            |
| insert(str,index,n,newstr) | 将字符串str从第index位置开始的n个字符替换成字符串newstr |
| length(str)                | 获取str长度                                             |
| lower(str)                 | 将str每个字符转成小写                                   |
| upper(str)                 | 将str每个字符转成大写                                   |
| left(str,n)                | 获取str最左边的n个字符                                  |
| right(str,n)               | 获取str最右边的n字符                                    |
| strcmp(str1,str2)          | 比较str1和str2的大小                                    |
| substring(str,index,n)     | 获取从str的index位置开始的n个字符                       |

2. 数值函数(Math) 

| 函数           | 描述                                     |
| :------------- | :--------------------------------------- |
| abs(num)       | 返回num的绝对值                          |
| ceil(num)      | 向上取整                                 |
| floor(num)     | 向下取整                                 |
| mod(num1,mun2) | num1/num2取模                            |
| PI()           | 返回圆周率的值                           |
| rand(num)      | 返回0~1之间的随机数                      |
| round(num,n)   | 返回x四舍五入的值，改值保留到小数点后n位 |
| truncate(nu,n) | 返回num被舍去至小数点后n位的值           |

3. 日期与时间函数(Date)

| 函数      | 描述                       |
| :-------- | :------------------------- |
| curdate() | 返回当前日期               |
| curtime() | 返回当前时间               |
| now()     | 返回当前日期和时间         |
| sysdate() | 返回该函数执行的日期和时间 |

4. 流程函数(if switch)

| 函数                                                         | 描述                                                       |
| :----------------------------------------------------------- | :--------------------------------------------------------- |
| if(condition,t,f)                                            | 条件真返回t，否则返回f                                     |
| ifnull(value1,value2)                                        | v1不为null，返回v1，否则返回v2                             |
| nullif(value1,value2)                                        | v1等于v2，返回null，否则返回value1                         |
| case value when [value1] then result1 when [value2] then result2...end | 如果value等于value1，则返回result1，···，否则返回result    |
| case when [condition1] then result1 when [condition2] then result2 end | 如果条件condition1为真，则返回result1，···，否则返回result |

5. JSON函数

| 函数            | 描述                           |
| :-------------- | :----------------------------- |
| json_append()   | 在json文档中追加数据           |
| json_insert()   | 在json文档中插入数据           |
| json_replace()  | 替换json文档中的数据           |
| json_remove()   | 从json文档中的指定位置移除数据 |
| json_contains() | 判断json文档中是否包含某个数据 |
| json_search()   | 查找json文档中给定字符串的路径 |

6. 其他函数 

| 函数       | 描述                  |
| :--------- | :-------------------- |
| database() | 返回当前数据库名      |
| version()  | 返回当前mysql的版本号 |
| user()     | 返回当前登入的用户名  |

```sql
select * from emp;
-- 1.字符串函数
-- substring从1开始
select job,lower(job),length(job),substring(job,1,3) from emp;

-- 2.数值函数
-- dual实际是一个伪表
select abs(-10),ceil(3.6),floor(3.6),PI() from dual;

select ename,sal,ceil(sal) from emp;

select mod(5,3),5/3,5%3 from dual;

-- 3.日期与时间函数
select curdate(),curtime();

select now(),sysdate(),sleep(3),now(),sysdate() from dual;

insert into emp values(888,'小强','salasman',6666,now(),1000,null,30);

-- 查看emp表结构
desc emp;

-- 4.流程函数
-- if相关(if-else双分支)
select empno,ename,sal,if(sal>3000,'高薪','底薪') as '薪资等级' from emp; 
--  若comm是null，只取0(单分支)
select empno,ename,sal,comm,sal+ifnull(comm,0) from emp;
-- 1=1返回null，1!=2返回1
select nullif(1,1),nullif(1,2) from dual;

-- case相关
-- case等值判断
select empno,ename,job,
case job
 when 'clerk' then '店员'
 when 'salesman' then '销售'
 when 'manager' then '经理'
 else '其他'
end '岗位',
sal from emp;
-- case区间判断
select empno,ename,sal,
case
 when sal <=1000 then 'A'
 when sal <=2000 then 'B'
 when sal <=3000 then 'C'
 else 'D'
end '工资等级',
deptno from emp;

-- 5.JSON函数  
-- 6.其他函数
select database(),user(),version() from dual;
```

##### 多行函数

> 多行函数是指**对一组数据**进行运算，针对这一组数据（多行记录）只返回一个结果，也称为分组函数。

| 函数    | 描述                 |
| :------ | :------------------- |
| count() | 统计表中记录的数目   |
| sum()   | 计算指定字段的总和   |
| avg()   | 计算指定字段的平均值 |
| max()   | 统计指定字段的最大值 |
| min()   | 统计指定字段的最小值 |

```sql
-- 多行函数：
select max(sal),min(sal),count(sal),sum(sal),avg(sal),sum(sal)/count(sal) from emp;
-- 多行函数自动忽略null值
select max(comm),min(comm),count(comm),sum(comm),avg(comm),sum(comm)/count(comm) from emp;
-- count --计数
-- 统计表的记录数：方式1：
select * from emp;
select count(ename) from emp;
select count(*) from emp;
-- 统计表的记录数：方式2
select 1 from dual;
select 1 from emp;
select count(1) from emp;
```

#### 4)group_by分组

> group by : 用来进行分组

```sql
-- 查询emp表
select * from emp;
-- 统计各个部门的平均工资 
-- 字段和多行函数不可以同时使用
select deptno,avg(sal) from emp; 
-- 字段和多行函数不可以同时使用,除非这个字段属于分组
select deptno,avg(sal) from emp group by deptno; 
select deptno,avg(sal) from emp group by deptno order by deptno desc;

-- 统计各个岗位的平均工资
select job 岗位, avg(sal) 平均工资 from emp group by job;
select job 岗位, lower(job),avg(sal) from emp group by job;
```

#### 5)having分组后筛选

```sql
-- 统计各个部门的平均工资 ,只显示平均工资2000以上的  
-- 分组以后进行二次筛选 having
select deptno,avg(sal) from emp group by deptno having avg(sal)>2000;
select deptno,avg(sal) 平均工资 from emp group by deptno having 平均工资 > 2000;
select deptno,avg(sal) 平均工资 from emp group by deptno having 平均工资 > 2000 order by deptno desc;
-- 统计各个岗位的平均工资,除了manager
-- 方法1 先where后group by：
select job,avg(sal) from emp where job!='manager' group by job;
-- 方法2 先group by后having：
select job,avg(sal) from emp group by job having job != 'manager';

```

#### 6)单表查询总结

- select 语句总结:顺序固定，不可改变顺序

```sql
select column,group_function(column)
from table
[where condition]
[group by group_condition]
[having group_condition]
[order by column];
```

- select 语句执行顺序

> from--where--group by--select - having - order by

#### 7)单表查询练习

```sql
-- 列出工资最小值小于2000的职位
select job 职位,min(sal) 最小工资
from emp
group by 职位
having 最小工资 < 2000;

-- 列出平均工资大于1200元的部门和工作搭配组合
select deptno 部门,job 职位,avg(sal) 平均工资
from emp
group by 部门,职位
having 平均工资 > 1200
order by deptno;

-- 统计[人数小于4的]部门的平均工资。
select deptno 部门,avg(sal) 平均工资,count(1) 计数
from emp
group by 部门
having 计数 < 4;

-- 统计各部门的最高工资，排除最高工资小于3000的部门。
select deptno 部门,max(sal) 最高工资
from emp
group by 部门
having 最高工资 < 3000;

```

select deptno,sal from emp;



## 参考文章

- [sql练习](https://blog.csdn.net/qq_44498443/article/details/103108422)
- [马士兵教育](https://space.bilibili.com/318518352)

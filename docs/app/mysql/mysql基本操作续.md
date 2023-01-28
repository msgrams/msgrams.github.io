---
title: mysql基本操作续
description: DQL查询、事务、视图
tags:
  - MySQL
---
# mysql基本操作续
## 1. DQL-查询操作

### 多表查询(99语法)

#### 交叉连接，自然连接，内连接查询

> 一条SQL语句查询多个表，得到一个结果，包含多个表的数据。效率高。在SQL99中，连接查询需要使用join关键字实现。提供了多种连接查询的类型：cross、natural、using、on

> 交叉连接(cross join)是对两个或者多个表进行笛卡儿积操作，所谓笛卡儿积就是关系代数里的一个概念，表示两个表中的每一行数据任意组合的结果。比如：有两个表，左表有m条数据记录，x个字段，右表有n条数据记录，y个字段，则执行交叉连接后将返回m*n条数据记录，x+y个字段。笛卡儿积示意图如图所示.  

aaa

|  a1  |  a2  |
| :--: | :--: |
|  a   |  aa  |
|  b   |  bb  |

bbb

|  b1  |  b2  |
| :--: | :--: |
|  1   |  11  |
|  2   |  22  |

|  笛  |  卡  |  尔  |  积  |
| :--: | :--: | :--: | :--: |
|  a   |  aa  |  1   |  11  |
|  a   |  aa  |  2   |  22  |
|  b   |  bb  |  1   |  11  |
|  b   |  bb  |  2   |  22  |

```sql
-
-- 查询员工表、部门表
select * from emp; #14条记录
select * from dept; #4条记录

-- 交叉查询：cross join
select *
from emp
    cross join dept;
-- 结果为56条数据，14*4=56条，此法没有实际意义

select *
from emp
    join dept;
-- 在mysql数据库中cross 可省略不写，oracle中不可以


-- 自然连接：natural join
select *
from emp
    natural join dept;
-- 结果：14条数据。优点：自然连接自动匹配所有的同名列(只显示一次)

select empno,
    ename,
    sal,
    dname,
    loc
from emp
    natural join dept;
-- 能查询到结果，但没有指定字段所属的数据库表，效率低下

-- 解决：指定表名
select emp.empno,
    emp.ename,
    emp.sal,
    dept.dname,
    dept.loc,
    dept.deptno
from emp
    natural join dept;
-- 缺点：表名太长了

-- 解决：给数据库表起个别名
select e.empno,
    e.ename,
    e.sal,
    d.dname,
    d.loc,
    d.deptno
from emp e
    natural join dept d;

-- 总结：自然连接 缺点：自动匹配表中所有的同名列，但我们通常只匹配部分同名列
-- 解决：内连接：using子句

select *
from emp e
    inner join dept d using(deptno);
-- inner可以不写，此using缺点：关联字段必须是同名的

-- 解决：内连接 on子句
select *
from emp e
    inner join dept d on(e.deptno = d.deptno);

-- 总结
-- 1.交叉连接 cross join
-- 2.自然连接 natural join
-- 3.内连接 using子句
-- 4.内连接 on子句
--综合比较：优先使用 内连接 on子句 

select *
from emp e
    inner join dept d on(e.deptno = d.deptno)
where sal > 3500;
-- 条件：
-- 1、筛选条件 where having
-- 2、连接条件 on using natural
-- sql99语法：筛选条件和连接条件是分开的

```

#### 外连接查询

```sql
-- inner join -on子句：显示所有匹配信息
select *
from emp e
    inner join dept d on e.deptno = d.deptno;

-- 外连接：显示不匹配数据
-- outer可以省略不写
-- 左外连接 left outer join (左边的表显示不匹配数据)
select *
from emp e
    left outer join dept d on e.deptno = d.deptno;
-- 右外连接 right outer join (右边的表显示不匹配数据)
select *
from emp e
    right outer join dept d on e.deptno = d.deptno;

-- 全外连接 full outer join (左边、右边的表显示不匹配数据)(mysql不支持，oracle支持)
select *
from emp e
    full outer join dept d on e.deptno = d.deptno;

-- 解决mysql中全外连接不支持问题
-- union并集 去重 效率低
select *
from emp e
    left outer join dept d on e.deptno = d.deptno
union
select *
from emp e
    right outer join dept d on e.deptno = d.deptno;

-- union all并集 不去重 效率高
select *
from emp e
    left outer join dept d on e.deptno = d.deptno
union all
select *
from emp e
    right outer join dept d on e.deptno = d.deptno;

-- mysql对集合操作支持比较弱(只支持并集),交集、差集不支持(oracle支持)，

```

#### 三表连接查询

```sql
-- 查询员工的编号、姓名、薪水、部门编号、部门名称、薪水等级
select * from emp;
select * from dept;
select * from salgrade;

select e.ename,
    e.sal,
    e.empno,
    e.deptno,
    d.dname,
    s.*
from emp e
    right outer join dept d on e.deptno = d.deptno
    inner join salgrade s on e.sal between s.losal and s.hisal

```

#### 自连接

> 自己跟自己关联

```sql
-- 查询员工编号、姓名、上级编号、上级姓名
select * from emp;

select e1.empno,
    e1.ename,
    e1.mgr,
    e2.ename
from emp e1
    inner join emp e2 on e1.mgr = e2.empno;

-- 左外连接
select e1.empno,
    e1.ename,
    e1.mgr,
    e2.ename
from emp e1
    left outer join emp e2 on e1.mgr = e2.empno;

```

#### 多表查询(92语法)

```sql
-- 查询员工的编号，员工姓名，薪水，员工部门编号，部门名称：
-- 相当于99语法中的cross join ,出现笛卡尔积，没有意义
select e.empno,
    e.ename,
    e.sal,
    e.deptno,
    d.dname
from emp e,
    dept d

-- 相当于99语法中的natural join 
select e.empno,
    e.ename,
    e.sal,
    e.deptno,
    d.dname
from emp e,
    dept d
where e.deptno = d.deptno;

-- 查询员工的编号，员工姓名，薪水，员工部门编号，部门名称，查询出工资大于2000的员工
select e.empno,
    e.ename,
    e.sal,
    e.deptno,
    d.dname
from emp e,
    dept d
where e.deptno = d.deptno
    and e.sal > 2000;

-- 查询员工的名字，岗位，上级编号，上级名称（自连接）：
select e1.ename,
    e1.job,
    e1.mgr,
    e2.ename
from emp e1,
    emp e2
where e1.mgr = e2.empno;

-- 查询员工的编号、姓名、薪水、部门编号、部门名称、薪水等级
select e.empno,
    e.ename,
    e.sal,
    e.deptno,
    d.dname,
    s.grade
from emp e,
    dept d,
    salgrade s
where e.deptno = d.deptno
    and e.sal >= s.losal
    and e.sal <= s.hisal;

-- 总结：
-- 1.92语法麻烦 
-- 2.92语法中 表的连接条件 和  筛选条件  是放在一起的没有分开
-- 3.99语法中提供了更多的查询连接类型：cross,natural,inner,outer 
```

### 子查询

子查询是什么？

> 一条sql语句含有多个select
> 顺序：先执行子查询，在执行外查询

#### 不相关子查询

> 子查询可以独立运行，先运行子查询，再运行外查询。
> 不相关子查询: 子查询可以独立运行
> 不相关子查询分类: 根据子查询的结果行数，可以分为单行子查询和多行子查询。

```sql
-- 问题：查询所有比“clark”工资高的员工的信息  
-- 步1) 查询比“clark”员工的工资 2450$
select sal
from emp
where ename = 'clark';
-- 步2) 查询所有比2450$高的工资的员工信息
select * from emp where sal > 2450;

-- 遗留问题：此法效率低，第二条命令依赖于第一条命令。若第一条命令改的话，第二条命令也发生变化
-- 步1) 步2)合并 ==>子查询 效率高
select *
from emp
where sal > (
        select sal
        from emp
        where ename = 'clark'
    );

```

##### 单行子查询

```sql
-- 查询工资高于平均工资的雇员名字和工资
select ename,
    sal
from emp
where sal > (
        select avg(sal)
        from emp
    );

-- 查询和clark同一部门且比它工资低的雇员名字和工资
select ename,
    sal
from emp
where deptno = (
        select deptno
        from emp
        where ename = 'clark'
    )
    and sal < (
        select sal
        from emp
        where ename = 'clark'
    );


-- 查询职务和scott相同，比SCOTT雇佣时间早的雇员信息
select *
from emp
where job = (
        select job
        from emp
        where ename = 'scott'
    )
    and hiredate < (
        select hiredate
        from emp
        where ename = 'scott'
    );

```

##### 多行子查询

```sql
-- 1)查询【20号部门中职务同部门10的雇员一样的】雇员信息
-- 1.1查询雇员信息
select * from emp;
-- 1.2查询20号部门的雇员信息
select * from emp where deptno = 20;
-- 1.3查询10号部门雇员的职位
select job from emp where deptno = 10;
-- 1.4查询20部门同10号部门雇员一样的雇员信息
select * from emp where deptno = 20
and job in (select job from emp where deptno = 10)

select * from emp where deptno = 20
and job = any (select job from emp where deptno = 10)


-- 2)查询工资比所有的“salesman”都高的雇员的编号、名字和工资。
-- 2.1查询雇员编号、名字、工资
select empno,ename,sal from emp;
-- 2.2查询"salesman'的工资
select sal from emp where job = 'salesman';
-- 2.3查询工资比所有的“salesman”都高的雇员的编号、名字和工资
-- 多行子查询
select empno,ename,sal from emp where sal > all(select sal from emp where job = 'salesman');
-- 单行子查询
select empno,ename,sal from emp where sal > (select max(sal) from emp where job = 'salesman');

-- 3)查询工资低于任意一个“clerk”的工资的雇员信息
-- 多行子查询
select * from emp where sal < any (select sal from emp where job = 'clerk') and job != 'clerk'; 

-- 单行子查询
select * from emp where sal < (select max(sal) from emp where job = 'clerk') and job != 'clerk';

```

#### 相关子查询

> 子查询不可以独立运行，并且先运行外查询，再运行子查询（一些使用不相关子查询不能实现或者实现繁琐的子查询，可以使用相关子查询实现）
> 好处：简单   功能强大（一些使用不相关子查询不能实现或者实现繁琐的子查询，可以使用相关子查询实现） 缺点：稍难理解

```sql
-- 1.查询最高工资的员工(不相关子查询)
select * from emp where sal = (select max(sal) from emp);

-- 2.查询本部门最高工资的员工 (相关子查询)
-- 方法1：通过不相关子查询实现：
select * from emp where deptno = 10 and sal = (select max(sal) from emp where deptno = 10)
union
select * from emp where deptno = 20 and sal = (select max(sal) from emp where deptno = 20)
union
select * from emp where deptno = 30 and sal = (select max(sal) from emp where deptno = 30);
-- 缺点：语句比较多，具体到底有多少个部分未知

-- 方法2： 相关子查询
select * from emp e where sal = (select max(sal) from emp where deptno = e.deptno) order by deptno;

-- 3.查询工资高于其所在岗位的平均工资的那些员工 (相关子查询)
-- 不相关子查询 ???
select * from emp where job = 'clerk' and sal >= (select avg(sal) from emp where job = 'clerk');
-- 相关子查询
select * from emp e where sal >= (select avg(sal) from emp e2 where e2.job = e.job);

```



## 2. 数据库对象

### 事务

> 概念：事务（Transaction）指的是一个操作序列，该操作序列中的多个操作要么都做，要么都不做，是一个不可分割的工作单位，是数据库境中的逻辑工作单位，由DBMS（数据库管理系统）中的事务管理子系统负责事务的处理。目前常用的存储引擎有InnoDB（MySQL5.5以后默认的存储引擎）和MyISAM（MySQL5.5之前默认的存储引擎），其中InnoDB支持事务处理机制，而MyISAM不支持。

> 特性：事务处理可以确保除**非事务性序列内的所有操作**都成功，否则不会永久更新面向数据的资源。通过将一组相关操作组合为一个要么全部成功要么全部失败的序列，可以简化错误恢复并使应用程序更加可靠。

> ACID特性：原子性(Atomicity)、一致性(Consistentcy)、隔离性(Isolation)、持久性(Durability)

|  特性  |                             内容                             |
| :----: | :----------------------------------------------------------: |
| 原子性 |  事务中所有操作看作一个原子，事务是不可再分的最小逻辑执行体  |
| 一致性 | 事务执行的结果必须使数据库从一个一致性状态，变到另一个一致性状态(通过原子性来保证的 |
| 隔离性 | 各个事务执行互不干扰，任意一个事务的内部操作对其他并发的事务都是隔离的 |
| 持久性 |   事务一旦提交，对数据所做的任何改变都要记录到永久存储器中   |

```sql
-- 通过使用事务来保证转账安全

-- 创建账户表
create table account(
    id int primary key auto_increment,
    uname varchar(10) not null,
    balance double
)

-- 查看账户表
select * from account;
-- 在表中插入数据
insert into account values(null,'小红',2000),(null,'小黑',2000);

-- 小红给小黑转200元
update account set balance = balance - 200 where id = 1;
update account set balance = balance + 200 where id = 2;
-- 默认一个MDL语句是一个事务，所以上面操作实际上是2个事务

update account set balance = balance - 200 where id = 1;
update account set balance = balance + 200 where id = 2;
-- 必须让上面两个操作控制在一个事务中

-- 手动开启事务
start transaction;

update account set balance = balance - 200 where id = 1;
update account set balance = balance + 200 where id = 2;

-- 手动回滚：刚才执行操作全部取消
rollback;

-- 手动提交
commit;

-- 为啥要提交？？
-- 在回滚和提交之前，数据库中的数据都是操作的缓存中的数据，提交之后数据保存在磁盘上
```

##### 脏读(Dirty read)

| 时间点 |     事务A     |     事务B     |
| :----: | :-----------: | :-----------: |
|   1    |   开启事务A   |               |
|   2    |               |   开启事务B   |
|   3    | 查询余额为100 |               |
|   4    |               | 余额增加至150 |
|   5    | 查询余额为150 |               |
|   6    |               |   事务回滚    |

> 当一个事务正在访问数据并且对数据进行修改，而这种修改还没有提交到数据库中，这时另外一个事务也让访问了这个数据库，然后使用这个数据。因为这个数据是没有保存到磁盘上，在内存中的，那么另外一个事务读到这个数据是“脏数据”，依据“脏数据”所做的操作可能是不正确的。

##### 不可重复读(Unrepeatabler read)

| 时间点 |     事务A     |     事务B     |
| :----: | :-----------: | :-----------: |
|   1    |   开启事务A   |               |
|   2    |               |   开启事务B   |
|   3    | 查询余额为100 |               |
|   4    |               | 余额增加至150 |
|   5    | 查询余额为100 |               |
|   6    |               |   提交事务    |
|   7    | 查询余额为150 |               |

> 在一个事务内多次读同一数据，在这个事务还没结束时，另外一个事务也访问该数据，那么，在第一个事务中的两次读数据之间，由于第二个事务的修改导致第一个事务两次读取的数据可能不太一样。这就发生了在一个事务内两次读到的数据是不太一样的情况。

##### 幻读(Phantom read)

| 时间点 |         事务A          |      事务B       |
| :----: | :--------------------: | :--------------: |
|   1    |       开启事务A        |                  |
|   2    |                        |    开启事务B     |
|   3    | 查询id<3所有记录,共3条 |                  |
|   4    |                        | 插入一条记录id=2 |
|   5    |                        |     提交事务     |
|   6    | 查询id<3所有记录,共4条 |                  |

> 发生在一个事务(t1)读取了几行数据，接着另一个并发事务(t2)插入了一些数据时。在随后的查询中，第一个事务(t1)就会发现多了一些原本不存在的记录，就好像发生了幻觉一样。

【注】

> **不可重复读**:重点指修改 **幻读**:重点指新增或者删除

> **解决不可重复读的问题**只需锁住满足条件的行，**解决幻读**需要锁表 

#### 事务隔离级别

|             隔离级别             | 脏读 | 不可重复读 | 幻读 |
| :------------------------------: | :--: | :--------: | :--: |
| read uncommitted(读取未提交数据) |  √   |     √      |  √   |
|   read committed(读取提交数据)   |  ×   |     √      |  √   |
|     repeatable read(可重读)      |  ×   |     ×      |  √   |
|       serializable(串行化)       |  ×   |     ×      |  ×   |

PS：√  代表会出现问题，×代表不会出现问题 = 解决问题

```sql
-- 查看默认的事务隔离级别
-- mysql默认：repeatable read
-- 设置事务的隔离级别(设置当前会话隔离级别)
set session transaction isolation level read uncommitted;
set session transaction isolation level read committed;
set session transaction isolation level repeatable read;
set session transaction isolation level serializable;

-- 开启事务
start transaction;

-- 查询
select * from account where id = 1;
select * from account where id = 2;
```

#### 进程与事务的查询SQL

```sql
-- 1.查看进程
show full processlist;

-- 2.查看是否锁表
show open tables where In_use > 0;

-- 3.查看正在锁的事务
select * from information_schema.innodb_locks;

-- 4.查看等待锁的事务
select * from information_schema.innodb_lock_waits;

-- 5.查询正在执行的事务
select * from information_schema.innodb_trx;

-- 6.查看session的表
select * from sys.session;

-- 7.查看当前执行的线程
select * from performance_schema.threads;

-- 8.查看执行完成，但未commit的sql语句
select * from performance_schema.events_statements_current;

-- 9.查看慢查询sql语句
select * from mysql.slow_log;

-- 10.查看慢查询的设置
show variable like 'slow%';

-- 11.查看加锁的状态
show engine innodb status;

-- 12.查看/修改mysql事务隔离级别
select @@global.tx_isolation,@@tx_isolation;
-- 全局的
set global transaction isolation level read committed;
-- 当前会话
set session transaction isolation level read committed;
```

【注】  
1、ID：进程ID

2、DB：属于哪个库

3、COMMAND：该进程的状态，比如Sleep、query、killed

4、TIME：时间，该进程执行的时间，单位是秒

5、STATE：该进程的状态，比如执行中或者等待

6、INFO：执行的sql

### 视图(view)

#### 概念：

> 视图(view)是一个从单张或多张基础数据表或其他视图中构建出来的虚拟表。在数据库中只存放视图的定义，也就是动态检索数据的查询语句，而并不存放视图中的数据，这些数据依旧放在构建视图的基础表中，只有当用户使用视图时才去数据库请求相应的数据，即视图中的数据是在引用视图时动态生成的。因此视图中的数据依赖于构建视图的基础表，如果基本表中的数据发生变化，那么视图中相应的数据也会跟着改变。
> PS：视图本质：一个查询语句，是一个虚拟的表，不存在的表，当查看视图时，就是查看视图对应的sql语句。

#### 视图好处：

> 简化用户操作：视图可以使用户将注意力集中在所关心地数据上，而不需要关心数据表的结构、与其他表的关联条件以及查询条件等。

> 对机密数据提供安全保护：有了视图，就可以在设计数据库应用系统时，对不同的用户定义不同的视图，避免机密数据（如，敏感字段“salary”）出现在不应该看到这些数据的用户视图上。这样视图就自动提供了对机密数据的安全保护功能

```sql
-- 创建/替换单表视图
create or replace view myview01
as
select empno,ename,job,deptno
from emp
where deptno = 20
with check option;

-- 查看视图
select * from myview01;

-- 在视图中插入数据：
insert into myview01(empno,ename,job,deptno) values(1111,'xiaohong','clerk',20);
insert into myview01(empno,ename,job,deptno) values(2222,'xiaohei','clerk',20);
insert into myview01(empno,ename,job,deptno) values(3333,'xiaopeng','clerk',20);

-- 创建/替换多表视图
create or replace view myview02
as
select e.empno,e.ename,e.sal,d.deptno,d.dname
from emp e
join dept d
on e.deptno = d.deptno
where sal > 2000;

-- 查看视图
select * from myview02;

-- 创建统计视图：
create or replace view myview03
as
select e.deptno,d.dname,avg(sal),min(sal),count(1)
from emp e
join dept d
using(deptno)
group by e.deptno;

-- 查看视图
select * from myview03;

--创建基于视图的视图
create or replace view myview04
as
select * from myview03 where deptno = 20;

-- 查看视图
select * from myview04;
```

### 存储过程

#### 什么是存储过程(Stored Procedure)

> 存储过程就是数据库中保存(Stored)的一系列SQL命令（Procedure）的集合。也可以将其看作相互之间有关系的SQL命令组织在一起形成的一个小程序。

#### 存储过程的优点

> 1.提高执行性能。存储过程执行效率之所高，在于普通的SQL语句，每次都会对语法分析，编译，执行，而存储过程只是在第一次执行语法分析，编译，执行，以后都是对结果进行调用。

> 2.可减轻网络负担。使用存储过程，复杂的数据库操作也可以在数据库服务器中完成。只需要从客户端(或应用程序)传递给数据库必要的参数就行，比起需要多次传递SQL命令本身，这大大减轻了网络负担。

> 3.可将数据库的处理黑匣子化。应用程序中完全不用考虑存储过程的内部详细处理，只需要知道调用哪个存储过程就可以了

```sql
-- 定义一个没有返回值 存储过程
-- 实现：模糊查询操作
select * from emp where ename like '%A%';

create procedure mypro01(name varchar(10)) 
begin 
    if name is null or name = "" 
    then
        select * from emp;
    else
        select * from emp where ename like concat('%', name, '%');
    end if;
end;

-- 删除存储过程
drop procedure mypro01;

-- 调用存储过程
call mypro01(null);
call mypro01('R');

-- 定义一个  有返回值的存储过程：
-- 实现：模糊查询操作：
-- in 参数前面的in可以省略不写
-- found_rows()mysql中定义的一个函数，作用返回查询结果的条数
create procedure mypro02(in name varchar(10),out num int(3))
begin
    if name is null or name = "" then
        select * from emp;
    else
    select * from emp where ename like concat('%',name,'%');
    end if;
    select found_rows() into num;
end;

-- 调用存储过程
call mypro02(null,@num);
select @num;

call mypro02('R',@aaa);
select @aaa;

```


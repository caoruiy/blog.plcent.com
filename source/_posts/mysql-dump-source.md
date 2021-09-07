---
title: mysql-数据迁移
toc: true
sidebar: true
date: 2021-09-01 14:50:35
tags: 
- mysql
categories:
- mysq
---

# mysql数据导入导出

简单介绍mysql自带数据备份工具mysqldump和数据导入



## mysqldump

`mysqldump` 是 `MySQL` 自带的逻辑备份工具。

它的备份原理是通过协议连接到 `MySQL` 数据库，将需要备份的数据查询出来，将查询出的数据转换成对应的`insert` 语句，当我们需要还原这些数据时，只要执行这些 `insert` 语句，即可将对应的数据还原。



`mysqldump`优点包括在恢复之前查看甚至编辑输出的便利性和灵活性。您可以克隆用于开发和 DBA 工作的数据库，或生成现有数据库的细微变化以进行测试。它不是用于备份大量数据的快速或可扩展的解决方案。对于大数据量，即使备份步骤花费合理的时间，恢复数据也可能非常缓慢，因为重放 SQL 语句涉及用于插入、索引创建等的磁盘 I/O。



mysql 官方文档 [https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html)



### 命令格式

```java
mysqldump [options] db_name [tbl_name ...]
mysqldump [options] --databases db_name ...
mysqldump [options] --all-databases
```



### 常用选项说明

| 参数名                                                       | 缩写 | 含义                                                         |
| ------------------------------------------------------------ | ---- | ------------------------------------------------------------ |
| --host                                                       | -h   | 服务器IP地址                                                 |
| --port                                                       | -P   | 服务器端口号                                                 |
| --user                                                       | -u   | MySQL 用户名                                                 |
| --pasword                                                    | -p   | MySQL 密码                                                   |
| --databases                                                  |      | 指定要备份的数据库                                           |
| --all-databases                                              |      | 备份mysql服务器上的所有数据库                                |
| [`--add-drop-database`](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_add-drop-database) |      | 在每个 CREATE DATABASE 语句之前添加 DROP DATABASE 语句       |
| [--add-drop-table](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_add-drop-table) |      | 在每个 CREATE TABLE 语句之前添加 DROP TABLE 语句。默认添加drop语句 |
| [--opt](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_opt) |      | --add-drop-table --add-locks --create-options --disable-keys --extended-insert --lock-tables --quick --set-charset 语句的简写。该选项默认启用。 |
| [--skip-add-drop-table](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_add-drop-table) |      | 不要在每个 CREATE TABLE 语句之前添加 DROP TABLE 语句         |
| [--extended-insert](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_extended-insert) |      | 使用多行 INSERT 语法。输出一条insert语句                     |
| [--skip-extended-insert](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_extended-insert) |      | 关闭--extended-insert。输出多条insert语句                    |
| --compact                                                    |      | 压缩模式，产生更少的输出                                     |
| --comments                                                   |      | 添加注释信息                                                 |
| --complete-insert                                            |      | 输出完成的插入语句                                           |
| --lock-tables                                                | -l   | 备份前，锁定所有数据库表                                     |
| --no-create-db/--no-create-info                              |      | 禁止生成创建数据库语句                                       |
| --no-data                                                    |      | 不写入任何表行信息（即不转储表内容）。如果您只想转储[`CREATE TABLE`](https://dev.mysql.com/doc/refman/5.6/en/create-table.html)表的语句 |
| --force                                                      |      | 当出现错误时仍然继续备份操作                                 |
| --default-character-set                                      |      | 指定默认字符集                                               |
| [--add-locks](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_add-locks) |      | 备份数据库表时锁定数据库表。生产环境慎用                     |
| --where='*`where_condition`*'                                | -w   | 仅转储由给定`WHERE`条件选择的行 。                           |
| --quick`, `-q                                                | -q   | 一次一行地从服务器检索表的行                                 |
| [--single-transaction](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_single-transaction) |      | 在从服务器转储数据之前发出 BEGIN SQL 语句。一致性备份        |
| --skip-opt                                                   |      | 关闭由 --opt 设置的选项。避免锁表备份                        |
| --result-file                                                | >    | 导出结果输出到文件                                           |

全部选项参见[https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html)



### 常见示例

1. 导出所有数据库

该命令会导出mysql中所有的数据库内容，如果你是全表备份，

```mysql
mysqldump -u用户名 -p密码 --all-databases > ~/all.sql
```

2. 导出指定数据库

```
mysqldump -u用户名 -p密码 --databases db1 > ~/db1.sql
```

该[`--databases`](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_databases)选项使命令行上的所有名称都被视为数据库名称。如果没有此选项，[**mysqldump**](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html)将第一个名称视为数据库名称，将后面的名称视为表名称。

3. 导出指定数据库的指定表

```mysql
mysqldump -u用户名 -p密码 databaseName tableName --single-transaction --set-gtid-purged=OFF > ~/tableName.sql
```

4. 导出数据时指定条件--where

```mysql
# 只导出ID>10的记录
mysqldump -u用户名 -p密码 databaseName tableName --single-transaction --set-gtid-purged=OFF --where="id>10" > ~/tableName.sql
```





### 常见问题

#### 避免锁表

默认mysqldump备份会`lock-tables`，对于线上服务，锁表会影响线上业务。mysqldump提供了几种方式来避免备份是锁表

##### --single-transaction

[--single-transaction](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_single-transaction)是针对innodb引擎的，备份一致性选项，通过事务来保证数据的一致性。

##### --skip-opt

由于[--opt](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_opt)选项默认启用，因此您只需指定其相反的选项 [`--skip-opt`](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_skip-opt)即可关闭几个默认设置。

##### --skip-lock-tables

使用`--opt`选项时，会自动启动`--lock-tables`，如果你不想锁表操作，可以指定`--skip-opt`或者追加`--skip-lock-tables`属性来覆盖它。



#### 一条记录输出一条insert语句

[--skip-extended-insert](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_extended-insert) 语句可以关闭默认的多行 INSERT 语法。

```mysql
mysqldump -u用户名 -p密码 --single-transaction --quick --set-gtid-purged=OFF --skip-extended-insert databaseName tableName > ~/tableName.sql
```



#### 转储大表

[--quick](https://dev.mysql.com/doc/refman/5.6/en/mysqldump.html#option_mysqldump_quick) 该选项用于转储大的表。它强制**mysqldump**从服务器一次一行地检索表中的行而不是检索所有行并在输出前将它缓存到内存中。



### 导入

#### 重新导入有mysqldump导出的SQL文件

1. 直接通过mysql导入

```shell
# 如果dump.sql脚本中包含CREATE_DATABASE和USE语句，可以直接导入sql
shell> mysql < dump.sql
# 如果不存在，在加载转储文件时指定数据库名称
shell> mysql db1 < dump.sql
```

2. 使用source命令

进入mysql命令行，使用mysql中的source命令导入

```mysql
mysql> source dump.sql
```

如果文件不包含`CREATE_DATABASE`和`USE`语句，需要提前创建数据库

```shell
shell> mysqladmin create db1
```

或者

```mysq
mysql> CREATE DATABASE IF NOT EXISTS db1;
mysql> USE db1;
mysql> source dump.sql
```




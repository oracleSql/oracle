
--------------------------------------------------------------------------------------------------------
--创建表
--------------------------------------------------------------------------------------------------------

create table tab_name(
	colName1 varchar2(30) default 'adf' not null,
	colName2 number(3,2) default 0 check (colName2 < 8),
	constraint tab_name_uq unique(colName1,colName2),
	constraint tab_name_pk primary key(colName1) using index tablespace users
)

--唯一索引
constraint tab_name_uq unique(colName1,colName2)
--主键
constraint tab_name_pk primary key(colName1) using index tablespace users
--外键
constraint tab_name_fk foreign key(colName1) references tabName2(colName1)

--只读表
alter table tabName read only;
alter table tabName read write;

--创建虚拟列
create table tabName(
	colName1 varchar2(80) not null primary key,
	colName2 date,
	colName3 number(3,1)
	generated always as (upper(colName1)) virtual
)

--CTAS 方法创建表
create table tabNameNew as 
select colName1,colName2 from tabName;

create table tabNameNew as 
nologging
select colName1,colName2 from tabName;

--索引组织表(当表中的主键由大部分列构成时,并且表内数据不会频繁变动,可以考虑)
create table tabName(
	...
)
organization index;


--------------------------------------------------------------------------------------------------------
--删除表
--------------------------------------------------------------------------------------------------------
drop table tabName;

--删除表的同时,清空回收站
drop table tabName purge;
--清空已删除表的回收站
purge table tabName;
--清空回收站所有内容
purge recyclebin;

--截断表(不会触发触发器)
truncate table tabName;


--------------------------------------------------------------------------------------------------------
--修改表
--------------------------------------------------------------------------------------------------------
alter table tabName add
(
	colName varchar2(80) not null, 
	colName1 number(3,1)
)

alter table tabName modify(
	colName varchar(70) not null,
	colNmae number(4,1)
)

alter table tabName drop column colName;
alter table tabName drop (colName1,colName2);
--将列标记为 unused 状态后,在删除,会减少对数据库的性能影响
alter table tabName set unused column colName;
alter table tabName drop unused columns;

--超时执行(秒)
alter session set ddl_lock_timeout=60
alter system set ddl_lock_timeout=60 































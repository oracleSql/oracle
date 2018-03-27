
--------------------------------------------------------------------------------------------------------
--创建表
--------------------------------------------------------------------------------------------------------

create table tab_name(
	colName1 varchar2(30) default 'adf' not null,
	colName2 number(3,2) default 0 check (colName2 < 8),
	constraint tab_name_uq unique(colName1,colName2),
	constraint tab_name_pk primary key(colName1) using index tablespace users
)

--创建索引
create [bitmap | unique] index indName on tabName(colName1 [,colName2]...) [reverse];
--唯一索引
constraint tab_name_uq unique(colName1,colName2) tablespace ind_space;
--主键
constraint tab_name_pk primary key(colName1) using index tablespace users
--外键
constraint tab_name_fk foreign key(colName1) references tabName2(colName1)
--创建不可见索引
alter index indName invisible;
--重建索引
alter index indName rebuild 
storage(initial 8m next 4m pctincrease 0)
tablespace ind_space
--访问索引时,重建这些索引
alter index indName rebuild tablespace ind_space online


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


--创建只读视图
create or replace view viewName as 
select * from tabName
with read only;


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



--------------------------------------------------------------------------------------------------------
--创建集群表和索引
--------------------------------------------------------------------------------------------------------

--创建集群 
create cluster clusterName(colName1 dataType [,colName2 dataType]...) [other options];
--创建集群表
create table tabName(
	...
)
cluster clusterName(title)
;
--创建集群索引
create index indexName on cluster clusterName;



--------------------------------------------------------------------------------------------------------
--序列
--------------------------------------------------------------------------------------------------------
create sequence seqName increment by 1 start with 1000;



--------------------------------------------------------------------------------------------------------
--分区表
--------------------------------------------------------------------------------------------------------

--范围分区,范围内的值小于但不等于最大值
create table tabName(
	...
)
partition by range(colName)
(
	partition part1 values less then (10) tablespace part1_ts,
	partition part2 values less then (maxvalue) tablespace part2_ts
);

--散列分区
create table tabName(
	...
)
partition by hash(colName)
partition 2 
store in (part1_ts,part2_ts)
;

create table tabName(
	...
)
partition by hash(colName)
(
	partition part1 tablespace part1_ts,
	partition part2 tablespace part2_ts
)
;

--列表分区
create table tabName(
	...
)
partition by list(colName)
(
	partition part1 values(1,2,3,4) tablespace part1_ts ,
	partition part2 values(5,6,7,8) tablespace part2_ts ,
	partition partOther values(default)
)
;

--创建子分区
create table tabName(
	...
)
partition by range(colName)
subpartition by hash(colName2)
subpartition 8 
(
	partition part1 values less then (10) tablespace part1_ts,
	partition part2 values less then (maxvalue) tablespace part2_ts
)
;


--创建分区索引
create index indexName on tabName(colName) local
(
	partition part1 tablespace part1_ts,
	partition part2 tablespace part2_ts
);
--创建全局索引(全局索引进行唯一性检查的速度会比局部索引(分区索引)快)
create index indexName on tabName(colName) global;










--------------------------------------------------------------------------------------------------------
--用户操作
--------------------------------------------------------------------------------------------------------
create user userName identified {by password | externally | globally as 'txtnm'}

create user userName identified by passwd; 
alter user userName identified by passwdNew;

alter user userName account unlock; --解锁用户
alter user userName account lock;   --锁定用户
--------------------------------------------------------------------------------------------------------
--权限操作
--------------------------------------------------------------------------------------------------------
grant create session to userName;  --登录权限


password username --修改用户 username 的密码
password          --修改自己的密码

revoke create session from userName; --撤销权限


--------------------------------------------------------------------------------------------------------
--创建角色(权限的集合)
--------------------------------------------------------------------------------------------------------

create role roleName;


--------------------------------------------------------------------------------------------------------
--表空间
--------------------------------------------------------------------------------------------------------

create tablespace tabSpaceName 
	datafile '/u01/.../data1.dbf'
	size 100M autoextend on next 50G maxsize 2T;
	
--只读,读写表空间
alter tablespace tabSpaceName read only;
alter tablespace tabSpaceName read write;


--------------------------------------------------------------------------------------------------------
--导入和导出
--------------------------------------------------------------------------------------------------------
--创建逻辑目录 
create or replace directory dpdata1 as 'd:\test\dump';
grant read,write on directory dpdata1 to scott;
--查看管理理员目录（同时查看操作系统是否存在，因为Oracle并不关心该目录是否存在，如果不存在，则出错）
select * from dba_directories;

--必须具有 exp_full_database 系统权限的,才能执行完全导出或者传输表空间导出.

--1)按用户导
expdp scott/tiger@orcl DIRECTORY=dpdata1 dumpfile=expdp.dmp  schemas=scott ;

--2)并行进程parallel
expdp scott/tiger@orcl directory=dpdata1 dumpfile=scott3.dmp   parallel=40 job_name=scott3

--3)按表名导
expdp scott/tiger@orcl DIRECTORY=dpdata1 dumpfile=expdp.dmp  TABLES=emp,dept ;

--4)按查询条件导
expdp scott/tiger@orcl directory=dpdata1 dumpfile=expdp.dmp  Tables=emp query='WHERE deptno=20';

--5)按表空间导
expdp system/manager DIRECTORY=dpdata1 DUMPFILE=tablespace.dmp TABLESPACES=temp,example;

--6)导整个数据库
expdp system/manager DIRECTORY=dpdata1 DUMPFILE=full.dmp FULL=y;

--将会话连接到一个正在运行的实例下
expdb scott/tiger@orcl attach;
expdb scott/tiger@orcl attach=job_name;



五、还原数据

--1)导到指定用户下
impdp scott/tiger DIRECTORY=dpdata1 DUMPFILE=expdp.dmp SCHEMAS=scott;

--2)改变表的owner,从scott转变为sytem 
impdp system/manager DIRECTORY=dpdata1 DUMPFILE=expdp.dmp TABLES=scott.dept REMAP_SCHEMA=scott:system;

--3)导入表空间
impdp system/manager DIRECTORY=dpdata1 DUMPFILE=tablespace.dmp TABLESPACES=example;

--4)导入数据库
impdb system/manager DIRECTORY=dump_dir DUMPFILE=full.dmp FULL=y;

--5)追加数据
impdp system/manager DIRECTORY=dpdata1 DUMPFILE=expdp.dmp SCHEMAS=system TABLE_EXISTS_ACTION


--------------------------------------------------------------------------------------------------------
--创建 dblink 
--------------------------------------------------------------------------------------------------------
create [shared] [public] database link linkName
  connect to linkUser identified by linkPwd
  using '(DESCRIPTION =
                (ADDRESS_LIST =
                  (ADDRESS = (PROTOCOL = TCP)(HOST = linkIP)(PORT = 1521))
                )
                (CONNECT_DATA =
                  (SERVICE_NAME = linkServiceName)
                )
              )';

--
-




--------------------------------------------------------------------------------------------------------
--创建 物化视图 
--------------------------------------------------------------------------------------------------------
--必要的权限
create materialized view 
create table 或者 create any table 
unlimited tablespace 
on commit refresh
























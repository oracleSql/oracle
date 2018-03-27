


--------------------------------------------------------------------------------------------------------
--�û�����
--------------------------------------------------------------------------------------------------------
create user userName identified {by password | externally | globally as 'txtnm'}

create user userName identified by passwd; 
alter user userName identified by passwdNew;

alter user userName account unlock; --�����û�
alter user userName account lock;   --�����û�
--------------------------------------------------------------------------------------------------------
--Ȩ�޲���
--------------------------------------------------------------------------------------------------------
grant create session to userName;  --��¼Ȩ��


password username --�޸��û� username ������
password          --�޸��Լ�������

revoke create session from userName; --����Ȩ��


--------------------------------------------------------------------------------------------------------
--������ɫ(Ȩ�޵ļ���)
--------------------------------------------------------------------------------------------------------

create role roleName;


--------------------------------------------------------------------------------------------------------
--��ռ�
--------------------------------------------------------------------------------------------------------

create tablespace tabSpaceName 
	datafile '/u01/.../data1.dbf'
	size 100M autoextend on next 50G maxsize 2T;
	
--ֻ��,��д��ռ�
alter tablespace tabSpaceName read only;
alter tablespace tabSpaceName read write;


--------------------------------------------------------------------------------------------------------
--����͵���
--------------------------------------------------------------------------------------------------------
--�����߼�Ŀ¼ 
create or replace directory dpdata1 as 'd:\test\dump';
grant read,write on directory dpdata1 to scott;
--�鿴������ԱĿ¼��ͬʱ�鿴����ϵͳ�Ƿ���ڣ���ΪOracle�������ĸ�Ŀ¼�Ƿ���ڣ���������ڣ������
select * from dba_directories;

--������� exp_full_database ϵͳȨ�޵�,����ִ����ȫ�������ߴ����ռ䵼��.

--1)���û���
expdp scott/tiger@orcl DIRECTORY=dpdata1 dumpfile=expdp.dmp  schemas=scott ;

--2)���н���parallel
expdp scott/tiger@orcl directory=dpdata1 dumpfile=scott3.dmp   parallel=40 job_name=scott3

--3)��������
expdp scott/tiger@orcl DIRECTORY=dpdata1 dumpfile=expdp.dmp  TABLES=emp,dept ;

--4)����ѯ������
expdp scott/tiger@orcl directory=dpdata1 dumpfile=expdp.dmp  Tables=emp query='WHERE deptno=20';

--5)����ռ䵼
expdp system/manager DIRECTORY=dpdata1 DUMPFILE=tablespace.dmp TABLESPACES=temp,example;

--6)���������ݿ�
expdp system/manager DIRECTORY=dpdata1 DUMPFILE=full.dmp FULL=y;

--���Ự���ӵ�һ���������е�ʵ����
expdb scott/tiger@orcl attach;
expdb scott/tiger@orcl attach=job_name;



�塢��ԭ����

--1)����ָ���û���
impdp scott/tiger DIRECTORY=dpdata1 DUMPFILE=expdp.dmp SCHEMAS=scott;

--2)�ı���owner,��scottת��Ϊsytem 
impdp system/manager DIRECTORY=dpdata1 DUMPFILE=expdp.dmp TABLES=scott.dept REMAP_SCHEMA=scott:system;

--3)�����ռ�
impdp system/manager DIRECTORY=dpdata1 DUMPFILE=tablespace.dmp TABLESPACES=example;

--4)�������ݿ�
impdb system/manager DIRECTORY=dump_dir DUMPFILE=full.dmp FULL=y;

--5)׷������
impdp system/manager DIRECTORY=dpdata1 DUMPFILE=expdp.dmp SCHEMAS=system TABLE_EXISTS_ACTION


--------------------------------------------------------------------------------------------------------
--���� dblink 
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
--���� �ﻯ��ͼ 
--------------------------------------------------------------------------------------------------------
--��Ҫ��Ȩ��
create materialized view 
create table ���� create any table 
unlimited tablespace 
on commit refresh
























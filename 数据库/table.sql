--1.EMP表:
		--删除表
		DROP TABLE EMP;
		--创建表
		CREATE TABLE EMP(
			EMPNO     NUMBER(10),                          
			ENAME     VARCHAR2(20),                      
			JOB       VARCHAR2(25),                        
			MGR       NUMBER(10) ,                          
			BIRTHDATE DATE  ,                               
			SALARY    NUMBER(10,2) ,                        
			COMM      NUMBER(10,2)  ,   --奖金                  
			DEPTNO    NUMBER(5) 
		)
		--插入数据
		INSERT INTO EMP VALUES(7369,'SMITH','CLERK',7902,'17-12月-1980',800.00,NULL,20);
		INSERT INTO EMP VALUES(7499,'ALLEN','SALESMAN',7698,'20-2月-1981',1600.00,300,30);
		INSERT INTO EMP VALUES(7521,'WARD','SALESMAN',7698,'22-2月-1981',1250.00,500,30);		
		INSERT INTO EMP VALUES(7566,'JONES','MANAGER',7839,'2-4月-1981',2975,NULL,20);
		INSERT INTO EMP VALUES(7654,'MARTIN','SALESMAN',7698,'28-9月-1981',1250.00,1400,30);
		INSERT INTO EMP VALUES(7782,'CLARK','MANAGER',7839,'1-5月-1981',2450.00,NULL,10);
		INSERT INTO EMP VALUES(7698,'BLAKE','MANAGER',7839,'9-6月-1981',2850.00,NULL,30);
		INSERT INTO EMP VALUES(7788,'SCOTT','ANALYST',7566,'19-4月-1981',3000.00,NULL,20);
		INSERT INTO EMP VALUES(7839,'KING','PRESIDENT',NULL,'17-11月-1981',5000.00,NULL,10);		
		INSERT INTO EMP VALUES(7844,'TURNER','SALESMEAN',7698,'8-9月-1980',1500.00,0,30);
		INSERT INTO EMP VALUES(7876,'ADAMS','CLERK',7788,'23-5月-1987',1100.00,NULL,20);
		INSERT INTO EMP VALUES(7900,'JAMES','CLERK',7698,'3-12月-1981',950.00,NULL,30);
		INSERT INTO EMP VALUES(7902,'FORD','ANALYST',7566,'3-12月-1981',3000.00,NULL,20);
		INSERT INTO EMP VALUES(7934,'NILLER','CLERK',7782,'23-1月-1982',1300.00,NULL,10);
		
--2.DEPT表
		--删除表
		DROP TABLE DEPT;
		--创建表
		CREATE TABLE DEPT(
			DEPTNO NUMBER(5),
			DNAME VARCHAR2(25),
			LOC VARCHAR2(30)
		);
		
		--插入数据
		INSERT INTO DEPT VALUES(10,'ACCOUNTING','NEW YORK');
		INSERT INTO DEPT VALUES(20,'RESEARCH','DALLAS');
		INSERT INTO DEPT VALUES(30,'SALES','CHICAGO');
		INSERT INTO DEPT VALUES(40,'OPERATIONS','BOSTON');
		
--3.SAL_GRADE
		--删除表
		DROP TABLE SAL_GRADE;
		--创建表
		CREATE TABLE SAL_GRADE(
			GRADE NUMBER(3),
			LOSAL NUMBER(10,2),
			HISAL NUMBER(10,2)
		);
		--插入数据
		INSERT INTO SAL_GRADE VALUES(1,700,1200);
		INSERT INTO SAL_GRADE VALUES(2,1201,1400);
		INSERT INTO SAL_GRADE VALUES(3,1401,2000);
		INSERT INTO SAL_GRADE VALUES(4,2001,3000);
		INSERT INTO SAL_GRADE VALUES(5,3001,9999);
		
--查询第N到第M条记录工资的记录
		SELECT ENAME,SAL FROM(
			SELECT ENAME,SAL,ROWNUM NUM FROM(
				SELECT ENAME,SAL FROM EMP ORDER BY SAL DESC
			) WHERE ROWNUM <=M
		)WHERE NUM>N;	
		
--查询第N高工资的记录		
	SELECT MAX(SAL) FROM EMP  WHERE LEVEL = &N  CONNECT BY PRIOR SAL>SAL  START WITH SAL = 
	( SELECT MAX(SAL) FROM EMP);	
	
	select max(sal) from emp  where level = 4  connect by prior sal>sal  start with sal = 
	( select max(sal) from emp);	
	select sal from(
		select rownum num, sal from  (select distinct sal from emp)
	) where num = ( select count (distinct sal ) + 1 - &n from emp);
		
		
	
		
		
		
		

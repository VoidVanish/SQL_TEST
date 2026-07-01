-- 演示1: union 和 union all
select * from emp where deptno = 10
union all
select * from emp where deptno = 10 or deptno = 20;

--列数要一致 但列名可以不一致 且要保证不一致的列数据类型相同
select ename, sal, deptno from emp where deptno = 10
union
select ename, comm, deptno from emp where deptno = 20;


------DDL

--1查询每个雇员的编号、姓名、职位。
select empno, ename, job
from emp;

--2查询每个雇员的职位。
select ename, job
from emp;

--3查询每个雇员的职位，使用DISTINCT消除掉显示的重复行记录。  ---distinct(列)
select ename, distinct(job)
from emp;

--4查询基本工资高于2000的全部雇员信息。
select *
from emp
where sal > 2000;

--5查询出smith的信息。
select *
from emp
where ename = 'SMITH';

--6查询出所有不是CLERK的详细信息。
select *
from emp
where job != 'CLERK';

--7查询出所有销售人员(SALESMAN)的基本信息，并且要求销售人员的工资高于1300。
select ename, job, sal, deptno
from emp
where job = 'SALESMAN' and sal > 1300;

--8查询出工资范围在1500~3000之间的全部雇员信息（包含1500和3000）。
select  *
from emp
where sal between 1500 and 3000;

--9查询出所有经理或者是销售人员的信息，并且要求这些人的基本工资高于1500。
select *
from emp
where (job = 'SALESMAN' or  job ='MANAGER') and sal > 1500;


--10.要求查询出所有在1981年雇佣的雇员信息。
select *
from emp
where substr(to_char(hiredate, 'YYYY-MM-DD'), 1,4);


--11.查询所有领取奖金的雇员信息（comm不为空）。
select *
from emp
where comm is not null;

--12.查询出雇员编号是7369、7566、9999的雇员信息。
select *
from emp
where empno in (7369, 7566, 9999);

--13.查询出所有雇员姓名是以A开头的全部雇员信息。
select *
from emp 
where ename like 'A%';


--14.查询出雇员姓名第二个字母是M的全部雇员信息。
select *
from emp
where ename like '_M%';


--15.查询出雇员姓名任意位置上包含字母A的全部雇员信息。
select *
from emp
where instr(ename, 'A', 1) != 0;

--16.查询出所有雇员的信息，要求按照工资排序。
select *
from emp
order by sal;

--17.要求查询所有雇员的信息，按照雇佣日期由先后排序。
select *
from emp
order by hiredate;


--18.查询全部雇员信息，按照工资由高到低排序，如果工资相同，则按照雇佣日期由先后排序。
select *
from emp e join (select *
     from emp
     where sal = sal
order by hiredate) t on t.hiredate = e.hiredate
order by e.sal desc;

select *
from emp
where sal = sal
order by hiredate;

--19.查询部门30中的所有员工。
select *
from emp
where deptno = 30

--20.查询出所有办事员（CLERK）的姓名，编号和部门编号。
select ename, empno, deptno
from emp
where job = 'CLERK';

--21.查询出部门10中所有经理（MANAGER）和部门20中所有办事员（CLERK）的详细资料。
select *
from emp
where job in ('MANAGER', 'CLERK') and deptno =10;

--22.查询出部门10中所有经理，部门20中所有办事员，既不是经理又不是办事员但其薪金大于或等于2000的所有员工的信息。
select *
from emp
where deptno in (10, 20) and job not in ('MANAGER', 'CLERK');


select *
from (select *
     from emp
     where deptno in (10, 20) and job not in ('MANAGER', 'CLERK')) t 
where sal >= 2000;


--23.查询有津贴的员工的不同工作。
select ename, job
from emp
where comm is not null;

--24.查询出不带有'R'的员工的姓名。
select ename
from emp 
where instr(ename, 'R', 1) != 0;

--25 查询10号部门中工种为MANAGER和20号部门中工种为CLERK的员工的信息
select *
from emp
where (deptno = 10 and job = 'MANAGER') or (deptno = 20 and job = 'CLERK');

--26 查询所有工种不是MANAGER和CLERK，且工资大于或等于2000的员工的详细信息
select *
from emp 
where job not in ('MANAGER', 'CLERK') and sal >= 2000;

--27 查询没有奖金或奖金低于100的员工信息
select *
from emp
where comm = 0 or comm <= 100;

--28 查询有奖金的员工的不同工种
select *
from emp
where comm is not null;

select t.job
from (select *
     from emp
     where comm is not null) t
group by t.job;

--29 查询员工名字中最后一个字母是“S”员工信息
select *
from emp
where ename like '%S'

--30 查询薪资在[1000, 2000]的雇员信息，使用2种方式
法一
select *
from emp
where sal between 1000 and 2000;

法二
select *
from emp
where sal >= 1000 and sal <= 2000;

----------------------------------------------------
一、函数和聚合函数

字符函数
--在emp表中查询出姓名的第二个字母为A的记录。
select *
from emp
where instr(ename, 'A', 1, 1) = 2;

--显示员工姓名正好为5个字符的员工。
select *
from emp
where length(ename) = 5;

--显示所有员工姓名的前三个字符。
select substr(ename, 1, 3)
from emp;

--显示所有员工的姓名，用 a 替换A。
select replace(ename, 'A', 'a')
from emp;

--在'广东省-广州市-番禺区' 中截取出市区
select substr('广东省-广州市-番禺区', 5)
from dual;

数字函数
--显示所有员工的日薪金，忽略余数。每个月的天数都以30天计。
select ename, round(sal/30) as 日薪
from emp;


时间函数
--查询1981年入职的员工
select *
from emp
where to_char(hiredate, 'YYYY') = '1981';


聚合函数
--查出30部门全年工资 与 奖金总和。
select sum(sal*12) 年工资, sum(comm) 年奖金
from emp
where deptno = 30


--查出每个部门每个职位的员工数量。
select deptno, count(deptno)
from emp
group by (deptno);

--查出年薪大于50000且奖金大于1000的员工信息。
select *
from emp
where sal > 5000/12 and comm >1000;

--查出各部门各职位员工数量与部门职位年薪。
1 统计所有工作和部门
select job, deptno, sal
from emp

2
select t2.job,count(t2.job) 职位员工数量, t2.deptno, sum(sal*12) 部门职位年薪
from (select job, deptno, sal
     from emp) t2
group by t2.job, t2.deptno --上面是按步骤 临时表1是先把emp里面的东西拿出来 步骤2再把临时表1收进来
                           --临时表3是直接把emp当临时表用从中组合job和部门 两者方法是一致的 
                           --只是步骤1多次一举生成一张临时表了
3
select job,count(job) 职位员工数量, deptno, sum(sal*12) 部门职位年薪
from emp
group by job, deptno;

--查出20部门CLERK和MANAGER职位的员工数量。
select job, count(job) 数量
from emp
where deptno = 20 and job in('CLERK', 'MANAGER')
group by job;

--查出员工人数大于3个的部门的部门编号及对应的员工数量
1 查询各个部门的人数和部门号
select deptno, count(deptno) Countdep
from emp
group by deptno;

2 过滤小于三个的
select *
from (select deptno, count(deptno) Countdep
     from emp
     group by deptno) t
where t.Countdep > 3



--------------------------------------------
--查询员工编号，员工姓名，领导编号，领导姓名。 例如：7369  SMITH  7902  FORD
select e.empno 员工编号, e.ename 员工姓名, m.empno 领导编号, m.ename 领导姓名 
from emp e join emp m on e.mgr = m.empno
where e.ename = 'SMITH' or e.ename = 'FORD' ;


--查询入职日期早于其直接上级领导的所有员工信息
select e.empno,
       e.ename,
       e.job,
       e.mgr,
       e.hiredate,
       e.sal,
       e.comm,
       e.deptno
from emp e join emp m on e.mgr = m.empno
where e.hiredate < m.hiredate;

--查询所有部门及其员工信息，包括那些没有员工的部门
select *
from dept d left join emp e on d.deptno = e.deptno;

--查询所有工种为CLERK的员工的姓名及其部门名称
1 查询所有工种为clerk的员工
select ename, deptno
from emp
where job = 'CLERK'
2 链接dept表
select c.ename, d.deptno, d.dname
from dept d join (select ename, deptno
     from emp
     where job = 'CLERK') c on d.deptno = c.deptno

--查询各个部门的编号,名称 以及部门人数、部门平均工资
1 查询每个部门的人数和每个部门的平均工资
select deptno, count(deptno) 人数, avg(sal) 平均工资
from emp 
group by deptno
2 与部门关联
select d.deptno, d.dname, t.人数, t.平均工资
from dept d join (select deptno, count(deptno) 人数, avg(sal) 平均工资
     from emp 
     group by deptno) t on d.deptno = t.deptno;

--查询最低工资低于2000的部门名称
1 查询最低工资的部门
select deptno, min(sal) 最低工资
from emp
group by deptno;
2 与部门表关联 并判断最低工资低于两千的部门有几个
select t.deptno, d.dname
from dept d join (select deptno, min(sal) minsal
          from emp
          group by deptno) t on d.deptno = t.deptno
where t.minsal < 2000;

--查询所有员工工资都在900~3000之间的部门的信息
1
select ename, deptno, sal
from emp
where sal between 900 and 3000;
2
select d.dname
from dept d join (select ename, deptno, sal
     from emp
where sal between 900 and 3000) t on t.deptno = d.deptno;
                   
二、子查询（写步骤）
--查询工资比SMITH员工工资高的所有员工信息
1 获取sim工资  
select sal from emp where ename = 'SMITH';
2 将sal工资与其余员工比对
select *
from emp e
where e.sal > (select sal from emp where ename = 'SMITH');

--查询工资比SCOTT或者SMITH高的员工信息
1 查询scott与smi的工资
select sal
from emp
where ename = 'SMITH';

select sal
from emp
where ename = 'SCOTT';

2 将单列多行的数据与其他员工比较
select *
from emp e
where e.sal > (select sal
      from emp
      where ename = 'SMITH') or
      e.sal > (select sal
      from emp
      where ename = 'SCOTT') 
and
      ename != 'SCOTT' and ename != 'SMITH';

--查询与SMITH员工从事相同工作的所有员工信息 
1 查询sim的工作
select job
from emp
where ename = 'SMITH';
2 把1作为条件与其他雇员进行比较
select *
from emp e
where e.job = (select job
      from emp
      where ename = 'SMITH')

--查询所有员工的姓名及其 直接上级的姓名(子查询)
1 获取所有员工的姓名和mgr
select ename, mgr
from emp;
2 将1作为表放入from与emp m表连
select t.ename, m.ename
from (select ename, mgr
     from emp) t join emp m on t.mgr = m.empno;

--查询工资高于公司平均工资的所有员工信息
1 查平均工资
select avg(sal)
from emp ;
2 比较
select *
from emp e
where e.sal > (select avg(sal)
      from emp );

--列出工资等于 30号部门中某个员工工资 的所有员工的姓名和工资。
1 所有不是30部门的员工的工资
select ename, sal
from emp 
where deptno != 30

e.sal = t.sal

2 拿不是
select sal
from emp e
where deptno = 30  当做list


select t.ename, t.sal
from (select ename, sal
     from emp 
     where deptno != 30
) t
where t.sal in((select sal
      from emp e
      where deptno = 30 ));


--查询工资高于 30号部门中工作的所有员工的工资 的员工姓名和工资
1 30部门最高工资
select max(sal)
from emp
where deptno = 30 --值
2 对比
select ename, sal
from emp
where sal > (select max(sal)
      from emp
      where deptno = 30)


--查询所有员工工资都大于1000的部门的信息
1 过滤工资
select deptno
from emp
where sal > 1000
2 链接部门
select d.deptno, d.dname, d.loc
from dept d
where d.deptno in (select deptno
      from emp
      where sal > 1000)

--查询所有员工工资都大于1000的部门的信息及其员工信息
1 查询大于1000的员工信息
select *
from emp
where sal > 1000
2 放进from当表
select *
from (
     select *
     from emp
     where sal > 1000
) t join dept d on t.deptno = d.deptno;


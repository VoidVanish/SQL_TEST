1. 显示工资比ALLEN高 并且与SCOTT从事相同工作的所有员工的姓名,工资,职位
 1 查询与ALLEN工资
select sal from emp where ename = 'ALLEN';
 2 找到与scott相同工种的员工
select e.ename, e.sal, e.job from emp e where e.sal > 
(select sal from emp where ename = 'ALLEN') and e.job = 'ANALYST' and e.ename != 'SCOTT';
 
 
2. ★查询20部门所有工资高于全表平均工资的员工姓名,工资,全表平均工资
 1 计算全表平均工资
select avg(sal) from emp;
 2 查询20部门的所有人的工资高于全表
select e.ename, e.sal, (select avg(sal) from emp) as avgsal
from emp e where e.deptno = 20 and
     e.sal > (select avg(sal) from emp);

3. ★查询工资最高的员工所在部门的员工信息
 1 先查出工资最高
select max(sal) from emp;
 2 查询出工资最高的人的信息 
select deptno from emp e where e.sal = (select max(sal) from emp);
 3 查询出最高工资的部门号导出雇员信息
select * from emp ee
       where ee.deptno = (select deptno from emp e where e.sal = (select max(sal) from emp));
  
4. 查询平均工资最高的部门信息
 1 查询部门的平均工资
select avg(sal) avgsal, deptno from emp group by deptno;
 2 在上面的临时表里面获取最高平均工资
select max(avgsal)
from (select avg(sal) avgsal, deptno from emp group by deptno);
 3 把获取到的最高平均工资与临时表比较 获取到部门号
select t.deptno
from (select avg(sal) avgsal, deptno from emp group by deptno) t
where t.avgsal = (select max(avgsal)
from (select avg(sal) avgsal, deptno from emp group by deptno));
 4 把获取的部门号与dept比较
select * from dept
where deptno = (select t.deptno
from (select avg(sal) avgsal, deptno from emp group by deptno) t
where t.avgsal = (select max(avgsal)
from (select avg(sal) avgsal, deptno from emp group by deptno)));

 
5. 查询每个部门工资最高的员工信息
 1 查询部门员工工资信息
select sal, deptno from emp;
 2 分组 并查出最高工资
select t.deptno, max(sal) maxsal
from (select sal, deptno from emp) t
group by t.deptno;
 3 对于最高工资的员工进行对比并且输出员工信息
select *
from emp e join (select t.deptno, max(sal) maxsal
     from (select sal, deptno from emp) t
     group by t.deptno) f on e.sal = f.maxsal
where f.deptno = e.deptno;


6. 列出至少有一个雇员的所有部门信息
 1 如果存在部门有雇员 则返回信息
select * from emp e where e.deptno = 10;
 2 使用exists
select *
from dept d where exists(select * from emp e where e.deptno = d.deptno);

7、查出跟SCOTT在同一个部门，并且从事相同工作的员工 (4种)
法一子查询：
 1 查出scott所在的部门、工种
select deptno from emp where ename = 'SCOTT';
select job from emp where ename = 'SCOTT'
 2 查出跟scott一个部门的雇员
select * from emp e where e.deptno = (select deptno from emp where ename = 'SCOTT');
 3 在查出的雇员表中找出与scott相同工种的雇员
select *
from (select * from emp e where e.deptno = (select deptno from emp where ename = 'SCOTT')) t
where t.job = (select job from emp where ename = 'SCOTT') and ename != 'SCOTT';

法二：多表连接
 1 select deptno, job from emp where ename = 'SCOTT';
 2 select * from emp e join (select deptno, job from emp where ename = 'SCOTT') t
          on e.deptno = t.deptno
   where e.job = t.job and ename != 'SCOTT';

8、列出薪金(工资)比‘SMITH’或者‘ALLEN’多的所有员工的编号、姓名，工资
 1 列出sm和al的工资
select ename, sal from emp where ename = 'SMITH' or ename = 'ALLEN';
 2 将雇员表的员工与 上临时表做判断雇员的工资是否比sm和al高
select e.empno, e.ename, e.sal from emp e join
       (select ename, sal from emp where ename = 'SMITH' or ename = 'ALLEN') t
       on e.sal > t.sal
where e.ename not in('SMITH', 'ALLEN');

9、查询出部门人数超过3人的部门，算出这些部门的平均工资，最高工资
 1 查询有几个部门 每个部门多少人
select deptno, count(deptno) countdp from emp group by deptno;
 2 算出每个部门的最高工资
select t.deptno, avg(sal) avgsal, max(sal) maxsal
from (select sal, deptno from emp) t
group by t.deptno;
 3 合并两张表
select dp.deptno, dp.countdp, amsal.avgsal, amsal.maxsal from (select t.deptno, avg(sal) avgsal, max(sal) maxsal
       from (select sal, deptno from emp) t
       group by t.deptno) amsal join (select deptno, count(deptno) countdp from emp group by deptno) dp on
dp.deptno = amsal.deptno;




请使用in和exists 2种方法完成
--小练习: 查询SMITH上班地点
1 查询sm部门 用in
select deptno from emp where ename = 'SMITH';
2 在dept表判断部门号 输出地点

select loc from dept where deptno in(select deptno from emp where ename = 'SMITH');

用exists
select t.loc
from dept t
where exists (select 1 from emp e where ename = 'SMITH' and e.deptno = t.deptno);


--小练习2: 查询在NEW YORK上班的员工名字
用in
1 select deptno from dept where loc = 'NEW YORK';

select ename from emp e
where deptno in(select deptno from dept where loc = 'NEW YORK');

用exists
1 select ename from emp e
where exists(select d.deptno from dept d where d.loc = 'NEW YORK' and d.deptno = e.deptno);


--小练习3: 查询和10号部门中，岗位相同的其他员工的信息
1 select job from emp where deptno = 10;
上面是一行多列
用in
select * from emp e
where e.job in(select job from emp where deptno = 10);

用exists
select * from emp e
where exists(select job from emp where job = e.job and deptno = 10);

--小练习4: 查询和SMITH是相同岗位的   但是部门是ACCOUNTING的员工信息
用in

select job from emp where ename = 'SMITH';
 1找出跟job一样的其余数据
select deptno from emp e where e.job = (select job from emp where ename = 'SMITH');
 2找出acc的部门号
select deptno from dept where dname = 'ACCOUNTING';
 3跟临时表2 in 求交集
select *
from (select deptno from dept where dname = 'ACCOUNTING') dp
where dp.deptno in (select deptno from emp e where e.job = (select job from emp where ename = 'SMITH'));
 4用临时表3与雇员相求
select * from emp e
where e.deptno = (select *
from (select deptno from emp e where e.job = (select job from emp where ename = 'SMITH')) dp
where dp.deptno in (select deptno from dept where dname = 'ACCOUNTING'));

用exists
select *
from emp e where exists(select 1 from(select deptno from dept where dname = 'ACCOUNTING') t where e.deptno = t.deptno) and
e.job = (select job from emp where ename = 'SMITH');

面试题: in和exists区别？
in是以单列多行结果集对单个结果进行判断查询
exists是以单个结果与其他表进行判断查询

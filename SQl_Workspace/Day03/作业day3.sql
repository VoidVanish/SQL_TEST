--查询20部门的雇员，将工资格式化(转换成)为货币格式（如 ￥99,999.00）显示
select ename, '¥'||to_char(sal,'9999.00')
from emp
where deptno = 20;


--将当前日期转成'2026-04-24'格式的字符串
select sysdate,to_char(sysdate,'YYYY-MM-DD') from dual;

--查询1987年入职的雇员（可以3种方法写）
法一
select ename,hiredate
from emp
where substr(to_char(hiredate,'YYYY/MM/DD'),1,4) = '1987';

法二--instr(to_char(hiredate,'YYYY/MM/DD'),'1987',1,1)
select ename, hiredate
from emp
where instr(to_char(hiredate,'YYYY/MM/DD'),'1987',1,1) = 1;

--查询1987年4月入职的雇员
select ename,hiredate
from emp
where substr(to_char(hiredate,'YYYY/MM/DD'),1,7) = '1987/04';

--查询1987年2季度入职的雇员
select ename
from emp
where to_char(hiredate, 'Q') = '2' and substr(to_char(hiredate,'YYYY/MM/DD'),1,4) = '1987';

--查询1987年1月1日之后入职的雇员
select ename, hiredate
from emp
where trunc(hiredate, 'YEAR') = to_date('19870101', 'YYYYMMDD');



【条件函数-作业】
(1) 给部门10的所有雇员评价薪资等级，标准如下：
工资范围在[0, 999]等级为L1；
工资范围在[1000, 2999]等级为L2；
工资范围在3000以上的等级为L3；

select ename, sal,
       case 
         when sal between 0 and 999 then 'L1'
         when sal between 1000 and 2999 then 'L2'
         when sal > 3000 then 'L3'    
         end as grade
from emp
where deptno = 10;


(2) 为所有人涨工资，查询所有雇员姓名，涨薪前薪资，涨薪后薪资。使用【2种】方法
涨薪标准是：
10部门长10%
20部门长15%
30部门长20%
其他部门长18%

-- case when
select ename, sal BeforeSal, 
       case 
         when deptno = '10' then sal*1.1
         when deptno = '20' then sal*1.15
         when deptno = '30' then sal*1.2
         else sal*1.18
         end as AfterSAl
from emp;

-- decode
select ename, sal BeforeSal,
       decode(deptno,
              '10',sal*1.1,
              '20',sal*1.15,
              '30',sal*1.2,
              'sal*1.18'
       ) as AfterSAl
from emp;


-- 【综合题】 数据标注
需求: 查询所有雇员，统计有津贴和无津贴的人数
------------
有津贴    4
无津贴  10
------------select nvl2(comm, '有津贴', '无津贴') , count(1)
from emp;
group by nvl2(comm, '有津贴', '无津贴');




多表关联
★ 基础题 (99语法)
-- 列出所有“CLERK”（办事员）的姓名及其部门名称。(92语法, 99语法)
--92语法
select ename, d.dname
from emp e, dept d
where e.deptno = d.deptno and e.job = 'CLERK';
--99语法
select ename, d.dname
from emp e
     join dept d on e.deptno = d.deptno 
where e.job = 'CLERK';


-- 列出从事“SALES”（销售）工作的雇员的姓名(92语法, 99语法)  
--92语法
select ename
from emp e, dept d
where e.deptno = d.deptno and d.dname = 'SALES';
--99语法
select ename
from emp e
     join dept d on e.deptno = d.deptno 
where d.dname = 'SALES';


-- 列出在每个部门工作的雇员的数量以及部门名称
select d.deptno, count(e.empno),d.dname
from dept d
     left outer join emp e on d.deptno = e.deptno
group by d.deptno,d.dname;


-- 列出所有雇员的雇员名称、部门名称和基本薪资
select e.ename, d.dname, e.sal
from emp e
     join dept d on d.deptno = e.deptno;


-- 列出所有部门名称及雇员
select e.ename, d.dname
from emp e
     join dept d on d.deptno = e.deptno;

-- 统计所有部门的雇员人数, 显式效果如下:
-----------------
10 xx    3
20 xx    5
30 SALES 6
40 xx    0
-----------------
select d.deptno, d.dname, count(e.deptno)
from dept d
     left join emp e on e.deptno = d.deptno
group by d.deptno, d.dname
order by d.deptno;

★★ （可讨论）
-- 查询每个员工的姓名,工资,工资级别,部门名称, 按照工资排序(子查询)
select e.ename, e.sal, sg.grade, d.dname
from emp e
     join salgrade sg on sal between sg.losal and sg.hisal
     join dept d      on d.deptno = e.deptno


-- 查询每个部门的部门名称，部门编号，部门人数
select d.dname, d.deptno, count(e.deptno)
from dept d
     left join emp e on e.deptno = d.deptno
group by d.dname, d.deptno

★★★ （可讨论）
-- 求出部门编号为20的雇员名、部门名、薪水等级
select e.ename, d.dname,sg.grade 
from emp e
     join dept d on d.deptno = e.deptno
     join salgrade sg on sal between sg.losal and sg.hisal
where d.deptno = 20;


-- 列出所有雇员的姓名及其上级的姓名	
select e.ename, m.ename
from emp e
     join emp m on m.empno = e.mgr;

-- 列出入职日期早于其直接上级的所有雇员
select e.ename
from emp e
      join emp m on m.empno = e.mgr
where trunc(e.hiredate, 'DAY') < trunc(m.hiredate, 'DAY');

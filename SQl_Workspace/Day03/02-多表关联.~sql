--笛卡尔积
关联两张表 在过滤中添加关联条件使两张表
--演示 
select *
from emp, dept   --92语法
where emp.deptno= dept.deptno; 

--查询雇员a所在部门的名称
select e.ename, d.dname
from emp e, dept d
where e.deptno= d.deptno and e.ename = 'SCOTT';

----join连接
select *
from emp e
     join dept d on e.deptno = d.deptno
where e.ename = 'SCOTT';



--查询雇员a的薪资等级 
select e.ename,e.sal,sg.grade
from emp e,salgrade sg
where sal between losal and hisal and e.ename = 'SCOTT';

----join连接------
select ename, sal,sg.grade
from emp e
     join salgrade sg on sal between losal and hisal
where e.ename = 'SCOTT';


↑
----JOIN连接--------------
重点就是分开关联条件和业务条件分开 在多张表关联当中用92繁琐


---练习 查询雇员scott的管理者的名称
分析 雇员的管理者也在雇员表里 需要使用join连接
     需要获取表里面的mag信息 再比较id

select e.ename, m.ename
from emp e
     join emp m on e.mgr = m.empno
where e.ename = 'SCOTT';

------- 需求: 查询SCOTT的部门名称, 薪资等级,管理者名字
select e.ename, d.dname, sg.grade, m.ename
from emp e
     join dept d on e.deptno = d.deptno
     join salgrade sg on e.sal between sg.losal and sg.hisal
     join emp m on e.mgr = m.empno
where e.ename = 'SCOTT';


--综合练习 查询雇员所在部门名称 薪资等级 管理者名称 管理者所在的城市
select *--e.ename, d.dname, sg.grade, m.ename
from emp e
     join dept d on e.deptno = d.deptno
     join salgrade sg on e.sal between sg.losal and sg.hisal
     join emp m on e.mgr = m.empno
     join dept dd on m.deptno = dd.deptno
where e.ename = 'SCOTT';


--左外连接 查询所有部门的所有雇员信息
select *
from dept d
     left outer join emp e on d.deptno = e.deptno;

-- 案例：查询所有部门的所有雇员信息，使用右外连接
select *
from emp e
     right outer join dept d on d.deptno = e.deptno;























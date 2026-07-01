--字符串转成数值
select '3.14', to_number('3.14','9.99') from dual;

select to_number('3.00') from dual;  --如何原封不动？

---条件函数
select ename, sal, comm, nvl(comm, 0) as comm2
from emp
where deptno = 30;

--收入统计
select ename, sal, comm, sal+nvl(comm,0)as 收入
from emp
where deptno = 30;

select ename, sal, comm, nvl2(comm, '有', '无') as comm2
from emp
where deptno=30;

--查询所有emp 有无奖金统计人数
select nvl2(comm, '1', '0') as comm2, count(1) --在这里为统计列相同的计数+1
from emp                                       --count（列）
group by nvl2(comm, '1', '0');  --对comm2进行分组

--nvl/nvl2只针对空值判断

--case when 是个结构 当做函数使用

--需求 查询30部门的雇员名字和职位 并且职位显示用中文
select ename,job,
       case job
            when 'SALESMAN' then 'xiaoshou'
            when 'MANAGER' then 'guanli'
            when 'CLERK' then 'wenyuan'
end as job2
from emp
where deptno = 30;

g
-----decode函数-----------
select ename,  
       decode(deptno,
       10, '1',
       20, '2',
       30, '3',
       'other'
       ) as 测试
from emp;



-----Trunc取整
select trunc(2.3) from dual;
可以在






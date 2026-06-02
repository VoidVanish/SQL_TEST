开始时间：
结束时间：

-- 1、查询姓“何”的学生名单
select *
from student
where substr(sname, 1, 1) = '何'

-- 1.1查询姓名中最后一个字是肯的学生名单
select *
from student
where substr(sname, -1, 1) = '肯';

-- 1.2查询姓名中带金的学生名单

select *
from student
where instr(sname, '金',1) != 0;


-- 1.3、查询姓“孟”老师的个数
select tname, count(*)
from teacher
where substr(tname, 1, 1) = '孟'
group by tname

--2、查询课程编号为“0002”的总成绩
select sum(sscore) as 总成绩
from score
where scoure = 0002

-- 2.1、查询选了课程的学生人数
1 查询学生的sid
select sid
from student;
2 在表score里拿sid对比
select t.sid
from (select sid
     from student) t left join score s on t.sid = s.sid
where scoure is not null  --没有选课的同学不会在这里
group by(t.sid)

3 统计选了课的人数
select count(p.sid)
from (select t.sid
     from (select sid
          from student) t left join score s on t.sid = s.sid
          where scoure is not null  --没有选课的同学不会在这里
          group by(t.sid)) p

-- 3、查询各科创建最高和最低分数
select scoure, max(sscore) 最高分, min(sscore) 最低分
from score
group by scoure;

-- 3.1、查询每门课程被选修学生数
select scoure, count(scoure) 选修人数
from SCORE
group by scoure;

-- 3.2、查询男生，女生人数
select sgender, count(sgender) 人数
from student
group by sgender

-- 4、查询平均成绩大于70分学生的学号和平均成绩
1 查出每个学生的平均成绩
select sid, avg(sscore) avgsscore
from score
group by sid
2 在临1表找出平均分大于70的学生的学号和平均成绩
select *
from (select sid, avg(sscore) avgsscore
     from score
     group by sid) t
where t.avgsscore > 70;

-- 4.1、查询至少选修两门课程的学生学好
1 通过sid统计选修两门的学生
select sid, count(sid) couresum
from score
group by sid;
2 判断
select t.sid
from (select sid, count(sid) couresum
     from score
     group by sid) t
where t.couresum >= 2;


-- 4.2、查询同名同姓学生名单并统计同名人数
1 查询人名
select sname, count(*) 同名人数
from student
group by sname
having count(*) > 1 ----统计好后有同名的就显示
2 与学生表进行关联 --用t表的同名关联s表的人名
SELECT s.sid, s.sname, s.sgender,t.同名人数
FROM student s
JOIN (
    SELECT sname, COUNT(*) AS 同名人数
    FROM student
    GROUP BY sname
    HAVING COUNT(*) > 1
) t ON s.sname = t.sname
ORDER BY s.sname, s.sid;

-- 4.3、查询不及格的课程并按课程号从大到小排列
select *
from score
where sscore > 60
order by scoure desc;

-- 4.4、查询每门课程的平均成绩，结果按平均成绩升序排序，平均成绩相同时，按课程号降序排列
1 统计课程和平均成绩
select scoure, avg(sscore) avgscore
from score
group by scoure;
2 对临表1进行排序
select t.avgscore,t.scoure
from (select scoure, avg(sscore) avgscore
     from score
     group by scoure) t
order by t.avgscore, scoure desc  --当在排平均分的时候，如果平均成绩相同时，
                                  --会自动按课程号降序排列 --scoure desc


-- 4.5、检索课程编号为“0004”且分数小于60的学生学号，结果按按分数降序排列
select sid, sscore
from SCORE 
where scoure = '004' and sscore < 60
order by sscore desc;

--4.6、统计每门课程的学生选修人数(超过2人的课程才统计)
--要求输出课程号和选修人数，查询结果按人数降序排序，若人数相同，按课程号升序排序
1
select scoure, count(*) countscr
from score
group by scoure
2
select *
from (select scoure, count(*) countscr
     from score
     group by scoure) t
order by t.countscr desc,t.scoure


-- 4.7、查询两门以上不及格课程的同学的学号及其平均成绩


-- 5、查询学生的总成绩并进行排序
select sid, sum(sscore) sumscore
from score
group by sid;

select * from (select sid, sum(sscore) sumscore
       from score
group by sid) t order by t.sumscore

-- 5.1、查询平均成绩大于70分的学生学号和平均成绩        19
select sid, avg(sscore) avgscore
from score
group by sid
having avgscore>70

select * from (select sid, avg(sscore) avgscore
       from score
group by sid) t where t.avgscore > 70 




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
1 查询同学 过滤出是不及格到90分的课程
select sid, sscore
from score
where sscore < 90
2 统计两门以上不及格的同学 
select tt.sid, avg(tt.sscore) 平均成绩
from (
     select sid, sscore
     from score
     where sscore < 90
) tt
group by tt.sid
having count(*) > 1


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

select * from (select sid, avg(sscore) avgscore
       from score
group by sid) t where t.avgscore > 70 


--------------------------------
-- 6、查询所有课程成绩小于80分学生的学号、姓名
select *
from score
where sscore <= 80
group by sid

select t.sid, s.sname
from student s join (select sid
     from score
where sscore <= 80 group by sid) t on s.sid = t.sid 

-- 6.1、查询没有学全所有课的学生的学号、姓名
SELECT SID ,COUNT(1) 
FROM SCORE
GROUP BY SID
HAVING COUNT(1) != (select count(scoure) from course)
优化后↓
SELECT T.SID, S.SNAME FROM STUDENT S JOIN (SELECT SID ,COUNT(1) 
       FROM SCORE
       GROUP BY SID
       HAVING COUNT(1) != (select count(scoure) from course)) T ON S.SID = T.SID;

优化前↓
1 统计一共有多少科
select count(scoure) from course;
2 统计学生学习的科目
select st.sid, st.sname
from student st left join score s on st.sid = s.sid
group by st.sid, st.sname
having count(S.SCOURE) < (select count(scoure) from course);


--6.2、查询出只选修了两门课程的全部学生的学号和姓名

select st.sid, st.sname
from student st left join score s on st.sid = s.sid
group by st.sid, st.sname
having count(*) = 2;


-- 7.查询所有学生的学号、姓名、选课数、总成绩
select sid, count(sid) 选课数, sum(sscore) 总成绩
from score
group by sid

select t.sid, s.sname, t.选课数, t.总成绩
from student s join (select sid, count(sid) 选课数, sum(sscore) 总成绩
     from score
     group by sid) t on s.sid = t.sid

-- 7.2、查询学生的选课情况：学号，姓名，课程号，课程名称
1 查询学生的选课情况：学号，课程号，课程名称
select sid, sname from student;

2
select t1.sid, t2.sname, t1.scoure, t1.cname
from (
     select sc.sid, sc.scoure, co.cname
       from score sc join COURSE co on sc.scoure = co.scoure) t1 left join 
       (select sid, sname from student) t2 on t1.sid = t2.sid;


-- 7.3、查询出每门课程的及格人数和不及格人数（***） 
SELECT SCOURE,
COUNT(CASE WHEN SSCORE > 80 THEN 1 END) 及格人数,
COUNT(CASE WHEN SSCORE <= 80 THEN 1 END) 不及格人数
FROM SCORE
GROUP BY SCOURE
--结论：casewhen把它当做一个列函数 它用来统计并返回值 非常好用！

/*
1 查询及格与否
select scoure, count(scoure) --不及格人数
from score
where sscore < 80
group by scoure

select scoure, count(scoure) 及格人数
from score
where sscore >= 80
group by scoure

3 拼接表
--左连接
select t1.scoure, t1.及格人数, t2.不及格人数
from (select scoure, count(scoure) 及格人数
     from score
     where sscore >= 80
     group by scoure) t1 left join (select scoure, count(scoure) 不及格人数
     from score
     where sscore < 80
     group by scoure) t2 on t1.scoure = t2.scoure;

--全连接 
select t2.scoure, t2.及格人数, t1.不及格人数 --显示数据的方式多种，但是要保证每个数据都显示 比如这里的课程 需要以有全的那个为主
from (select scoure, count(scoure) 不及格人数
     from score
     where sscore < 80
     group by scoure
     ) t1 full join (select scoure, count(scoure) 及格人数
     from score
     where sscore >= 80
     group by scoure) t2 on t1.scoure = t2.scoure;
*/

-- 7.4、使用分段[100-85],[85-70],[70-60],[<60]来统计各科成绩，分别统计：各分数段人数，课程号和课程名称
select scoure, sscore
from score
where sscore between 86 and 100  --[100-85]de值 统计的是范围人数

select  scoure, sscore
from score
where sscore between 71 and 85 

select  scoure, sscore
from score
where sscore between 60 and 70 

select  scoure, sscore
from score
where sscore < 60

每个分段的人数
select count(t2.sscore) 六十到七十, count(t1.sscore) 低于六十,  count(t3.sscore) 七十到八十五,  count(t4.sscore) 八十五到一百分
from (select  scoure, sscore
from score
where sscore < 60
) t1 full join (select  scoure, sscore
from score
where sscore between 60 and 70 
) t2 on t1.scoure = t2.scoure
full join (select  scoure, sscore
from score
where sscore between 71 and 85 
) t3 on t1.scoure = t3.scoure

full join (select scoure, sscore
from score
where sscore between 86 and 100 ) t4 on t1.scoure = t4.scoure


--9.1、检索0001课程分数小于90，按照分数降序排列的学生信息
select *
from score
where scoure = 1 and sscore < 90

select s.sid, s.sname, s.sbirth, s.sgender, t.scoure, t.sscore
from (select *
     from score
     where scoure = 1 and sscore < 90) t join student s on t.sid = s.sid;

-- 9.2、查询不同老师所教授不同课程平均分从高到低显示
--统计各科的平均分
SELECT SCOURE,AVG(SSCORE) PINGJUNFEN
FROM SCORE
GROUP BY SCOURE
ORDER BY PINGJUNFEN DESC

SELECT T.TNAME, C.SCOURE, C.CNAME
FROM TEACHER T JOIN COURSE C ON T.CTEACHER = C.CTEACHER;

总↓
SELECT T2.TNAME,T2.CNAME,T1.PINGJUNFEN
FROM (SELECT SCOURE,AVG(SSCORE) PINGJUNFEN
     FROM SCORE
     GROUP BY SCOURE
     ORDER BY PINGJUNFEN DESC
) T1 JOIN (SELECT T.TNAME, C.SCOURE, C.CNAME
          FROM TEACHER T JOIN COURSE C ON T.CTEACHER = C.CTEACHER) T2
     ON T1.SCOURE = T2.SCOURE;
     

-- 9.4、查询任何一门课程成绩在70分以上的姓名、课程名称和分数（与上题类似）
SELECT SID, SCOURE, SSCORE,ROW_NUMBER()OVER(PARTITION BY SID ORDER BY SSCORE DESC) RN
FROM SCORE
WHERE SSCORE >70

SELECT S.SNAME, C.CNAME, T1.SSCORE
FROM (SELECT SID, SCOURE, SSCORE,
     ROW_NUMBER()OVER(PARTITION BY SID ORDER BY SSCORE DESC) RN  ---开窗函数
     FROM SCORE
     WHERE SSCORE >70
      ) T1 JOIN STUDENT S ON T1.SID = S.SID
           JOIN COURSE C ON T1.SCOURE = C.SCOURE
WHERE T1.RN = 1

-- 9.5、查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩 八十分合格
SELECT SID, AVG(SSCORE)
FROM SCORE
GROUP BY SID
HAVING COUNT(CASE WHEN SSCORE <= 80 THEN 1 END) > 1

/*12.6、查询课程编号为“0001”的课程比“0002”的课程成绩等于或者低的所有学生的学号,
                  成绩，和课程号*/
逻辑：查询每个学生1和2的课程成绩 把1课程的成绩与2课程的成绩对比 最后输出所有学生的学号，成绩，课程号
      要查询1 2的课程成绩用SCORE表 如何比较成绩呢？列进行比较

SELECT a.SID, a.SSCORE AS 成绩, a.SCOURE AS 课程号
FROM SCORE a
INNER JOIN SCORE b ON a.SID = b.SID
WHERE a.SCOURE = '0001'
  AND b.SCOURE = '0002'
  AND a.SSCORE <= b.SSCORE;  

SELECT a.SID, a.SSCORE AS 成绩, a.SCOURE AS 课程号
FROM SCORE A JOIN SCORE B ON A.SID = B.SID
WHERE A.SCOURE = '0001' AND B.SCOURE = '0002' AND A.SSCORE <= B.SSCORE

-- 12.7、查询学过“孟扎扎”老师所教的所有课的同学的学号、姓名
逻辑：先找出所有学过孟的课程的学生 再把学过的排出在外
SELECT SC.SID FROM SCORE SC 
JOIN COURSE CO ON SC.SCOURE = CO.SCOURE
JOIN TEACHER TE ON CO.CTEACHER = TE.CTEACHER
WHERE TE.TNAME = '孟扎扎'


SELECT SID,SNAME
FROM STUDENT 
WHERE SID IN(
      SELECT SC.SID FROM SCORE SC 
      JOIN COURSE CO ON SC.SCOURE = CO.SCOURE
      JOIN TEACHER TE ON CO.CTEACHER = TE.CTEACHER
      WHERE TE.TNAME = '孟扎扎'
      )


-- 12.8、查询没学过"孟扎扎"老师讲授的任一门课程的学生姓名  
SELECT SNAME
FROM STUDENT
WHERE SID NOT IN (
    SELECT DISTINCT SC.SID
    FROM SCORE SC
    JOIN COURSE C ON SC.SCOURE = C.SCOURE
    JOIN TEACHER T ON C.CTEACHER = T.CTEACHER
    WHERE T.TNAME = '孟扎扎'
);


SELECT * FROM STUDENT
WHERE SID NOT IN (
SELECT SC.SID FROM SCORE SC
       LEFT JOIN COURSE CO ON SC.SCOURE=CO.SCOURE
       LEFT JOIN TEACHER TE ON TE.CTEACHER=CO.CTEACHER
       WHERE TE.TNAME='孟扎扎')

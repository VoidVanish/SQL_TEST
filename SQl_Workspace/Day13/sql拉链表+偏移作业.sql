DROP TABLE acct1;
CREATE TABLE acct1(           
  dt            date          ,          
  rate          number(10,1)
);

INSERT INTO acct1 VALUES (to_date('2010-01-01','yyyy-mm-dd'),5.1);
INSERT INTO acct1 VALUES (to_date('2010-10-01','yyyy-mm-dd'),5.1);
INSERT INTO acct1 VALUES (to_date('2011-01-01','yyyy-mm-dd'),6.0);
INSERT INTO acct1 VALUES (to_date('2012-10-31','yyyy-mm-dd'),6.0);
INSERT INTO acct1 VALUES (to_date('2012-11-10','yyyy-mm-dd'),6.0);
INSERT INTO acct1 VALUES (to_date('2012-12-31','yyyy-mm-dd'),6.0);
INSERT INTO acct1 VALUES (to_date('2013-03-31','yyyy-mm-dd'),5.9);
INSERT INTO acct1 VALUES (to_date('2013-09-01','yyyy-mm-dd'),5.5);
INSERT INTO acct1 VALUES (to_date('2014-05-01','yyyy-mm-dd'),5.5);
INSERT INTO acct1 VALUES (to_date('2015-01-01','yyyy-mm-dd'),5.1);
INSERT INTO acct1 VALUES (to_date('2016-06-01','yyyy-mm-dd'),5.1);
INSERT INTO acct1 VALUES (to_date('2017-09-01','yyyy-mm-dd'),5.1);
COMMIT;
 
SELECT * FROM acct1;
-- 将上面的数据，显示成如下的结果：
起始日期    截止日期    贷款利率
2010/1/1    2010/12/31   5.1%
2011/1/1    2013/3/30    6%
2013/3/31   2013/8/31    5.9%
2013/9/1    2014/12/31   5.5%
2015/1/1    9999/12/31   5.1%

SELECT B.DT 起始时间, LEAD(B.DT,1,DATE'9999-12-31')OVER(ORDER BY B.DT)-1 截止日期 ,B.RATE 贷款利率 FROM (
SELECT A.*,A.RATE-LAG(A.RATE,1,0)OVER(ORDER BY A.DT) JG
FROM ACCT1 A) B WHERE B.JG<>0;






-- 实验数据：
    DROP TABLE acct;
    CREATE TABLE acct(
      acctid        CHAR(3)     ,            
      bal           number      ,             
      rate          number(10,3),             
      st            date      ,          
      et            date
    );

    INSERT INTO acct VALUES ('001',500,0.012,to_date('20190101','yyyymmdd'),to_date('20191215','yyyymmdd'));
    INSERT INTO acct VALUES ('001',1000,0.015,to_date('20191215','yyyymmdd'),to_date('20200116','yyyymmdd'));
    INSERT INTO acct VALUES ('001',2000,0.015,to_date('20200116','yyyymmdd'),to_date('30001231','yyyymmdd'));
    INSERT INTO acct VALUES ('002',1500,0.015,to_date('20191231','yyyymmdd'),to_date('20200126','yyyymmdd'));
    INSERT INTO acct VALUES ('002',10000,0.015,to_date('20200126','yyyymmdd'),to_date('20200306','yyyymmdd'));
    INSERT INTO acct VALUES ('002',900,0.015,to_date('20200306','yyyymmdd'),to_date('30001231','yyyymmdd'));
    COMMIT;

    SELECT * FROM acct; 

/**
-- 根据余额拉链历史表acct，用一个SQL计算每个帐户（2020/1/1,2020/3/31）期间的利息？
-- 公式：sum(bal*rate*days/360)
-- 期望查询结果：
   ----------------------------------
  |  帐号 acctid     |   利息 lnt    |
   ----------------------------------
  |      001         |     6.96      |
  |      002         |     19.20     |
   ----------------------------------
    
**/

SELECT T.ACCTID,
ROUND(SUM(T.BAL*T.RATE*(LEAST(ET,DATE'2020-03-31'+1)-
GREATEST(ST,DATE'2020-01-01'))/360),2)
FROM(
SELECT A.ACCTID,
       A.BAL,
       A.RATE,
       A.ST,
       A.ET
FROM ACCT A WHERE A.ET>=DATE'2019-12-31' AND A.ST<=DATE'2020-03-31') T GROUP BY T.ACCTID


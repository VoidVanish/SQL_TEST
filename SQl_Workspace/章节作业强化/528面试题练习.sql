统计结果 客户id 客户姓名  累计消费笔数 累计消费金额

消费表
SELECT cust_id,SUM(amount) 累计消费金额,COUNT(trans_id) 累计消费笔数 FROM transaction
WHERE trans_date<=DATE'2024-01-01' AND trans_type = 0 --消费类
GROUP BY cust_id
HAVING SUM(amount)>=5000

客户表
SELECT cust_id, cust_name FROM customer
WHERE gender=1 AND is_valid=1

关联表
SELECT *
FROM (
SELECT cust_id, cust_name FROM customer
WHERE gender=1 AND is_valid=1 ) A LEFT JOIN (SELECT cust_id,SUM(amount) 累计消费金额,COUNT(trans_id) 累计消费笔数 FROM transaction
WHERE trans_date<=DATE'2024-01-01' AND trans_type = 0 --消费类
GROUP BY cust_id
HAVING SUM(amount)>=5000) B ON A.cust_id=B.cust_id
ORDER BY B.累计消费金额 DESC


------------------------
SELECT cust_id,
CASE WHEN EXISTS (SELECT 1 FROM transaction T WHERE T1.CUST_ID=T.CUST_ID 
  GROUP BY TO_CHAR(trans_date,'MM') HAVING COUNT(TO_CHAR(trans_date,'MM')) >=2) --对交易时间
  THEN '高活跃' END AS 活跃度,
    COUNT(cust_id) 交易总,
    ROUND(COUNT(cust_id)/12,2) 月均交易
FROM transaction T1
GROUP BY cust_id


SELECT cust_id,TO_CHAR(trans_date,'MM') 月份,COUNT(TO_CHAR(trans_date,'MM')) 月交易 FROM transaction
  GROUP BY cust_id,TO_CHAR(trans_date,'MM') HAVING COUNT(TO_CHAR(trans_date,'MM'))>=1



月交易笔数 trans_date
SELECT cust_id,trans_date  --统计人数和交易时间
FROM transaction 
WHERE TO_CHAR(trans_date,'YYYY') = '2025'



SELECT TO_CHAR(SYSDATE,'MM') FROM DUAL

SELECT * FROM transaction FOR UPDATE









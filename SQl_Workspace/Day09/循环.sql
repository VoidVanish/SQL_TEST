
--传入任意两个数字,求出两数字之间的偶数和
10-234  345-89
DECLARE 
V_A NUMBER:=&A;
V_B NUMBER:=&B;
V_SUM NUMBER:=0;

BEGIN
  FOR I IN LEAST(V_A,V_B) .. GREATEST(V_A,V_B) LOOP
    IF MOD(I,2) = 0 
      THEN V_SUM := V_SUM+I;   
      END IF;
  END LOOP;
  DBMS_OUTPUT.put_line(V_SUM);
END;




1.使用一个for循环，打印出下面的图案
*
**
***
****
*****
DECLARE 
V_CHAR VARCHAR2(100);

BEGIN
  FOR I IN 1 .. 5 LOOP
        V_CHAR:=V_CHAR||'* ';
        DBMS_OUTPUT.put_line(V_CHAR);
  END LOOP;
END;

2.假设现在有鸡和兔子，一共有35只，它们的脚一共有94个，
使用一个for循环计算出鸡和兔子分别有多少只。
DECLARE 
V_ASUM NUMBER:=35;  ---共只数
V_FSUM NUMBER:=94;
V_CHINKE NUMBER;
V_RABBIT NUMBER;
BEGIN
  FOR I IN 1 .. 35 LOOP
    V_CHINKE:=I;
    V_RABBIT:=35-I;
    IF V_CHINKE*2+V_RABBIT*4=94 AND V_CHINKE+V_RABBIT=35
      THEN 
          DBMS_OUTPUT.put_line('鸡的数量 = '||V_CHINKE||'   兔的数量 = '||V_RABBIT);
    END IF;
    END LOOP;
END;


3.纸厚度1mm，珠穆朗玛峰高度8848m，问纸要对折多少次，
高度才会超过山
DECLARE 
V_ZHUMU NUMBER:= 8848000;
V_DUIZHECOUNT NUMBER:=0;
V_ZHIHOU NUMBER:=1;
BEGIN 
  --对折一次厚度翻倍
  WHILE V_ZHIHOU<V_ZHUMU LOOP
    V_ZHIHOU :=V_ZHIHOU*2;
    V_DUIZHECOUNT:=V_DUIZHECOUNT+1;
    DBMS_OUTPUT.put_line('厚度 =  '||V_ZHIHOU);
  END LOOP;
  DBMS_OUTPUT.put_line('对折了 =  '||V_DUIZHECOUNT);
END;


4.从今天开始存钱，今天存1分，明天2分，后天4分，每天翻倍，
问要几天才能存够100W元。
日存款  总存款  天

DECLARE
V_QIAN NUMBER:=0;  --       初始一分钱
V_GRATES NUMBER:= 100000000; --一亿分
V_DAYCOUNT NUMBER:=0;  --天数
V_CUNQIAN NUMBER:=1;
BEGIN
  WHILE V_QIAN <= V_GRATES LOOP
  V_DAYCOUNT:=V_DAYCOUNT+1; --天数
  V_QIAN:=V_QIAN+V_CUNQIAN; --总额
  V_CUNQIAN:=V_CUNQIAN*2; ----每天存的钱
  END LOOP;
  DBMS_OUTPUT.put_line('天数 =  '||V_DAYCOUNT);
END;

5.使用一个while循环，打印出下面的图案 
 
*********
 *******
  *****
   ***
    *
    
DECLARE
  V_CHAR1 VARCHAR2(1024) := '*********';
  V_I     NUMBER := 0;
BEGIN 
  WHILE V_I < 5 LOOP
    V_CHAR1 := REPLACE('SUBSTR(V_CHAR1,)','*',' ')
    V_CHAR1 := 
    DBMS_OUTPUT.put_line(V_CHAR1);
    V_I := V_I + 1;
  END LOOP;
  --DBMS_OUTPUT.put_line(V_CHAR1);
END;








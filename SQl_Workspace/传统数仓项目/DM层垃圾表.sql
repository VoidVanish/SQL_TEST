M_RISK_BADLOAN_INFO  不良贷款，

F_LN_LOAN_INFO    贷款宽表
M_RISK_CUST_INFO  风险客户
（ --判断客户是风险客户
    EXISTS (SELECT 1 FROM M_RISK_CUST_INFO C WHERE C.ECIF_CUST_NO =LN.ECIF_CUST_NO)
   --放款总金额>授信总额度
   OR LN.SUM_TRAN_AMT>LN.CREDTOTALAMT;）




create table M_RISK_BADLOAN_INFO 
(
   LOANACNO             CHAR(30),
   ECIF_CUST_NO         CHAR(21),
   CUSTNAME             CHAR(40),
   CURRSIGN             CHAR(30),
   LOANKIND             CHAR(30),
   FUNDSOUR             CHAR(20),
   LOANUSE              CHAR(20),
   ASSUKIND             CHAR(20),
   CONTDATE             DATE,
   CREDCAPI             NUMBER(20,2),
   SUM_TRAN_AMT         NUMBER(20,2),
   SUM_PAY_AMT          NUMBER(20,2),
   LN_BALANCE           NUMBER(20,2),
   TCAPI                NUMBER(20,2),
   THISTCAPI            NUMBER(20,2),
   CREDAMT              NUMBER(20,2),
   ASSUAMT              NUMBER(20,2),
   IMPAAMT              NUMBER(20,2),
   MORTAMT              NUMBER(20,2),
   CREDTOTALAMT         NUMBER(20,2),
   TERMFREQ             CHAR(10),
   TTERM                NUMBER(12,0),
   RETUTYPE             CHAR(30),
   TROTHDUEDAY          CHAR(10),
   FIXRATETERM          NUMBER(12,0),
   FIRSTDUEDATE         DATE,
   SUBSFLAG             CHAR(10),
   RELEWAY              CHAR(20),
   LOANSTATE            CHAR(10)
);

comment on table M_RISK_BADLOAN_INFO is
'不良贷款'; 


select * from M_RISK_BADLOAN_INFO;












M_RISK_CUST_INFO  风险客户

F_ECIF_CUST_INFO  客户宽表
(WHERE ECI.IS_BLACK_LIST = '是'    --判断是否在黑名单
  OR  NVL(INSTR(ECI.INDV_LEV_COD,'A'),0) = 0;  --判断征信等级） 
  
  
create table M_RISK_CUST_INFO  
(
   ECIF_CUST_NO         CHAR(32),
   CUST_NAME            CHAR(32),
   MRG_STS              CHAR(200),
   COU_CERT_NO          CHAR(190),
   COU_NAME             CHAR(120),
   INDV_TAX_NO          CHAR(250),
   INDV_INSURS_NO       CHAR(250),
   MN_INCO              CHAR(300),
   ECON_RESUR           CHAR(200),
   OTH_ECON_RESUR       CHAR(460),
   DEPEND_CNT           CHAR(460),
   AFF_INSTN_NO         CHAR(90),
   EMP_FLG              CHAR(100),
   POT_VIP_FLG          CHAR(100),
   SPEC_VIP_FLG         CHAR(100),
   INDV_CUST_ACCUM_TRN_LMT CHAR(460),
   CRED_CRD_GUAR_CNT    CHAR(460),
   FAMI_AVG_MN_INCO     CHAR(460),
   FAMI_CAPI            CHAR(460),
   FAMI_DEBT            CHAR(460),
   FAMI_MN_INCO         CHAR(460),
   GRAD_DT              CHAR(60),
   CHILD_FLG            CHAR(100),
   INDUSTRY_TYP         CHAR(100),
   FAMI_GUAR_TOTL       CHAR(460),
   PLAN_CPTL_CERT_NO    CHAR(302),
   CERT_TYP             CHAR(300),
   CERT_NO              CHAR(200),
   PRIM_NAT             CHAR(300),
   RSDNT_NAT            CHAR(300),
   CONC_CUST_FLG        CHAR(100),
   IS_BLACK_LIST        CHAR(100),
   INDV_LEV_COD         CHAR(100),
   CRLMT                CHAR(460),
   CRED_LOTP            CHAR(460)
);

comment on table M_RISK_CUST_INFO is
'风险客户'; 


select * from M_RISK_CUST_INFO;





�־����� : ����� ����ִ� ���ڿ�  '201912' ==> 31

���ڿ�         ==>               ��¥    ==>    ������ ��¥�� ����       ==>        ����
     TO_DATE('201912', 'YYYYMM')                                          TO_CHAR

SELECT TO_DATE(:yyyymm, 'YYYYMM'),
       LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),
       TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')
FROM dual;


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';
     (empno = 7369 )


SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


Plan hash value: 3956160932
 
�����ȹ�� ���� ����(id)
* �鿩���� �Ǿ������� �ڽ� ���۷��̼�
1. ������ �Ʒ���
   *�� �ڽ� ���۷��̼��� ������ �ڽ� ���� �д´�
   
   1 ==> 0
  --------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
    1 - filter("EMPNO"=7369)



EXPLAIN PLAN FOR 
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
   1 - filter(TO_CHAR("EMPNO")='7369')

EXPLAIN PLAN FOR 
SELECT *
FROM emp
WHERE empno = 7300 + '69';

SELECT *
FROM dept;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

0009000
0010000

SELECT ename, sal, TO_CHAR(sal, 'L009,999.00')
FROM emp;



NULL�� ���õ� �Լ�
NVL
NVL2
NULLIF
COALESCE;

�� null ó���� �ؾ��ұ�?
NULL�� ���� �������� NULL�̴�

������ emp ���̺� �����ϴ� sal, comm �ΰ��� �÷� ���� ���� ���� �˰� �; 
������ ���� SQL�� �ۼ�.

SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
FROM emp;

NLV(expr1, expr2)
expr1�� null�̸� expr2���� �����ϰ�
expr1�� null�� �ƴϸ� expr1�� ����

SELECT empno, ename, sal, comm, sal + NVL(comm, 0) sal_plus_comm
FROM emp;

REG_DT �÷��� NULL�� ��� ���� ��¥�� ���� ���� ������ ���ڷ� ǥ��
SELECT userid, usernm, reg_dt
FROM users;
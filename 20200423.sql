NVL(expr1, expr2)
if expr1 == null
    return expr2
else
    return expr1
    
NVL2(expr1, expr2, expr3)
if expr1 != null
    return expr2
else 
    return expr3
    
SELECT empno, ename, sal, comm, NVL2(comm, 100, 200)
FROM emp;


NULLIF(expr1, expr2)
if expr1 == expr2
    return null
else
    return expr1
    
sal�÷��� ���� 3000�̸� null�� ����    
SELECT empno, ename, sal, NULLIF(sal, 3000)
FROM emp;


�������� : �Լ��� ������ ������ ������ ���� ����
          �������ڵ��� Ÿ���� ���� �ؾ���
          display("test"), display("test", "test2", "test3")

���ڵ��߿� ���� ���������� null�� �ƴ� ���� ���� ����
coalesce(expr1, expr2, expr3....)
if expr1 != null
    return expr1
else
    coalesce(expr2, expr3.....)

mgr �÷� null
comm �÷� null

SELECT empno, ename, comm, sal, coalesce(comm, sal)
FROM emp;

fn4]
SELECT empno, ename, mgr, NVL(mgr, 9999), NVL2(mgr, mgr, 9999), coalesce(mgr, 9999)
FROM emp
WHERE empno=7839;

fn5]
SELECT userid, usernm, reg_dt, NVL(reg_dt, SYSDATE) N_REG_DT
FROM users
WHERE userid != 'brown';
    

condition
���ǿ� ���� �÷� Ȥ�� ǥ������ �ٸ� ������ ��ü
java if, switch ���� ����
1. case ����
2. decode �Լ�

1.CASE
CASE
    WHEN ��/������ �Ǻ��� �� �ִ� �� THEN ������ ��
    [WHEN ��/������ �Ǻ��� �� �ִ� �� THEN ������ ��]
    [ELSE ������ �� (�Ǻ����� ���� WHEN ���� ������� ����)]
END

emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ���� (ex: sal 100-> 105)
�ش� ������ job�� MANAGER�� ��� SAL���� 10% �λ�� �ݾ��� ���ʽ��� ����
�ش� ������ job�� PRESIDENT�� ��� SAL���� 20% �λ�� �ݾ��� ���ʽ��� ����
�׿� �������� sal��ŭ�� ���� 
    
SELECT empno, ename, job, sal, 
       CASE 
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal
       END bonus
FROM emp;

2. DECODE(EXPR1, search1, return1, search2, return2, search3, return3..., [default])
   DECODE(EXPR1,
          search1, return1,
          search2, return2,
          search3, return3,
          search4, return4,
          search5, return5,
          default);
if EXPR1 == search1
    return return1
else if EXPR1 == search2
    return return2
else if EXPR1 == search3
    return return3
.....
else
    return default;
    
    
SELECT empno, ename, job, sal, 
       DECODE(job, 'SALESMAN', sal*1.05,
                   'MANAGER', sal*1.10,
                   'PRESIDENT', sal*1.20,
                   sal) bonus
FROM emp;


cond1]
SELECT empno, ename, deptno,
       DECODE(deptno, 10, 'ACCOUNTING', 
                      20, 'RESEARCH', 
                      30, 'SALES', 
                      40, 'OPERATIONS', 'DDIT') dname,
       CASE
        WHEN deptno = 10 THEN 'ACCOUNTING' 
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
       END bonus2
FROM emp;


cond2] ���س⵵�� ¦��/Ȧ��, ������ ����⵵�� ¦��/Ȧ��
MOD����� ������ ���� �������� Ŭ���� ����
MOD(x, 2) ==> 0, 1

(���� �⵵ ¦/Ȧ��, ������ ����⵵ ¦/Ȧ��)
(1, 1) ==> �����
(1, 0) ==> ������
(0, 1) ==> ������
(0, 0) ==> �����;

SELECT empno, ename, hiredate, 
       MOD(TO_CHAR(SYSDATE, 'YYYY'), 2), MOD(TO_CHAR(hiredate, 'YYYY'), 2),
       CASE
        WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = 1 AND MOD(TO_CHAR(hiredate, 'YYYY'), 2)= 1 THEN '�ǰ����� �����'
        WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = 1 AND MOD(TO_CHAR(hiredate, 'YYYY'), 2)= 0 THEN '�ǰ����� ������'
        WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = 0 AND MOD(TO_CHAR(hiredate, 'YYYY'), 2)= 1 THEN '�ǰ����� ������'
        WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = 0 AND MOD(TO_CHAR(hiredate, 'YYYY'), 2)= 0 THEN '�ǰ����� �����'
       END CONTACT_TO_DOCTOR,
       
       CASE
        WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(hiredate, 'YYYY'), 2) THEN '�ǰ����� �����'
        ELSE '�ǰ����� ������'
       END CONTACT_TO_DOCTOR2
FROM emp;

    
    
    
    
    
    
    
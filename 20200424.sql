cond2]

SELECT empno, ename, hiredate, MOD(TO_CHAR(SYSDATE, 'YYYY'), 2), MOD(TO_CHAR(hiredate, 'YYYY'), 2),
       DECODE(MOD(TO_CHAR(SYSDATE+365, 'YYYY'), 2), MOD(TO_CHAR(hiredate, 'YYYY'), 2) , '�ǰ����� �����', '�ǰ����� ������')
FROM emp;


NULLó�� �ϴ� ��� (4���� �߿� ���� ���Ѱɷ� �ϳ� �̻��� ���)
NVL, NVL2...

condition : CASE, DECODE

�����ȹ : �����ȹ�� ����
          ���� ����;


emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ���� (ex: sal 100-> 105)
�ش� ������ job�� MANAGER�̸鼭 deptno�� 10�̸�  SAL���� 30% �λ�� �ݾ��� ���ʽ��� ����
                            �� ���� �μ��� ���ϴ� ����� 10% �λ�� �ݾ��� ���ʽ��� ����
�ش� ������ job�� PRESIDENT�� ��� SAL���� 20% �λ�� �ݾ��� ���ʽ��� ����
�׿� �������� sal��ŭ�� ���� 

DECODE�� ��� (case �� ��� ����)

SELECT empno, ename, job, sal, 
       DECODE(job, 'SALESMAN', sal*1.05,
                   'MANAGER', DECODE(deptno, 10, sal*1.3, sal*1.1),
                   'PRESIDENT', sal*1.20,
                   sal) bonus
FROM emp;

if ( job == "SALESMAN"){
    return sal*1.05
}
else if ( job == "MANAGER"){
    if( deptno == 10)
        return sal * 1.3;
    else 
        return sal * 1.1;
}
else if ( job == "PRESIDENT"){
    return sal * 1.2;
}
else{
    return sal;
}


if(���ǽ�){
    if(���ǽ�){
    }
}

SELECT *
FROM emp
ORDER BY deptno;


���� A = {10, 15, 18, 23, 24, 25, 29, 30, 35, 37}
�Ҽ�: �ڽŰ� 1�� ����� �ϴ� ��
Prime Number �Ҽ� : {23, 29, 37} : COUNT-3, MAX-37, MIN-23, AVG-29.66, SUM-89
��Ҽ� : {10, 15, 18, 24, 25, 30, 35};

SELECT (23+29+37)
FROM dual;

10 - 3
20 - 5
30 - 6

SELECT *
FROM emp
ORDER BY deptno;


GROUP FUNCTION
�������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
�������� �Է¹޾� �ϳ��� ������ ����� ���δ�
EX : �μ��� �޿� ���
     emp ���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ�(10, 20, 30)�� ���� �ִ�
     �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�


GROUP BY ����� ���� ���� : SELECT ����� �� �ִ� �÷��� ���ѵ�     


SELECT �׷��� ���� �÷�, �׷��Լ�
FROM ���̺�
GROUP BY �׷��� ���� �÷�
[ORDER BY ];


SELECT deptno, 
        MAX(sal), --�μ����� ���� ���� �޿� ��
        MIN(sal), --�μ����� ���� ���� �޿� ��
        ROUND(AVG(sal), 2), --�μ��� �޿� ���
        SUM(sal), --�μ��� �޿� ��
        COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*),    --�μ��� ���� ��
        COUNT(mgr)
FROM emp
GROUP BY deptno;

* �׷� �Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���� ���� ������
  ���� ���� �޿��� �޴� ����� �̸��� �� ���� ����
    ==> ���� WINDOW/�м� FUNCTION�� ���� �ذ� ����


emp ���̺��� �׷� ������ �μ���ȣ�� �ƴ� ��ü �������� ���� �ϴ� ���
SELECT  MAX(sal), --��ü ������ ���� ���� �޿� ��
        MIN(sal), --��ü ������ ���� ���� �޿� ��
        ROUND(AVG(sal), 2), --��ü ������ �޿� ���
        SUM(sal), --��ü ������ �޿� ��
        COUNT(sal), --��ü ������ �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*),    --��ü ���� ��
        COUNT(mgr)   -- mgr �÷��� null�� �ƴ� �Ǽ�
FROM emp;

2020.04.27�� ��ǥ �� ���� Ȯ�� 
GROUP BY ���� ����� �÷���
    SELECT ���� ������ ������ ????

GROUP BY ���� ������� ���� �÷���
    SELECT ���� ������ ????


�׷�ȭ�� ���� ���� ���ڿ�, ��� ���� SELECT ���� ǥ�� �� �� �ִ� (���� �ƴ�);
SELECT deptno, 'TEST', 1,
        MAX(sal), --�μ����� ���� ���� �޿� ��
        MIN(sal), --�μ����� ���� ���� �޿� ��
        ROUND(AVG(sal), 2), --�μ��� �޿� ���
        SUM(sal), --�μ��� �޿� ��
        COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*),    --�μ��� ���� ��
        COUNT(mgr)
FROM emp
GROUP BY deptno;

GROUP �Լ� ����� NULL ���� ���ܰ� �ȴ�
30�� �μ����� NULL���� ���� ���������� SUM(COMM)�� ���� ���������� ���� �� Ȯ�� �� �� �ִ�
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10, 20�� �μ��� SUM(COMM) �÷��� NULL�� �ƴ϶� 0�� �������� NULLó��
* Ư���� ������ �ƴϸ� �׷��Լ� ������� NULL ó���� �ϴ� ���� ���ɻ� ����

NVL(SUM(comm), 0) : COMMĿ���� SUM �׷��Լ��� �����ϰ� ���� ����� NVL�� ����(1ȸ ȣ��)
SUM(NVL(comm, 0)) : ��� COMM�÷��� NVL �Լ��� ������(�ش� �׷��� ROW�� ��ŭ ȣ��) SUM �׷��Լ� ����

SELECT deptno, NVL(SUM(comm), 0), SUM(NVL(comm, 0))
FROM emp
GROUP BY deptno;


signle row �Լ��� where���� ����� �� ������
multi row �Լ�(group �Լ�)�� where���� ����� �� ����
GROUP BY �� ���� HAVING ���� ������ ���

single row �Լ��� WHERE ������ ��� ����
SELECT *
FROM emp
WHERE LOWER(ename) = 'smith';


�μ��� �޿� ���� 5000�� �Ѵ� �μ��� ��ȸ
SELECT deptno, SUM(sal)
FROM emp
WHERE SUM(sal) > 9000
GROUP BY deptno;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;


grp3] * ����
SELECT  DECODE(deptno, 10, 'ACCOUNTING', 
                      20, 'RESEARCH', 
                      30, 'SALES', 
                      40, 'OPERATIONS', 'DDIT') dname,                     
        MAX(sal), --�μ����� ���� ���� �޿� ��
        MIN(sal), --�μ����� ���� ���� �޿� ��
        ROUND(AVG(sal), 2), --�μ��� �޿� ���
        SUM(sal), --�μ��� �޿� ��
        COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*),    --�μ��� ���� ��
        COUNT(mgr)
FROM emp
GROUP BY deptno;



grp4]
SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM')
ORDER BY TO_CHAR(hiredate, 'YYYYMM');

grp4]
SELECT TO_CHAR(hiredate, 'YYYY') hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');




grp6]

SELECT COUNT(*) cnt
FROM emp;

SELECT COUNT(*) cnt
FROM dept;

SELECT *
FROM dept;





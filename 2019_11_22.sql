--h_2 �����ý��ۺ� ������ ���� �������� ��ȸ (dept0_02)
SELECT level lv, deptcd, 
       LPAD(' ', 4*(level-1), ' ') || deptnm deptnm, p_deptcd
FROM dept_h a
START WITH deptcd = 'dept0_02'
CONNECT BY p_deptcd = PRIOR deptcd;

--����� �������� 
--Ư�� ���κ��� �ڽ��� �θ��带 Ž��(Ʈ�� ��ü Ž���� �ƴϴ�)
--���������� �������� ���� �μ��� ��ȸ
--�������� dept0_00_0
SELECT *
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

--h_4 : ����� ����
SELECT LPAD(' ', 4*(level-1), ' ') || s_id s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

SELECT *
FROM dept_h;

--h_5
SELECT *
FROM no_emp;

SELECT LPAD('A', 10, '+') || '_TEST'
FROM dual;

--pruning branch (����ġ��)
--������������ [WHERE]���� START WITH, CONNECT BY ���� ���� ����� ���Ŀ�
--����ȴ�

--dept_h���̺��� �ֻ��� ��� ���� ��������� ��ȸ
SELECT deptcd, LPAD(' ', 4*(level-1), ' ') || deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

--���������� �ϼ��� ���� WHERE���� ����ȴ�
SELECT deptcd, LPAD(' ', 4*(level-1), ' ') || deptnm deptnm
FROM dept_h
WHERE deptnm != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;


SELECT deptcd, LPAD(' ', 4*(level-1), ' ') || deptnm deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd 
           AND deptnm != '������ȹ��';

--CONNECT_BY_ROOT(col) : col�� �ֻ��� ��� �÷� ��
--SYS_CONNECT_BY_PATH(col, ������) : col�� �������� ������ �����ڷ� ���� ���
--    . LTRIM�� ���� �ֻ��� ��� ������ �����ڸ� ���� �ִ� ���°� �Ϲ���
--CONNECT_BY_ISLEAF : �ش� row�� leaf node���� �Ǻ�( 1 : O, 0 : X) 
SELECT LPAD(' ', 4*(level-1), ' ') || org_cd org_cd,
       CONNECT_BY_ROOT(org_cd) root_org_cd,
       LTRIM(SYS_CONNECT_BY_PATH(org_cd, '-'), '-') path_org_cd,
       CONNECT_BY_ISLEAF isleaf
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;


--h6
SELECT seq, LPAD(' ', 4*(level-1), ' ') || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR SEQ = parent_seq;

--���� �ֽű��� ���� ������ ����
SELECT *
FROM 
    (SELECT seq, LPAD(' ', 4*(level-1), ' ') || title title,
           CONNECT_BY_ROOT(seq) r_seq
    FROM board_test
    START WITH parent_seq IS NULL
    CONNECT BY PRIOR SEQ = parent_seq)
ORDER BY r_seq DESC, seq;


SELECT seq, LPAD(' ', 4*(level-1), ' ') || title title,
       CASE WHEN parent_seq IS NULL THEN seq ELSE 0 END o1,
       CASE WHEN parent_seq IS NOT NULL THEN seq ELSE 0 END o2
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR SEQ = parent_seq
ORDER SIBLINGS BY CASE WHEN parent_seq IS NULL THEN seq ELSE 0 END DESC,
                  seq ; 
 
SELECT *
FROM board_test;
--�� �׷��ȣ �÷� �߰�
ALTER TABLE board_test ADD (gn NUMBER);

 
SELECT seq, LPAD(' ', 4*(level-1), ' ') || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gn DESC, seq;


SELECT a.ename, a.sal, b.sal l_sal
FROM
    (SELECT ename, sal, ROWNUM rn
     FROM 
        (SELECT ename, sal
         FROM emp
         ORDER BY sal DESC)) a,
    (SELECT ename, sal, ROWNUM rn
     FROM 
        (SELECT ename, sal
         FROM emp
         ORDER BY sal DESC)) b
WHERE a.rn = b.rn(+)-1;







CREATE TABLE DEPT_TEST2 AS
SELECT *
FROM dept ;

idx1]
CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2(deptno);
CREATE INDEX idx_dept_test2_02 ON dept_test2(dname);
CREATE INDEX idx_dept_test2_03 ON dept_test2(deptno, dname);

idx2]
DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_dept_test2_02;
DROP INDEX idx_dept_test2_03;

1]
empno(=)

3]
deptno(=) empno(LIKE :empno || '%')

4]
deptno(=)
empno(=)



�����ȹ

�����ð��� ��� ����
==> ���� ���� ���¸� �̾߱� ��, ������� �̾߱Ⱑ �ƴ�
inner join : ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���� ���
outer join : ���ο� �����ص� �����̵Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���� ���
cross join : ������ ����(īƼ�� ������Ʈ), ���� ������ ������� �ʾƼ�
              ���� ������ ��� ����� ���� ���εǴ� ���
self join : ���� ���̺� ���� ���� �ϴ� ����              


�����ڰ� DBMS�� SQL�� ���� ��û �ϸ� DBMS�� SQL�� �м��ؼ�
��� �� ���̺� ������ ���� ����, 3���� ����� ���� ���(������ ���� ���, ������� �̾߱�)
1. Nested Loop Join
2. Sort Merge Join
3. Hash Join

OLTP (OnLine Transaction Processing) : �ǽð� ó�� 
                                     ==> ������ ����� �ϴ� �ý���(�Ϲ����� �� ����)
                                     
OLAP (OnLine Analysis Processing) : �ϰ�ó�� ==> ��ü ó���ӵ��� �߿��� ���
                                         (���� ���� ���, ���� �ѹ��� ���)



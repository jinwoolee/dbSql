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



실행계획

수업시간에 배운 조인
==> 논리적 조인 형태를 이야기 함, 기술적인 이야기가 아님
inner join : 조인에 성공하는 데이터만 조회하는 조인 기법
outer join : 조인에 실패해도 기준이되는 테이블의 컬럼정보는 조회하는 조인 기법
cross join : 묻지마 조인(카티션 프러덕트), 조인 조건을 기술하지 않아서
              연결 가능한 모든 경우의 수로 조인되는 기법
self join : 같은 테이블 끼리 조인 하는 형태              


개발자가 DBMS에 SQL을 실행 요청 하면 DBMS는 SQL을 분석해서
어떻게 두 테이블 연결할 지를 결정, 3가지 방식의 조인 방식(물리적 조인 방식, 기술적인 이야기)
1. Nested Loop Join
2. Sort Merge Join
3. Hash Join

OLTP (OnLine Transaction Processing) : 실시간 처리 
                                     ==> 응답이 빨라야 하는 시스템(일반적인 웹 서비스)
                                     
OLAP (OnLine Analysis Processing) : 일괄처리 ==> 전체 처리속도가 중요한 경우
                                         (은행 이자 계산, 새벽 한번에 계산)



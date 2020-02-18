SELECT dept_h.*, level, LPAD(' ', (LEVEL-1)*4) || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY p_deptcd = PRIOR deptcd; 

h_2;
SELECT dept_h.*, level, LPAD(' ', (LEVEL-1)*4) || deptnm
FROM dept_h
START WITH deptcd = 'dept0_02   '
CONNECT BY p_deptcd = PRIOR deptcd;


상향식 계층쿼리 (leaf ==> root node(상위 node))
전체 노드를 방문하는게 아니라 자신의 부모노드만 방문 (하향식과 다른점)
시작점 : 디자인팀
연결은 : 상위부서;

SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1) * 4) || deptnm
FROM dept_h
START WITH deptnm = '디자인팀'
CONNECT BY PRIOR p_deptcd = deptcd;


create table h_sum as
select '0' s_id, null ps_id, null value from dual union all
select '01' s_id, '0' ps_id, null value from dual union all
select '012' s_id, '01' ps_id, null value from dual union all
select '0123' s_id, '012' ps_id, 10 value from dual union all
select '0124' s_id, '012' ps_id, 10 value from dual union all
select '015' s_id, '01' ps_id, null value from dual union all
select '0156' s_id, '015' ps_id, 20 value from dual union all

select '017' s_id, '01' ps_id, 50 value from dual union all
select '018' s_id, '01' ps_id, null value from dual union all
select '0189' s_id, '018' ps_id, 10 value from dual union all
select '11' s_id, '0' ps_id, 27 value from dual;

h_4;
SELECT LPAD(' ', (LEVEL-1)*3) || S_ID s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;



create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XX회사', null, 1);
insert into no_emp values('정보시스템부', 'XX회사', 2);
insert into no_emp values('개발1팀', '정보시스템부', 5);
insert into no_emp values('개발2팀', '정보시스템부', 10);
insert into no_emp values('정보기획부', 'XX회사', 3);
insert into no_emp values('기획팀', '정보기획부', 7);
insert into no_emp values('기획파트', '기획팀', 4);
insert into no_emp values('디자인부', 'XX회사', 1);
insert into no_emp values('디자인팀', '디자인부', 7);

commit;

h_5;
SELECT LPAD(' ', (LEVEL-1)*4) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd='XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;


계층형 쿼리의 행 제한 조건 기술 위치에 따른 결과 비교 (pruning branch - 가지치기)
FROM => START WITH, CONNECT BY => WHERE
1. WHERE  : 계층 연결을 하고 나서 행을 제한
2. CONNECT BY : 계층 연결을 하는 과정에서 행을 제한;


WHERE 절 기술전 : 총 9개의 행이 조회되는 것 확인
WHERE 절 (org_cd != '정보기획부') : 정보기획부를 제외한 8개의 행 조회되는 것 확인;

SELECT LPAD(' ', (LEVEL-1)*4) || org_cd org_cd, no_emp
FROM no_emp
WHERE org_cd != '정보기획부'
START WITH org_cd='XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;


CONNECT BY 절에 조건을 기술;

SELECT LPAD(' ', (LEVEL-1)*4) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd='XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd AND org_cd != '정보기획부';



CONNECT_BY_ROOT(컬럼) : 해당 컬럼의 최상위 행의 값을 반환
SYS_CONNECT_BY_PATH(컬럼, 구분자) : 해당 행의 컬럼이 거쳐온 컬럼 값을 추전, 구분자로 이어준다
CONNECT_BY_ISLEAF : 해당 행이 LEAF 노드인지(연결된 자식이 없는지) 값을 리턴  [1:leaf, 0: no leaf];

SELECT LPAD(' ', (LEVEL-1)*4) || org_cd org_cd, no_emp,
       CONNECT_BY_ROOT(org_cd) root,
       LTRIM(SYS_CONNECT_BY_PATH(org_cd, '-'), '-') path,
       CONNECT_BY_ISLEAF leaf
FROM no_emp
START WITH org_cd='XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;




create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, '첫번째 글입니다');
insert into board_test values (2, null, '두번째 글입니다');
insert into board_test values (3, 2, '세번째 글은 두번째 글의 답글입니다');
insert into board_test values (4, null, '네번째 글입니다');
insert into board_test values (5, 4, '다섯번째 글은 네번째 글의 답글입니다');
insert into board_test values (6, 5, '여섯번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (7, 6, '일곱번째 글은 여섯번째 글의 답글입니다');
insert into board_test values (8, 5, '여덜번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (9, 1, '아홉번째 글은 첫번째 글의 답글입니다');
insert into board_test values (10, 4, '열번째 글은 네번째 글의 답글입니다');
insert into board_test values (11, 10, '열한번째 글은 열번째 글의 답글입니다');
commit;


h6;
SELECT *
FROM board_test;


SELECT seq, LPAD(' ', (LEVEL-1)*4) || title title
FROM board_test
START WITH PARENT_SEQ IS NULL
CONNECT BY PRIOR seq = parent_seq;

h7;
SELECT seq, LPAD(' ', (LEVEL-1)*4) || title title
FROM board_test
START WITH PARENT_SEQ IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;


그룹번호를 저장할 컬럼을 추가;
ALTER TABLE board_test ADD (gn NUMBER);

UPDATE board_test SET gn = 4
WHERE seq IN (4, 5, 6, 7, 8, 10, 11);

UPDATE board_test SET gn = 2
WHERE seq IN (2, 3);

UPDATE board_test SET gn = 1
WHERE seq IN (1, 9);

COMMIT;

SELECT gn, seq, LPAD(' ', (LEVEL-1)*4) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gn DESC, seq ASC;


SELECT seq, LPAD(' ', (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY root DESC, seq ASC;



SELECT seq, LPAD(' ', 4*(level-1)) || title title,
       CASE WHEN parent_seq IS NULL THEN seq ELSE 0 END o1,
       CASE WHEN parent_seq IS NOT NULL THEN seq ELSE 0 END o2
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR SEQ = parent_seq
ORDER SIBLINGS BY CASE WHEN parent_seq IS NULL THEN seq ELSE 0 END DESC,
                  seq ; 

SELECT *
FROM board_test;


SELECT *
FROM emp
ORDER BY deptno DESC, empno ASC;

SELECT ename, MAX(sal)
FROM emp
             
SELECT *
FROM emp
WHERE sal = (SELECT MAX(sal)
             FROM emp);
             
SELECT *
FROM emp
WHERE sal = 5000;

SELECT *
FROM 
(SELECT LEVEL lv
 FROM dual
 CONNECT BY LEVEL <= 14) a,

(SELECT deptno, COUNT(*) cnt
 FROM emp
 GROUP BY deptno) b
WHERE b.cnt >= a.lv
ORDER BY b.deptno, a.lv; 


�õ�, �ñ���, ����ŷ �Ǽ�, kfc �Ǽ�, �Ƶ����� �Ǽ�, �Ե����� �Ǽ�

�õ�, �ñ���, ����ŷ �Ǽ�
�õ�, �ñ���, kfc �Ǽ�
�õ�, �ñ���, �Ƶ����� �Ǽ�
�õ�, �ñ���, �Ե����� �Ǽ�

���� SQL ���� : WHERE, �׷쿬���� ���� GROUP BY, ������ �Լ�(COUNT),
                 �ζ��� ��, ROWNUM, ORDER BY, ��Ī(�÷�, ���̺�), ROUND, JOIN

SELECT ROWNUM rn, a.sido, a.sigungu, a.city_idx
FROM 
(SELECT bk.sido, bk.sigungu, bk.cnt, kfc.cnt, mac.cnt, lot.cnt, 
       ROUND((bk.cnt +kfc.cnt+ mac.cnt)/ lot.cnt, 2) city_idx
FROM
(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = '����ŷ'
GROUP BY sido, sigungu) bk,

(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = 'KFC'
GROUP BY sido, sigungu) kfc,

(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = '�Ƶ�����'
GROUP BY sido, sigungu) mac,

(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = '�Ե�����'
GROUP BY sido, sigungu) lot
WHERE bk.sido = kfc.sido
  AND bk.sigungu = kfc.sigungu
  AND bk.sido = mac.sido
  AND bk.sigungu = mac.sigungu
  AND bk.sido = lot.sido
  AND bk.sigungu = lot.sigungu
ORDER BY city_idx DESC ) a;  



SELECT *
FROM tax;

�ʼ�
����1] fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� SQL �ۼ�
 1. �õ� �ñ����� ���ù��������� ���ϰ�(������ ���� ���ð� ������ ����)
 2. �δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�
 3. ���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL �ۼ�
 
����, �ܹ��� �õ�, �ܹ��� �ñ���, �ܹ��� ���ù�������, ����û �õ�, ����û �ñ���, ����û �������� �ݾ�1�δ� �Ű�� 


�ɼ�
����2]
�ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ��� �Ͽ��µ� (fastfood ���̺��� 4�� ���)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ���� (fastfood ���̺��� 1���� ���)
CASE, DECODE

����3]
�ܹ��� ���� sql�� �ٸ� ���·� �����ϱ�



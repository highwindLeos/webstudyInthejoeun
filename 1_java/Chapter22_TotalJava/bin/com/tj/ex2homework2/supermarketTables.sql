DROP TABLE CUSTOMER;
DROP TABLE CGRADE; 

CREATE TABLE CGRADE (
	GNO NUMBER(2) PRIMARY KEY,
	GRADE VARCHAR2(10) NOT NULL,
    LOW NUMBER(10,0),
    HIGH NUMBER(10,0)
);

CREATE TABLE CUSTOMER (
    CNO VARCHAR2(4) PRIMARY KEY,
    CTEL VARCHAR2(20) NOT NULL, 
    CNAME VARCHAR2(30) NOT NULL,
    POINT NUMBER(10) DEFAULT 1000, 
    BUY NUMBER(30) DEFAULT 0,
    GNO NUMBER(2)  DEFAULT 1 REFERENCES CGRADE(GNO)
);


-- �� ��ȣ ������
DROP SEQUENCE SEQ_CNO;
CREATE SEQUENCE SEQ_CNO MAXVALUE 9999;
SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'SEQ_CNO';
--1. �������� ���� ���� Ȯ��
SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'SEQ_CNO';

--2. �������� INCREMENT �� ���� ����ŭ ������ ���� (�Ʒ��� ���簪�� 999999 �� ���)
ALTER SEQUENCE SEQ_CNO INCREMENT BY -3 MINVALUE 1;

--3. ���������� ���� ���� ���� �´�
SELECT SEQ_CNO.NEXTVAL FROM DUAL;

--4. ���� ���� Ȯ�� �غ��� -999999 ��ŭ ���� �ߴ�
SELECT SEQ_CNO.CURRVAL FROM DUAL;

--5. �������� INCREMENT �� 1�� ���� �Ѵ�
ALTER SEQUENCE SEQ_CNO INCREMENT BY 1;

--6. �������� 1���� �ٽ� ���� �Ѵ�.

COMMIT;

-- TABLE ���� Ȯ��
SELECT * FROM CGRADE;
SELECT * FROM CUSTOMER;

-- �� ��� ������ �Է�
INSERT INTO CGRADE VALUES (1, '�Ϲ�', 0, 99999);
INSERT INTO CGRADE VALUES (2, '�ǹ�', 100000, 199999);
INSERT INTO CGRADE VALUES (3, '���', 200000, 299999);
INSERT INTO CGRADE VALUES (4, 'VIP',  300000, 399999);
INSERT INTO CGRADE VALUES (5, 'VVIP', 400000, 9999999999);


-- �� ������ �Է�
INSERT INTO CUSTOMER VALUES (SEQ_CNO.NEXTVAL, '010-9999-9999', '�̵���', 1000, 0, 1);
INSERT INTO CUSTOMER VALUES (SEQ_CNO.NEXTVAL, '010-9999-8888', '�̸�ȭ', 1000, 0, 1);
INSERT INTO CUSTOMER VALUES (SEQ_CNO.NEXTVAL, '010-9999-7777', '������', 1000, 0, 1);
INSERT INTO CUSTOMER VALUES (SEQ_CNO.NEXTVAL, '010-9999-6666', '���ٴ�', 1000, 0, 1);
INSERT INTO CUSTOMER VALUES (SEQ_CNO.NEXTVAL, '010-9999-5555', '�츶��', 1000, 0, 1);
INSERT INTO CUSTOMER VALUES (SEQ_CNO.NEXTVAL, '010-9999-4444', '�տ���', 1000, 0, );

COMMIT;

UPDATE CUSTOMER SET CNO = ROWNUM; -- ���̺��� ���� CNO �� ���������� �Ѵ�.

-- �޺� �ڽ� /
SELECT GRADE FROM CGRADE;

-- 1. �� �˻� /
SELECT C.*, G.GRADE, NVL((SELECT HIGH-BUY+1 from CUSTOMER WHERE CNO = C.CNO and GNO != 5), 0) LEVELUP
FROM CUSTOMER C, CGRADE G
WHERE C.GNO = G.GNO AND SUBSTR(CTEL, -4) = '8888';

SELECT C.*, G.GRADE, NVL((SELECT HIGH-BUY+1 from CUSTOMER WHERE CNO = C.CNO and GNO != 5), 0) LEVELUP
FROM CUSTOMER C, CGRADE G
WHERE C.GNO = G.GNO AND CTEL LIKE '%8888';

-- 2.���̸� �˻� /

SELECT C.*, G.GRADE, NVL((SELECT HIGH-BUY+1 from CUSTOMER WHERE CNO = C.CNO and GNO != 5), 0) LEVELUP
FROM CUSTOMER C, CGRADE G
WHERE C.GNO = G.GNO AND CNAME = '�տ���';

-- 3.����Ʈ ���� /
SELECT POINT FROM CUSTOMER WHERE CTEL LIKE '%'||'7777' AND CNAME = '������';

UPDATE CUSTOMER SET BUY = (BUY + 500), POINT = (POINT - 500) WHERE CTEL LIKE '%'||'7777' OR CNAME = '������';

-- 4.��ǰ���� /
UPDATE CUSTOMER SET POINT = POINT + (10000 * 0.05), BUY = (BUY + 10000) WHERE CTEL LIKE '%'||'7777' OR CNAME = '������';

-- ���� �� �� ���Ŵ����ݾ׿� ���� ������ ���� /
SELECT G.GNO FROM CUSTOMER C, CGRADE G WHERE BUY BETWEEN LOW AND HIGH;

UPDATE CUSTOMER SET GNO = (SELECT G.GNO FROM CUSTOMER C, CGRADE G
                WHERE BUY BETWEEN LOW AND HIGH AND CTEL LIKE '%'||'4444')
            WHERE CTEL LIKE '%'||'4444';

-- 5.��޺� ��� /
SELECT C.*, G.GRADE
FROM CUSTOMER C, CGRADE G
WHERE C.GNO = G.GNO AND G.GRADE = '�ǹ�'
ORDER BY CNO;

SELECT C.*, G.GRADE, NVL((SELECT HIGH-BUY+1 from CUSTOMER WHERE CNO = C.CNO and GNO != 5), 0) LEVELUP
FROM CUSTOMER C, CGRADE G
WHERE C.GNO = G.GNO AND G.GRADE = '�Ϲ�' 
ORDER BY CNO;

-- 6.��ü ��� /
SELECT C.*, G.GRADE, NVL((SELECT HIGH-BUY+1 from CUSTOMER WHERE CNO = C.CNO and GNO != 5), 0) LEVELUP
FROM CUSTOMER C, CGRADE G
WHERE C.GNO = G.GNO
ORDER BY C.CNO;

-- 7.ȸ������ /
INSERT INTO CUSTOMER VALUES (SEQ_CNO.NEXTVAL, '010-9999-7890', '�̿���', 1000, 0, 1);

-- 8.ȸ�� ����ó ���� /
UPDATE CUSTOMER SET CTEL = '010-8888-9999' WHERE CNAME = '������';

-- 9.ȸ�� Ż�� /
DELETE FROM CUSTOMER WHERE CTEL = '�츶��';

COMMIT;
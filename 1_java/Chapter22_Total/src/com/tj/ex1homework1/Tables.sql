DROP TABLE STUDENT;
DROP TABLE MAJOR;

CREATE TABLE MAJOR (
    MNO NUMBER(1) PRIMARY KEY,
    MNAME VARCHAR2(30) NOT NULL
);

CREATE TABLE STUDENT (
    SNO VARCHAR2(20) PRIMARY KEY,
    SNAME VARCHAR2(30) NOT NULL,
    MNO NUMBER(1) REFERENCES MAJOR(MNO), 
    SCORE NUMBER(3) CHECK (SCORE >= 0 AND SCORE <= 100),
    EXPEL NUMBER(1) DEFAULT 0 CHECK (EXPEL = 0 OR EXPEL = 1)
);

SELECT * FROM STUDENT;
SELECT * FROM MAJOR;

INSERT INTO MAJOR VALUES (1, '경영');
INSERT INTO MAJOR VALUES (2, '컴퓨터');
INSERT INTO MAJOR VALUES (3, '디자인');
INSERT INTO MAJOR VALUES (4, '수학');
INSERT INTO MAJOR VALUES (5, '영문학');

COMMIT;


INSERT INTO STUDENT VALUES ('A001', '이만화', 1, 80, 0);
INSERT INTO STUDENT VALUES ('A002', '이기린', 3, 90, 0);
INSERT INTO STUDENT VALUES ('A003', '박부검', 2, 99, 0);
INSERT INTO STUDENT VALUES ('A004', '박부장', 5, 100, 1);
-- 콤보 박스
SELECT MNAME FROM MAJOR;

-- 학번 검색
SELECT S.*, MNAME
FROM STUDENT S, MAJOR M
WHERE S.MNO = M.MNO AND SNO = 'A001';

-- 이름 검색
SELECT S.*, MNAME
FROM STUDENT S, MAJOR M
WHERE S.MNO = M.MNO AND SNAME = '박부검';

-- 전공 검색
SELECT S.*, MNAME
FROM STUDENT S, MAJOR M
WHERE S.MNO = M.MNO AND MNAME = '컴퓨터';

-- 학생 입력
SELECT MNO FROM MAJOR WHERE MNAME = '컴퓨터';

INSERT INTO STUDENT VALUES (UPPER('Z001'), '이만화', (SELECT MNO FROM MAJOR WHERE MNAME = '컴퓨터'), 80, 0);
INSERT INTO STUDENT VALUES (UPPER('B002'), '이유라', (SELECT MNO FROM MAJOR WHERE MNAME = '컴퓨터'), 80, 0);

-- 학생 수정
UPDATE STUDENT SET SNAME = '이데이', MNO = (SELECT MNO FROM MAJOR WHERE MNAME = '경영'), SCORE = 100 WHERE SNO = UPPER('Z123');
UPDATE STUDENT SET SNAME = '이주리', MNO = (SELECT MNO FROM MAJOR WHERE MNAME = '영문학'), SCORE = 90 WHERE SNO = UPPER('Z123');


-- 학생 출력
SELECT S.*, MNAME
FROM STUDENT S, MAJOR M
WHERE S.MNO = M.MNO AND EXPEL = 0;

-- 제적 처리
UPDATE STUDENT SET EXPEL = 1 WHERE SNO = UPPER('Z123');


-- 재적자 출력
SELECT S.*, MNAME
FROM STUDENT S, MAJOR M
WHERE S.MNO = M.MNO AND EXPEL = 1 ORDER BY S.SNO;

COMMIT;


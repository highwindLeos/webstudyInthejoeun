DROP TABLE BOOK;

CREATE TABLE BOOK (
    BID NUMBER(5) PRIMARY KEY,                   -- 책번호
    BNAME VARCHAR2(100) NOT NULL,                -- 책이름
    BPRICE NUMBER(7) NOT NULL,                   -- 책가격
    BIMAGE1 VARCHAR2(100) DEFAULT 'NOTHING.JPG', -- 책이미지 1
    BIMAGE2 VARCHAR2(100) DEFAULT 'NOTHING.JPG', -- 책이미지 2
    BCONTENT VARCHAR2(1000),
    -- 저자, 출판사, 출판년(일), 발행년일(일) 생략
    BDISCOUNT NUMBER(3) DEFAULT 0           -- 할인율
);

DROP SEQUENCE BOOK_SEQ;
CREATE SEQUENCE BOOK_SEQ;

-- 책을 등록
INSERT INTO BOOK VALUES (BOOK_SEQ.NEXTVAL, 'JSP PROGRAMING', 20000, 'NOTHING.JPG', 'NOTHING.JPG', '', 0); -- dao 사용

INSERT INTO BOOK (BID, BNAME, BPRICE, BCONTENT, BDISCOUNT) VALUES (BOOK_SEQ.NEXTVAL, 'HTML TAGS', 15000, '', 10);

INSERT INTO BOOK (BID, BNAME, BPRICE, BIMAGE1, BCONTENT, BDISCOUNT) VALUES (BOOK_SEQ.NEXTVAL, 'HTML TAGS', 15000, 'NOTHING.JPG', '', 5);

INSERT INTO BOOK (BID, BNAME, BPRICE, BIMAGE1, BIMAGE2, BCONTENT, BDISCOUNT) VALUES (BOOK_SEQ.NEXTVAL, 'CSS DESING', 15000, 'NOTHING.JPG', 'NOTHING.JPG', '', 0);

COMMIT;

--책목록 보기
SELECT * FROM BOOK ORDER BY BID DESC;

SELECT ROWNUM RN, A.* FROM (SELECT * FROM BOOK ORDER BY BID DESC) A;

SELECT * FROM (SELECT ROWNUM RN, A.* FROM (SELECT * FROM BOOK ORDER BY BID DESC) A)
WHERE RN BETWEEN 3 AND 4; -- 페이징의 쓰이는 top-n 구문

-- 책 목록 수 구해오기
SELECT count(*) FROM BOOK;

-- 특정책의 상세보기
SELECT * FROM BOOK WHERE BID = 1;

DELETE FROM BOOK WHERE BID = 5;

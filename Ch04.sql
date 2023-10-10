/*
    날짜: 2023/10/05
    이름: 이지민
    실습: PL/SQL
*/

-- 실습 1-1. Hello Oracle 출력
SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello Oracle!');
END;

-- 실습 1-2. 주석 처리
DECLARE
    NO NUMBER(4) := 1001;
    NAME VARCHAR2(10) := '홍길동';
    HP CHAR(13) := '010-1000-1001';
    ADDR VARCHAR2(100) := '부산광역시';
BEGIN
    DBMS_OUTPUT.PUT_LINE('번호 : '|| NO);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| NAME);
    DBMS_OUTPUT.PUT_LINE('전화 : '|| HP);
    DBMS_OUTPUT.PUT_LINE('주소 : '|| ADDR);
END;

-- 실습 2-1. 변수 선언 및 변수값 출력
SET SERVEROUTPUT ON; // 콘솔 출력이 안될 경우 실행

DECLARE
    NO      CONSTANT NUMBER(4) := 1001;
    NAME    VARCHAR2(10);
    HP      CHAR(13) := '000-0000-0000';
    AGE     NUMBER(2) DEFAULT 1;
    ADDR    VARCHAR2(10) NOT NULL := '부산';
BEGIN
    NAME := '김유신';
    HP := '010-1000-1001';
    DBMS_OUTPUT.PUT_LINE('번호: '|| NO);
    DBMS_OUTPUT.PUT_LINE('이름: '|| NAME);
    DBMS_OUTPUT.PUT_LINE('전화: '|| HP);
    DBMS_OUTPUT.PUT_LINE('나이: '|| AGE);
    DBMS_OUTPUT.PUT_LINE('주소: '|| ADDR);
END;

-- 실습 2-2. 열 참조형 변수
DECLARE
    NO      DEPT.DEPTNO%TYPE;
    NAME    DEPT.DNAME%TYPE;
    ADDR    DEPT.LOC%TYPE;
BEGIN
    SELECT *
    INTO NO, NAME, ADDR
    FROM DEPT
    WHERE DEPTNO = 30;
    
    DBMS_OUTPUT.PUT_LINE('부서번호 : ' || NO);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('주소 : ' || ADDR);
END;

-- 실습 2-3. 행 참조형 변수

DECLARE
    -- 선언
    ROW_DEPT DEPT%ROWTYPE;
BEGIN
    -- 처리
    SELECT *
    INTO ROW_DEPT
    FROM DEPT
    WHERE DEPTNO = 40;
    
    -- 출력
    DBMS_OUTPUT.PUT_LINE('부서번호 : ' || ROW_DEPT.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || ROW_DEPT.DNAME);
    DBMS_OUTPUT.PUT_LINE('주소 : ' || ROW_DEPT.LOC);
END;

-- 실습 2-4. 레코드 자료형 기본 실습
DECLARE
    -- Record Define
    TYPE REC_DEPT IS RECORD (
        deptno  NUMBER(2),
        dname   DEPT.DNAME%TYPE,
        loc     DEPT.LOC%TYPE
    );
    -- Record Declare
    dept_rec REC_DEPT;
BEGIN
    -- Record Initialize
    dept_rec.deptno := 10;
    dept_rec.dname := '개발부';
    dept_rec.loc := '부산';
    
    -- Record Print
    DBMS_OUTPUT.PUT_LINE('deptno : ' || dept_rec.deptno);
    DBMS_OUTPUT.PUT_LINE('dname : ' || dept_rec.dname);
    DBMS_OUTPUT.PUT_LINE('loc : ' || dept_rec.loc);
    DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 테이블 복사(데이터 제외)
CREATE TABLE DEPT_RECORD AS SELECT * FROM DEPT WHERE 1 = 0; // 데이터까지 조회하지 않음

DECLARE
    TYPE REC_DEPT IS RECORD (
        deptno  NUMBER(2),
        dname   DEPT.DNAME%TYPE,
        loc     DEPT.LOC%TYPE
    );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.deptno := 10;
    dept_rec.dname := '개발부';
    dept_rec.loc := '부산';
    
    INSERT INTO DEPT_RECORD VALUES dept_rec;
END;

DECLARE
    TYPE REC_DEPT IS RECORD (
        deptno  DEPT.DEPTNO%TYPE,
        dname   DEPT.DNAME%TYPE,
        loc     DEPT.LOC%TYPE
    );
    TYPE REC_EMP IS RECORD (
        empno   EMP.EMPNO%TYPE,
        ename   EMP.ENAME%TYPE,
        dinfo   REC_DEPT
    );
    
    emp_rec REC_EMP;

BEGIN
    SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
    INTO
        emp_rec.empno,
        emp_rec.ename,
        emp_rec.dinfo.deptno,
        emp_rec.dinfo.dname,
        emp_rec.dinfo.loc
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO AND E.EMPNO = 7788;
    
    DBMS_OUTPUT.PUT_LINE('EMPNO : '|| emp_rec.empno);
    DBMS_OUTPUT.PUT_LINE('EMPNO : '|| emp_rec.ename);
    DBMS_OUTPUT.PUT_LINE('EMPNO : '|| emp_rec.dinfo.deptno);
    DBMS_OUTPUT.PUT_LINE('EMPNO : '|| emp_rec.dinfo.dname);
    DBMS_OUTPUT.PUT_LINE('EMPNO : '|| emp_rec.dinfo.loc);
    
    DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 2-7. 테이블(연관배열) 기본 실습
DECLARE
    TYPE ARR_CITY IS TABLE OF VARCHAR2(20) INDEX BY PLS_INTEGER;
    arrCity ARRCITY;
BEGIN
    arrCity(1) := '서울';
    arrCity(2) := '대전';
    arrCity(3) := '부산';
    
    DBMS_OUTPUT.PUT_LINE('arrCity(1) :' || arrCity(1));
    DBMS_OUTPUT.PUT_LINE('arrCity(2) :' || arrCity(2));
    DBMS_OUTPUT.PUT_LINE('arrCity(3) :' || arrCity(3));
END;

-- 실습 3-1. IF 실습
DECLARE
    NUM NUMBER := 1;
BEGIN
    IF NUM > 0 THEN
        DBMS_OUTPUT.PUT_LINE('NUM은 0보다 크다.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 3-2. IF~ELSE 실습
DECLARE
    NUM NUMBER := -1;
BEGIN
    IF NUM > 0 THEN
        DBMS_OUTPUT.PUT_LINE('NUM은 0보다 크다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('NUM은 0보다 작다.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

DECLARE
    SCORE NUMBER := 86;
BEGIN
    IF SCORE >= 90 AND SCORE <= 100 THEN
        DBMS_OUTPUT.PUT_LINE('A 입니다.');
    ELSIF SCORE >= 80 AND SCORE < 90 THEN
        DBMS_OUTPUT.PUT_LINE('B 입니다.');
    ELSIF SCORE >= 70 AND SCORE < 80 THEN
        DBMS_OUTPUT.PUT_LINE('C 입니다.');
    ELSIF SCORE >= 60 AND SCORE < 70 THEN
        DBMS_OUTPUT.PUT_LINE('D 입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F 입니다.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;

-- 실습 3-4. CASE 실습
DECLARE
    SCORE NUMBER := 86;
BEGIN
    

-- 실습 4-1. 단일 행 결과를 처리하는 커서 사용
DECLARE
    -- 커서 데이터를 저장할 변수 선언
    V_DEPT_ROW DEPT%ROWTYPE;
    
    -- 커서 선언
    CURSOR c1 IS SELECT * FROM DEPT WHERE DEPTNO = 40;
BEGIN
    -- 커서 열기
    OPEN c1;
    
    -- 커서 데이터 입력
    FETCH c1 INTO V_DEPT_ROW;
    
    -- 커서 데이터 출력
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
    
    -- 커서 종료
    CLOSE c1;
END;


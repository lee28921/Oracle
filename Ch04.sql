/*
    ��¥: 2023/10/05
    �̸�: ������
    �ǽ�: PL/SQL
*/

-- �ǽ� 1-1. Hello Oracle ���
SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello Oracle!');
END;

-- �ǽ� 1-2. �ּ� ó��
DECLARE
    NO NUMBER(4) := 1001;
    NAME VARCHAR2(10) := 'ȫ�浿';
    HP CHAR(13) := '010-1000-1001';
    ADDR VARCHAR2(100) := '�λ걤����';
BEGIN
    DBMS_OUTPUT.PUT_LINE('��ȣ : '|| NO);
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| NAME);
    DBMS_OUTPUT.PUT_LINE('��ȭ : '|| HP);
    DBMS_OUTPUT.PUT_LINE('�ּ� : '|| ADDR);
END;

-- �ǽ� 2-1. ���� ���� �� ������ ���
SET SERVEROUTPUT ON; // �ܼ� ����� �ȵ� ��� ����

DECLARE
    NO      CONSTANT NUMBER(4) := 1001;
    NAME    VARCHAR2(10);
    HP      CHAR(13) := '000-0000-0000';
    AGE     NUMBER(2) DEFAULT 1;
    ADDR    VARCHAR2(10) NOT NULL := '�λ�';
BEGIN
    NAME := '������';
    HP := '010-1000-1001';
    DBMS_OUTPUT.PUT_LINE('��ȣ: '|| NO);
    DBMS_OUTPUT.PUT_LINE('�̸�: '|| NAME);
    DBMS_OUTPUT.PUT_LINE('��ȭ: '|| HP);
    DBMS_OUTPUT.PUT_LINE('����: '|| AGE);
    DBMS_OUTPUT.PUT_LINE('�ּ�: '|| ADDR);
END;

-- �ǽ� 2-2. �� ������ ����
DECLARE
    NO      DEPT.DEPTNO%TYPE;
    NAME    DEPT.DNAME%TYPE;
    ADDR    DEPT.LOC%TYPE;
BEGIN
    SELECT *
    INTO NO, NAME, ADDR
    FROM DEPT
    WHERE DEPTNO = 30;
    
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ : ' || NO);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('�ּ� : ' || ADDR);
END;

-- �ǽ� 2-3. �� ������ ����

DECLARE
    -- ����
    ROW_DEPT DEPT%ROWTYPE;
BEGIN
    -- ó��
    SELECT *
    INTO ROW_DEPT
    FROM DEPT
    WHERE DEPTNO = 40;
    
    -- ���
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ : ' || ROW_DEPT.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || ROW_DEPT.DNAME);
    DBMS_OUTPUT.PUT_LINE('�ּ� : ' || ROW_DEPT.LOC);
END;

-- �ǽ� 2-4. ���ڵ� �ڷ��� �⺻ �ǽ�
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
    dept_rec.dname := '���ߺ�';
    dept_rec.loc := '�λ�';
    
    -- Record Print
    DBMS_OUTPUT.PUT_LINE('deptno : ' || dept_rec.deptno);
    DBMS_OUTPUT.PUT_LINE('dname : ' || dept_rec.dname);
    DBMS_OUTPUT.PUT_LINE('loc : ' || dept_rec.loc);
    DBMS_OUTPUT.PUT_LINE('PL/SQL ����...');
END;

-- ���̺� ����(������ ����)
CREATE TABLE DEPT_RECORD AS SELECT * FROM DEPT WHERE 1 = 0; // �����ͱ��� ��ȸ���� ����

DECLARE
    TYPE REC_DEPT IS RECORD (
        deptno  NUMBER(2),
        dname   DEPT.DNAME%TYPE,
        loc     DEPT.LOC%TYPE
    );
    dept_rec REC_DEPT;
BEGIN
    dept_rec.deptno := 10;
    dept_rec.dname := '���ߺ�';
    dept_rec.loc := '�λ�';
    
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
    
    DBMS_OUTPUT.PUT_LINE('PL/SQL ����...');
END;

-- �ǽ� 2-7. ���̺�(�����迭) �⺻ �ǽ�
DECLARE
    TYPE ARR_CITY IS TABLE OF VARCHAR2(20) INDEX BY PLS_INTEGER;
    arrCity ARRCITY;
BEGIN
    arrCity(1) := '����';
    arrCity(2) := '����';
    arrCity(3) := '�λ�';
    
    DBMS_OUTPUT.PUT_LINE('arrCity(1) :' || arrCity(1));
    DBMS_OUTPUT.PUT_LINE('arrCity(2) :' || arrCity(2));
    DBMS_OUTPUT.PUT_LINE('arrCity(3) :' || arrCity(3));
END;

-- �ǽ� 3-1. IF �ǽ�
DECLARE
    NUM NUMBER := 1;
BEGIN
    IF NUM > 0 THEN
        DBMS_OUTPUT.PUT_LINE('NUM�� 0���� ũ��.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('PL/SQL ����...');
END;

-- �ǽ� 3-2. IF~ELSE �ǽ�
DECLARE
    NUM NUMBER := -1;
BEGIN
    IF NUM > 0 THEN
        DBMS_OUTPUT.PUT_LINE('NUM�� 0���� ũ��.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('NUM�� 0���� �۴�.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('PL/SQL ����...');
END;

DECLARE
    SCORE NUMBER := 86;
BEGIN
    IF SCORE >= 90 AND SCORE <= 100 THEN
        DBMS_OUTPUT.PUT_LINE('A �Դϴ�.');
    ELSIF SCORE >= 80 AND SCORE < 90 THEN
        DBMS_OUTPUT.PUT_LINE('B �Դϴ�.');
    ELSIF SCORE >= 70 AND SCORE < 80 THEN
        DBMS_OUTPUT.PUT_LINE('C �Դϴ�.');
    ELSIF SCORE >= 60 AND SCORE < 70 THEN
        DBMS_OUTPUT.PUT_LINE('D �Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F �Դϴ�.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('PL/SQL ����...');
END;

-- �ǽ� 3-4. CASE �ǽ�
DECLARE
    SCORE NUMBER := 86;
BEGIN
    

-- �ǽ� 4-1. ���� �� ����� ó���ϴ� Ŀ�� ���
DECLARE
    -- Ŀ�� �����͸� ������ ���� ����
    V_DEPT_ROW DEPT%ROWTYPE;
    
    -- Ŀ�� ����
    CURSOR c1 IS SELECT * FROM DEPT WHERE DEPTNO = 40;
BEGIN
    -- Ŀ�� ����
    OPEN c1;
    
    -- Ŀ�� ������ �Է�
    FETCH c1 INTO V_DEPT_ROW;
    
    -- Ŀ�� ������ ���
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
    
    -- Ŀ�� ����
    CLOSE c1;
END;


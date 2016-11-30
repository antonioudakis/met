CREATE TABLE METWEBKINDPISTOP (TMIMACODE SMALLINT NOT NULL, K_PISTOP SMALLINT NOT NULL, 
	B_EXPORT SMALLINT NOT NULL WITH DEFAULT, TITLOS VARCHAR (100) );

CREATE UNIQUE INDEX METWEBKINDPISTOP ON METWEBKINDPISTOP(TMIMACODE, K_PISTOP);

ALTER TABLE METWEBKINDPISTOP PRIMARY KEY (TMIMACODE, K_PISTOP);

CREATE TABLE METWEBAITPISTOP (TMIMACODE SMALLINT NOT NULL, AID INTEGER NOT NULL, URIID INTEGER NOT NULL, 
	K_PISTOP INTEGER NOT NULL, MITROO  VARCHAR(250) NOT NULL, ARPRVT VARCHAR (50), COPIES SMALLINT NOT NULL
	WITH DEFAULT, AITDATE DATE NOT NULL, PISTOSTATUS SMALLINT NOT NULL, PISTOFLAG SMALLINT NOT NULL
	WITH DEFAULT, PRINTERROR SMALLINT, AITIO LONG, PISTOREPLY LONG);

CREATE UNIQUE INDEX METWEBAITPISTOP ON METWEBAITPISTOP(TMIMACODE, AID);

ALTER TABLE METWEBAITPISTOP PRIMARY KEY (TMIMACODE, AID);

ALTER TABLE METWEBAITPISTOP FOREIGN KEY METWEBKINDPISTOP (TMIMACODE, K_PISTOP) REFERENCES
	METWEBKINDPISTOP ON DELETE RESTRICT;

INSERT INTO METWEBKINDPISTOP  VALUES (3,1,0, '������������� ��������� ������������ ��������� ��� ���� �����');
INSERT INTO METWEBKINDPISTOP  VALUES (3,2,0, '������������� ��������� ������������ ��������� ��� ������������ �����');
INSERT INTO METWEBKINDPISTOP  VALUES (3,3,0, '������������� ��������� ������������ ��������� ��� ����� ��� ����������');
INSERT INTO METWEBKINDPISTOP  VALUES (3,4,0, '������������� ������� �������' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,5,0, '������������� ������� 2�� ����� �������' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,6,0, '������������� �������� �.�. �� �������� �������� ��� ���� �����' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,7,0, '������������� �������� �.�. �� �������� �������� ��� ������������ �����' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,8,0, '������������� �������� �.�. ����� �������� �������� ��� ���� �����' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,9,0, '������������� �������� �.�. ����� �������� �������� ��� ������������ �����' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,10,0, '������������� ������������� ���������' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,11,0, '������������� ��������' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,12,0, '������������� �����������' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,13,0, '������������� �������� ��� ��������� ��� ���� �����' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,14,0, '������������� �������� ��� ��������� ��� ������������ �����' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,15,0, '������������� �������� ��� ��������� ��� ����� ��� ����������' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,16,0, '������������� ���������� ����������� �� �������� ��� ���� �����' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,17,0, '������������� ���������� ����������� �� �������� ��� ������������ �����' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,18,0, '������������� ���������� ����������� ����� �������� ��� ���� �����' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,19,0, '������������� ���������� ����������� ����� �������� ��� ������������ �����' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,20,0, '������������� ���� ��� �������� �.�.�. ��� ���� �����' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,21,0, '������������� ���� ��� �������� �.�.�. ��� ������������ �����' );


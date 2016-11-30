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

INSERT INTO METWEBKINDPISTOP  VALUES (3,1,0, 'Πιστοποιητικό εκπόνησης διδακτορικής διατριβής για κάθε χρήση');
INSERT INTO METWEBKINDPISTOP  VALUES (3,2,0, 'Πιστοποιητικό εκπόνησης διδακτορικής διατριβής για στρατολογική χρήση');
INSERT INTO METWEBKINDPISTOP  VALUES (3,3,0, 'Πιστοποιητικό εκπόνησης διδακτορικής διατριβής για χρήση στη βιβλιοθήκη');
INSERT INTO METWEBKINDPISTOP  VALUES (3,4,0, 'Πιστοποιητικό έκδοσης δανείου' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,5,0, 'Πιστοποιητικό έκδοσης 2ης δόσης δανείου' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,6,0, 'Πιστοποιητικό εξέτασης Υ.Δ. με επταμελή επιτροπή για κάθε χρήση' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,7,0, 'Πιστοποιητικό εξέτασης Υ.Δ. με επταμελή επιτροπή για στρατολογική χρήση' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,8,0, 'Πιστοποιητικό εξέτασης Υ.Δ. χωρίς επταμελή επιτροπή για κάθε χρήση' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,9,0, 'Πιστοποιητικό εξέτασης Υ.Δ. χωρίς επταμελή επιτροπή για στρατολογική χρήση' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,10,0, 'Πιστοποιητικό εκπαιδευτικής εμπειρίας' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,11,0, 'Πιστοποιητικό διακοπής' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,12,0, 'Πιστοποιητικό αναγόρευσης' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,13,0, 'Πιστοποιητικό εγγραφής στο πρόγραμμα για κάθε χρήση' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,14,0, 'Πιστοποιητικό εγγραφής στο πρόγραμμα για στρατολογική χρήση' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,15,0, 'Πιστοποιητικό εγγραφής στο πρόγραμμα για χρήση στη βιβλιοθήκη' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,16,0, 'Πιστοποιητικό αναλυτικής βαθμολογίας με εγγραφές για κάθε χρήση' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,17,0, 'Πιστοποιητικό αναλυτικής βαθμολογίας με εγγραφές για στρατολογική χρήση' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,18,0, 'Πιστοποιητικό αναλυτικής βαθμολογίας χωρίς εγγραφές για κάθε χρήση' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,19,0, 'Πιστοποιητικό αναλυτικής βαθμολογίας χωρίς εγγραφές για στρατολογική χρήση' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,20,0, 'Πιστοποιητικό μετά την απόκτηση Μ.Δ.Ε. για κάθε χρήση' );
INSERT INTO METWEBKINDPISTOP  VALUES (3,21,0, 'Πιστοποιητικό μετά την απόκτηση Μ.Δ.Ε. για στρατολογική χρήση' );


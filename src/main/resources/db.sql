CREATE TABLE orange9.role (
	ID INT NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(100),
	NAME_CN VARCHAR(100),
	IS_SHOW INT,
	CONSTRAINT role_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB;

INSERT INTO orange9.role (ID,NAME,NAME_CN,IS_SHOW) VALUES 
(1,'BOSS','老板',0)
,(2,'PHOTOGRAPHER','摄影师',1)
,(3,'DISIGNER','设计师',1)
,(4,'ASSISTANT','助理',1)
,(5,'DRESSER','化妆师',1)
,(6,'CLIENT','客户',0)
;

CREATE TABLE orange9.user (
	ID INT NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(100),
	ROLE_ID INT,
	BOSS_ID INT,
	ACCOUNT VARCHAR(100),
	PASSWORD VARCHAR(100),
	SALARY NUMERIC,
	PERFORMANCE_PAY NUMERIC,
	HEADER LONGTEXT,
	ACTIVE INT DEFAULT 1,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	CONSTRAINT user_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB;

INSERT INTO orange9.user (ID,NAME,ROLE_ID,ACCOUNT,PASSWORD,SALARY,PERFORMANCE_PAY,HEADER,BOSS_ID) VALUES 
(1,'administrator',1,'administrator','administrator',0,0,NULL,NULL)
;
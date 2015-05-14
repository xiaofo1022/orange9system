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
,(5,'CLIENT','客户',0)
;

CREATE TA5LE orange9.user (
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
	PHONE VARCHAR(100),
	CONSTRAINT user_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB;

INSERT INTO orange9.user (ID,NAME,ROLE_ID,ACCOUNT,PASSWORD,SALARY,PERFORMANCE_PAY,HEADER,BOSS_ID) VALUES 
(1,'administrator',1,'administrator','administrator',0,0,NULL,NULL)
;

CREATE TABLE orange9.orders (
	ID INT NOT NULL AUTO_INCREMENT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	SHOOT_DATE DATE,
	SHOOT_HALF VARCHAR(100),
	CLIENT_ID INT,
	GOODS_ID INT,
	MODEL_NAME VARCHAR(100),
	BROKER_NAME VARCHAR(100),
	BROKER_PHONE VARCHAR(100),
	STATUS_ID INT,
	ACTIVE INT DEFAULT 1,
	DRESSER_NAME VARCHAR(100),
	STYLIST_NAME VARCHAR(100),
	PHOTOGRAPHER_ID INT,
	ASSISTANT_ID INT,
	CONSTRAINT order_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB;

CREATE TABLE orange9.order_goods (
	ID INT NOT NULL AUTO_INCREMENT,
	ORDER_ID INT,
	RECEIVE_EXPRESS_NO VARCHAR(100),
	RECEIVE_EXPRESS_COMPANY VARCHAR(100),
	DELIVER_EXPRESS_NO VARCHAR(100),
	DELIVER_EXPRESS_COMPANY VARCHAR(100),
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	COAT_COUNT INT,
	PANTS_COUNT INT,
	JUMPSUITS_COUNT INT,
	SHOES_COUNT INT,
	BAG_COUNT INT,
	HAT_COUNT INT,
	OTHER_COUNT INT,
	REMARK VARCHAR(1000),
	ACTIVE INT DEFAULT 1,
	CONSTRAINT order_goods_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB;

CREATE TABLE orange9.client (
	ID INT NOT NULL AUTO_INCREMENT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	NAME VARCHAR(100),
	PHONE VARCHAR(100),
	EMAIL VARCHAR(100),
	SHOP_NAME VARCHAR(100),
	SHOP_LINK VARCHAR(100),
	REMARK VARCHAR(100),
	ACTIVE INT DEFAULT 1,
	CONSTRAINT client_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

CREATE TABLE orange9.order_history (
	ID INT NOT NULL AUTO_INCREMENT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	ORDER_ID INT,
	OPERATOR_ID INT,
	INFO VARCHAR(100),
	REMARK VARCHAR(1000),
	CONSTRAINT order_history_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

CREATE TABLE orange9.order_status (
	ID INT NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(100),
	CONSTRAINT order_status_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

INSERT INTO orange9.order_status (ID,NAME) VALUES 
(1,'拍摄中')
,(2,'上传原片')
,(3,'等待客户选片')
,(4,'导图')
,(5,'后期中')
,(6,'等待审核')
,(7,'完成')
;

CREATE TABLE orange9.order_transfer_image (
	ID INT NOT NULL AUTO_INCREMENT,
	ORDER_ID INT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	OPERATOR_ID INT,
	IS_DONE INT DEFAULT 0,
	CONSTRAINT order_transfer_image_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB;

CREATE TABLE orange9.order_time_limit (
	ID INT NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(100),
	LIMIT_MINUTES INT,
	CONSTRAINT order_time_limit_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB;

INSERT INTO orange9.order_time_limit (ID,NAME,LIMIT_MINUTES) VALUES 
(1,'TRANSFER_IMAGE',30)
,(2,'CONVERT_IMAGE',300)
,(3,'SHOOT',480)
;

CREATE TABLE orange9.order_transfer_image_data (
	ID INT NOT NULL AUTO_INCREMENT,
	ORDER_TRANSFER_IMAGE_ID INT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	ORDER_ID INT,
	FILE_NAME VARCHAR(100),
	IS_SELECTED INT DEFAULT 0,
	CONSTRAINT order_transfer_image_data_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

CREATE TABLE orange9.order_convert_image (
	ID INT NOT NULL AUTO_INCREMENT,
	ORDER_ID INT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	OPERATOR_ID INT,
	IS_DONE INT DEFAULT 0,
	CONSTRAINT order_convert_image_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

CREATE TABLE orange9.order_image_fix_skin (
	ID INT NOT NULL AUTO_INCREMENT,
	ORDER_ID INT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	OPERATOR_ID INT,
	IS_DONE INT DEFAULT 0,
	IMAGE_ID INT,
	CONSTRAINT order_image_fix_skin_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

CREATE TABLE orange9.order_image_fix_background (
	ID INT NOT NULL AUTO_INCREMENT,
	ORDER_ID INT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	OPERATOR_ID INT,
	IS_DONE INT DEFAULT 0,
	IMAGE_ID INT,
	CONSTRAINT order_image_fix_background_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

CREATE TABLE orange9.order_image_cut_liquify (
	ID INT NOT NULL AUTO_INCREMENT,
	ORDER_ID INT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	OPERATOR_ID INT,
	IS_DONE INT DEFAULT 0,
	IMAGE_ID INT,
	CONSTRAINT order_image_cut_liquify_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

CREATE TABLE orange9.order_fixed_image_data (
	ID INT NOT NULL AUTO_INCREMENT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	ORDER_ID INT,
	FILE_NAME VARCHAR(100),
	IS_VERIFIED INT DEFAULT 0,
	REASON VARCHAR(100),
	CONSTRAINT order_fixed_image_data_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

CREATE TABLE orange9.order_verify_image (
	ID INT NOT NULL AUTO_INCREMENT,
	ORDER_ID INT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	OPERATOR_ID INT,
	IS_DONE INT DEFAULT 0,
	CONSTRAINT order_verify_image_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

CREATE TABLE orange9.order_shoot_goods (
	ID INT NOT NULL AUTO_INCREMENT,
	ORDER_ID INT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	COAT_COUNT INT,
	PANTS_COUNT INT,
	JUMPSUITS_COUNT INT,
	SHOES_COUNT INT,
	BAG_COUNT INT,
	HAT_COUNT INT,
	OTHER_COUNT INT,
	CONSTRAINT order_shoot_goods_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

CREATE TABLE orange9.employee_clock_in (
	ID INT NOT NULL AUTO_INCREMENT,
	USER_ID INT,
	CLOCK_DATE VARCHAR(10),
	CLOCK_DATETIME DATETIME,
	REMARK VARCHAR(1000),
	CONSTRAINT employee_clock_in_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

CREATE TABLE orange9.performance (
	ID INT NOT NULL AUTO_INCREMENT,
	POST_TYPE VARCHAR(100),
	BASE_COUNT INT,
	PUSH_PER_IMAGE FLOAT,
	CONSTRAINT performance_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;

INSERT INTO orange9.performance (ID,POST_TYPE,BASE_COUNT,PUSH_PER_IMAGE) VALUES 
(1,'FIX_SKIN',300,0.2)
,(2,'FIX_BACKGROUND',300,0.2)
,(3,'CUT_LIQUIFY',300,0.3)
;

CREATE TABLE orange9.client_message (
	ID INT NOT NULL AUTO_INCREMENT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	CLIENT_ID INT,
	ORDER_ID INT,
	MESSAGE VARCHAR(1000),
	REPLY VARCHAR(1000),
	CONSTRAINT client_message_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;
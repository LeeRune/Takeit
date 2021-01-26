-- Drop Table
DROP TABLE `Takeit`.`Area`, `Takeit`.`City`, `Takeit`.`Comment`, `Takeit`.`Creditcard`, `Takeit`.`Favorite`, `Takeit`.`Grade_Type`, `Takeit`.`Hall`, `Takeit`.`Hall_Seat`, `Takeit`.`Hall_Type`, `Takeit`.`Member`, `Takeit`.`Message`, `Takeit`.`Message_Type`, `Takeit`.`Movie`, `Takeit`.`Movie_Type`, `Takeit`.`Order`, `Takeit`.`Order_Detail`, `Takeit`.`Order_Product_Detail`, `Takeit`.`Product`, `Takeit`.`Question`, `Takeit`.`Score`, `Takeit`.`Session`, `Takeit`.`Theater`;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Takeit
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Takeit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Takeit` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `Takeit` ;

-- -----------------------------------------------------
-- Table `Takeit`.`Area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Area` (
  `ID` INT NOT NULL COMMENT '地區編號(PK)',
  `Name` VARCHAR(50) NOT NULL COMMENT '地區名稱',
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`City`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`City` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '縣市編號(PK)',
  `Name` VARCHAR(50) NOT NULL COMMENT '縣市名稱',
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Member` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '會員流水號(PK)',
  `Account` CHAR(10) NULL DEFAULT NULL COMMENT '帳號(電話)',
  `Password` VARCHAR(100) NULL DEFAULT NULL COMMENT '密碼',
  `Report` INT NULL DEFAULT NULL COMMENT '被檢舉次數',
  `Black_Mark` BIT(1) NULL DEFAULT NULL COMMENT '黑名單標記',
  `Nickname` VARCHAR(50) NULL DEFAULT NULL COMMENT '暱稱',
  `Profile_Photo` LONGBLOB NULL DEFAULT NULL COMMENT '會員頭像',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `Account_UNIQUE` (`Account` ASC) VISIBLE,
  INDEX `FK_Memeber_Create_User_idx` (`Create_User` ASC) VISIBLE,
  INDEX `FK_Member_Modify_User_idx` (`Modify_User` ASC) VISIBLE,
  CONSTRAINT `FK_Memeber_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Member_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Grade_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Grade_Type` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '分級類型編號(PK)',
  `Name` VARCHAR(50) NOT NULL COMMENT '分級類型名稱',
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Movie_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Movie_Type` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '電影類型編號(PK)',
  `Name` VARCHAR(50) NOT NULL COMMENT '電影類型名稱',
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Movie` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '電影ID',
  `Movie_Type_ID` INT NULL COMMENT '電影類型ID(FK)',
  `Grade_Type_ID` INT NULL COMMENT '分級類型ID(FK)',
  `Name` VARCHAR(50) NOT NULL COMMENT '電影名稱',
  `Release_Date` DATETIME NOT NULL COMMENT '上映日期',
  `Photo` LONGBLOB NULL DEFAULT NULL COMMENT '電影圖片',
  `Intro` VARCHAR(500) NOT NULL COMMENT '電影簡介',
  `URL` VARCHAR(100) NOT NULL COMMENT '預告URL',
  `Min` INT NOT NULL COMMENT '電影長度',
  `Director` VARCHAR(50) NOT NULL COMMENT '導演',
  `Actor` VARCHAR(100) NOT NULL COMMENT '演員',
  `On_Shelf` BIT(1) NOT NULL COMMENT '上下架標誌，0下架，1上架',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `GradeID_idx` (`Grade_Type_ID` ASC) VISIBLE,
  INDEX `MovieID_idx` (`Movie_Type_ID` ASC) VISIBLE,
  INDEX `FK_Movie_Modify_User` (`Modify_User` ASC) VISIBLE,
  INDEX `FK_Movie_Create_User_idx` (`Create_User` ASC) VISIBLE,
  CONSTRAINT `FK_Movie_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Movie_Grade_Type_ID`
    FOREIGN KEY (`Grade_Type_ID`)
    REFERENCES `Takeit`.`Grade_Type` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Movie_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Movie_Movie_Type_ID`
    FOREIGN KEY (`Movie_Type_ID`)
    REFERENCES `Takeit`.`Movie_Type` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Comment` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '評論訊息流水號(PK)',
  `Member_ID` INT NULL COMMENT '會員ID(FK)',
  `Movie_ID` INT NULL COMMENT '電影ID(FK)',
  `Content` VARCHAR(500) NOT NULL COMMENT '留言內容',
  `Visible_Mark` BIT(1) NOT NULL COMMENT '隱藏標誌，0隱藏，1顯示',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間(留言時間)',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `FK_Comment_Member_ID` (`Member_ID` ASC) VISIBLE,
  INDEX `FK_Comment_Movie_ID` (`Movie_ID` ASC) VISIBLE,
  INDEX `FK_Comment_Create_User` (`Create_User` ASC) VISIBLE,
  INDEX `FK_Comment_Modify_User` (`Modify_User` ASC) VISIBLE,
  CONSTRAINT `FK_Comment_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Comment_Member_ID`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Comment_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Comment_Movie_ID`
    FOREIGN KEY (`Movie_ID`)
    REFERENCES `Takeit`.`Movie` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Creditcard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Creditcard` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '信用卡流水號(PK)',
  `Member_ID` INT NULL COMMENT '會員ID(FK)',
  `Card_Number` CHAR(16) NOT NULL COMMENT '卡號',
  `Exp_Year` CHAR(4) NOT NULL COMMENT '失效日期(年)',
  `Exp_Month` CHAR(2) NOT NULL COMMENT '失效日期(月)',
  `Name` VARCHAR(50) NOT NULL COMMENT '姓名',
  `Address` VARCHAR(100) NOT NULL COMMENT '帳單地址',
  `Use_Mark` BIT(1) NOT NULL COMMENT '使用標誌',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `Account_idx` (`Create_User` ASC) VISIBLE,
  INDEX `FK_Creditcard_Member_ID` (`Member_ID` ASC) VISIBLE,
  INDEX `FK_Creditcard_Create_User_idx` (`Modify_User` ASC) VISIBLE,
  CONSTRAINT `FK_Creditcard_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Creditcard_Member_ID`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Creditcard_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Favorite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Favorite` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '收藏流水號(PK)',
  `Movie_ID` INT NULL COMMENT '電影ID(FK)',
  `Member_ID` INT NULL COMMENT '會員ID(FK)',
  `Favorite_Mark` BIT(1) NOT NULL COMMENT '收藏標誌，0隱藏，1顯示',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `FK_Favorite_Member_ID` (`Member_ID` ASC) VISIBLE,
  INDEX `FK_Favorite_Movie_ID` (`Movie_ID` ASC) VISIBLE,
  INDEX `FK_Favorite_Create_User` (`Create_User` ASC) VISIBLE,
  INDEX `FK_Favorite_Modify_User` (`Modify_User` ASC) VISIBLE,
  CONSTRAINT `FK_Favorite_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Favorite_Member_ID`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Favorite_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Favorite_Movie_ID`
    FOREIGN KEY (`Movie_ID`)
    REFERENCES `Takeit`.`Movie` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Hall_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Hall_Type` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '影廳類型編號(PK)',
  `Name` VARCHAR(50) NOT NULL COMMENT '影廳類型名稱',
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Theater`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Theater` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '影城流水號(PK)',
  `Name` VARCHAR(50) NOT NULL COMMENT '影城名稱',
  `Phone` CHAR(10) NULL DEFAULT NULL COMMENT '影城電話',
  `Address` VARCHAR(200) NULL DEFAULT NULL COMMENT '影城地址',
  `Longitude` DOUBLE NOT NULL COMMENT '經度',
  `Latitude` DOUBLE NOT NULL COMMENT '緯度',
  `Photo` LONGBLOB NULL DEFAULT NULL COMMENT '影城照片',
  `Intro` VARCHAR(500) NULL DEFAULT NULL COMMENT '影城簡介',
  `City_ID` INT NULL COMMENT '縣市ID',
  `Area_ID` INT NULL COMMENT '地區ID',
  `On_Shelf` BIT(1) NOT NULL COMMENT '上下架標誌，0下架，1上架',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `Modify_User_idx` (`Modify_User` ASC) VISIBLE,
  INDEX `FK_Theater_City_ID` (`City_ID` ASC) VISIBLE,
  INDEX `FK_Theater_Area_ID` (`Area_ID` ASC) VISIBLE,
  INDEX `FK_Theater_Create_User` (`Create_User` ASC) VISIBLE,
  CONSTRAINT `FK_Theater_Area_ID`
    FOREIGN KEY (`Area_ID`)
    REFERENCES `Takeit`.`Area` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Theater_City_ID`
    FOREIGN KEY (`City_ID`)
    REFERENCES `Takeit`.`City` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Theater_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Theater_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Hall`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Hall` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '影廳流水號(PK)',
  `Theater_ID` INT NULL COMMENT '影城ID(FK)',
  `Hall_Type_ID` INT NULL COMMENT '影廳類型',
  `Name` VARCHAR(50) NOT NULL COMMENT '影廳名稱',
  `Ticket_Price` INT NOT NULL COMMENT '影廳票價',
  `On_Shelf` BIT(1) NOT NULL COMMENT '上下架標誌，0下架，1上架',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `FK_Hall_Theater_ID` (`Theater_ID` ASC) VISIBLE,
  INDEX `FK_Hall_Hall_Type_ID` (`Hall_Type_ID` ASC) VISIBLE,
  INDEX `FK_Hall_Create_User` (`Create_User` ASC) VISIBLE,
  INDEX `FK_Hall_Modify_User` (`Modify_User` ASC) VISIBLE,
  CONSTRAINT `FK_Hall_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Hall_Hall_Type_ID`
    FOREIGN KEY (`Hall_Type_ID`)
    REFERENCES `Takeit`.`Hall_Type` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Hall_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Hall_Theater_ID`
    FOREIGN KEY (`Theater_ID`)
    REFERENCES `Takeit`.`Theater` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Hall_Seat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Hall_Seat` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '影廳座位流水號(PK)',
  `Hall_ID` INT NULL COMMENT '影廳ID(FK)',
  `Row` INT NOT NULL COMMENT '排數',
  `Column` INT NOT NULL COMMENT '列數',
  `Hall_Seat_Status` BIT(1) NULL DEFAULT NULL COMMENT '狀態，0未選擇，1已選擇',
  UNIQUE INDEX `Row_UNIQUE` (`Row` ASC) VISIBLE,
  UNIQUE INDEX `Column_UNIQUE` (`Column` ASC) VISIBLE,
  PRIMARY KEY (`ID`),
  INDEX `FK_Hall_Seat_Hall_ID_idx` (`Hall_ID` ASC) VISIBLE,
  CONSTRAINT `FK_Hall_Seat_Hall_ID`
    FOREIGN KEY (`Hall_ID`)
    REFERENCES `Takeit`.`Hall` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Message_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Message_Type` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '訊息類型流水號(PK)',
  `Name` VARCHAR(50) NOT NULL COMMENT '訊息類型名稱',
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Message` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '訊息流水號(PK)',
  `Message_Type_ID` INT NULL DEFAULT NULL COMMENT '訊息類型ID(FK)',
  `Sender` INT NULL COMMENT '發訊人會員帳號(FK)',
  `Receiver` INT NULL,
  `Comment_ID` INT NULL DEFAULT NULL COMMENT '評論訊息ID(FK)',
  `Content` VARCHAR(500) NULL DEFAULT NULL COMMENT '訊息內容',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間(發訊時間)',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `FK_Message_Message_Type_ID` (`Message_Type_ID` ASC) VISIBLE,
  INDEX `FK_Message_Comment_ID` (`Comment_ID` ASC) VISIBLE,
  INDEX `FK_Message_Sender` (`Sender` ASC) VISIBLE,
  INDEX `FK_Message_Receiver` (`Receiver` ASC) VISIBLE,
  INDEX `FK_Message_Create_User` (`Create_User` ASC) VISIBLE,
  INDEX `FK_Message_Modify_User` (`Modify_User` ASC) VISIBLE,
  CONSTRAINT `FK_Message_Comment_ID`
    FOREIGN KEY (`Comment_ID`)
    REFERENCES `Takeit`.`Comment` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Message_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Message_Message_Type_ID`
    FOREIGN KEY (`Message_Type_ID`)
    REFERENCES `Takeit`.`Message_Type` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Message_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Message_Receiver`
    FOREIGN KEY (`Receiver`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Message_Sender`
    FOREIGN KEY (`Sender`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Session` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '場次流水號(PK)',
  `Hall_ID` INT NULL COMMENT '影廳ID(FK)',
  `Movie_ID` INT NULL COMMENT '電影ID(FK)',
  `Period` DATETIME NOT NULL COMMENT '時段',
  `On_Shelf` BIT(1) NOT NULL COMMENT '上下架標誌，0下架，1上架',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `FK_Session_Hall_ID` (`Hall_ID` ASC) VISIBLE,
  INDEX `FK_Session_Movie_ID` (`Movie_ID` ASC) VISIBLE,
  INDEX `FK_Session_Create_User` (`Create_User` ASC) VISIBLE,
  INDEX `FK_Session_Modify_User` (`Modify_User` ASC) VISIBLE,
  CONSTRAINT `FK_Session_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Session_Hall_ID`
    FOREIGN KEY (`Hall_ID`)
    REFERENCES `Takeit`.`Hall` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Session_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Session_Movie_ID`
    FOREIGN KEY (`Movie_ID`)
    REFERENCES `Takeit`.`Movie` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Order` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '訂單ID',
  `Member_ID` INT NULL COMMENT '會員ID(FK)',
  `Session_ID` INT NULL COMMENT '場次ID(FK)',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間(下單時間)',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `ID_idx` (`Member_ID` ASC) VISIBLE,
  INDEX `FK_Order_Modify_User` (`Modify_User` ASC) VISIBLE,
  INDEX `FK_Order_Session_ID_idx` (`Session_ID` ASC) VISIBLE,
  CONSTRAINT `FK_Order_Member_ID`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Order_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Order_Session_ID`
    FOREIGN KEY (`Session_ID`)
    REFERENCES `Takeit`.`Session` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Order_Detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Order_Detail` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '訂單明細流水號(PK)',
  `Order_ID` INT NULL COMMENT '訂單ID(FK)',
  `Hall_Seat_Row` INT NULL COMMENT '選取排號',
  `Hall_Seat_Column` INT NULL COMMENT '選取列號',
  `Quantity` INT NOT NULL COMMENT '電影票數量',
  `QR` LONGBLOB NOT NULL COMMENT 'QRcode圖檔',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `Row_idx` (`Hall_Seat_Row` ASC) VISIBLE,
  INDEX `Column_idx` (`Hall_Seat_Column` ASC) VISIBLE,
  INDEX `FK_Order_Detail_Order_ID` (`Order_ID` ASC) VISIBLE,
  INDEX `FK_Order_Detail_Create_User` (`Create_User` ASC) VISIBLE,
  INDEX `FK_Order_Detail_Modify_User` (`Modify_User` ASC) VISIBLE,
  CONSTRAINT `FK_Order_Detail_Column`
    FOREIGN KEY (`Hall_Seat_Column`)
    REFERENCES `Takeit`.`Hall_Seat` (`Column`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Order_Detail_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Order_Detail_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Order_Detail_Order_ID`
    FOREIGN KEY (`Order_ID`)
    REFERENCES `Takeit`.`Order` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Order_Detail_Row`
    FOREIGN KEY (`Hall_Seat_Row`)
    REFERENCES `Takeit`.`Hall_Seat` (`Row`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Product` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '商品流水號(PK)',
  `Theater_ID` INT NULL COMMENT '影城ID(FK)',
  `Name` VARCHAR(50) NOT NULL COMMENT '商品名稱',
  `Price` INT NOT NULL COMMENT '商品價格',
  `Photo` LONGBLOB NULL DEFAULT NULL COMMENT '商品圖檔',
  `On_Shelf` BIT(1) NOT NULL COMMENT '上下架標誌，0下架，1上架',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `ID_idx` (`Theater_ID` ASC) VISIBLE,
  INDEX `FK_Product_Create_User` (`Create_User` ASC) VISIBLE,
  INDEX `FK_Product_Modify_User` (`Modify_User` ASC) VISIBLE,
  CONSTRAINT `FK_Product_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Product_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Product_Theater_ID`
    FOREIGN KEY (`Theater_ID`)
    REFERENCES `Takeit`.`Theater` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Order_Product_Detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Order_Product_Detail` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '訂單商品流水號(PK)',
  `Order_ID` INT NULL COMMENT '訂單ID(FK)',
  `Product_ID` INT NULL COMMENT '商品ID(FK)',
  `Quantity` INT NOT NULL COMMENT '商品數量',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `MAccount_idx` (`Modify_User` ASC) VISIBLE,
  INDEX `FK_Order_Product_Detail_Order_ID` (`Order_ID` ASC) VISIBLE,
  INDEX `FK_Order_Product_Detail_Product_ID` (`Product_ID` ASC) VISIBLE,
  INDEX `FK_Order_Product_Detail_Create_User` (`Create_User` ASC) VISIBLE,
  CONSTRAINT `FK_Order_Product_Detail_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Order_Product_Detail_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Order_Product_Detail_Order_ID`
    FOREIGN KEY (`Order_ID`)
    REFERENCES `Takeit`.`Order` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Order_Product_Detail_Product_ID`
    FOREIGN KEY (`Product_ID`)
    REFERENCES `Takeit`.`Product` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Question` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '常見問題流水號(PK)',
  `Title` VARCHAR(50) NOT NULL COMMENT '常見問題名稱',
  `Content` VARCHAR(500) NOT NULL COMMENT '常見問題解答',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `FK_Question_Create_User` (`Create_User` ASC) VISIBLE,
  INDEX `FK_Question_Modify_User` (`Modify_User` ASC) VISIBLE,
  CONSTRAINT `FK_Question_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Question_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Takeit`.`Score`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Takeit`.`Score` (
  `ID` INT NOT NULL AUTO_INCREMENT COMMENT '表單流水號(PK)',
  `Member_ID` INT NULL COMMENT '會員ID(FK)',
  `Movie_ID` INT NULL COMMENT '電影ID(FK)',
  `Stars` FLOAT NOT NULL COMMENT '分數',
  `Create_Time` DATETIME NULL DEFAULT NULL COMMENT '新增時間',
  `Create_User` INT NULL DEFAULT NULL COMMENT '新增人',
  `Modify_Time` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `Modify_User` INT NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`),
  INDEX `FK_Score_Member_ID` (`Member_ID` ASC) VISIBLE,
  INDEX `FK_Score_Movie_ID` (`Movie_ID` ASC) VISIBLE,
  INDEX `FK_Score_Create_User` (`Create_User` ASC) VISIBLE,
  INDEX `FK_Score_Modify_User` (`Modify_User` ASC) VISIBLE,
  CONSTRAINT `FK_Score_Create_User`
    FOREIGN KEY (`Create_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Score_Member_ID`
    FOREIGN KEY (`Member_ID`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Score_Modify_User`
    FOREIGN KEY (`Modify_User`)
    REFERENCES `Takeit`.`Member` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `FK_Score_Movie_ID`
    FOREIGN KEY (`Movie_ID`)
    REFERENCES `Takeit`.`Movie` (`ID`)
    ON DELETE SET NULL
    ON UPDATE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

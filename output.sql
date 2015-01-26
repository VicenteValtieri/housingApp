SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `hashpass` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`room` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `number` TINYINT NOT NULL,
  `floor` TINYINT NOT NULL,
  `building` VARCHAR(8) NULL,
  `wing` VARCHAR(1) NULL,
  `occupants` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`group` (
  `id` TINYINT NOT NULL AUTO_INCREMENT,
  `release` DATETIME NULL,
  `membercount` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `user_id` INT NOT NULL,
  `dob` DATE NULL,
  `credit_count` SMALLINT NOT NULL,
  `room_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  `roommate_id` INT NOT NULL,
  `created` TIMESTAMP NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_student_user_idx` (`user_id` ASC),
  INDEX `fk_student_room1_idx` (`room_id` ASC),
  INDEX `fk_student_group1_idx` (`group_id` ASC),
  INDEX `fk_student_student1_idx` (`roommate_id` ASC),
  CONSTRAINT `fk_student_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `mydb`.`room` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `mydb`.`group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_student1`
    FOREIGN KEY (`roommate_id`)
    REFERENCES `mydb`.`student` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`schedule` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `schedname` VARCHAR(30) NULL,
  `start` DATETIME NULL,
  `end` DATETIME NULL,
  `interval` TIME NULL,
  `groupcount` INT NULL,
  `created` TIMESTAMP NULL,
  `current` TINYINT(1) NULL,
  `rosterfile` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`questionnaire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`questionnaire` (
  `idquestionnaire` INT NOT NULL AUTO_INCREMENT,
  `filename` VARCHAR(45) NULL,
  `student_user_id` INT NOT NULL,
  PRIMARY KEY (`idquestionnaire`),
  UNIQUE INDEX `idquestionaire_UNIQUE` (`idquestionnaire` ASC),
  INDEX `fk_questionaire_student1_idx` (`student_user_id` ASC),
  CONSTRAINT `fk_questionaire_student1`
    FOREIGN KEY (`student_user_id`)
    REFERENCES `mydb`.`student` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

CREATE DATABASE bookverse;
USE bookverse;

CREATE TABLE Users (
    user_ID INT NOT NULL AUTO_INCREMENT,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) DEFAULT '',
    phone varchar(10) DEFAULT '',
    PRIMARY KEY (user_ID)
);

CREATE TABLE Membership_plan (
    plan_ID INT NOT NULL AUTO_INCREMENT,
    name CHAR(20) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >=0),
    duration INT NOT NULL,
    PRIMARY KEY(plan_ID)

);

CREATE TABLE Subscriptions (
    subscription_ID INT AUTO_INCREMENT,
    user_ID INT NOT NULL,
    plan_ID INT NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    active BOOLEAN NOT NULL,
    PRIMARY KEY (subscription_ID),
    CONSTRAINT fk_sub_user FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    CONSTRAINT fk_sub_plan FOREIGN KEY (plan_ID) REFERENCES Membership_plan(plan_ID)

);

CREATE TABLE User_address (
    address_ID INT NOT NULL AUTO_INCREMENT,
    user_ID INT NOT NULL,
    address VARCHAR(200) NOT NULL,
    state VARCHAR(50) NOT NULL,
    Zip_Code VARCHAR(10) NOT NULL,
    PRIMARY KEY (address_ID),
    CONSTRAINT fk_address_user FOREIGN KEY (user_ID) REFERENCES Users(user_ID)
);

CREATE TABLE Series (
    series_ID INT NOT NULL AUTO_INCREMENT,
    series_name VARCHAR(50) DEFAULT '',
    PRIMARY KEY (series_ID)
);

CREATE TABLE Books (
    book_ID INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    status ENUM('On-Going', 'Complete') NOT NULL,
    series.ID INT DEFUALT '' ,
    volume# INT DEFAULT '',
    PRIMARY KEY (book_ID) 
) AUTO_INCREMENT = 1111;

CREATE TABLE Authors (
    author_ID VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCAHR(50) NOT NULL,
    PRIMARY KEY (author_ID),

);

CREATE TABLE Book_author (
    ID INT NOT NULL AUTO_INCREMENT,
    book_ID INT NOT NULL,
    author_ID INT NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk_ba_book FOREGIN KEY (book_ID) REFERENCES Books(book_ID),
    CONSTRAINT fk_ba_author FOREIGN KEY (author_ID) REFERENCES Authors(author_ID)
);


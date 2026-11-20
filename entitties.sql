CREATE DATABASE bookverse;
USE bookverse;

/* USERS & SUBSCRIPTIONS */
CREATE TABLE Users (
    user_ID INT NOT NULL AUTO_INCREMENT,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) DEFAULT '',
    phone varchar(10) DEFAULT '',
    PRIMARY KEY (user_ID),
    UNIQUE(email)
);

CREATE TABLE Membership_plan (
    plan_ID INT NOT NULL AUTO_INCREMENT,
    name CHAR(20) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >=0),
    duration INT NOT NULL CHECK (duration >0),
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

/* BOOKS*/
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
    series_ID INT DEFAULT NULL ,
    volume_number INT DEFAULT NULL,
    PRIMARY KEY (book_ID),
    CONSTRAINT fk_book_series FOREIGN KEY (series_ID) REFERENCES Series(series_ID)
) AUTO_INCREMENT = 1111;

CREATE TABLE Authors (
    author_ID VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (author_ID)

);

CREATE TABLE Book_author (
    ID INT NOT NULL AUTO_INCREMENT,
    book_ID INT NOT NULL,
    author_ID VARCHAR(50) NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk_ba_book FOREIGN KEY (book_ID) REFERENCES Books(book_ID),
    CONSTRAINT fk_ba_author FOREIGN KEY (author_ID) REFERENCES Authors(author_ID)
);

CREATE TABLE Genres (
    genre_ID INT AUTO_INCREMENT NOT NULL,
    book_ID INT NOT NULL,
    genre VARCHAR(20) DEFAULT '',
    PRIMARY KEY (genre_ID),
    CONSTRAINT fk_genre_book FOREIGN KEY (book_ID) REFERENCES Books(book_ID)
);

CREATE TABLE Digital_files (
    file_ID INT NOT NULL AUTO_INCREMENT,
    book_ID INT NOT NULL,
    file_format VARCHAR(10) NOT NULL,
    file_url VARCHAR(2048) NOT NULL,
    content_type VARCHAR(200) NOT NULL,
    PRIMARY KEY (file_ID),
    CONSTRAINT fk_file_book FOREIGN KEY (book_ID) REFERENCES Books(book_iD)

);

CREATE TABLE Book_access (
    book_ID INT NOT NULL,
    plan_id INT NOT NULL,
    PRIMARY KEY (book_ID, plan_ID),
    CONSTRAINT fk_access_book FOREIGN KEY (book_ID) REFERENCES BookS(book_ID),
    CONSTRAINT fk_access_plan FOREIGN KEY (plan_id) REFERENCES Membership_plan(plan_ID)

);

CREATE TABLE Rental_options (
    option_ID INT NOT NULL AUTO_INCREMENT,
    book_ID INT NOT NULL,
    price DECIMAL(10, 2) DEFAULT 0.00,
    duration VARCHAR(50) NOT NULL,
    PRIMARY KEY (option_ID),
    CONSTRAINT fk_rental_book FOREIGN KEY (book_ID) REFERENCES Books(book_ID)
);

CREATE TABLE Special_chapter (
    sp_ID INT NOT NULL AUTO_INCREMENT,
    book_ID INT NOT NULL,
    file_ID INT NOT NULL,
    chapter_number VARCHAR(50) NOT NULL,
    plan_ID INT NOT NULL,
    PRIMARY KEY (sp_ID),
    CONSTRAINT fk_special_chapter FOREIGN KEY (book_ID) REFERENCES Books(book_ID),
    CONSTRAINT fk_special_file FOREIGN KEY (file_ID) REFERENCES Digital_files(file_ID),
    CONSTRAINT fk_special_plan FOREIGN KEY (plan_ID) REFERENCES Membership_plan(plan_ID)
);

/* LIFRARY*/
CREATE TABLE My_library (
    list_ID INT NOT NULL AUTO_INCREMENT,
    user_ID INT NOT NULL,
    book_ID INT NOT NULL,
    progress VARCHAR(50),
    PRIMARY KEY (list_ID),
    CONSTRAINT fk_library_user FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    CONSTRAINT fk_library_book FOREIGN KEY (book_ID) REFERENCES Books(book_ID)
);

CREATE TABLE Rentals (
    rental_ID INT NOT NULL AUTO_INCREMENT,
    user_ID INT NOT NULL,
    option_ID INT NOT NULL,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY(rental_ID),
    CONSTRAINT fk_rental_user FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    CONSTRAINT fk_rental_option FOREIGN KEY (option_ID) REFERENCES Rental_options(option_ID)
);

CREATE TABLE Goods (
    goods_ID INT NOT NULL AUTO_INCREMENT,
    book_ID INT DEFAULT NULL,
    name VARCHAR(100) DEFAULT '',
    type VARCHAR(100) DEFAULT '',
    edition VARCHAR(100) DEFAULT '',
    retail DECIMAL(10, 2) NOT NULL,
    sale DECIMAL(10, 2) NOT NULL,
    stock_quantity INT,
    status VARCHAR(100),
    PRIMARY KEY (goods_ID),
    CONSTRAINT fk_goods_book FOREIGN KEY (book_ID) REFERENCES Books(book_ID)

);

CREATE TABLE Orders (
    order_ID INT NOT NULL,
    user_ID INT NOT NULL,
    address_ID INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('Pending', 'Processing', 'Delivered','Canceled') NOT NULL DEFAULT 'Pending',
    PRIMARY KEY (order_ID),
    CONSTRAINT fk_order_user FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    CONSTRAINT fk_order_add FOREIGN KEY (address_ID) REFERENCES User_address(Address_ID)
);

CREATE TABLE Order_items (
    orderitem_ID INT NOT NULL AUTO_INCREMENT,
    order_ID INT NOT NULL,
    goods_ID INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (orderitem_ID),
    CONSTRAINT fk_item_order FOREIGN KEY (order_ID) REFERENCES Orders(order_ID),
    CONSTRAINT fk_item_good FOREIGN KEY (goods_ID) REFERENCES Goods(goods_ID)

);

CREATE TABLE Events (
    event_ID INT NOT NULL AUTO_INCREMENT,
    event_name VARCHAR(100) DEFAULT '',
    format ENUM('Online', 'Offline', 'ELSE'),
    location VARCHAR(100) DEFAULT '',
    time_begin TIMESTAMP NOT NULL,
    time_end TIMESTAMP NOT NULL,
    description TEXT(700),
    Deals VARCHAR (255),
    PRIMARY KEY (event_ID)
);

CREATE TABLE Payments (
    payment_ID INT NOT NULL AUTO_INCREMENT,
    user_ID INT NOT NULL,
    subscription_ID INT DEFAULT NULL,
    rental_ID INT DEFAULT NULL,
    order_ID INT DEFAULT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME NOT NULL,
    payment_method ENUM('Cash', 'Card') NOT NULL,
    status ENUM('Pending', 'Completed', 'Canceled') NOT NULL,
    PRIMARY KEY (payment_ID),
    CONSTRAINT fk_pay_user FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    CONSTRAINT fk_pay_rental FOREIGN KEY (rental_ID) REFERENCES Rentals(rental_ID),
    CONSTRAINT fk_pay_sub FOREIGN KEY (subscription_ID) REFERENCES Subscriptions(subscription_ID),
    CONSTRAINT fk_pay_order FOREIGN KEY (order_ID) REFERENCES Orders(order_ID),
    CONSTRAINT chk_payment_type CHECK (
        (subscription_ID IS NOT NULL) +
        (rental_ID IS NOT NULL) +
        (order_ID IS NOT NULL) = 1
    ),
    CONSTRAINT chk_payment_amount CHECK (amount >= 0)

);

SHOW TABLES;

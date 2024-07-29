DROP DATABASE IF EXISTS campusbike;
CREATE DATABASE campusbike;
USE campusbike;

CREATE TABLE country(
    id INT AUTO_INCREMENT,
    name_country VARCHAR(20),
    CONSTRAINT pk_id_country PRIMARY KEY (id)
);

CREATE TABLE city(
    id INT AUTO_INCREMENT,
    name_city VARCHAR(20),
    id_country INT,
    CONSTRAINT pk_id_city PRIMARY KEY (id),
    CONSTRAINT fk_id_country FOREIGN KEY (id_country) REFERENCES country(id)
);

CREATE TABLE bike_brand(
    id INT AUTO_INCREMENT,
    brand_name VARCHAR(20),
    CONSTRAINT pk_id_brand PRIMARY KEY (id)
);

CREATE TABLE bike_model(
    id INT AUTO_INCREMENT,
    model_name VARCHAR(20),
    id_bike_brand INT,
    CONSTRAINT pk_id_model PRIMARY KEY (id),
    CONSTRAINT fk_id_bike_brand FOREIGN KEY (id_bike_brand) REFERENCES bike_brand(id)
);

CREATE TABLE bike(
    id INT AUTO_INCREMENT,
    id_bike_model INT,
    id_bike_brand INT,
    price DOUBLE,
    stock INT,
    CONSTRAINT pk_id_bike PRIMARY KEY (id),
    CONSTRAINT fk_id_bike_model FOREIGN KEY (id_bike_model) REFERENCES bike_model(id),
    CONSTRAINT fk_id_bikebrand FOREIGN KEY (id_bike_brand) REFERENCES bike_brand(id),
    CONSTRAINT chk_price_stock CHECK (price>0 AND stock>0)
);

CREATE TABLE customer(
    id INT AUTO_INCREMENT,
    customer_name VARCHAR(20),
    email VARCHAR(50) UNIQUE,
    phone VARCHAR(20) UNIQUE,
    id_city INT,
    CONSTRAINT pk_id_customer PRIMARY KEY (id),
    CONSTRAINT fk_id_city FOREIGN KEY (id_city) REFERENCES city(id)
);

CREATE TABLE sale(
    id INT AUTO_INCREMENT,
    sale_date DATE,
    id_customer INT,
    total DOUBLE,
    CONSTRAINT pk_id_sale PRIMARY KEY (id),
    CONSTRAINT fk_id_customer FOREIGN KEY (id_customer) REFERENCES customer(id),
    CONSTRAINT chk_total CHECK (total>0)
);

CREATE TABLE sale_detail(
    id INT AUTO_INCREMENT,
    id_sale INT,
    id_bike INT,
    amount INT,
    unit_price DOUBLE,
    CONSTRAINT pk_id_sale_detail PRIMARY KEY (id),
    CONSTRAINT fk_id_sale FOREIGN KEY (id_sale) REFERENCES sale(id),
    CONSTRAINT fk_id_bike FOREIGN KEY (id_bike) REFERENCES bike(id),
    CONSTRAINT chk_amount_unit_price CHECK (amount>0 AND unit_price>0)
);

CREATE TABLE supplier(
    id INT AUTO_INCREMENT,
    supplier_name VARCHAR(20) UNIQUE,
    contact_name VARCHAR(20),
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(50) UNIQUE,
    id_city INT,
    CONSTRAINT pk_id_supplier PRIMARY KEY (id),
    CONSTRAINT fk_id_city_supplier FOREIGN KEY (id_city) REFERENCES city(id)
);

CREATE TABLE replacement(
    id INT AUTO_INCREMENT,
    replacement_name VARCHAR(20),
    replacement_description TEXT,
    price DOUBLE,
    stock INT,
    id_supplier INT,
    CONSTRAINT pk_id_replacement PRIMARY KEY (id),
    CONSTRAINT fk_id_supplier FOREIGN KEY (id_supplier) REFERENCES supplier(id),
    CONSTRAINT chk_price_stock_replacement CHECK (price>0 AND stock>0)
   
);

CREATE TABLE purchase(
    id INT AUTO_INCREMENT,
    purchase_date DATE,
    id_supplier INT,
    total DOUBLE,
    CONSTRAINT pk_id_purchase PRIMARY KEY (id),
    CONSTRAINT fk_id_supplier_purchase FOREIGN KEY (id_supplier) REFERENCES supplier(id),
    CONSTRAINT chk_total_purchase CHECK (total>0)
);

CREATE TABLE purchase_detail(
    id INT AUTO_INCREMENT,
    id_purchase INT,
    id_replacement INT,
    amount INT,
    unit_price DOUBLE,
    CONSTRAINT pk_id_purchase_detail PRIMARY KEY (id),
    CONSTRAINT fk_id_purchase FOREIGN KEY (id_purchase) REFERENCES purchase(id),
    CONSTRAINT fk_id_replacement FOREIGN KEY (id_replacement) REFERENCES replacement(id),
    CONSTRAINT chk_price_amount_purchase_detail CHECK (unit_price>0 AND amount>0)
);
CREATE DATABASE dw_tienda_bicicletas;
\connect dw_tienda_bicicletas

DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS fact_stock;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_brand;
DROP TABLE IF EXISTS dim_category;
DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_staff;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_date;

CREATE TABLE dim_brand (
    brand_id    INT PRIMARY KEY,
    brand_name  VARCHAR(50) NOT NULL
);

CREATE TABLE dim_category (
    category_id    INT PRIMARY KEY,
    category_name  VARCHAR(50) NOT NULL
);

CREATE TABLE dim_product (
    product_id    INT PRIMARY KEY,
    product_name  VARCHAR(150) NOT NULL,
    brand_id      INT NOT NULL REFERENCES dim_brand(brand_id),
    category_id   INT NOT NULL REFERENCES dim_category(category_id),
    model_year    INT NOT NULL,
    list_price    NUMERIC(10,2) NOT NULL
);

CREATE TABLE dim_store (
    store_id    INT PRIMARY KEY,
    store_name  VARCHAR(60) NOT NULL,
    phone       VARCHAR(20),
    email       VARCHAR(80),
    street      VARCHAR(80),
    city        VARCHAR(60),
    state       CHAR(2),
    zip_code    INT
);

CREATE TABLE dim_staff (
    staff_id    INT PRIMARY KEY,
    first_name  VARCHAR(40) NOT NULL,
    last_name   VARCHAR(40) NOT NULL,
    email       VARCHAR(80),
    phone       VARCHAR(20),
    active      SMALLINT,
    store_id    INT,
    manager_id  INT
);

CREATE TABLE dim_customer (
    customer_id  INT PRIMARY KEY,
    first_name   VARCHAR(40) NOT NULL,
    last_name    VARCHAR(40) NOT NULL,
    phone        VARCHAR(20),
    email        VARCHAR(80),
    street       VARCHAR(80),
    city         VARCHAR(60),
    state        CHAR(2),
    zip_code     INT
);

CREATE TABLE dim_date (
    date_id              DATE PRIMARY KEY,
    year                 INT NOT NULL,
    quarter_of_year      SMALLINT NOT NULL,
    month_of_year        SMALLINT NOT NULL,
    day_of_month         SMALLINT NOT NULL,
    date_int             INT NOT NULL,
    month_name           VARCHAR(15) NOT NULL,
    month_in_calendar    VARCHAR(10) NOT NULL,
    quarter_in_calendar  VARCHAR(10) NOT NULL,
    day_in_week          SMALLINT NOT NULL,
    day_of_week_name     VARCHAR(12) NOT NULL,
    week_ending          DATE NOT NULL,
    week_number          SMALLINT NOT NULL,
    month_n_year         INT NOT NULL,
    quarter_n_year       INT NOT NULL,
    short_year           SMALLINT NOT NULL,
    fy                   VARCHAR(4) NOT NULL
);

CREATE TABLE fact_stock (
    store_id    INT NOT NULL REFERENCES dim_store(store_id),
    product_id  INT NOT NULL REFERENCES dim_product(product_id),
    quantity    INT NOT NULL,
    PRIMARY KEY (store_id, product_id)
);

CREATE TABLE fact_sales (
    order_id       INT NOT NULL,
    product_id     INT NOT NULL REFERENCES dim_product(product_id),
    customer_id    INT NOT NULL REFERENCES dim_customer(customer_id),
    order_date     DATE NOT NULL REFERENCES dim_date(date_id),
    required_date  DATE,
    shipped_date   DATE,
    store_id       INT NOT NULL,
    staff_id       INT NOT NULL REFERENCES dim_staff(staff_id),
    quantity       INT NOT NULL,
    list_price     NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id)
);
